defmodule Nerd.PageController do
  use Nerd.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
