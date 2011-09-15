module Refinery
  module Admin
    class InquiriesController < ::Refinery::AdminController

      crudify :'refinery/inquiry',
              :title_attribute => "name",
              :order => "created_at DESC"

      helper_method :group_by_date

      before_filter :find_all_ham, :only => [:index]
      before_filter :find_all_spam, :only => [:spam]
      before_filter :get_spam_count, :only => [:index, :spam]

      def index
        @inquiries = @inquiries.with_query(params[:search]) if searching?
        @inquiries = @inquiries.page(params[:page])
      end

      def spam
        self.index
        render :action => 'index'
      end

      def toggle_spam
        find_inquiry
        @inquiry.toggle!(:spam)

        redirect_to :back
      end

      protected

      def find_all_ham
        @inquiries = Refinery::Inquiry.ham
      end

      def find_all_spam
        @inquiries = Refinery::Inquiry.spam
      end

      def get_spam_count
        @spam_count = Refinery::Inquiry.count(:conditions => {:spam => true})
      end

    end
  end
end
