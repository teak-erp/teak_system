defmodule TeakSystem.Resources.AttributePermission do
  use Teak.Document

  document do
    name "Attribute Permission"
    description "Permission to limit access to document attributes"
  end

  postgres do
    table "attribute_permissions"
    repo TeakSystem.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    attribute :resource, :atom, do: allow_nil? false
    attribute :attribute, :atom, do: allow_nil? false
    attribute :read_access, :boolean, do: allow_nil? false
    attribute :create_access, :boolean, do: allow_nil? false
    attribute :update_access, :boolean, do: allow_nil? false
  end

  relationships do
    belongs_to :group, TeakSystem.Resources.Group, do: allow_nil? false
  end
end
