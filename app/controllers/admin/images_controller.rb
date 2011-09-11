class Admin::ImagesController < Admin::BaseController
  def show
    image = Image.find(params[:id])
    # do security check here
    send_file image.upload.path, :type => image.upload_content_type
  end

end
