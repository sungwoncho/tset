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
        create_file("app/models/#{name}.rb")
      end

      context 'with rspec' do

        before do
          command.start
        end

        it 'generates a model spec' do
          content = @root.join('spec/models/post_spec.rb').read
          expect(content).to match %(require 'spec_helper')
        end
      end

      context 'with minitest' do
        let(:framework) { 'minitest' }

        before do
          command.start
        end

        it 'generates a model test' do
          content = @root.join('test/models/post_test.rb').read
          expect(content).to match %(require 'test_helper')
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
