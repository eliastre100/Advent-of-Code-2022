class Terminal
  def initialize(filesystem)
    @filesystem = filesystem
    @current_path = filesystem
    @commands = {
      "cd": method(:change_directory),
      "ls": method(:list_directory)
    }
  end

  def interpret(cmd, result)
    cmd, arguments = cmd.split(" ")
    @commands[cmd.to_sym].call(arguments, result)
  end

  def change_directory(path, _)
    case path
      when "/"
        @current_path = @filesystem
      when ".."
        @current_path = @current_path.parent
      else
        @current_path = @current_path.folder(path)
    end
  end

  def list_directory(_, results)
    results.each do |result|
      type_size, name = result.split(" ")
      if type_size.eql?("dir")
        @current_path.create_folder(name)
      else
        @current_path.create_file(name, type_size)
      end
    end
  end
end
