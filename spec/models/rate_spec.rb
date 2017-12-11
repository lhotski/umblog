require 'rails_helper'

describe Rate, type: :model do
  it { should belong_to :post }
end
