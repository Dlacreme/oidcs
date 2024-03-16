defmodule OIDCWeb.PageController do
  use OIDCWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
