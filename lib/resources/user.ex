defmodule TeakSystem.Resources.User do
  use Teak.Document

  postgres do
    table "users"
    repo TeakSystem.Repo
  end

  policies do
    bypass always() do
      authorize_if actor_attribute_equals(:super_admin, true)
    end

    # policy action_type(:read) do
    #   authorize_if expr(:id == actor(:id))
    # end
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    # read :list do
    #   primary? true

    #   pagination offset?: true, countable: :by_default

    #   filter expr(enabled == true)
    # end

    create :register do
      primary? true

      accept [:username, :full_name, :super_admin]

      argument :password, :string do
        allow_nil? false
        sensitive? true
      end
      argument :confirm_password, :string do
        allow_nil? false
        sensitive? true
      end

      validate confirm(:password, :confirm_password)

      change {
        TeakSystem.Changes.Hash,
        attribute: :hashed_password, value: arg(:password)}
    end
  end

  attributes do
    attribute :full_name, :string do
      allow_nil? false
      # check out Hubert Blaine
      constraints [max_length: 747]
    end
    attribute :first_name, :string do
      constraints [max_length: 747]
    end
    attribute :family_name, :string do
      constraints [max_length: 747]
    end
    attribute :username, :string do 
      allow_nil? false
      constraints [min_length: 2, max_length: 100, match: ~r"^[a-z0-9_]+$"]
    end
    attribute :enabled, :boolean do
      default :true
      allow_nil? false
    end
    attribute :super_admin, :boolean do
      default false
      allow_nil? false
    end
    attribute :hashed_password, :string do
      private? true
      sensitive? true
      filterable? false
    end
  end

  relationships do
    many_to_many :user_groups, TeakSystem.Resources.Group do
      through TeakSystem.Resources.UserGroup
      source_attribute_on_join_resource :user_id
      destination_attribute_on_join_resource :group_id
    end
  end

  identities do
    identity :username, [:username]
  end

  document do
    name "User"
    audit_created_by? false
    audit_updated_by? false
    field_names %{super_admin: "System Admin"}
  end

  forms do
    form "Register New User", :create, :register do
      grid 2, :row do
        grid 2, :col do
          section "General" do
            field :username, "Username"
            field :full_name, "Full Name"
            field :super_admin, "System Administrator?"
          end
          section "Authentication" do
            field :password, "Password"
            field :confirm_password, "Confirm Password"
          end
        end
        section "Groups" do
          list :groups, "Access Groups"
        end
      end
    end
  end
end
