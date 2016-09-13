class UsersController < ApplicationController

  before_action :authenticate_user!, :except =>[:confirm]

  def show
    @user = current_user
  end

  def confirm
    token = params[:confirmation_token]
    user = User.find_by(:confirmation_token => token)
    latest_activity = Activity.where.not(:subdomain => nil).where(:status => 1).order("created_at DESC").first
    subdomain = latest_activity.subdomain

    front_domain = YAML.load(File.read("#{Rails.root}/config/domain_variables.yml"))[Rails.env]
    front_domain_name = front_domain["FRONT_DOMAIN"]

    if user
      user.confirmed_at = Time.now
      user.save

      redirect_url = "http://" + subdomain + "." + front_domain_name + "#registerOk"
      redirect_to redirect_url

    else
      redirect_url = "http://" + subdomain + "." + front_domain_name + "#registerFail"
      redirect_to redirect_url
    end
  end

end
