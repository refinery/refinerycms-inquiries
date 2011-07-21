module Refinery
  class InquiriesController < ::ApplicationController

    before_filter :find_page, :only => [:create, :new]

    def thank_you
      @page = Refinery::Page.find_by_link_url("/contact/thank_you", :include => [:parts, :slugs])
    end

    def new
      @inquiry = Refinery::Inquiry.new
    end

    def create
      @inquiry = Refinery::Inquiry.new(params[:inquiry])

      if @inquiry.save
        if @inquiry.ham?
          begin
            Refinery::InquiryMailer.notification(@inquiry, request).deliver
          rescue
            logger.warn "There was an error delivering an inquiry notification.\n#{$!}\n"
          end

          begin
            Refinery::InquiryMailer.confirmation(@inquiry, request).deliver
          rescue
            logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
          end if Refinery::InquirySetting.send_confirmation?
        end

        redirect_to thank_you_inquiries_url
      else
        render :action => 'new'
      end
    end

    protected

    def find_page
      @page = Refinery::Page.find_by_link_url('/contact', :include => [:parts, :slugs])
    end

  end
end