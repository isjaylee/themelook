defmodule Themelook.Router do
  use Themelook.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
    plug Themelook.SharedMethods
    plug Themelook.Application, repo: Themelook.Repo
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  pipeline :api do
    plug :accepts, ["json"]
    # plug Coherence.Authentication.Session
  end

  scope "/", Themelook do
    pipe_through :browser
    coherence_routes
  end

  scope "/", Themelook do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", Themelook do
    pipe_through :browser
    get "/", CategoryController, :index
    get "/about", PageController, :about
    get "/privacy", PageController, :privacy
    get "/terms", PageController, :terms
    get "/logout", ThemeController, :logout
    get "/search", ThemeController, :search_themes
    resources "/themes", ThemeController
    resources "/categories", CategoryController, only: [:index, :show]
  end

  scope "/", Themelook do
    pipe_through :protected
  end

  scope "/", Themelook do
    pipe_through :api
    scope "/api", Api, as: :api  do
      scope "/v1", V1, as: :v1 do
        resources "/themes", ThemeController
        get "/categories", CategoryController, :index
      end
    end
  end
end
