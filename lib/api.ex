defmodule TeakSystem.Api do
  use Ash.Api
    # , extensions: [Teak.Core.Module]

  # module do
  #   name "Access Control"
  #   description "Manage Authorization and Access Control"
  #   topic do
  #     name "User Management"
  #     description "Manage Users and Access Control Groups"
  #     topic_items [
  #       TeakSystem.Resources.User,
  #       TeakSystem.Resources.Group
  #     ]
  #   end
  # end

  resources do
    registry TeakSystem.Registry
  end

  authorization do
    require_actor? true
    authorize :by_default
  end

  # json_api do
  #   prefix "/json_api"
  #   serve_schema? true
  #   log_errors? true
  #   authorize? false
  # end
end
