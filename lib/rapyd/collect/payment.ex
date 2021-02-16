defmodule Rapyd.Collect.Payment do
  @moduledoc """
    handles Rapyd payments
  """
  alias Rapyd.Collect.Payment

  @type timestamp :: integer()
  @type amount :: integer()

  @type t :: %__MODULE__{
          id: String.t(),
          amount: float(),
          original_amount: float(),
          is_partial: boolean(),
          currency_code: String.t(),
          country_code: String.t(),
          status: String.t(),
          description: String.t(),
          merchant_reference_id: String.t(),
          customer_token: String.t(),
          payment_method: String.t(),
          payment_method_data: map(),
          expiration: integer(),
          captured: boolean(),
          refunded: boolean(),
          refunded_amount: float(),
          receipt_email: String.t(),
          redirect_url: String.t(),
          complete_payment_url: String.t(),
          error_payment_url: String.t(),
          receipt_number: String.t(),
          flow_type: String.t(),
          address: String.t(),
          statement_descriptor: String.t(),
          transaction_id: String.t(),
          created_at: timestamp(),
          metadata: map(),
          failure_code: String.t(),
          failure_message: String.t(),
          paid: boolean(),
          paid_at: timestamp(),
          dispute: any(),
          refunds: any(),
          order: any(),
          outcome: any(),
          visual_codes: map(),
          textual_codes: map(),
          instructions: map(),
          ewallet_id: String.t(),
          ewallets: [map()],
          payment_method_options: map(),
          payment_method_type: String.t(),
          payment_method_type_category: String.t(),
          fx_rate: String.t(),
          merchant_requested_currency: String.t(),
          merchant_requested_amount: amount(),
          fixed_side: String.t(),
          payment_fees: amount(),
          invoice: String.t(),
          escrow: any(),
          group_payment: String.t(),
          cancel_reason: String.t(),
          initiation_type: String.t(),
          mid: String.t()
        }

  defstruct [
    :id,
    :amount,
    :original_amount,
    :is_partial,
    :currency_code,
    :country_code,
    :status,
    :description,
    :merchant_reference_id,
    :customer_token,
    :payment_method,
    :payment_method_data,
    :expiration,
    :captured,
    :refunded,
    :refunded_amount,
    :receipt_email,
    :redirect_url,
    :complete_payment_url,
    :error_payment_url,
    :receipt_number,
    :flow_type,
    :address,
    :statement_descriptor,
    :transaction_id,
    :created_at,
    :metadata,
    :failure_code,
    :failure_message,
    :paid,
    :paid_at,
    :dispute,
    :refunds,
    :order,
    :outcome,
    :visual_codes,
    :textual_codes,
    :instructions,
    :ewallet_id,
    :ewallets,
    :payment_method_options,
    :payment_method_type,
    :payment_method_type_category,
    :fx_rate,
    :merchant_requested_currency,
    :merchant_requested_amount,
    :fixed_side,
    :payment_fees,
    :invoice,
    :escrow,
    :group_payment,
    :cancel_reason,
    :initiation_type,
    :mid
  ]

  @namespace "payments"

  import Rapyd.Request

  alias Rapyd.Utils

  @spec create(map()) :: {:ok, Payment.t()} | {:error, any()}
  def create(params) when is_map(params) do
    new_request()
    |> put_endpoint(@namespace)
    |> put_method(:post)
    |> put_param(params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end

  @spec update(String.t(), map()) :: {:ok, Payment.t()} | {:error, any()}
  def update(payment_id, params) do
    endpoint = Utils.endpoint_with_id(@namespace, payment_id)

    new_request()
    |> put_endpoint(endpoint)
    |> put_method(:post)
    |> put_param(params)
    |> send_request()
    |> Utils.to_struct(%__MODULE__{})
  end
end
