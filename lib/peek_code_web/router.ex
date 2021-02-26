defmodule PeekCodeWeb.Router do
  use PeekCodeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PeekCodeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PeekCodeWeb do
    pipe_through :browser
    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PeekCodeWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # coveralls-ignore-start

    scope "/graphql" do
      pipe_through :api
      forward "/server", Absinthe.Plug, schema: PeekCodeGraphql.Schema, json_codec: Jason
      forward "/ui", Absinthe.Plug.GraphiQL,
        schema: PeekCodeGraphql.Schema,
        json_codec: Jason
    end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PeekCodeWeb.Telemetry
    end
  end
  # coveralls-ignore-stop
end
