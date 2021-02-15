defmodule Rapyd.Request do
  @moduledoc """
    handles Request to the Rapyd API.
  """

  @type t :: %__MODULE__{
          end_point: String.t() | nil,
          headers: map | nil,
          opts: Keyword.t() | nil,
          method: nil,
          params: map
        }

  defstruct end_point: nil, opts: [], headers: nil, method: nil, params: %{}

  alias Rapyd.Request

  @doc """
    creates a new request 
  """
  @spec new(Rapyd.options(), map) :: Request.t()
  def new(opts \\ [], headers \\ %{}) do
    %Request{opts: opts, headers: headers}
  end

  @doc """
    Specifies endpoint for request 
    
  """
  @spec put_endpoint(Request.t(), String.t()) :: Request.t()
  def put_endpoint(%Request{} = request, endpoint) do
    %{request | end_point: endpoint}
  end

  @spec put_method(Request.t(), atom) :: Request.t()
  def put_method(%Request{} = request, method) do
    %{request | method: method}
  end

  @spec put_param(Request.t(), map) :: Request.t()
  def put_param(%Request{params: params} = request, new_param) do
    %{request | params: Map.merge(params, new_param)}
  end

  @spec put_param(Request.t(), atom, any) :: Request.t()
  def put_param(%Request{params: params} = request, key, value) do
    %{request | params: Map.put(params, key, value)}
  end
end
