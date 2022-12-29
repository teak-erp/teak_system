defmodule TeakSystem.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry TeakSystem.Resources.User
    entry TeakSystem.Resources.Group
    entry TeakSystem.Resources.UserGroup
    entry TeakSystem.Resources.ResourcePermission
    entry TeakSystem.Resources.AttributePermission
  end
end
