# frozen_string_literal: true

class FrequencyCount
  attr_reader :records, :order, :errors, :frequency_counts

  def initialize(records, order = 'none')
    @records = records
    @order = order
    @errors = []
    @frequency_counts = {}

    check_errors
  end

  def generate
    return 'Something went wrong.' if errors.any?

    @frequency_counts = records.reduce(:+)&.each_char&.tally
    return frequency_counts if order == 'none'

    sort.to_h.with_indifferent_access.except(*SPECIAL_CHARACTERS)
  end

  private

  ALLOWED_ORDERS = %w[desc asc none].freeze
  SPECIAL_CHARACTERS = %i[@ .].freeze

  private_constant :ALLOWED_ORDERS, :SPECIAL_CHARACTERS

  def sort
    frequency_counts.sort do |v1,v2|
      order == 'asc' ? v1[1] <=> v2[1] : v2[1] <=> v1[1]
    end
  end

  def check_errors
    errors << 'Records are missing.' unless records.any?
    error << 'Wrong Data type.' unless records.is_a?(Array)
    errors << 'Order by type is not allowed.' unless ALLOWED_ORDERS.include?(order)
  end
end
