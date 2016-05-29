defmodule CubesemServer.SessionChannel do
  require Logger

  use CubesemServer.Web, :channel

  def join("session:" <> session_id, _params, socket) do
    {:ok, assign(socket, :session_id, session_id)}
  end

  def handle_in("log:event", %{"message" => message}, socket) do
    Logger.warn "(#{socket.assigns.session_id}) #{message}"
    {:noreply, socket}
  end
end
