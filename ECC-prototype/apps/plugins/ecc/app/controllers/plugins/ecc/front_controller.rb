class Plugins::Ecc::FrontController < CamaleonCms::Apps::PluginsFrontController
  include Plugins::Ecc::MainHelper
  def index
  # add custom methods below
    @static_pages = Plugins::Ecc::StaticPages.all
    render 'ecc/index'
  end
end
