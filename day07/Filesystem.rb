require_relative 'folder'

class FileSystem < Folder
  def initialize(capacity = 70000000)
    super "/", self
    @capacity = capacity
  end

  def freespace
    @capacity - size
  end
end
