require 'spec_helper'

describe Recipe do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }

end
