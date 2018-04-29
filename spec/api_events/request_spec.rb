RSpec.describe ApiEvents::Request do
  before do
    @request = described_class.new(:updated, { foo: :bar })
    @params  = @request.params
  end

  describe "#trigger!" do
    it "triggers a POST to the given endpoint" do
      expect(described_class).to receive(:post).with("some_endpoint", @params)
      @request.trigger!(endpoints: "some_endpoint")
    end

    it "allos to trigger the request to multiple endpoints" do
      expect(described_class).to receive(:post).with("endpoint_1", @params)
      expect(described_class).to receive(:post).with("endpoint_2", @params)

      @request.trigger!(endpoints: ["endpoint_1", "endpoint_2"])
    end
  end

  describe "#params" do
    it "returns the event and the payload" do
      result = @request.params
      expect(result).to include(event: :updated)
      expect(result).to include(data: { foo: :bar })
    end
  end
end
