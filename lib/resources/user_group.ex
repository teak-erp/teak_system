defmodule TeakSystem.Resources.UserGroup do
  use Teak.Document

  document do
    name "User Group"
    description "Document linking which groups a user belongs to"
  end

  postgres do
    table "user_groups"
    repo TeakSystem.Repo
  end

  relationships do
    belongs_to :user, TeakSystem.Resources.User do
      allow_nil? false
    end
    belongs_to :group, TeakSystem.Resources.Group do
      allow_nil? false
    end
  end
end
