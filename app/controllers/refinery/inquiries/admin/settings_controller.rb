module Refinery
  module Inquiries
    module Admin
      class SettingsController < ::Refinery::AdminController

        crudify :'refinery/setting',
                :title_attribute => "name",
                :order => 'name ASC',
                :redirect_to_url => 'refinery.inquiries_admin_inquiries_path'

        before_filter :set_url_override?, :only => [:edit, :update]
        after_filter :save_subject_for_confirmation?, :only => :update
        after_filter :save_message_for_confirmation?, :only => :update
        around_filter :rewrite_flash?, :only => :update

        protected

        def rewrite_flash?
          yield

          flash[:notice] = flash[:notice].to_s.gsub(/(\'.*\')/) {|m| m.titleize}.gsub('Inquiry ', '')
        end

        def save_subject_for_confirmation?
          Refinery::Inquiries::Setting.confirmation_subject = params[:subject] if params.keys.include?('subject')
        end

        def save_message_for_confirmation?
          Refinery::Inquiries::Setting.confirmation_message = params[:message] if params.keys.include?('message')
        end

        def set_url_override?
          @url_override = refinery.inquiries_admin_setting_path(@setting, :dialog => from_dialog?)
        end

        def find_setting
          # ensure that we're dealing with the name of the setting, not the id.
          begin
            if params[:id].to_i.to_s == params[:id]
              params[:id] = Refinery::Setting.find(params[:id]).name.to_s
            end
          rescue
          end

          # prime the setting first, if it's valid.
          if Refinery::Inquiries::Setting.methods.map(&:to_sym).include?(params[:id].to_s.gsub('inquiry_', '').to_sym)
            Refinery::Inquiries::Setting.send(params[:id].to_s.gsub('inquiry_', '').to_sym)
          end

          @setting = Refinery::Setting.find_by_name(params[:id])
        end

      end
    end
  end
end
