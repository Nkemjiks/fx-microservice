class Transaction < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  
  belongs_to :customer
  belongs_to :input_currency, class_name: "Currency", foreign_key: "input_currency_id"
  belongs_to :output_currency, class_name: "Currency", foreign_key: "output_currency_id"

  validates_associated :customer, :input_currency, :output_currency
  validates :input_amount, presence: true, numericality: true

  before_save :convert_amount

  def formatted_input
    number_to_currency(input_amount, unit: input_currency.symbol)
  end

  def formatted_output
    number_to_currency(output_amount, unit: output_currency.symbol)
  end

  def convert_amount
    input_amount = self.input_amount

    rates = EXCHANGE_RATES[self.input_currency.code]
    conversion_value = rates[self.output_currency.code]
    self.output_amount = conversion_value * input_amount
  end

  EXCHANGE_RATES = {
    'NGN' => {
      'USD' => 0.002,
      'CAD' => 0.0025
    },
    'CAD' => {
      'NGN' => 400,
      'USD' => 1.5
    },
    'USD' => {
      'NGN' => 500,
      'CAD' => 1.2
    }
  }
end
