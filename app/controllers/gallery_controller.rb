class GalleryController < ApplicationController

  def index
    path = File.join(GALLERY_HOME_DIRECTORY, params[:gallery_path])

    if File.exist? path
      @directory = FileSystemItem.new(path)
    else
      redirect_to :action => :index
    end
  end

  def resize_128x128
    resize_XxX(128, 128)
  end

  def resize_1024x768
    resize_XxX(1024, 768)
  end

private

  def resize_XxX(width, height)
    path = File.join(GALLERY_HOME_DIRECTORY, params[:gallery_path])

    image = Magick::Image.read(path).first
    image.background_color = 'transparent'
    image.resize_to_fit!(width, height)
    image = image.extent(width, height, -(width - image.columns) / 2, -(height - image.rows) / 2)
    image.format = 'PNG'

    send_data image.to_blob, disposition: 'inline'
  end

end
