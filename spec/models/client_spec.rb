require "rails_helper"

RSpec.describe Client, type: :model do
  subject {
    described_class.new(
        coach: Coach.new,
        mail_address: Faker::Internet.email,
        password: Faker::Internet.password(3, 6),
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
  }

  # Association test
  # ensure Client model has a m:1 relationship with the Coach model
  it {should belong_to(:coach)}

  # Validation test
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without coach" do
    subject.coach = nil
    expect(subject).to be_invalid
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

  # Default values test
  it "should be created with true pending status" do
    expect(subject.is_pending).to eq true
  end

  it "should be created with nil active status" do
    expect(subject.is_active).to eq nil
  end

  # Uniqueness test
  it {should validate_uniqueness_of(:mail_address)}

  # Diet plan validations
  it {should have_attached_file(:diet_plan)}

  it {should validate_attachment_content_type(:diet_plan).allowing('application/pdf')}

end
