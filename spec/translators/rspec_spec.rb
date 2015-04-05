require "spec_helper"

describe Tset::Translators::Rspec do
  let(:translator) { Tset::Translators::Rspec.new(testable) }
  let(:testable) { Tset::Testable.new('model', code) }
  let(:result) { translator.start }

  context 'for models' do
    context 'validates_presence_of :post' do
      let(:code) { 'validates_presence_of :post' }

      it 'returns a proper test' do
        expect(result).to eq "it { is.expected_to validate_presence_of(:post) }"
      end
    end

    context 'validates :post, presence: true' do
      let(:code) { 'validates :post, presence: true' }

      it 'returns a proper test' do
        expect(result).to eq "it { is.expected_to validate_presence_of(:post) }"
      end
    end

    context 'belongs_to :author' do
      let(:code) { 'belongs_to :author' }

      it 'returns a proper test' do
        expect(result).to eq "it { is.expected_to belong_to(:author) }"
      end
    end

    context 'has_many :comments' do
      let(:code) { 'has_many :comments' }

      it 'returns a proper test' do
        expect(result).to eq "it { is.expected_to have_many(:comments) }"
      end
    end

    context 'has_one :tag' do
      let(:code) { 'has_one :tag' }

      it 'returns a proper test' do
        expect(result).to eq "it { is.expected_to have_one(:tag) }"
      end
    end
  end
end
