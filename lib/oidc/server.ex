defmodule OIDC.Server do
  @behaviour OIDCCore.Server

  @impl OIDCCore.Server
  def redirect_to_authentication(conn, _opts) do
    conn
    |> Phoenix.Controller.redirect(to: "/sign_in")
  end

  @impl OIDCCore.Server
  def handle_error(conn, error, opts) do
    conn
    |> Plug.Conn.put_status(Keyword.get(opts, :status, 500))
    |> Plug.Conn.assign(:error, error)
    |> Phoenix.Controller.put_view(OIDCWeb.ErrorHTML)
    |> Phoenix.Controller.render("sso.html")
  end
end
