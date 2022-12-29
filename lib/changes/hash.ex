defmodule TeakSystem.Changes.Hash do
  use Ash.Resource.Change

  @impl true
  def init(opts) do
    with :ok <- validate_attribute(opts[:attribute]),
         :ok <- validate_value(opts[:value]) do
      {:ok, opts}
    end
  end

  defp validate_attribute(nil), do: {:error, "attribute is required"}
  defp validate_attribute(value) when is_atom(value), do: :ok
  defp validate_attribute(other), do: {:error, "attribute is invalid: #{inspect(other)}"}

  defp validate_value(nil), do: {:error, "value is required"}
  defp validate_value(_), do: :ok

  @impl true
  def change(changeset, opts, _) do
    if Keyword.get(opts, :value) do
      hashed_value = Pbkdf2.hash_pwd_salt(opts[:value])
      Ash.Changeset.force_change_attribute(changeset, opts[:attribute], hashed_value)
    else
      changeset
    end
  end
end
