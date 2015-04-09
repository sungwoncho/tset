require "spec_helper"

describe Tset::Translators::Rspec do
  let(:translator) { Tset::Translators::Rspec.new(testable) }
  let(:testable) { Tset::Testable.new('model', code) }
  let(:result) { translator.start }

  context 'for models' do
    context 'validates_presence_of :post' do
      let(:code) { 'validates_presence_of :post' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to validate_presence_of(:post) }"
      end
    end

    context 'validates_uniqueness_of :title' do
      let(:code) { 'validates_uniqueness_of :title' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to validate_uniqueness_of(:title) }"
      end
    end

    context 'validates_uniqueness_of :title' do
      let(:code) { 'validates_uniqueness_of :title' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to validate_uniqueness_of(:title) }"
      end
    end

    context 'validates_length_of :body, maximum: 300' do
      let(:code) { 'validates_length_of :body, maximum: 300' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to ensure_length_of(:body).is_at_most(300) }"
      end
    end

    context 'validates_length_of :body, minimum: 100' do
      let(:code) { 'validates_length_of :body, minimum: 100' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to ensure_length_of(:body).is_at_least(100) }"
      end
    end

    context 'belongs_to :author' do
      let(:code) { 'belongs_to :author' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to belong_to(:author) }"
      end
    end

    context 'has_many :comments' do
      let(:code) { 'has_many :comments' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to have_many(:comments) }"
      end
    end

    context 'has_one :tag' do
      let(:code) { 'has_one :tag' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to have_one(:tag) }"
      end
    end

    context 'has_and_belongs_to_many :admins' do
      let(:code) { 'has_and_belongs_to_many :admins' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to have_and_belong_to_many(:admins) }"
      end
    end

    context 'has_attached_file :profile_picture' do
      let(:code) { 'has_attached_file :profile_picture' }

      it 'returns a proper test' do
        expect(result.code).to eq "it { is.expected_to have_attached_file(:profile_picture) }"
      end
    end
  end
end
