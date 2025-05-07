# frozen_string_literal: true

module Loaders
  class RecordLoader < GraphQL::Batch::Loader
    def initialize(model, column: :id, scope: nil)
      @model = model
      @column = column
      @scope = scope
    end

    def self.loader_key_for(model, kwargs)
      [self, model, kwargs[:column], kwargs[:scope]&.to_sql]
    end

    def perform(ids)
      # this can be improved using reflection
      is_single_record = @column == :id
      if is_single_record
        @model.where(id: ids).each { |record| fulfill(record.id, record) }
        ids.each { |id| fulfill(id, nil) unless fulfilled?(id) }
      else
        results = @model.where(@column => ids).group_by do |record|
          record.public_send(@column)
        end
        results.each do |id, records|
          fulfill(id, records)
        end
        # results = @model.where(@column => ids).each { |record| fulfill(record.id, record) }
        ids.each { |id| fulfill(id, []) unless fulfilled?(id) }
      end
    end
  end
end