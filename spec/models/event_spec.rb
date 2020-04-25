require 'rails_helper'
  describe Event,type: :model do
    describe '#create' do
      
      # it "is invalid without a title" do
        
      # end
      
      # it "is invalid without a date" do
         
      # end
      
      # it "is invalid without a descrip" do
         
      # end
      
      
      # it "is invalid without a where" do
         
      # end
      
      it "is invalid without a group_id" do
        event =build(:event, group_id: nil)
        event.valid?
        expect(event.errors).to be_added(:group_id, :blank)
         
      end
      
       it "is valid with title where date descrip group_id image" do
        # buildではなくcreate
        event = create(:event)
        puts "This event's group is #{event.group.inspect}"
        event.valid?
        expect(event).to be_valid
      end
      
      
    end
  end