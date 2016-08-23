class ApiV1::UsersController < ApiController

  before_action :authenticate_user_from_token!, :except => [:resetPasswordByToken]
  before_action :authenticate_user!, :except => [:resetPasswordByToken]

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
      if user_params["avatar_gender"] && !(user_params["avatar_gender"] == "male" || user_params["avatar_gender"] == "female")
        render :json => {
          :error => "user['avatar_gender']格式錯誤，請輸入 'male' 或 'female'!"
        }, :status => 401

      else
        @user = current_user
        @user.update(user_params)
      end

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

      if params[:new_password].blank? || params[:new_password].size < 8
        render :json => {
          :error => "新密碼空白或少於8個字元"
        }, :status => 401

      elsif params[:new_password] != params[:new_password_confirm]
        render :json => {
          :error => "新密碼及確認新密碼不一致"
        }, :status => 401
        

      elsif params[:new_password] == params[:new_password_confirm]
        @user.password = params[:new_password]
        @user.save!
        render :json => {
          :member => {
            :msg => "編輯新密碼成功!",
            :email => @user.email
          }
        }, :status => 200
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
      all_public_merchant_ids = Merchant.all.where(:merchantable_type => "Activity").where(:merchantable_id => public_activies_ids).pluck(:id)
      user_order_merchant_ids = @user.orders.pluck(:merchant_id).uniq
      miss_merchant_ids = all_public_merchant_ids - user_order_merchant_ids
      @miss_merchants = Merchant.where(:id => miss_merchant_ids)
      @miss_availible_merchants = @miss_merchants.where(:merchantable_type => "Activity")

      
      win_lotteries_ids = @user.lotteries.includes(:user_lottery_ships).where(:user_lottery_ships =>{:winner => 1}).pluck(:id)
      overtime_lotteries_ids = Lottery.where(:status => 1).where('end_time < ?',Time.now).pluck(:id)
      miss_lotteries_ids = overtime_lotteries_ids - win_lotteries_ids
      @miss_overtime_lotteries = Lottery.where(:id => miss_lotteries_ids)


    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def countUserGiftsBadge
    if authenticate_user_from_token!
      @user = current_user
      user_click_time = @user.click_user_gifts_at

      @orders = @user.orders.where(:cancelled_at => nil)
      user_orders = @orders.where("created_at > ? ", user_click_time)
      
      @lotteries = @user.lotteries.includes(:user_lottery_ships).where(:user_lottery_ships =>{:winner => 1})
      user_lotteries = @lotteries.where("end_time > ? ", user_click_time)

      @user_gifts_badge_count = user_orders.size + user_lotteries.size

      render :json => {
              :user_gifts_badge_count => @user_gifts_badge_count
            }, :status => 200


    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def clickUserGifts
    if authenticate_user_from_token!

      user = current_user
      user.click_user_gifts_at = Time.now
      user.save

      render :json => {
              :success => "記錄點擊已領取"
            }, :status => 200
    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def countUserMissGiftsBadge
    if authenticate_user_from_token!
      @user = current_user
      user_click_time = @user.click_user_miss_gifts_at

      public_activies_ids = Activity.where(:status => 1).pluck(:id)
      all_public_merchant_ids = Merchant.all.where(:merchantable_type => "Activity").where(:merchantable_id => public_activies_ids).pluck(:id)
      user_order_merchant_ids = @user.orders.pluck(:merchant_id).uniq
      miss_merchant_ids = all_public_merchant_ids - user_order_merchant_ids
      @miss_merchants = Merchant.where(:id => miss_merchant_ids)
      @miss_availible_merchants = @miss_merchants.where(:merchantable_type => "Activity")

      
      win_lotteries_ids = @user.lotteries.includes(:user_lottery_ships).where(:user_lottery_ships =>{:winner => 1}).pluck(:id)
      overtime_lotteries_ids = Lottery.where(:status => 1).where('end_time < ?',Time.now).pluck(:id)
      miss_lotteries_ids = overtime_lotteries_ids - win_lotteries_ids
      @miss_overtime_lotteries = Lottery.where(:id => miss_lotteries_ids)


      user_miss_merchants = @miss_availible_merchants.where("created_at > ? ", user_click_time)
      user_miss_lotteries = @miss_overtime_lotteries.where("end_time > ? ", user_click_time)

      @user_miss_gifts_badge_count = user_miss_merchants.size + user_miss_lotteries.size

      render :json => {
              :user_miss_gifts_badge_count => @user_miss_gifts_badge_count
            }, :status => 200


    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def clickUserMissGifts
    if authenticate_user_from_token!

      user = current_user
      user.click_user_miss_gifts_at = Time.now
      user.save

      render :json => {
              :success => "記錄點擊未領取"
            }, :status => 200
    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def addFavoriteActivity
    if authenticate_user_from_token!

      if !params[:activity_id]
        render :json => {
                :error => "請回傳 activity_id"
              }, :status => 200

      elsif !Activity.find_by(:id => params[:activity_id])
        render :json => {
                :error => " 活動 id 錯誤"
              }, :status => 200

      elsif current_user && !current_user.user_activity_favoritings.find_by(:activity_id => params[:activity_id])
        @favoriting = current_user.user_activity_favoritings.new
        @favoriting.activity_id = params[:activity_id]
        @favoriting.save

        render :json => {
                :success => "活動收藏完成"
              }, :status => 200
      else
        render :json => {
                :error => "活動已經收藏過了"
              }, :status => 200
      end

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def removeFavoriteActivity
    if authenticate_user_from_token!

      if !params[:activity_id]
        render :json => {
                :error => "請回傳 activity_id"
              }, :status => 200

      elsif !Activity.find_by(:id => params[:activity_id])
        render :json => {
                :error => " 活動 id 錯誤"
              }, :status => 200

      elsif current_user && current_user.user_activity_favoritings.find_by(:activity_id => params[:activity_id])
        @favoriting = current_user.user_activity_favoritings.find_by(:activity_id => params[:activity_id])
        @favoriting.destroy

        render :json => {
                :success => "移除收藏"
              }, :status => 200
      else
        render :json => {
                :error => "沒有收藏過此活動"
              }, :status => 200
      end

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  def showFavoriteActivity
    if authenticate_user_from_token!

      if current_user
        @activities = current_user.activities
        @favoritings_count = current_user.favoritings_count
        @favoritings = current_user.user_activity_favoritings
      end

    else
      render :json => {
        :error => "auth_token is wrong!"
      }, :status => 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone_number ,:address, 
                                  :birthday, :head_shot, :avatar_gender)
  end


end
