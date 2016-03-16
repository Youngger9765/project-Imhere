class UsersController < ApplicationController

  before_action :authenticate_user!, :except =>[:confirm]

  def show
    @user = current_user
  end

  def confirm
    token = params[:confirmation_token]
    user = User.find_by(:confirmation_token => token)

    if user
      redirect_to "http://iam.goodideas-campus.com/star/index.php?eventsId=1#registerOk"
    else
      redirect_to "http://iam.goodideas-campus.com/star/index.php?eventsId=1#registerFail"
    end
  end

end
