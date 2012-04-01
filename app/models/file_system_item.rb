class FileSystemItem

  include FileSystemItemDecorator

  WRONG_SYMBOLS = [/[\\\/]+/, /\./, /\.\./]

  def initialize(path)
    @path = PathExtensions.normalize path
  end

  def can_back?
    @path != GALLERY_HOME_DIRECTORY
  end

  def back_item
    FileSystemItem.new(File.dirname(@path))
  end

  def directory_items
    directory_pattern = File.join(@path, '/*/')
    get_items directory_pattern
  end

  def picture_items
    pictures_pattern = File.join(@path, '*.{jpg,jpeg,png}')
    get_items pictures_pattern
  end

private

  def get_items(pattern)
    Dir.glob(pattern, File::FNM_CASEFOLD).sort.collect {|p| FileSystemItem.new(p) }
  end

end