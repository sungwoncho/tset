require "spec_helper"

describe Tset::Analyzers::Model do
  let(:name) { 'post' }
  let(:analyzer) { Tset::Analyzers::Model.new(name) }

  before do
    set_up_testing_directory
    create_file("app/models/#{name}.rb")
  end

  before(:each) do
    erase_file_content("app/models/#{name}.rb")
  end

  after do
    chdir_back_to_root
  end

  it 'returns an array of testable codes' do
    content = "
  belongs_to :author
  has_one :tipjar
  has_many :comments
  has_many :likes
  lets_validate_this :forum
  validates_presence_of :post
  acts_as_votable
  validates_presence_of :author
  validates :category, presence: true
"
    insert_into_file("app/models/#{name}.rb", content)
    result = analyzer.start

    expect(result.map(&:code)).to match_array ['validates_presence_of :post', 'validates_presence_of :author', 'validates :category, presence: true',
                                    'belongs_to :author', 'has_one :tipjar', 'has_many :comments', 'has_many :likes']

  end
end
