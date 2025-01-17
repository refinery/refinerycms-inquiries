require 'spec_helper'

module Refinery
  module Inquiries
    describe Inquiry, :type => :model do
      describe "validations" do
        subject do
          FactoryBot.build(:inquiry, {
            name: "Ugis Ozols",
            email: "ugis.ozols@example.com",
            message: "Hey, I'm testing!"
          })
        end

        it { is_expected.to be_valid }

        describe '#errors' do
          subject { super().errors }
          it { is_expected.to be_empty }
        end

        describe '#name' do
          subject { super().name }
          it { is_expected.to eq("Ugis Ozols") }
        end

        describe '#email' do
          subject { super().email }
          it { is_expected.to eq("ugis.ozols@example.com") }
        end

        describe '#message' do
          subject { super().message }
          it { is_expected.to eq("Hey, I'm testing!") }
        end

        it "validates name length" do
          expect(FactoryBot.build(:inquiry, {
            name: "a"*255,
            email: "ugis.ozols@example.com",
            message: "This Text Is OK"
          })).to be_valid
          expect(FactoryBot.build(:inquiry, {
            name: "a"*256,
            email: "ugis.ozols@example.com",
            message: "This Text Is OK"
          })).not_to be_valid
        end
        it "validates email length" do
          expect(FactoryBot.build(:inquiry, {
            name: "Ugis Ozols",
            email: "a"*243 + "@example.com",
            message: "This Text Is OK"
          })).to be_valid
          expect(FactoryBot.build(:inquiry, {
            name: "Ugis Ozols",
            email: "a"*244 + "@example.com",
            message: "This Text Is OK"
          })).not_to be_valid
        end
      end

      describe "default scope" do
        before { Refinery::Inquiries::Inquiry.destroy_all }
        it "orders by created_at in desc" do
          inquiry1 = FactoryBot.create(:inquiry, created_at: 1.hour.ago)
          inquiry2 = FactoryBot.create(:inquiry, created_at: 2.hours.ago)
          inquiries = Inquiry.all
          expect(inquiries.first).to eq(inquiry1)
          expect(inquiries.second).to eq(inquiry2)
        end
      end

      describe ".latest" do
        it "returns latest 7 non-spam inquiries by default" do
          8.times { FactoryBot.create(:inquiry) }
          Inquiry.last.toggle!(:spam)
          expect(Inquiry.latest.length).to eq(7)
        end

        it "returns latest 7 inquiries including spam ones" do
          7.times { FactoryBot.create(:inquiry) }
          Inquiry.all[0..2].each { |inquiry| inquiry.toggle!(:spam) }
          expect(Inquiry.latest(7, true).length).to eq(7)
        end

        it "returns latest n inquiries" do
          4.times { FactoryBot.create(:inquiry) }
          expect(Inquiry.latest(3).length).to eq(3)
        end
      end
    end
  end
end
