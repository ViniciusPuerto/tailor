defmodule TailorApiWeb.Router do
  use TailorApiWeb, :router

  pipeline :auth do
    plug Guardian.Plug.Pipeline,
      module: TailorApi.Guardian,
      error_handler: TailorApiWeb.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Public API routes (no authentication required)
  scope "/api", TailorApiWeb do
    pipe_through [:api]

    post "/login", AuthController, :login
  end

  # Protected API routes (JWT authentication required)
  scope "/api", TailorApiWeb do
    pipe_through [:api, :auth]

    resources "/orders", OrderController, except: [:new, :edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:tailor_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TailorApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
