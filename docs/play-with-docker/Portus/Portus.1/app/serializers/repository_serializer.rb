class RepositorySerializer < ActiveModel::Serializer
  attributes :id, :name, :namespace_id
end
