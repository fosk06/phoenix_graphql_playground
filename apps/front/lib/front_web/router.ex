defmodule FrontWeb.Router do
  use FrontWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
  
  pipeline :authentication do
    plug BasicAuth, use_config: {:front, :authentication}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FrontWeb do
    pipe_through [:browser, :authentication]

    get "/", PageController, :index
  end

  scope "/api", FrontWeb do
    pipe_through [:api, :authentication]

    get "/ping", ApiController, :ping
  end

  # Other scopes may use custom stacks.
  # scope "/api", FrontWeb do
  #   pipe_through :api
  # end
end