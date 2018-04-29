RSpec.describe ApiEvents do
  it "has a version number" do
    expect(ApiEvents::VERSION).not_to be nil
  end

  describe "#reset" do
    before :each do
      ApiEvents.configure do |config|
        config.listeners = ["some_endpoint"]
      end
    end

    it "resets the configuration" do
      ApiEvents.reset
      config = ApiEvents.configuration
      expect(config.listeners).to eq([])
    end
  end
end
