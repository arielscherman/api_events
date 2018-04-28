RSpec.describe ApiEvents::Model do
  class Foo
    include ApiEvents::Model
  end

  it "the config is triggered when the broadcast line is added to the model" do
    expect(ApiEvents::Model::Config).to receive(:new).with(Foo).and_call_original

    class Foo
      broadcast
    end
  end

  it "arguments are sent to the config" do
    expect_any_instance_of(ApiEvents::Model::Config).to receive(:setup).with(foo: :bar)

    class Foo
      broadcast foo: :bar
    end
  end
end
