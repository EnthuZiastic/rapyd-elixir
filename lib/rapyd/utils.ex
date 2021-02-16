defmodule Rapyd.Utils do
  @moduledoc """
    Utiliy functions
  """

  @spec to_struct(Rapyd.api_respone() | map() | [map()], struct()) ::
          {:ok, struct()} | {:error, any()}

  def to_struct({:ok, resp}, struct_module) when is_struct(struct_module) do
    {:ok, to_struct(resp, struct_module)}
  end

  def to_struct(resp, struct_module) when is_map(resp) and is_struct(struct_module) do
    struct(struct_module.__struct__, resp)
  end

  def to_struct(resp, struct_module) when is_struct(struct_module) and is_list(resp) do
    Enum.reduce(resp, [], fn data, result ->
      if is_map(data) do
        struct(struct_module.__struct__, data)
      else
        result
      end
    end)
  end

  def to_struct(resp, _), do: resp

  @spec endpoint_with_id(String.t(), Rapyd.id()) :: String.t()
  def endpoint_with_id(endpoint, id) do
    "#{endpoint}/#{id}"
  end
end
