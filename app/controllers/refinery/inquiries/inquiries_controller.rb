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
        @inquiry = Inquiry.new(params[:inquiry])

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
        @page = Page.where(link_url: '/contact').first
      end

      def find_thank_you_page
        @page = Page.where(link_url: '/contact/thank_you').first
      end

    end
  end
end
