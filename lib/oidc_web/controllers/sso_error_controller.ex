defmodule OIDCWeb.ErrorController do
  use OIDCWeb, :controller

  def index(conn, params) do
    conn
    |> put_status(params["status"] || 500)
    |> render(%{message: params["message"] || "server error"})
  end
end
