defmodule OIDCWeb.Router do
  use OIDCWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OIDCWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :no_csrf_browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OIDCWeb.Layouts, :root}
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OIDCWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/sign_in", SignInController, :sign_in
    post "/sign_in", SignInController, :do_sign_in
    get "/sign_up", SignInController, :sign_up
    post "/sign_up", SignInController, :do_sign_up
  end

  scope "/sso", OIDCWeb do
    pipe_through :no_csrf_browser

    post "/error", SSOErrorController, :index
  end

  scope "/oauth2", OIDCCore.Endpoint do
    pipe_through :browser

    get("/authorize", Authorization, :index)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:oidc, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: OIDCWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
