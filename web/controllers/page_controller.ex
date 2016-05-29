defmodule CubesemServer.PageController do
  require Logger

  use CubesemServer.Web, :controller

  def index(conn, _params) do
    IO.puts "Hello world!"
    Logger.error "hello world!"
    Logger.debug "Woot! Woot!"
    render conn, "index.html"
  end
end
