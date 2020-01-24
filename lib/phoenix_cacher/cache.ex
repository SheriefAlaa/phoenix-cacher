defmodule PhoenixCacher.Cache do
  @cache_bucket :reaction

  require Logger

  def create_or_update(content_id, user_id) when is_binary(content_id) and is_binary(user_id) do
    Cachex.transaction!(@cache_bucket, [content_id], fn cache ->
      case Cachex.get(cache, content_id) do
        {:ok, nil} ->
          Cachex.put(cache, content_id, [user_id])

        {:ok, users} ->
          if !Enum.member?(users, user_id) do
            Cachex.update(cache, content_id, [user_id | users])
          else
            Logger.info("Reaction already exists, ignoring...")
          end
      end
    end)
  end

  def count(content_id) when is_binary(content_id) do
    case Cachex.get(@cache_bucket, content_id) do
      {:ok, nil} ->
        0

      {:ok, users} ->
        length(users)
    end
  end

  def delete_user_reaction(content_id, user_id)
      when is_binary(content_id) and is_binary(user_id) do
    Cachex.transaction!(@cache_bucket, [content_id], fn cache ->
      case Cachex.get(cache, content_id) do
        {:ok, nil} ->
          {:error, :not_found}

        {:ok, users} ->
          Cachex.update(cache, content_id, List.delete(users, user_id))
      end
    end)
  end
end
