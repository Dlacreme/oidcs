defmodule OIDCWeb.SSOErrorController do
  use OIDCWeb, :controller

  def index(conn, params) do
    IO.inspect(params)

    conn
    |> put_status(params["status"] || 500)
    |> render(%{message: params["message"] || "server error"})
  end
end
