require 'rails_helper'
  describe Student,type: :model do
      
       it "is invalid without a grade" do
         student =build(:student, grade: nil)
         student.valid?
         expect(student.errors).to be_added(:grade, :blank)
      end
      
      it "is invalid without an email" do
        student = build(:student,email: nil)
        student.valid?
        expect(student.errors).to be_added(:email, :blank)
      end
      
      it "is invalid without a password" do
         student = build(:student,  password: nil)
         student.valid?
         expect(student.errors).to be_added(:password, :blank)
      end
      
       it "is invalid without a password_confirmation although with a password" do
         student = build(:student, password_confirmation: nil)
         student.valid?
         expect(student.errors).to be_added(:password_confirmation, :blank)
      end
      
       it "is invalid with a duplicate email " do
         student = create(:student)
         another_student= build(:student, email: student.email)
         another_student.valid?
         expect(another_student.errors[:email]). to include("はすでに存在します。")
      end
      
       it "password requires more than 6 characters " do
         student = build(:student, password: "00000",password_confirmation:  "00000")
         student.valid?
         expect(student.errors.added?(:password, :too_short, count: 6)).to be_truthy
      end
      # too_short
      it "is valid with email password password_confirmation grade" do
        student = build(:student, grade: "3", email: "test@test", password: "00000000", password_confirmation: "00000000")
        # student.valid?
        expect(student).to be_valid
      end
      
    #   it "is invalid with a grade except 1 or 2 0r 3 or 4" do
    #      student =build(:student, grade: "5")
    #      student.valid?
    #      expect(student.errors.added?(:grade,:expect_grade)).to be_truthy
    #   end
      
      # full_profile?メソッドの検証
      it "returns true if all columns are full" do
        student =create(:student)
        student.valid?
        expect(student.full_profile?).to eq true
     end
     
  end