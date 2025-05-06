module Loaders
  class SuperGoldiLoader < GraphQL::Batch::Loader
    def initialize(model)
      @model = model
    end

    def load(key, &block)
      @block = block
      super(key)
    end

    def perform(objects)
      @block.call(objects)
      objects.each do |object|
        fulfill(object, object)
      end
    end
  end
end
