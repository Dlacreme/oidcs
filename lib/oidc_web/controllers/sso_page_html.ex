defmodule OIDCWeb.SSOErrorHTML do
  use OIDCWeb, :html

  def render(_template, assigns) do
    ~H"""
    <div>
      SSO Error: <%= @message %>
    </div>
    """
  end
end
