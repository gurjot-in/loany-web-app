defmodule BynkLoanyWeb.PageController do
  use BynkLoanyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
