class NakanohitosController < ApplicationController
  def index
    @nakanohitos = User.all(:conditions => {:nakanohito => true})
  end

  def show
    @nakanohito = User.find_by_login!(params[:id])
  end
end
