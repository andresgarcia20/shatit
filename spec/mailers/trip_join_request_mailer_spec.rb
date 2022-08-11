require "rails_helper"

RSpec.describe TripJoinRequestMailer, type: :mailer do
  describe "stage updates" do
    let(:trip_request) { create(:trip_join_request) }

    context "updates for requester" do
      let(:mail) { described_class.stage_update(trip_request.id) }

      it "renders the subject" do
        expect(mail.subject).to eq("Trip request status update")
      end

      it "renders the receiver email" do
        expect(mail.to).to eq([trip_request.user.email])
      end

      it "renders the sender email" do
        expect(mail.from).to eql(["no-reply@shatit.com"])
      end

      it "assigns @trip_request" do
        expect(mail.body.encoded).to match(trip_request.stage)
      end
    end

    context "updates for driver" do
      let(:mail) { described_class.driver_stage_update(trip_request.id) }

      it "renders the subject" do
        expect(mail.subject).to eq("Trip request status update for your trip")
      end

      it "renders the receiver email" do
        expect(mail.to).to eq([trip_request.trip.user.email])
      end

      it "renders the sender email" do
        expect(mail.from).to eql(["no-reply@shatit.com"])
      end

      it "assigns @trip_request" do
        expect(mail.body.encoded).to match(trip_request.stage)
      end
    end
  end
end
