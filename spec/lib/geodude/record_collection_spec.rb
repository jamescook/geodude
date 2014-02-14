require "spec_helper"

describe Geodude::RecordCollection do
  let(:fixture) { File.expand_path("spec/fixtures/test1.shp") }
  let(:file) { File.open(fixture) }

  after { file.rewind }

  describe "#count" do
    subject { described_class.new(file) }

    before do
      file.seek(100) # skip the file header
    end

    it "knows the total number of records" do
      expect(subject.count).to eq 3
    end
  end

  describe "#next" do
    subject { described_class.new(file) }

    before do
      file.seek(100)
    end

    it "returns the next record" do
      expect(subject.next).to be_an_instance_of(Geodude::PolygonRecord)
    end
  end
end
