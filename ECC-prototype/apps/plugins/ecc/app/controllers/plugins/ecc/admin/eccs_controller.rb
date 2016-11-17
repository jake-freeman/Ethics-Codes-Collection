class Plugins::Ecc::Admin::EccsController < Plugins::Ecc::AdminController
  before_action :set_ecc, only: ['show','edit','update','destroy']
  include Plugins::Ecc
  def index
    @ecc = Eccs.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
    render 
  end

  def new
    @ecc = current_site.eccs
    add_breadcrumb("#{t('plugin.ecc.ecc.new')}")
    @ecc.save
  end

  def show
    #add_breadcrumb("#{t('plugin.ecc.ecc.table.details')}")
  end

  def edit
  end

  def create
    @ecc = current_site.ecc.new(ecc_params)
    if @ecc.save
      flash[:notice] = "Code saved."
      redirect_to admin_plugins_ecc_ecc_path(@ecc)
    else
      flash[:notice] = "ecc not saved"

      render 'new'
    end
  end

  def update
  end


  private
  def ecc_params
    params.require(:ecc).permit(:id);
  end

  def set_ecc
    @ecc = current_site.ecc.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Ecc not found"
    redirect_to index
  end


end
