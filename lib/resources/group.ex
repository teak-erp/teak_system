defmodule TeakSystem.Resources.Group do
  use Teak.Document

  document do
    name "Group"
    description "Access control group with a set of permissions that can be assigned to a user"
  end

  postgres do
    table "groups"
    repo TeakSystem.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    attribute :name, :string, do: allow_nil? false
    attribute :description, :string
  end
  
  relationships do
    has_many :resource_permissions, TeakSystem.Resources.ResourcePermission
    has_many :attribute_permissions, TeakSystem.Resources.AttributePermission
  end
end
