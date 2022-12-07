require_relative 'folder'

class FileSystem < Folder
  def initialize
    super "/", self
  end
end
