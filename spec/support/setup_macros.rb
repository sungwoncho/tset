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
end
