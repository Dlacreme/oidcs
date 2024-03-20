defmodule OIDCSWeb.PageController do
  use OIDCSWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
