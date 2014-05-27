require 'spec_helper'

describe User do
  it { should have_many(:recipes) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
