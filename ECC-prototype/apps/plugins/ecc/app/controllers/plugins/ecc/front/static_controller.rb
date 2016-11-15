class Plugins::Ecc::Front::StaticController < Plugins::Ecc::FrontController
  include Plugins::Ecc::StaticPages
  def index
    @stat = StaticPages.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
    render 'ecc/index'
  end
end

