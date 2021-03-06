RSpec.describe ApiEvents::Event do
  describe "#broadcast!" do
    it "triggers the request" do
      model        = double(event_name: :foo_created, json_payload: { foo: :bar })
      stub_request = double()
      ApiEvents.configuration.listeners = ["http://my-endpoint.com/"]

      expect(ApiEvents::Request).to receive(:new).with(:foo_created, { foo: :bar }).and_return(stub_request)
      expect(stub_request).to       receive(:trigger!).with(urls: ["http://my-endpoint.com/"])

      described_class.new(model, :created).broadcast!
    end
  end

  describe "#event_name" do
    it "asks the record for its event_name" do
      model = double()
      allow(model).to receive(:event_name).with(:updated).and_return(:model_updated)

      expect(described_class.new(model, :updated).send(:event_name)).to eq :model_updated
    end
  end

  describe "#endpoints" do
    it "return listeners" do
      ApiEvents.configuration.listeners = ["my-listeners"]
      expect(described_class.new(double(), :updated).send(:endpoints)).to eq ["my-listeners"]
    end

    it "raises an error when no listeners given" do
      ApiEvents.reset
      expect { described_class.new(double(), :updated).send(:endpoints) }.to raise_error ApiEvents::Event::NO_ENDPOINTS_ERROR
    end
  end
end
