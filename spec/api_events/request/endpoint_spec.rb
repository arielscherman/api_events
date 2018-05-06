RSpec.describe ApiEvents::Request::Endpoint do
  describe "#path" do
    subject        { endpoint.path }

    context "when it ends with a slash" do
      let(:endpoint) { ApiEvents::Request::Endpoint.new("http://domain.com/") }

      it { is_expected.to eq "http://domain.com/api/events" }
    end

    context "when it doesn't end with a slash" do
      let(:endpoint) { ApiEvents::Request::Endpoint.new("http://domain.com") }

      it { is_expected.to eq "http://domain.com/api/events" }
    end
  end
end
