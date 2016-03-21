class ApiV1::UsersController < ApiController

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  def getUserInfo
    if authenticate_user_from_token!
      @user = current_user

      if @user.fb_token
        @fb_lock = "fb 已綁定"
      
      else
        @fb_lock = nil
      end
      

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def editUserInfo
    if authenticate_user_from_token!
      @user = current_user
      @user.update(user_params)

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def lockFbLogin

    if authenticate_user_from_token!
      user = current_user      

      if params[:access_token]
        fb_data = User.get_fb_data( params[:access_token])

        if User.find_by(:fb_uid => fb_data["id"])
          render :json => {
            :error => "此Facebook帳號已被綁定，請換另一組"
          }, :status => 401

        else

          if fb_data
            auth_hash = OmniAuth::AuthHash.new({
              uid: fb_data["id"],
              info: {
                email: fb_data["email"],
                name: fb_data["name"],
                image: fb_data["picture"]["data"]["url"],
              },
              credentials: {
                token: params[:access_token],
                expires_at: Time.now + 60.days
              }
            })

            user.fb_token = params[:access_token]
            user.fb_uid = auth_hash[:uid]
            user.fb_email = auth_hash[:info][:email]
            user.fb_name = auth_hash[:info][:name]
            user.fb_head_shot = auth_hash[:info][:image]
            user.fb_raw_data = auth_hash

            if user.save
              render :json => { :message => "綁定成功",
                          :auth_token => user.authentication_token,
                          :user_id => user.id,
                          :email => user.email,
                          :fb => "FB已綁定",
                          :fb_name => user.fb_name,
                          :fb_email => user.fb_email,
                          :fb_image => user.fb_head_shot
                        }, :status => 200
            end

          else
            render :json => {
              :error => "access_token 錯誤"
            }, :status => 401

          end
        end

      else
        render :json => {
          :error => "請提供FB access_token"
        }, :status => 401
      end

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def eraseFbLogin
    if authenticate_user_from_token!
      @user = current_user
      @user.fb_uid = nil
      @user.fb_token = nil
      @user.fb_raw_data = nil
      @user.fb_name = nil
      @user.fb_email = nil
      @user.fb_head_shot = nil
      @user.save!

      render :json => {
        :member => {
          :msg => "解除綁定FB",
        }
      }

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def editUserPassword
    if authenticate_user_from_token!
      @user = current_user

      if params[:new_password] == params[:new_password_confirm]
        @user.password = params[:new_password]
        @user.save!
        render :json => {
          :member => {
            :msg => "Edit Password success!",
            :email => @user.email
          }
        }
      end

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def resetPasswordByToken
    original_token       = params[:reset_password_token]
    reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)

    @user = User.find_by(:reset_password_token => reset_password_token)

    if @user  
      @user.password = params[:new_password]
      @user.save
      render :json => {
        :message => "#{@user.email} 密碼重設完畢，請登入"
      }, :status => 200

    else
      render :json => {
        :error => "reset_password_token 錯誤! "
      }, :status => 401
    end
  end

  def getOrder
    if authenticate_user_from_token!
      @user = current_user
      @orders = @user.orders.all

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def getUserGifts
    if authenticate_user_from_token!
      @user = current_user
      @orders = @user.orders.where(:cancelled_at => nil)
      @lotteries = @user.lotteries.includes(:user_lottery_ships).where(:user_lottery_ships =>{:winner => 1})

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def getUserMissGifts
    if authenticate_user_from_token!
      @user = current_user

      public_activies_ids = Activity.where(:status => 1).pluck(:id)
      all_public_merchant_ids = Merchant.all.where(:merchantable_type => "Activity").where(:merchantable_id => public_activies_ids)
      user_order_merchant_ids = @user.orders.pluck(:merchant_id).uniq
      miss_merchant_ids = all_public_merchant_ids - user_order_merchant_ids
      @miss_merchants = Merchant.where(:id => miss_merchant_ids)
      @miss_availible_merchants = @miss_merchants.where(:merchantable_type => "Activity")

      
      win_lotteries_ids = @user.lotteries.includes(:user_lottery_ships).where(:user_lottery_ships =>{:winner => 1}).pluck(:id)
      overtime_lotteries_ids = Lottery.where(:status => 1).where('end_time < ?',Time.now)
      miss_lotteries_ids = overtime_lotteries_ids - win_lotteries_ids
      @miss_overtime_lotteries = Lottery.where(:id => miss_lotteries_ids)


    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone_number ,:address, :birthday, :head_shot)
  end


end
