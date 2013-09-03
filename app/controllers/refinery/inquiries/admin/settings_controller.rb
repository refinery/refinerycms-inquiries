module Refinery
  module Inquiries
    module Admin
      class SettingsController < Refinery::AdminController

        before_filter :find_setting, :only => [:edit, :update]
        after_filter :save_subject_for_confirmation, :save_message_for_confirmation, :only => :update

        def edit
        end

        def update
          if @setting.update_attributes(params[:setting])
            flash[:notice] = t('refinery.crudify.updated', :what => @setting.name.gsub("inquiry_", "").titleize)

            unless request.xhr? or from_dialog?
              redirect_back_or_default(refinery.inquiries_admin_inquiries_path)
            else
              render :text => "<script type='text/javascript'>parent.window.location = '#{refinery.inquiries_admin_inquiries_path}';</script>"
            end
          end
        end

      protected

        def find_setting
          setting = params[:id].gsub("inquiry_", "")

          if Refinery::Inquiries::Setting.respond_to?(setting)
            Refinery::Inquiries::Setting.send(setting)
          end

          @setting = Refinery::Setting.friendly.find(params[:id])
        end

        def save_subject_for_confirmation
          if params.keys.include?('subject')
            Refinery::Inquiries::Setting.confirmation_subject = params[:subject]
          end
        end

        def save_message_for_confirmation
          if params.keys.include?('message')
            Refinery::Inquiries::Setting.confirmation_message = params[:message]
          end
        end

      end
    end
  end
end
