class Plugins::Ecc::Admin::CodesController < Plugins::Ecc::AdminController
<<<<<<< 930019e2a15235305d8845d57180109c3e1995a3
  before_action :set_ecc
  before_action :set_code, only: ['show','edit','update','destroy']
=======
  before_action :set_code, :set_org, only: ['show','edit','update','destroy']
>>>>>>> updated some frontend, backend functioning well
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
  def set_code
    @code = Codes.find(params[:id])
  end
end
