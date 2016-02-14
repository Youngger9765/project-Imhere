class AttachmentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def upload
    @attachment = Attachment.new
    @attachment.picture = params[:file]
    @attachment.save

    respond_to do |format|
        format.json { render :json => { status: 'OK', link: @attachment.picture.url}}
    end
  end
end
