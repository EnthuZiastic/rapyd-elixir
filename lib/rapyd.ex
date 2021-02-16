defmodule Rapyd do
  @moduledoc """
    `Rapyd`.
  """

  @type options :: Keyword.t()
  @type id :: String.t()
  @type success_response :: {:ok, map()} | {:ok, [map()]} | {:ok, any()}
  @type error_response :: {:error, any()}

  @type api_respone :: success_response() | error_response()
end
