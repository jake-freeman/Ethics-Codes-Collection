class Plugins::Ecc::Front::StaticpagesController < Plugins::Ecc::FrontController
  include Plugins::Ecc
  def index
    @pagetype = ActiveRecord::Base.connection.exec_query("SELECT id FROM plugins_ecc_pagetypes WHERE description = 'HOME'").first
    @ptid = @pagetype.to_hash
    @page = Staticpages.where("pagetype_id = ?", @ptid['id']).first
    render 'ecc/index'
  end
  def show
    @pt = ActiveRecord::Base.connection.exec_query("SELECT id FROM plugins_ecc_pagetypes WHERE description = '" + params[:description].upcase + "'").first
    @pt = @pt.to_hash
    @page = Staticpages.where("pagetype_id = ?", @pt['id']).first
    render 'ecc/show'
  end

end

