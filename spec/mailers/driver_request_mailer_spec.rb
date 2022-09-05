require "rails_helper"

RSpec.describe DriverRequestMailer, type: :mailer do
  describe "stage updates" do
    let(:driver_request) { create(:driver_request) }

    context "updates for requester" do
      let(:mail) { described_class.stage_update(driver_request.id) }

      it "renders the subject" do
        expect(mail.subject).to eq("Driver request status update")
      end

      it "renders the receiver email" do
        expect(mail.to).to eq([driver_request.user.email])
      end

      it "renders the sender email" do
        expect(mail.from).to eql(["no-reply@shatit.com"])
      end

      it "assigns @driver_request" do
        expect(mail.body.encoded).to match(driver_request.stage)
      end
    end

    context "updates for admin" do
      let(:mail) { described_class.admin_stage_update(driver_request.id) }

      it "renders the subject" do
        expect(mail.subject).to eq("Driver request status update")
      end

      it "renders the receiver email" do
        expect(mail.to).to eq([User.find_by(role: "admin").email])
      end

      it "renders the sender email" do
        expect(mail.from).to eql(["no-reply@shatit.com"])
      end

      it "assigns @driver_request" do
        expect(mail.body.encoded).to match(driver_request.stage)
      end
    end
  end
end
