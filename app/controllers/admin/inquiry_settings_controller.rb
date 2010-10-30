class Admin::InquirySettingsController < Admin::BaseController

  crudify :refinery_setting,
          :title_attribute => "name",
          :order => 'name ASC',
          :redirect_to_url => "admin_inquiries_url"

  before_filter :set_url_override?, :only => [:edit, :update]
  after_filter :save_subject_for_confirmation?, :only => :update
  around_filter :rewrite_flash?, :only => :update

protected
  def rewrite_flash?
    yield

    flash[:notice] = flash[:notice].to_s.gsub(/(\'.*\')/) {|m| m.titleize}.gsub('Inquiry ', '')
  end

  def save_subject_for_confirmation?
    InquirySetting.confirmation_subject = params[:subject] if params.keys.include?('subject')
  end

  def set_url_override?
    @url_override = admin_inquiry_setting_url(@refinery_setting, :dialog => from_dialog?)
  end

  def find_refinery_setting
    # ensure that we're dealing with the name of the setting, not the id.
    begin
      if params[:id].to_i.to_s == params[:id]
        params[:id] = RefinerySetting.find(params[:id]).name.to_s
      end
    rescue
    end

    # prime the setting first, if it's valid.
    if InquirySetting.methods.map(&:to_sym).include?(params[:id].to_s.gsub('inquiry_', '').to_sym)
      InquirySetting.send(params[:id].to_s.gsub('inquiry_', '').to_sym)
    end
    @refinery_setting = RefinerySetting.find_by_name(params[:id])
  end

end
