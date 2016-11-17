class Plugins::Ecc::Front::OrgsController < Plugins::Ecc::FrontController
  before_action :set_ecc, only: ['show','edit','update','destroy']

  def index
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
