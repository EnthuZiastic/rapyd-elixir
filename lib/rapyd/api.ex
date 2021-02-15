defmodule Rapyd.Api do
  @moduledoc """
    handle Api request to Rapyd
  """

  alias Rapyd.Config

  @base_url "https://api.rapyd.net"
  @version "v1"

  @type method :: :get | :post | :delete | :put

  @spec request(map(), method(), String.t(), keyword(), keyword()) ::
          {:ok, map()} | {:error, any()}
  def request(body, :get, endpoint, headers, _opts) when is_map(body) do
    prepare_url(endpoint, body)
    |> HTTPoison.get(headers)
    |> prepare_response()
  end

  def request(body, method, endpoint, headers, _opts) when is_map(body) do
    url = prepare_url(endpoint, %{})

    HTTPoison.request(method, url, Jason.encode!(body), headers)
    |> prepare_response()
  end

  defp prepare_url(endpoint, params) do
    base_url = Config.resolve(:base_url, @base_url)

    "#{base_url}/#{@version}/#{endpoint}?#{URI.encode_query(params)}"
  end

  defp prepare_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    case parse_body(body) do
      %{"data" => data} ->
        {:ok, data}

      resp ->
        {:ok, resp}
    end
  end

  defp prepare_response({:ok, %HTTPoison.Response{body: body}}) do
    {:error, parse_body(body)}
  end

  defp prepare_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, parse_body(reason)}
  end

  defp parse_body(body) do
    case Jason.decode(body) do
      {:ok, json_body} ->
        json_body

      _ ->
        body
    end
  end
end
