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

      expect(Foo.broadcast_events).to include :created
      expect(Foo.broadcast_events).to include :updated
      expect(Foo.broadcast_events).to include :destroyed
    end 

    it "allows to override what events to broadcast" do
      described_class.new(Foo).setup_events(on: :updated)

      expect(Foo.broadcast_events).to     include :updated
      expect(Foo.broadcast_events).to_not include :created
      expect(Foo.broadcast_events).to_not include :destroyed

      described_class.new(Foo).setup_events(on: [:updated, :created])

      expect(Foo.broadcast_events).to     include :updated
      expect(Foo.broadcast_events).to     include :created
      expect(Foo.broadcast_events).to_not include :destroyed
    end
  end

  describe "model callbacks" do
    it "broadcast events on callbacks" do
      described_class.new(DummyModel).add_callback_to_model(:updated)
      dummy = DummyModel.create!(name: "foo")

      expect(dummy).to receive(:broadcast_event!)

      dummy.update!(name: "new name")
    end
  end
end
