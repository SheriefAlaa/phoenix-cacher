defmodule PhoenixCacherWeb.PageController do
  use PhoenixCacherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
