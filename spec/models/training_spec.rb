require 'rails_helper'

RSpec.describe Training, type: :model do
  subject {
    described_class.new(
        name: Faker::StarWars.character,
        weekday: Random.rand(6),
        client: Client.first
    )
  }

  # Validation test
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without mail address" do
    subject.name = nil
    expect(subject).to be_invalid
  end

  it "is not valid without password" do
    subject.weekday = nil
    expect(subject).to be_invalid
  end

end
