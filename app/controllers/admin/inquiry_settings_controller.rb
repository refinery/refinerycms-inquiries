class Admin::InquirySettingsController < Admin::BaseController

  crudify :refinery_setting, :title_attribute => "name", :order => 'name ASC', :redirect_to_url => "admin_inquiries_url"

  before_filter :redirect_back_to_inquiries?, :only => [:index]
  before_filter :set_url_override?, :only => [:edit]
  after_filter :save_subject_for_confirmation?, :only => [:create, :update]
  around_filter :rewrite_flash?, :only => [:create, :update]

protected
  def rewrite_flash?
    yield

    flash[:notice] = flash[:notice].to_s.gsub(/(\'.*\')/) {|m| m.titleize}.gsub('Inquiry ', '')
  end

  def save_subject_for_confirmation?
    InquirySetting.confirmation_subject = params[:subject] if params.keys.include?('subject')
  end

  def redirect_back_to_inquiries?
    redirect_to admin_inquiries_url
  end

  def set_url_override?
    @url_override = admin_inquiry_setting_url(@refinery_setting.name.to_sym, :dialog => from_dialog?)
  end

  def find_refinery_setting
    # prime the setting first, if it's valid.
    if InquirySetting.methods.include?(params[:id].to_s.gsub('inquiry_', ''))
      InquirySetting.send(params[:id].to_s.gsub('inquiry_', '').to_sym)
    end
    @refinery_setting = RefinerySetting.find_by_name(params[:id])
  end

end
