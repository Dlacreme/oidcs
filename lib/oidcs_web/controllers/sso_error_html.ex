defmodule OIDCSWeb.SSOErrorHTML do
  use OIDCSWeb, :html

  def render(_template, assigns) do
    ~H"""
    <div>
      SSO Error: <%= @message %>
    </div>
    """
  end
end
