defmodule OIDCWeb.SignInController do
  use OIDCWeb, :controller

  def index(conn, params) do
    conn
    |> render("sign_in.html", %{})
  end
end
