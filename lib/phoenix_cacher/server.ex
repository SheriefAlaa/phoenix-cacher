defmodule PhoenixCacher.Server do
  use GenServer, restart: :transient

  require Logger
  alias PhoenixCacher.Cache

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:get_count, content_id}, _from, _state) do
    state = Cache.count(content_id)
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:create_or_update, content_id, user_id}, _state) do
    state = Cache.create_or_update(content_id, user_id)
    Logger.info("GenServer: Cache.create_or_update result: #{inspect(state)}")
    {:noreply, %{}}
  end

  def handle_cast({:remove, content_id, user_id}, _state) do
    state = Cache.delete_user_reaction(content_id, user_id)
    Logger.info("GenServer: Cache.delete_user_reaction result: #{inspect(state)}")
    {:noreply, state}
  end
end
