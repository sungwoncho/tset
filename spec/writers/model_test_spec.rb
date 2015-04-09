require "spec_helper"

describe Tset::Writers::ModelTest do
  let(:writer) { Tset::Writers::ModelTest.new(model_name, testables, framework) }
  let(:model_name) { 'post' }

  before do
    set_up_testing_directory
    create_file('app/models/post.rb')
    create_file('spec/models/post_spec.rb')
    insert_into_file('spec/models/post_spec.rb', "describe Post do")
  end

  after do
    chdir_back_to_root
  end

  context 'rsepc' do
    let(:framework) { 'rspec' }
    let(:testables) { [Tset::Testable.new('model', 'validates_presence_of :author')] }

    it 'writes a test' do
      writer.start!

      content = @root.join('spec/models/post_spec.rb').read
      expect(content).to match %r(it { is.expected_to validate_presence_of\(:author\) })
    end
  end
end
