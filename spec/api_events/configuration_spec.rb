RSpec.describe ApiEvents::Configuration do
  describe "#listeners" do
    it "defaults to an empty array" do
      expect(described_class.new.listeners).to eq []
    end

    it "can set value" do
      config           = described_class.new
      config.listeners = ["http://some-endpoint.com/"]

      expect(config.listeners).to eq ["http://some-endpoint.com/"]
    end
  end
end
