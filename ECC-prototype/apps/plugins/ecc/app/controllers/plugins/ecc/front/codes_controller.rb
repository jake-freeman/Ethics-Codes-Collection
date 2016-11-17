class Plugins::Ecc::Front::CodesController < Plugins::Ecc::FrontController
  include Plugins::Ecc
  def index
    @codes = Codes.paginate(:page => params[:page], :per_page =>current_site.admin_per_page).order('code_title DESC')
    render 'ecc/codes/index'
  end
  def show
    @code = Codes.find(params[:id])
    @org = Orgs.find(@code.org_id)
    render 'ecc/codes/show'
  end
  private
  def ecc_params
    params.require(:ecc).permit(:id);
  end

end
