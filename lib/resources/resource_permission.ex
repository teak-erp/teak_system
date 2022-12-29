defmodule TeakSystem.Resources.ResourcePermission do
  use Teak.Document
  
  document do
    name "Resource Permission"
    description "Permission set to limit resource records by pre-defined filter"
  end

  postgres do
    table "resource_permissions"
    repo TeakSystem.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    attribute :resource, :atom, do: allow_nil? false
    attribute :action_name, :atom, do: allow_nil? false
    attribute :filter, :atom
  end

  relationships do
    belongs_to :group, TeakSystem.Resources.Group, do: allow_nil? false
  end
end
