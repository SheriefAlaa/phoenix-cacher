defmodule PhoenixCacherWeb.Router do
  use PhoenixCacherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixCacherWeb do
    pipe_through :api

    post "/reaction", API.ReactionController, :save_reaction
    get "/reaction_count/:content_id", API.ReactionController, :get_reaction_count
  end
end
