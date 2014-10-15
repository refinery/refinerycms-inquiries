module Refinery
  module Inquiries
    class InquiriesController < ::ApplicationController

      before_filter :find_page, only: [:create, :new]
      before_filter :find_thank_you_page, only: :thank_you

      def thank_you
      end

      def new
        @inquiry = Inquiry.new
      end

      def create
        @inquiry = Inquiry.new(inquiry_params)

        if @inquiry.save
          if @inquiry.ham? || Inquiries.send_notifications_for_inquiries_marked_as_spam
            begin
              InquiryMailer.notification(@inquiry, request).deliver
            rescue
              logger.warn "There was an error delivering an inquiry notification.\n#{$!}\n"
            end

            if Setting.send_confirmation?
              begin
                InquiryMailer.confirmation(@inquiry, request).deliver
              rescue
                logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
              end
            end
          end

          redirect_to refinery.thank_you_inquiries_inquiries_path
        else
          render :action => 'new'
        end
      end

      protected

      def find_page
        @page = Page.find_by(link_url: Refinery::Inquiries.page_path_new)
      end

      def find_thank_you_page
        @page = Page.find_by(link_url: Refinery::Inquiries.page_path_thank_you)
      end

      private

      def inquiry_params
        params.require(:inquiry).permit(:name, :phone, :message, :email)
      end

    end
  end
end
