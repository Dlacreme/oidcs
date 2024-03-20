defmodule OIDCWeb.SignInController do
  alias OIDC.Account
  use OIDCWeb, :controller

  def sign_in(conn, params) do
    conn
    |> assign(:csrf_token, get_csrf_token())
    |> assign(:email, Map.get(params, "email"))
    |> render("sign_in.html")
  end

  def do_sign_in(conn, %{"email" => email, "password" => password} = params)
      when is_binary(email) and is_binary(password) do
    case Account.get_by_credentials(email, password) do
      nil ->
        assign(conn, :error, "user not found")
        |> sign_in(params)

      user ->
        login_user(conn, user)
    end
  end

  def sign_up(conn, params) do
    conn
    |> assign(:csrf_token, get_csrf_token())
    |> assign(:email, Map.get(params, "email"))
    |> assign(:first_name, Map.get(params, "first_name"))
    |> assign(:last_name, Map.get(params, "last_name"))
    |> render("sign_up.html")
  end

  def do_sign_up(conn, params) do
    case Account.create_user(params) do
      {:ok, user} ->
        login_user(conn, user)

      _ ->
        conn
        |> assign(:error, "failed to create account")
        |> sign_up(params)
    end
  end

  defp login_user(conn, user) do
    OIDCCore.authorize(conn, user.id)
  end
end
