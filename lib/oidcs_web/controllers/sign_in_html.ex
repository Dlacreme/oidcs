defmodule OIDCSWeb.SignInHTML do
  use OIDCSWeb, :html

  def render("sign_in.html", assigns) do
    assigns = Map.put_new(assigns, :error, nil)

    ~H"""
    <div>
      <form class="flex flex-col" action="/sign_in" method="post">
        <div class="error text-red">
          <%= @error %>
        </div>

        <input type="hidden" name="_csrf_token" value={@csrf_token} readonly />
        <input type="text" name="email" value={@email || "toto@tata.fr"} />
        <input type="password" name="password" value="totototo" />

        <button type="submit">
          log in
        </button>
      </form>
      <a class="mt-8" href="/sign_up">
        Create an account
      </a>
    </div>
    """
  end

  def render("sign_up.html", assigns) do
    assigns = Map.put_new(assigns, :error, nil)

    ~H"""
    <form class="flex flex-col" action="/sign_up" method="post">
      <div class="error text-red">
        <%= @error %>
      </div>

      <input type="hidden" name="_csrf_token" value={@csrf_token} readonly />
      <input type="text" name="email" placeholder="Your email" value={@email} />
      <input type="text" name="first_name" placeholder="Your first name" value={@first_name} />
      <input type="text" name="last_name" placeholder="Your last name" value={@last_name} />
      <input type="password" name="password" placeholder="Your password" />

      <button type="submit">
        create account
      </button>

      <a class="mt-8" href="/sign_in">
        Already have an account?
      </a>
    </form>
    """
  end
end
