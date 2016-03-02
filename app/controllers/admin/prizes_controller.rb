class Admin::PrizesController < ApplicationController

  layout "admin"
  before_action :find_lottery, :only => [:edit, :update, :destroy]

  def index
    @prizes = Prize.all
  end

  def new
    @prize = Prize.new
  end

  def create
    
  end

  def show
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end


  private

  def find_lottery
    @lottery = Lottery.find_by_id(params[:lottery_id])
  end


end
