require "spec_helper"

describe 'tset generate model post' do
  let(:name) { 'post' }
  let(:cli) { Tset::Cli.new }
  let(:command) { Tset::Commands::Generate.new(type, name, framework, cli) }
  let(:type) { 'model' }
  let(:model_content) {
    "validates_presence_of :author
    validates_presence_of :title
    validates_presence_of :body
    validates_length_of :title, maximum: 30
    validates_length_of :body, minimum: 50
    belongs_to :author
    has_and_belongs_to_many :categories
    has_many :comments" }

  before do
    set_up_testing_directory
    create_file("app/models/#{name}.rb")
    insert_into_file("app/models/#{name}.rb", model_content)
  end

  after do
    chdir_back_to_root
  end

  context 'with rspec' do
    let(:framework) { 'rspec' }

    before(:each) do
      command.start
    end

    it 'generates the correct spec' do
      content = @root.join('spec/models/post_spec.rb').read
      expect(content).to match %(require 'spec_helper')
      expect(content).to match %(describe Post do)
      expect(content).to match %(  describe "associations" do)
      expect(content).to match %r(    it { is.expected_to have_and_belong_to_many\(:categories\) })
      expect(content).to match %r(    it { is.expected_to have_many\(:comments\) })
      expect(content).to match %r(    it { is.expected_to belong_to\(:author\) })
      expect(content).to match %(  end)
      expect(content).to match %(  describe "validations" do)
      expect(content).to match %r(    it { is.expected_to validate_presence_of\(:author\))
      expect(content).to match %r(    it { is.expected_to validate_presence_of\(:title\) })
      expect(content).to match %r(    it { is.expected_to validate_presence_of\(:body\) })
      expect(content).to match %r(    it { is.expected_to ensure_length_of\(:title\).is_at_most\(30\) })
      expect(content).to match %r(    it { is.expected_to ensure_length_of\(:body\).is_at_least\(50\) })
      expect(content).to match %(  end)
      expect(content).to match %(end)
    end
  end
end
