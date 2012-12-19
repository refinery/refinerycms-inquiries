module Refinery
  module Inquiries
    class InquiriesController < ::ApplicationController

      before_filter :find_page, :only => [:create, :new]

      def thank_you
        @page = ::Refinery::Page.find_by_link_url("/contact/thank_you")
      end

      def new
        @inquiry = ::Refinery::Inquiries::Inquiry.new

        new_respond
      end

      def create
        @inquiry = ::Refinery::Inquiries::Inquiry.new(params[:inquiry])

        if @inquiry.save
          if @inquiry.ham?
            begin
              ::Refinery::Inquiries::InquiryMailer.notification(@inquiry, request).deliver
            rescue
              logger.warn "There was an error delivering an inquiry notification.\n#{$!}\n"
            end

            begin
              ::Refinery::Inquiries::InquiryMailer.confirmation(@inquiry, request).deliver
            rescue
              logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
            end if ::Refinery::Inquiries::Setting.send_confirmation?
          end

          respond_to do |format|
            format.html do
              redirect_to refinery.thank_you_inquiries_inquiries_path
            end

            format.json do
              render_json_response :redirect, :to => refinery.thank_you_inquiries_inquiries_path
            end
          end
        else
          new_respond :error
        end
      end

      protected

      def find_page
        @page = ::Refinery::Page.find_by_link_url("/contact")
      end

      def new_respond status=:ok
        @form_holder_config = {
            :id => 'inquiry-form-holder',
            :class => 'inquiries',
            :append_to => '#body .inner'
        }

        respond_to do |format|
          if params[:form_holder_id].present? and params[:form_holder_id] =~ /\A[a-zA-Z]+[\w\-]{,128}\Z/
            @form_holder_config[:id] = params[:form_holder_id]
          end

          # fix "Missing partial refinery/inquiries/inquiries/form with {:formats=>[:json] .."
          form_html = render_to_string(:partial => 'form', :formats => :html) if request.xhr?

          format.html do
            render action: 'new'
          end

          format.json do
            render_json_response status, {
              :errors => @inquiry.errors,
              :html => { @form_holder_config[:id] => form_html }}
          end
        end
      end

      def render_json_response(type, hash)
        unless [ :ok, :redirect, :error ].include?(type)
          raise "Invalid json response type: #{type}"
        end

        json = {
          :status => type,
          :html => nil,
          :message => nil,
          :errors => nil,
          :to => nil }.merge(hash)

        render_options = {:json => json}
        render(render_options)
      end

    end
  end
end
