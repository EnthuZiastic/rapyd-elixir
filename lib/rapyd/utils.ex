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
    resp = to_atom_map(resp)
    struct(struct_module.__struct__, resp)
  end

  def to_struct(resp, struct_module) when is_struct(struct_module) and is_list(resp) do
    Enum.reduce(resp, [], fn data, result ->
      if is_map(data) do
        struct(struct_module.__struct__, to_atom_map(data))
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

  @spec without_ok({:ok, any()} | any()) :: any()
  def without_ok({:ok, resp}), do: resp
  def without_ok(resp), do: resp

  @spec generate_random_key(integer()) :: String.t()
  def generate_random_key(length \\ 10) do
    Enum.to_list(?a..?z)
    |> Enum.take_random(length)
    |> List.to_string()
  end

  @spec to_atom_map(map()) :: map()
  def to_atom_map(data) when is_map(data) do
    for {k, v} <- data, into: %{} do
      key = if is_binary(k), do: String.to_existing_atom(k), else: k

      if is_map(v) do
        {key, to_atom_map(v)}
      else
        {key, v}
      end
    end
  end

  def to_atom_map(data), do: data
end
