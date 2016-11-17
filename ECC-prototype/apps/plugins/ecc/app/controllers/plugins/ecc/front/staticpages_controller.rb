class Plugins::Ecc::Front::StaticpagesController < Plugins::Ecc::FrontController
  include Plugins::Ecc
  def index
    @static_pages = Staticpages.first
    render 'ecc/index'
  end

end

