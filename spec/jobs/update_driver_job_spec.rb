require "rails_helper"

RSpec.describe UpdateDriverJob, type: :job do
  describe "send email to the driver" do
    before { ActiveJob::Base.queue_adapter = :test }
    let(:trip_request) { create(:trip_join_request) }

    it "#perform_later" do
      allow_any_instance_of(described_class).to receive(:perform).with("poldo").and_return(true)

      expect do
        described_class.perform_later(trip_request.id)
      end.to have_enqueued_job
    end
  end
end
