class Plugins::Ecc::Admin::StaticsController < Plugins::Ecc::AdminController
#  before_action :set_ecc
  before_action :set_page, only: ['show','edit','update','destroy']
  before_action :set_pagetype
  include Plugins::Ecc
  
  def index
    @pages = Staticpages.all
    render 'statics_index'
  end

  def new
    @page = Staticpages.new
    render 'statics_new'
  end

  def show
    render 'statics_show' 
  end

  def edit
    render 'statics_edit'
  end
  def destroy
    @page = Staticpages.where(pagetype_id: params[:id]).take
    @page.destroy
    ActiveRecord::Base.connection.execute("DELETE FROM plugins_ecc_pagetypes WHERE id = " + params[:id]);
    redirect_to action: 'index'
  end    
  def create
    sql = "INSERT INTO plugins_ecc_pagetypes(description) values ('" + params[:ptype].upcase + "')"
    ActiveRecord::Base.connection.execute(sql)
    @pagetype = ActiveRecord::Base.connection.exec_query("SELECT id FROM plugins_ecc_pagetypes WHERE description = '" + params[:ptype].upcase + "'" ).first
    new_page = Staticpages.new
    new_page.title = params[:title]
    new_page.content = params[:content]
    pid = @pagetype.to_hash
    new_page.pagetype_id = pid['id']
    new_page.save
    redirect_to action: :show
  end
  def update
    up_page = params.require(:page).permit(:title, :content, :pagetype)
    if @page.update(up_page)
      redirect_to action: :show
    else 
      render 'edit'
    end
  end


  private
  def set_ecc
    @ecc = Ecc.find(22)
  end
  def set_pagetype
    @pagetype = Staticpages.find_by_sql("Select * from plugins_ecc_pagetypes")
  end
  def set_page
    @page = Staticpages.where('pagetype_id' => params[:id]).first
  end
end
