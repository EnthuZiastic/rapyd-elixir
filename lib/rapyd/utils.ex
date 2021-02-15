defmodule Rapyd.Utils do
  @moduledoc """
    Utiliy functions
  """

  @spec to_struct({:ok, map()} | {:ok, [map()]} | {:error, any()}, struct()) ::
          {:ok, struct()} | {:error, any()}

  def to_struct({:ok, resp}, struct_module) when is_struct(struct_module) do
    {:ok, struct(struct_module.__struct__, resp)}
  end

  def to_struct(resp, _), do: resp

  @spec endpoint_with_id(String.t(), Rapyd.id()) :: String.t()
  def endpoint_with_id(endpoint, id) do
    "#{endpoint}/#{id}"
  end
end
