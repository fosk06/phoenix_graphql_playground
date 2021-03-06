defmodule DbConnector.Person do
    @moduledoc false
    
    require Logger
    use Ecto.Schema
    import Ecto.Changeset
    import EctoEnum
    alias DbConnector.RoleEnum


    schema "people" do
      field :first_name, :string
      field :last_name, :string
      field :email, :string
      field :email_token, :string
      field :password, :string, virtual: true
      field :password_hash, :string
      field :role, RoleEnum
      field :email_validated, :boolean
      field :age, :integer
      field(:token, :string)
      
      timestamps(type: :utc_datetime_usec)
    end

    def changeset(person, params \\ %{}) do
        person
        |> cast(params, [:first_name,:last_name, :email,:email_token,:role, :email_validated, :password, :age])
        |> validate_required([:first_name, :last_name, :password, :email, :role])
        |> validate_format(:email, ~r/@/)
        |> validate_inclusion(:age, 0..130)
        |> validate_length(:first_name, min: 3, max: 20)
        |> validate_length(:last_name, min: 3, max: 20)
        |> validate_length(:password, min: 5, max: 20)
        |> unique_constraint(:email, downcase: true)
        |> put_password_hash()
    end

    def store_token_changeset(%DbConnector.Person{} = person, attrs) do
      person
      |> cast(attrs, [:token])
    end

    defp put_password_hash(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
          put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
        _ ->
          changeset
      end
    end

    def put_email_token(changeset) do
      uuid = UUID.uuid4()
      case changeset do
        %Ecto.Changeset{valid?: true} ->
          put_change(changeset, :email_token, uuid)
        _ ->
          changeset
      end
    end

end