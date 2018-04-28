RSpec.describe ApiEvents::Model do
  class DummyModel
    include ApiEvents::Model
  end

  it "the config is triggered when the broadcast line is added to the model" do
    expect(ApiEvents::Model::Config).to receive(:new).with(DummyModel).and_call_original

    class DummyModel
      broadcast
    end
  end

  it "arguments are sent to the config" do
    expect_any_instance_of(ApiEvents::Model::Config).to receive(:setup).with(dummy: :bar)

    class DummyModel
      broadcast dummy: :bar
    end
  end

  describe "#broadcast_event!" do
    it "triggers the event" do
      dummy      = DummyModel.new
      event_stub = double()

      expect(ApiEvents::Event).to receive(:new).with(dummy, :some_event).and_return(event_stub)
      expect(event_stub).to       receive(:trigger!)

      dummy.broadcast_event!(:some_event)
    end
  end

  describe "#event_name" do
    it "returns the class name and the event" do
      expect(DummyModel.new.event_name(:updated)).to eq "dummy_model_updated"
    end
  end
end
