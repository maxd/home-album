module FileSystemItemDecorator

  def title
    File.basename(@path, '.*')
  end

  def original_url
    PathExtensions.normalize(File.join(namespace, relative_path))
  end

  def thumbnail_url
    if File.directory? @path
      ActionController::Base.helpers.image_path('directory.png')
    else
      relative_directory = File.dirname(relative_path)
      file_name = File.basename(relative_path)

      File.join(PICTURES_NAMESPACE, File.join(relative_directory, 'thumbnail', file_name))
    end
  end

  def breadcrumbs
    result = []

    result << self
    while result.last.can_back?
      result << result.last.back_item
    end

    result.reverse
  end

private

  def namespace
    File.directory?(@path) ? GALLERY_NAMESPACE : PICTURES_NAMESPACE
  end

  def relative_path
    @path.gsub(GALLERY_HOME_DIRECTORY, '')
  end

end