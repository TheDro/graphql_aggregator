# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    def ultra_wrap(object)
      # This regex could be improved
      key = caller.grep(/_type.rb/).first
      Loaders::SuperGoldiLoader.for(key).wrap(object) do |obj|
        if block_given?
          yield obj
        else
          obj
        end
      end
    end

    def ultra_load(object, field, scope: nil, auto_loader: true)
      model = object.class
      reflection = model.reflect_on_association(field)
      promise = if reflection.is_a?(ActiveRecord::Reflection::BelongsToReflection)
        Loaders::RecordLoader.for(reflection.klass, scope: scope)
          .load(object.public_send(reflection.foreign_key))
      elsif reflection.is_a?(ActiveRecord::Reflection::HasManyReflection)
        Loaders::RecordLoader.for(reflection.klass, column: reflection.foreign_key)
          .load(object.public_send(reflection.active_record_primary_key))
      elsif reflection.is_a?(ActiveRecord::Reflection::ThroughReflection)
        # Some of these methods are probably wrong, but happen to be the correct value
        Loaders::RecordLoader.for(reflection.through_reflection.klass, column: reflection.through_reflection.foreign_key)
          .load(object.public_send(reflection.through_reflection.active_record_primary_key))
          .then do |intermediates|
            keys = intermediates.map { |record| record.public_send(reflection.association_foreign_key) }
            Loaders::RecordLoader.for(reflection.klass, scope: scope).load_many(keys)
          end.then do |grouped_records|
            grouped_records.flatten
          end
      end

      if !auto_loader
        if block_given?
          promise.then do |value|
            yield value
          end
        else
          promise
        end
      else
        promise.then do |value|
          if block_given?
            ultra_wrap(value) do |obj|
              yield obj
            end
          else
            ultra_wrap(value)
          end
        end
      end
    end
  end
end
