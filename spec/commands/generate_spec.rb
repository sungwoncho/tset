require "spec_helper"

describe Tset::Commands::Generate do
  let(:name) { 'post' }
  let(:cli) { Tset::Cli.new }
  let(:command) { Tset::Commands::Generate.new(type, name, framework, cli) }

  before do
    set_up_testing_directory
  end

  after do
    chdir_back_to_root
  end

  describe 'model' do
    let(:type) { 'model' }
    let(:framework) { 'rspec' }

    context 'when the model exists' do
      before do
        post_model = @root.join('app/models/post.rb')
        post_model.dirname.mkpath
        FileUtils.touch(post_model)
      end

      context 'with rspec' do

        before do
          command.start
        end

        it 'generates the model spec' do
          content = @root.join('spec/models/post_spec.rb').read
          expect(content).to match %(require 'spec_helper')
        end
      end
    end

    context 'when the model does not exist' do
      it 'raises error' do
        expect {
          command.start
        }.to raise_error(Tset::Commands::Generate::Error)
      end
    end

  end
end
