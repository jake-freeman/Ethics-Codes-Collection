class Plugins::Code::AdminController < CamaleonCms::Apps::PluginsAdminController
  include Plugins::Code::MainHelper
  
  before_action :set_form, only: ['show', 'edit']
  add_breadcrumb I18n.t("plugins.code.title", default: 'Code'), :admin_plugins_code_admin_forms_path
  def index
    @codes = current_site.codes.where("parent_id is null").all
    @codes = @codes.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
  end
  
  def edit
    add_breadcrumb I18n.t("plugins.code.edit_view", default: 'Edit Code')
    render "edit"
  end 


  # add custom methods below
end
