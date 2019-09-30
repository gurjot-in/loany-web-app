defmodule BynkLoanyWeb.PageController do
  use BynkLoanyWeb, :controller

  def index(conn, _params) do
    render(conn, "loany_index.html")
  end
end
