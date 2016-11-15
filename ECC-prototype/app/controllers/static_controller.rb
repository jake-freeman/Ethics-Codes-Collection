class StaticController < ApplicationController
  include Plugins::Ecc
  def show
    render params[:page]
  end
end
