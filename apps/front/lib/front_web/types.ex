defmodule FrontWeb.Schema.Types do
    use Absinthe.Schema.Notation
  
    object :item do
      field :id, :id
      field :name, :string
    end
  
  end