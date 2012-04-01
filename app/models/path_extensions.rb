module PathExtensions

  def self.normalize(str)
    str.gsub(/[\\\/]$/, '')
  end

end