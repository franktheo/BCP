class TaggingSerializer < ActiveModel::Serializer
  attributes :entity_type, :entity_id, :tags
end
