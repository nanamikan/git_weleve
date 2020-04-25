require 'rails_helper'

RSpec.describe Group, type: :model do
  
  # full_profile?メソッドの検証
      it "returns true if all columns are full" do
        group =create(:group)
        group.valid?
        expect(group.full_profile?).to eq true
     end
  
end
