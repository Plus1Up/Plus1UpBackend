require 'rails_helper'

RSpec.describe Exercise, type: :model do
  subject {
    described_class.new(
        coach: Coach.new,
        name: "Exercise test name",
        category: "triceps"
    )
  }

  # Validation test
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without couch" do
    subject.coach = nil
    expect(subject).to be_invalid
  end

  it "is not valid without name" do
    subject.name = nil
    expect(subject).to be_invalid
  end

  it "is not valid without category" do
    subject.category = nil
    expect(subject).to be_invalid
  end

  # Uniqueness test
  it {should validate_uniqueness_of(:name)}

end
