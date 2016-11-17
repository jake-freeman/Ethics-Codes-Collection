class Plugins::Ecc::Front::CodesController < Plugins::Ecc::FrontController
  include Plugins::Ecc
  def index
    @orgs = Codes.paginate(:page => params[:page], :per_page =>current_site.admin_per_page).order('name DESC')
    render 'ecc/orgs/index'
  end
  def show
    @org = Orgs.find(params[:id])
    @codes Staticpages.where("pagetype_id = ?", @org.id])
    render 'ecc/codes/show'
  end
  private
  def ecc_params
    params.require(:ecc).permit(:id);
  end

end
