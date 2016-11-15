class Plugins::Ecc::Admin::CodesController < Plugins::Ecc::AdminController
  before_action :set_ecc
  before_action :set_code, only: ['show','edit','update','destroy']
  include Plugins::Ecc

  def index
    @codes = Codes.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
    render 'codes_index'
  end

  def new
    @code = Codes.new
    @orgs = Orgs.all
    render 'codes_new'
  end

  def show
#    render 'orgs_show'
  end

  def edit
  end

  def create
    new_code = params.require(:code).permit(:code_title, :code_content, :org_id, :code_year)
    @code = Codes.new(new_code)
    r = {code: @code}; hooks_run('code_create', r)
    if @code.save
      r = {code: @code}; hooks_run('code_created', r)
      flash[:notice] = t('camaleon_cms.admin.user.message.created')
#      redirect_to action: :show
    else
      new
    end
  end

  def update
  end


  private
  def set_ecc
    @ecc = current_site.eccs.where(id: 22)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Ecc not found"
    redirect_to orgs_path
  end
  def set_code
    @code = Codes.find(params[:id])
  end
end
