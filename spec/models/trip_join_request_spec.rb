require "rails_helper"

RSpec.describe TripJoinRequest, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  describe "model" do
    let(:trip_request) { create(:trip_join_request) }
    let(:trip) { create(:trip) }

    context "validation" do
      it "returns true if trip join request has all permited params" do
        expect(trip_request.valid?).to be true
      end

      context "companions" do
        it "returns true if positive numbers are introduced" do
          expect(trip_request.valid?).to be true
        end

        it "returns false if negative numbers are introduced" do
          trip_request.companions = -3
          expect(trip_request.valid?).to be false
        end

        it "returns false if no numbers are introduced" do
          trip_request.companions = "a"
          expect(trip_request.valid?).to be false
        end

        it "returns true if number of companions plus coordinator is equal or less than available seats" do
          trip_request.companions = 2
          expect(trip_request.companions + 1).to be <= build(:trip, :three_available_seats).available_seats
        end

        it "returns false if number of companions plus coordinator is more than available seats" do
          trip_request.companions = 3
          expect(trip_request.companions + 1).not_to be <= trip.available_seats
        end

        context "returns true if the number of available seats decreases depending of number of companions" do
          before do
            @trip = create(:trip, :four_available_seats)
            @trip_request = create(:trip_join_request, :three_companion, trip: trip)
          end

          it { expect(@trip_request.trip.available_seats - 1).to eq(0) }
        end
      end

      context "pets" do
        it "returns true if positive numbers are introduced" do
          expect(trip_request.valid?).to be true
        end

        it "returns false if negative numbers are introduced" do
          trip_request.pets = -3
          expect(trip_request.valid?).to be false
        end

        it "returns false if no numbers are introduced" do
          trip_request.pets = "a"
          expect(trip_request.valid?).to be false
        end

        it "returns true if number of pets is equal or less than pets admited" do
          trip_request.pets = 1
          expect(trip_request.pets).to be <= trip.pets
        end

        it "returns false if number of pets is more than pets admited" do
          expect(build(:trip_join_request, :two_pets).pets).to be > trip.pets
        end
      end

      context "luggage" do
        it "returns true if positive numbers are introduced" do
          expect(trip_request.valid?).to be true
        end

        it "returns false if negative numbers are introduced" do
          trip_request.luggage = -3
          expect(trip_request.valid?).to be false
        end

        it "returns false if no numbers are introduced" do
          trip_request.luggage = "a"
          expect(trip_request.valid?).to be false
        end

        it "returns true if number of luggage is equal or less than luggage admited" do
          trip_request.luggage = 1
          expect(trip_request.luggage).to be <= trip.luggage
        end

        it "returns false if number of luggage is more than admited" do
          expect(build(:trip_join_request, :three_luggage).luggage).to be > trip.luggage
        end
      end

      context "kids" do
        it "returns false if the input is empty" do
          expect(trip_request.kids.size).to be > 0
        end
      end
    end

    context "stage cycle" do
      let(:user) { create(:user) }
      it "returns true if 'requested' is the default stage" do
        expect(TripJoinRequest.new.stage).to eq(trip_request.stage)
      end

      context "requested" do
        it "if driver accepts request, stage change to 'accepted'" do
          TripJoinRequestStageManager.accept!(trip_request)
          expect(trip_request.stage).to eq("accepted")
        end

        it "if driver rejects request, stage change to 'rejected'" do
          TripJoinRequestStageManager.reject!(trip_request)
          expect(trip_request.stage).to eq("rejected")
        end
      end

      context "accepted" do
        let(:trip_request) { build(:trip_join_request, stage: 10) }

        it "if user continue to payment, stage change to 'payment_in_progress'" do
          TripJoinRequestStageManager.pay!(trip_request)
          expect(trip_request.stage).to eq("payment_in_progress")
        end

        it "if user cancels request, stage change to 'canceled'" do
          TripJoinRequestStageManager.canceled!(trip_request)
          expect(trip_request.stage).to eq("canceled")
        end

        context "accept! validation" do
          before { travel_to Time.zone.local(2022, 07, 28) }
          let(:first_user) { create(:user) }
          let(:second_user) { create(:user) }
          let(:first_trip) { create(:trip, :two_pets, departure_date: "2022-08-20".to_date) }
          let(:second_trip) { create(:trip, departure_date: "2022-08-20".to_date) }
          let!(:first_trip_request) { create(:trip_join_request, :two_pets, trip_id: first_trip.id, user_id: first_user.id) }
          let!(:second_trip_request) { create(:trip_join_request, trip_id: second_trip.id, user_id: first_user.id) }
          let!(:third_trip_request) { create(:trip_join_request, trip_id: first_trip.id, user_id: second_user.id) }
          let!(:fourth_trip_request) { create(:trip_join_request, :two_pets, trip_id: first_trip.id, user_id: second_user.id) }

          it "when user has two requests with same date: if one gets accepted, the other gets rejected" do
            TripJoinRequestStageManager.accept!(first_trip_request)
            second_trip_request.reload
            expect(second_trip_request.rejected?).to be true
          end

          context "if one request gets accepted, others incompatible get rejected" do
            it "rejected for avaible_seats" do
              TripJoinRequestStageManager.accept!(first_trip_request)
              third_trip_request.reload
              expect(third_trip_request.rejected?).to be true
            end

            it "rejected for pets" do
              TripJoinRequestStageManager.accept!(first_trip_request)
              fourth_trip_request.reload
              expect(fourth_trip_request.rejected?).to be true
            end
          end
        end
      end

      context "payment_in_progress" do
        let(:trip_request) { build(:trip_join_request, stage: 20) }

        it "if payment success, stage change to 'paid'" do
          TripJoinRequestStageManager.paid!(trip_request)
          expect(trip_request.stage).to eq("paid")
        end

        it "if payment fails, stage change to 'accepted'" do
          TripJoinRequestStageManager.accept!(trip_request)
          expect(trip_request.stage).to eq("accepted")
        end
      end

      context "paid" do
        context "when the trip finalizes" do
          let(:new_trip) { create(:trip) }
          let!(:new_user) { create(:user) }
          let!(:trip_request) { create(:trip_join_request, :one_companion, stage: 30, trip_id: new_trip.id, user_id: new_user.id) }

          it "coordinator has to be in trip users list" do
            new_trip.finalized!
            expect(new_trip.passengers_list.map { |h| h["phone_number"] }).to include(new_user.phone_number)
          end

          it "coordinator's companions have to be in trip users list" do
            new_trip.finalized!
            expect(new_trip.passengers_list.map { |h| h["phone_number"] }).to include(*trip_request.requesters_list.map { |h| h["phone_number"] })
          end
        end
      end

      context "rejected" do
        let(:trip_request) { build(:trip_join_request, stage: 0) }

        it "if driver rejects request, stage change to 'rejected'" do
          TripJoinRequestStageManager.reject!(trip_request)
          expect(trip_request.stage).to eq("rejected")
        end
      end
    end
  end
end
