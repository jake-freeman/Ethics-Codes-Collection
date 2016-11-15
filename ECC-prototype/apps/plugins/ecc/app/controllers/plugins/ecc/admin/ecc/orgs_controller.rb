class Plugins::Ecc::Admin::Ecc::OrgsController < Plugins::Ecc::AdminController
  before_action :set_ecc
  before_action :set_org, only: ['show','edit','update','destroy']

  def index
    render 'index'
  end

  def new
    @org = @ecc.org.build
    add_breadcrumb("#{t('plugin.ecc.org.new')}")
  end

  def show
#    add_breadcrumb("#{t('plugin.ecc.ecc.table.details')}")
  end

  def edit
  end

  def create
#    @ecc = current_site.ecc.new(ecc_params)
#    if @ecc.save
#      flash[:notice] = "Code saved."
#      redirect_to admin_plugins_ecc_ecc_path(@ecc)
#    else
#      flash[:notice] = "ecc not saved"

 #     render 'new'
#    end
  end

  def update
  end


  private
  def org_params
    params.require(:org).permit(:name, :tags, :id);
  end

  def set_ecc
    #@ecc = current_site.eccs.find(params[:ecc_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Ecc not found"
    redirect_to orgs_path
  end
  def set_org
    @org = @ecc.orgs.find(params[:id])
  end


end
