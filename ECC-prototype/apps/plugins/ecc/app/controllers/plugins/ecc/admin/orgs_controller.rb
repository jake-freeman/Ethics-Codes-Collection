class Plugins::Ecc::Admin::OrgsController < Plugins::Ecc::AdminController
  before_action :set_org, only: ['show','edit','update','destroy']
  include Plugins::Ecc
  def index
    @orgs = Orgs.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
    render 'orgs_index'
  end

  def new
#    @org = @ecc.org.build
    @org = Orgs.new
    render 'orgs_new'
    add_breadcrumb("#{t('plugin.ecc.org.new')}")
  end

  def show
    render 'orgs_show'
  end

  def edit
    render 'orgs_edit'
  end

  def create
    new_org = params.require(:org).permit(:name, :desc)
    @org = Orgs.new(new_org)
    r = {org: @org}; hooks_run('org_create', r)
    if @org.save
      r = {org: @org}; hooks_run('org_created', r)
      flash[:notice] = 'New Organization created'
      redirect_to action: 'index'
    else
      new
    end
  end

  def update
    up_org = params.require(:org).permit(:name, :desc)
    if @org.update(up_org)
      redirect_to action: :show
    else
      render 'edit'
    end
  end
  def destroy
    @org = Orgs.find(params[:id])
    @org.destroy
    redirect_to action: 'index'
  end

  private
  def set_org
    @org = Orgs.find(params[:id])
  end
end
