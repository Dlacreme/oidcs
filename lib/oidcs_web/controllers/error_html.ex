defmodule OIDCSWeb.ErrorHTML do
  use OIDCSWeb, :html

  # If you want to customize your error pages,
  # uncomment the embed_templates/1 call below
  # and add pages to the error directory:
  #
  #   * lib/oidcs_web/controllers/error_html/404.html.heex
  #   * lib/oidcs_web/controllers/error_html/500.html.heex
  #
  embed_templates "error_html/*"

  # The default is to render a plain text page based on
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def render(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  def render_error(conn, template, opts \\ [status: 500, assigns: %{}]) do
    conn
    |> Phoenix.Controller.put_format([:html, :json])
    |> Phoenix.Controller.put_layout(html: OIDCSWeb.Layouts)
    |> Phoenix.Controller.put_view(__MODULE__)
    |> assign(Keyword.get(opts, :assigns, %{}))
    |> Plug.Conn.put_status(Keyword.get(opts, :status, 500))
    |> render(template)
  end
end
