defmodule PhoenixCacherWeb.API.ReactionController do
  use PhoenixCacherWeb, :controller
  require Logger
  def get_reaction_count(conn, %{"content_id" => content_id}) when is_binary(content_id) do
    resp = %{
      content_id: content_id,
      reaction_count: %{
        fire: GenServer.call(PhoenixCacher.Server, {:get_count, content_id})
      }
    }

    json(conn, resp)
  end

  def get_reaction_count(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, "Not Found")
  end

  def save_reaction(conn, %{
        "type" => "reaction",
        "action" => "add",
        "content_id" => content_id,
        "user_id" => user_id,
        "reaction_type" => "fire"
      }) do
        Logger.info(content_id)
        Logger.info(user_id)
    GenServer.cast(PhoenixCacher.Server, {:create_or_update, content_id, user_id})

    json(conn, %{status: :ok})
  end

  def save_reaction(conn, %{
        "type" => "reaction",
        "action" => "remove",
        "content_id" => content_id,
        "user_id" => user_id,
        "reaction_type" => "fire"
      }) do
    GenServer.cast(PhoenixCacher.Server, {:remove, content_id, user_id})

    json(conn, %{status: :ok})
  end

  def save_reaction(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, "Invalid data sent. Please correct your reaction json.")
  end
end
