defmodule Rapyd.Config do
  @moduledoc """
    utility that handles interaction with application configuration
  """

  @spec resolve(atom) :: any
  def resolve(key), do: resolve(key, nil)

  @spec resolve(atom, any) :: any
  def resolve(key, default) when is_atom(key) do
    case Application.get_env(:rapyd, key, default) do
      nil ->
        default

      {:system, env} when is_binary(env) ->
        System.get_env(env)

      value ->
        value
    end
  end

  def resolve(key, _) do
    raise ArgumentError, message: "#{__MODULE__} expected key `#{key}` to be an atom"
  end
end
