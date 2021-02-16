defmodule Rapyd.Collect.Customer do
  @moduledoc """
    describes the person or company that pays for products and services.
  """

  @type amount :: integer()
  @type timestamp :: integer()

  @type t :: %__MODULE__{
          id: Rapyd.id(),
          delinquent: boolean(),
          discount: amount(),
          name: String.t(),
          default_payment_method: String.t(),
          description: String.t(),
          email: String.t(),
          phone_number: String.t(),
          invoice_prefix: String.t(),
          addresses: list(),
          payment_methods: map(),
          subscriptions: any(),
          created_at: timestamp(),
          metadata: map(),
          business_vat_id: String.t(),
          ewallet: Rapyd.id()
        }

  defstruct [
    :id,
    :delinquent,
    :discount,
    :name,
    :default_payment_method,
    :description,
    :email,
    :phone_number,
    :invoice_prefix,
    :addresses,
    :payment_methods,
    :subscriptions,
    :created_at,
    :metadata,
    :business_vat_id,
    :ewallet
  ]

  @namespace "customers"

  alias __MODULE__, as: Customer
  alias Rapyd.Utils
  import Rapyd.Request

  @doc """
    creates customers 

    https://docs.rapyd.net/build-with-rapyd/reference#create-customer
  """
  @spec create(map()) :: {:ok, Customer.t()} | {:error, any()}
  def create(params) when is_map(params) do
    prepare_request(@namespace, :post, params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end

  @doc """
    change one or more fields in a 'customer' object. 
    To clear a field, set it to an empty string.

    https://docs.rapyd.net/build-with-rapyd/reference#update-customer
  """
  @spec update(String.t(), map()) :: {:ok, Customer.t()} | {:error, any()}
  def update(customer_id, params) do
    endpoint = "#{@namespace}/#{customer_id}"

    prepare_request(endpoint, :post, params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end

  @doc """
    retrieves a list of all customers.

    https://docs.rapyd.net/build-with-rapyd/reference#list-customers
  """
  @spec list(map()) :: [Customer.t()]
  def list(params) do
    prepare_request(@namespace, :get, params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
    |> Utils.without_ok()
  end

  @doc """
    retrieve details of a customer.

    https://docs.rapyd.net/build-with-rapyd/reference#retrieve-customer
  """
  @spec retrieve(Rapyd.id()) :: Customer.t()
  def retrieve(customer_id) when is_binary(customer_id) do
    Utils.endpoint_with_id(@namespace, customer_id)
    |> prepare_request(:get)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
    |> Utils.without_ok()
  end

  @doc """
    delete a customer

    https://docs.rapyd.net/build-with-rapyd/reference#delete-customer
  """
  @spec delete(Rapyd.id()) :: {:ok, Customer.t()} | {:error, any()}
  def delete(customer_id) when is_binary(customer_id) do
    Utils.endpoint_with_id(@namespace, customer_id)
    |> prepare_request(:delete)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end

  @doc """
    deletes the discount that has been assigned to a customer through a coupon. 
    This action does not affect the coupon that the discount was derived from.

    https://docs.rapyd.net/build-with-rapyd/reference#delete-discount-from-customer
  """
  @spec delete_discount_from_customer(Rapyd.id()) :: {:ok, any()} | {:error, any()}
  def delete_discount_from_customer(customer_id) when is_binary(customer_id) do
    endpoint = "#{@namespace}/#{customer_id}/discount"

    prepare_request(endpoint, :delete)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end
end
