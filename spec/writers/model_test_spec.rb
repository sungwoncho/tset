require "spec_helper"

describe Tset::Writers::ModelTest do
  let(:writer) { Tset::Writers::ModelTest.new(model_name, testables, framework) }
  let(:model_name) { 'post' }

  before do
    set_up_testing_directory
    create_file('app/models/post.rb')
    create_file('spec/models/post_spec.rb')
  end

  before(:each) do
    erase_file_content('spec/models/post_spec.rb')
  end

  after do
    chdir_back_to_root
  end

  context 'rsepc' do
    let(:framework) { 'rspec' }

    context 'validates_presence_of' do
      let(:testables) { [Tset::Testable.new('model', 'validates_presence_of :author')] }

      it 'writes a test' do
        writer.start!

        content = @root.join('spec/models/post_spec.rb').read
        expect(content).to eq %(it { is.expected_to validate_presence_of(:author) })
      end
    end
  end
end
