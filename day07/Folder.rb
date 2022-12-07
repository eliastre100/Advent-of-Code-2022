class Folder
  attr_accessor :path

  def initialize(path, parent)
    @path = path
    @parent = parent
    @folders = {}
    @files = {}
  end

  def folder(name)
    @folders[name]
  end

  def parent
    @parent
  end

  def create_folder(name)
    @folders[name] = Folder.new(name, self) unless folder(name)
  end

  def create_file(name, size)
    @files[name] = size.to_i unless @files[name]
  end

  def size
    file_sizes = @files.inject(0) { |sum, file| sum + file[1] }
    folder_sizes = @folders.inject(0) { |sum, folder| sum + folder[1].size }
    file_sizes + folder_sizes
  end

  def select_folders(&block)
    selected_folders = @folders.values.map { |folder| folder.select_folders(&block) }
    if block.call(self)
      (selected_folders + [self]).flatten
    else
      selected_folders.flatten
    end
  end

  def dump(depth = 0)
    puts "  " * depth + "- #{path} (dir)"
    @folders.each { |_, folder| folder.dump(depth + 1) }
    @files.each {|name, size| puts "  " * (depth + 1) + "- #{name} (file, size=#{size})"}
  end
end
