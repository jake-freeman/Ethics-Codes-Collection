class Plugins::Ecc::Front::EccsController < Plugins::Ecc::FrontController
  include Plugins::Ecc

  def index
  end

  def show
    redirect_to plugins_ecc_ecc_staticpages_path(:ecc_id => 22)
  end



end
