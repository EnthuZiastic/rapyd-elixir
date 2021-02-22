defmodule Rapyd.Disburse.Beneficiary do
  @moduledoc """
    Handles Rapyd Beneficiary Object
  """

  @type t :: %__MODULE__{
          id: String.t(),
          last_name: String.t(),
          first_name: String.t(),
          country: String.t(),
          entity_type: String.t(),
          address: String.t(),
          name: String.t(),
          postcode: String.t(),
          city: String.t(),
          account_number: String.t(),
          currency: String.t(),
          identification_type: String.t(),
          identification_value: String.t(),
          bank_name: String.t(),
          merchant_reference_id: String.t(),
          bsb_code: String.t(),
          payment_type: String.t(),
          category: String.t(),
          default_payout_method_type: String.t()
        }

  defstruct [
    :id,
    :last_name,
    :first_name,
    :country,
    :entity_type,
    :address,
    :name,
    :postcode,
    :city,
    :account_number,
    :currency,
    :identification_type,
    :identification_value,
    :bank_name,
    :merchant_reference_id,
    :bsb_code,
    :payment_type,
    :category,
    :default_payout_method_type
  ]

  @namespace "payouts/beneficiary"

  alias __MODULE__, as: Beneficiary
  alias Rapyd.Utils

  import Rapyd.Request

  @doc """
    creates a payout beneficiary. The Rapyd response provides a unique beneficiary ID, which you can use in place of the 'beneficiary' object for Create Payout.

    https://docs.rapyd.net/build-with-rapyd/reference#beneficiary-object
  """
  @spec create(map()) :: {:ok, Beneficiary.t()} | {:error, any()}
  def create(params) when is_map(params) do
    prepare_request(@namespace, :post, params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end

  @doc """
    validate the format of the payout beneficiary details for a payout method type.

    https://docs.rapyd.net/build-with-rapyd/reference#validate-beneficiary
  """
  @spec validate(map()) :: {:ok, Beneficiary.t()} | {:error, any()}
  def validate(params) when is_map(params) do
    namespace = "#{@namespace}/validate"

    prepare_request(namespace, :post, params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end

  @doc """
    retrieve details of a payout beneficiary.

    https://docs.rapyd.net/build-with-rapyd/reference#retrieve-beneficiary
  """
  @spec retrieve(String.t()) :: Beneficiary.t()
  def retrieve(beneficiary_id) when is_binary(beneficiary_id) do
    namespace = "#{@namespace}/#{beneficiary_id}"

    prepare_request(namespace, :get)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
    |> Utils.without_ok()
  end

  @doc """
    delete a payout beneficiary from the Rapyd platform.
    
    https://docs.rapyd.net/build-with-rapyd/reference#delete-beneficiary
  """
  @spec delete(Rapyd.t()) :: {:ok, %{deleted: boolean(), id: Rapyd.id()}} | {:error, any()}
  def delete(beneficiary_id) when is_binary(beneficiary_id) do
    Utils.endpoint_with_id(@namespace, beneficiary_id)
    |> prepare_request(:delete)
    |> send_request()
  end
end
