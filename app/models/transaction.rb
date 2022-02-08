class Transaction < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  
  belongs_to :customer
  belongs_to :input_currency, class_name: "Currency", foreign_key: "input_currency_id"
  belongs_to :output_currency, class_name: "Currency", foreign_key: "output_currency_id"

  validates_associated :customer, :input_currency, :output_currency
  validates :input_amount, :output_amount, presence: true, numericality: true

  def formatted_input
    number_to_currency(input_amount, unit: input_currency.symbol)
  end

  def formatted_output
    number_to_currency(output_amount, unit: output_currency.symbol)
  end
end
