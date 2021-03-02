defmodule Rapyd.Collect.CheckoutPage do
  @moduledoc """
    
  """
  @type t() :: %__MODULE__{
          id: Rapyd.id(),
          country: String.t(),
          amount: float(),
          status: String.t(),
          payment: map(),
          payment_method_type: String.t(),
          payment_method_type_categories: String.t(),
          payment_method_types_include: [String.t()],
          payment_method_types_exclude: list(),
          customer: Rapyd.id(),
          customer_default_payment_method: String.t(),
          customer_addresses: list(),
          country_name: String.t(),
          merchant_color: String.t(),
          merchant_website: String.t(),
          merchant_logo: String.t(),
          merchant_alias: String.t(),
          merchant_customer_support: map(),
          custom_elements: map(),
          language: String.t(),
          complete_checkout_url: Rapyd.url(),
          cancel_checkout_url: Rapyd.url(),
          redirect_url: Rapyd.url(),
          timestamp: Rapyd.timestamp(),
          page_expiration: Rapyd.timestamp(),
          cart_items: list()
        }

  defstruct [
    :id,
    :country,
    :amount,
    :status,
    :payment,
    :payment_method_type,
    :payment_method_type_categories,
    :payment_method_types_include,
    :payment_method_types_exclude,
    :customer,
    :customer_default_payment_method,
    :customer_addresses,
    :country_name,
    :merchant_color,
    :merchant_website,
    :merchant_logo,
    :merchant_alias,
    :merchant_customer_support,
    :custom_elements,
    :language,
    :complete_checkout_url,
    :cancel_checkout_url,
    :redirect_url,
    :timestamp,
    :page_expiration,
    :cart_items
  ]

  @namespace "checkout"

  alias Rapyd.Utils
  alias __MODULE__, as: CheckoutPage

  import Rapyd.Request

  @doc """
    creates a checkout page. 
    https://docs.rapyd.net/build-with-rapyd/reference#create-checkout-page
  """
  @spec create(map()) :: {:ok, CheckoutPage.t()} | {:error}
  def create(params) when is_map(params) do
    prepare_request(@namespace, :post, params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end

  @doc """
    method to retrieve a checkout page.
    https://docs.rapyd.net/build-with-rapyd/reference#sample-checkout-pages
  """
  @spec retrieve(Rapyd.id()) :: CheckoutPage.t()
  def retrieve(checkout_id) do
    endpoint = "#{@namespace}/#{checkout_id}"

    prepare_request(endpoint, :get)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
    |> Utils.without_ok()
  end
end
