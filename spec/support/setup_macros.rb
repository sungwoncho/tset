module SetupMacros
  def set_up_testing_directory
    @tmp = Pathname.new(@pwd = Dir.pwd).join('tmp')
    @tmp.rmtree if @tmp.exist?
    @tmp.mkpath

    @tmp.join('apps/controllers').mkpath
    @tmp.join('apps/models').mkpath

    Dir.chdir(@tmp)
    @root = @tmp
  end

  def chdir_back_to_root
    Dir.chdir(@pwd)
  end

  def create_file(dir, name)
    file = @root.join("app/#{dir}/#{name}.rb")
    file.dirname.rmtree if file.dirname.exist?
    file.dirname.mkpath
    FileUtils.touch(file)
  end

  def erase_file_content(dir, name)
    file = @root.join("app/#{dir}/#{name}.rb")
    File.open(file, 'w') {}
  end

  def insert_into_file(dir, name, content)
    file = @root.join("app/#{dir}/#{name}.rb")
    File.write(file, content)
  end
end
