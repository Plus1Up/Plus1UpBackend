require "rails_helper"

RSpec.describe Coach, type: :model do
  subject {
    described_class.new(
        mail_address: Faker::Internet.email,
        password: Faker::Internet.password(3, 6),
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
  }

  # Validation test
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without mail address" do
    subject.mail_address = nil
    expect(subject).to be_invalid
  end

  it "is not valid without password" do
    subject.password = nil
    expect(subject).to be_invalid
  end

  it "is not valid without name" do
    subject.name = nil
    expect(subject).to be_invalid
  end

  it "is not valid without last name" do
    subject.last_name = nil
    expect(subject).to be_invalid
  end

  # Uniqueness test
  it {should validate_uniqueness_of(:mail_address)}
end
