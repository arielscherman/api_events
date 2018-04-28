RSpec.describe ApiEvents::Model::Config do
  class Foo < ActiveRecord::Base
  end

  describe "#setup" do
    it "sets everything up using the given options" do
      expect_any_instance_of(described_class).to receive(:setup_events).with(foo: :bar)
      expect_any_instance_of(described_class).to receive(:setup_broadcast)
      described_class.new(Foo).setup(foo: :bar)
    end
  end

  describe "#setup_events" do
    it "creates a class method to set events to broadcast" do
      described_class.new(Foo).setup_events
      expect(Foo.broadcast_events).to eq %i(created updated destroyed)
    end 
  end
end
