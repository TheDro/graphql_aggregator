module Loaders
  class SuperGoldiLoader < GraphQL::Batch::Loader
    def initialize(model)
      @model = model
    end

    # TODO: I can probably use another method instead of overriding load
    def load(key, &block)
      @block = block
      super(key)
    end

    def wrap(object, &block)
      load(object) do |objects|
        auto_include_context = Goldiloader::AutoIncludeContext.new
        auto_include_context.register_models(objects.flatten)
        objects.flatten.each do |obj|
          obj.auto_include_context = auto_include_context
        end
      end.then do |obj|
        Goldiloader.enabled = true
        result = block.call(obj)
        Goldiloader.enabled = false
        result
      end
    end

    def perform(objects)
      @block.call(objects)
      objects.each do |object|
        fulfill(object, object)
      end
    end
  end
end
