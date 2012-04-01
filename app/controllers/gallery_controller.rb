class GalleryController < ApplicationController

  def index
    path = File.join(GALLERY_HOME_DIRECTORY, params[:gallery_path])

    if File.exist? path
      @directory = FileSystemItem.new(path)
    else
      redirect_to :action => :index
    end
  end

end
