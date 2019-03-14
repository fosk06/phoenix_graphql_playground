defmodule FrontWeb.Schema.Types do
    use Absinthe.Schema.Notation
    
    @desc "An item"
    object :item do
      field :id, :id
      field :name, :string
    end

    @desc "A Person"
    object :person do
      field :id, :id
      field :first_name, :string
      field :last_name, :string
      field :email, :string
      field :email_token, :string
      field :password, :string
      field :email_validated, :boolean
      field :age, :integer
    end

    @desc "An Email"
    object :email do
      field :id, :id
      field :person, :person
      field :template_id, :string
      field :recipient, :string
      field :subject, :string
      field :content, :string
      field :template_variables, :string
    end

    @desc "A standard reponse"
    object :standard_reponse do
      field :status, :string
      field :message, :string
    end
    
    @desc "the sign up input"
    input_object :sign_up_input do
      field :email, :string
      field :first_name, :string
      field :last_name, :string
      field :password, :string
    end
  
  end