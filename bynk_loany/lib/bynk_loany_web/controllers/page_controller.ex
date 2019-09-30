defmodule BynkLoanyWeb.PageController do
  use BynkLoanyWeb, :controller

  def index(conn, _params) do
    render(conn, "loany_index.html", layout: false)
  end
end
