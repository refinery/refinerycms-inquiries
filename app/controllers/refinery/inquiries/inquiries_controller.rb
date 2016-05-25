require 'refinery/inquiries/spam_filter'

module Refinery
  module Inquiries
    class InquiriesController < ::ApplicationController

      before_action :find_page, only: [:create, :new]
      before_action :find_thank_you_page, only: :thank_you

      def thank_you
      end

      def new
        @inquiry = Inquiry.new
      end

      def create
        @inquiry = Inquiry.new(inquiry_params)

        if inquiry_saved_and_validated?
          redirect_to refinery.thank_you_inquiries_inquiries_path
        else
          render action: 'new'
        end
      end

      protected

      def find_page
        @page = Page.find_by(link_url: Refinery::Inquiries.page_path_new)
      end

      def find_thank_you_page
        @page = Page.find_by(link_url: Refinery::Inquiries.page_path_thank_you)
      end

      def inquiry_params
        params.require(:inquiry).permit(permitted_inquiry_params)
      end

      private

      def permitted_inquiry_params
        [:name, :phone, :message, :email]
      end

      def inquiry_saved_and_validated?
        if @inquiry.valid?
          @filter = SpamFilter.new(@inquiry, request)
          @filter.call

          @filter.valid?
        end
      end

    end
  end
end
