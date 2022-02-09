class TransactionsController < ApplicationController
  before_action :find_customer, only: [:create]
  before_action :find_input_currency, only: [:create, :update]
  before_action :find_output_currency, only: [:create, :update]

  def index
    transactions = Transaction.includes(:customer, :input_currency, :output_currency)
    render json: ::TransactionsResource.new(transactions: transactions, base_url: request.base_url)
  end

  def create
    transaction = @customer.transactions.create!(
      input_currency: @input_currency,
      output_currency: @output_currency,
      input_amount: transaction_params[:input_amount],
    )
    render json: ::TransactionResource.new(transaction: transaction, base_url: request.base_url)
  rescue StandardError => error
    raise error
  end

  def show
    transaction = Transaction.find_by!(id: params[:id])
    render json: ::TransactionResource.new(transaction: transaction, base_url: request.base_url)
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: error, status: 404 }, status: 404
  rescue StandardError => error
    raise error
  end

  def update
    transaction = Transaction.find_by!(id: params[:id])
    transaction.update!(
      input_amount: transaction_params[:input_amount],
      input_currency: @input_currency,
      output_currency: @output_currency,
    )
    render json: ::TransactionResource.new(transaction: transaction, base_url: request.base_url)
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: error, status: 404 }, status: 404
  rescue StandardError => error
    raise error
  end

  private

  def transaction_params
    params.require(:transaction).permit(
      :customer_id,
      :input_amount
    )
  end

  def find_customer
    @customer = Customer.find_by!(id: transaction_params[:customer_id])
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: error, status: 404 }, status: 404
  end

  def find_input_currency
    @input_currency = Currency.find_by!(code: params[:input_currency])
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: "Input currency: #{error}", status: 404 }, status: 404
  end

  def find_output_currency
    @output_currency = Currency.find_by!(code: params[:output_currency])
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: "Output currency: #{error}", status: 404 }, status: 404
  end
end