defmodule Rapyd.Request do
  @moduledoc """
    handles Request to the Rapyd API.
  """

  alias Rapyd.Api
  alias Rapyd.Config
  alias Rapyd.Request
  alias Rapyd.Utils

  @type t :: %__MODULE__{
          endpoint: String.t() | nil,
          headers: map,
          method: Api.method() | nil,
          params: map
        }

  defstruct endpoint: nil, opts: [], headers: %{}, method: nil, params: %{}

  @spec prepare_request(String.t(), atom(), map()) :: Request.t()
  def prepare_request(endpoint, method, params \\ %{}, headers \\ %{}) do
    new_request(headers)
    |> put_endpoint(endpoint)
    |> put_method(method)
    |> put_param(params)
    |> put_auth_header()
  end

  @doc """
    creates a new request 
  """
  @spec new_request(map(), Rapyd.options()) :: Request.t()
  def new_request(headers \\ %{}, opts \\ []) do
    %Request{opts: opts, headers: headers}
  end

  @doc """
    Specifies endpoint for request 
    
  """
  @spec put_endpoint(Request.t(), String.t()) :: Request.t()
  def put_endpoint(%Request{} = request, endpoint) do
    %{request | endpoint: endpoint}
  end

  @spec put_method(Request.t(), atom) :: Request.t()
  def put_method(%Request{} = request, method) do
    %{request | method: method}
  end

  @spec put_param(Request.t(), map) :: Request.t()
  def put_param(%Request{params: params} = request, new_param) when is_map(new_param) do
    %{request | params: Map.merge(params, new_param)}
  end

  @spec put_param(Request.t(), atom, any) :: Request.t()
  def put_param(%Request{params: params} = request, key, value) do
    %{request | params: Map.put(params, key, value)}
  end

  @spec send_request(any()) :: any()
  def send_request(%Request{method: method, endpoint: endpoint} = request) do
    headers = Map.to_list(request.headers)
    Api.request(request.params, method, endpoint, headers, request.opts)
  end

  @spec put_auth_header(Request.t()) :: Request.t()
  def put_auth_header(%Request{method: method, endpoint: endpoint} = request) do
    access_key = Config.resolve(:access_key, "")
    secret_key = Config.resolve(:secret_key, "")

    salt = Utils.generate_random_key(15)
    url_path = "/v1/#{endpoint}"
    timestamp = DateTime.utc_now() |> DateTime.to_unix()

    header = %{
      "access_key" => access_key,
      "salt" => salt,
      "timestamp" => timestamp,
      "Content-Type" => "Application/json",
      "signature" =>
        generate_signature(
          Atom.to_string(method),
          url_path,
          access_key,
          secret_key,
          salt,
          Jason.encode!(request.params),
          timestamp
        )
    }

    %{request | headers: Map.merge(request.headers, header)}
  end

  defp generate_signature(method, url, access_key, secret_key, salt, body, timestamp) do
    sig_payload = "#{method}#{url}#{salt}#{timestamp}#{access_key}#{secret_key}#{body}"

    :crypto.hmac(:sha256, secret_key, sig_payload)
    |> Base.encode16()
    |> String.downcase()
    |> Base.url_encode64()
  end
end
