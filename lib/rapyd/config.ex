defmodule Rapyd.Config do
  @moduledoc """
    utility that handles interaction with application configuration
  """

  @spec resolve(atom) :: any
  def resolve(key), do: resolve(key, nil)

  @spec resolve(atom, any) :: any
  def resolve(key, default) when is_atom(key) do
    Application.get_env(:rapyd, key, default)
  end

  def resolve(key, _) do
    raise ArgumentError, message: "#{__MODULE__} expected key `#{key}` to be an atom"
  end
end
