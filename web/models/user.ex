defmodule MyApp.User do
  use MyApp.Web, :model

  @derive {Poison.Encoder, only: [:id, :email]}

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    has_many :stacks, MyApp.Stack, on_delete: :nothing

    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w(hashed_password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Passwords do not match.")
    |> unique_constraint(:email, message: "Email already registered.")
    |> hash_password
  end

  @doc """
  Updates the changeset with a hashed (using Bcrypt) password
  """
  def hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
