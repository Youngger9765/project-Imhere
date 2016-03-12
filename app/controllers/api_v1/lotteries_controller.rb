class ApiV1::LotteriesController < ApiController

  before_action :authenticate_user_from_token!

  def userJoinLottery
    if authenticate_user_from_token!
      @user = User.find_by_authentication_token(params[:auth_token] )
      

      if params[:lottery_id].blank?
        render :json => {
          :error => "lottery_id can't be blank！"
        }, :status => 401

      elsif !find_lottery!
        render :json => {
          :error => "lottery_id is fail"
        }, :status => 401

      elsif @user.lotteries.all.find_by_id(params[:lottery_id])
        render :json => {
          :error => "已參加過此抽獎！"
        }, :status => 401

      elsif params[:name].blank? || params[:address].blank? || params[:phone_number].blank? || params[:birthday].blank?
        render :json => {
          :error => "個人資訊不可有空白！"
        }, :status => 401

      elsif !params[:name].blank? && !params[:address].blank? && !params[:phone_number].blank? && !params[:birthday].blank?
        @user.name = params[:name]
        @user.address = params[:address]
        @user.phone_number = params[:phone_number]
        @user.birthday = params[:birthday]
        @user.save!

        @lottery = Lottery.find(params[:lottery_id])
        ship = UserLotteryShip.create(:user => @user, :lottery => @lottery)
        ship.user_name = params[:name]
        ship.user_address = params[:address]
        ship.user_phone_number = params[:phone_number]
        ship.user_birthday = params[:birthday]
        ship.save!
      end

    else
      render :json => {
        :error => "auth_token is wrong!!"
      }, :status => 401
    end

  end

  private

  def find_lottery!
    if params[:lottery_id].present?
      @lottery = Lottery.find_by_id(params[:lottery_id])
    else
      false
    end
  end

end
