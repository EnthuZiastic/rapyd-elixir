defmodule Rapyd do
  @moduledoc """
    `Rapyd`.
  """

  @type options :: Keyword.t()
  @type id :: String.t()
  @type success_response :: {:ok, map()} | {:ok, [map()]} | {:ok, any()}
  @type error_response :: {:error, map()} | {:error, String.t()}
  @type timestamp :: integer()
  @type api_respone :: success_response() | error_response()
  @type url :: String.t()
end
