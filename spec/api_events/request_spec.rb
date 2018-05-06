RSpec.describe ApiEvents::Request do
  before do
    @request = described_class.new(:updated, { foo: :bar })
    @params  = @request.params
  end

  describe "#trigger!" do
    it "triggers a POST to the given endpoint" do
      expect(described_class).to receive(:post).with("some_endpoint/api/events", body: @params)
      @request.trigger!(urls: "some_endpoint")
    end

    it "allos to trigger the request to multiple endpoints" do
      expect(described_class).to receive(:post).with("endpoint_1/api/events", body: @params)
      expect(described_class).to receive(:post).with("endpoint_2/api/events", body: @params)

      @request.trigger!(urls: ["endpoint_1", "endpoint_2"])
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
