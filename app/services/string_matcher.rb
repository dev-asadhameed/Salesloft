# frozen_string_literal: true

require 'fuzzystringmatch'

class StringMatcher
  attr_reader :records, :errors, :matching_strings, :fuzzy_string_matcher

  def initialize(records)
    @records = records
    @errors = []
    @matching_strings = {}
    @fuzzy_string_matcher = FuzzyStringMatch::JaroWinkler.create(:pure)

    check_errors
  end

  def generate
    return errors.to_sentence if errors.any?

    records.each_with_index do |record, outer_index|
      @matching_strings[record] = []

      records.each_with_index do |rec, inner_index|
        next if outer_index == inner_index

        @matching_strings[record] << rec if fuzzy_string_matcher.getDistance(record, rec) >= 0.9
      end
    end

    @matching_strings
  end

  private

  def check_errors
    errors << I18n.t('errors.missing_records') unless records.any?
    error << I18n.t('errors.data_type') unless records.is_a?(Array)
  end
end
