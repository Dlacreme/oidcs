defmodule OIDCWeb.SignInHTML do
  use OIDCWeb, :html

  def render("sign_in.html", assigns) do
    ~H"""
    <div>
      login now
    </div>
    """
  end
end
