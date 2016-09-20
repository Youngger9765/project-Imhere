class AuthorizeController < ApplicationController
  def not_authorized
    @text = "你沒有得到授權"
  end
end