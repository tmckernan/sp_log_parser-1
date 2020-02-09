# frozen_string_literal: true

require_relative '../constants/sorter_constants'

# Sorts the endpoints visits by visits
class VisitsSorter
  def self.sort(endpoints_visits, direction: SorterConstants::DESC)
    if direction == SorterConstants::DESC
      descending_sort(endpoints_visits)
    elsif direction == SorterConstants::ASC
      ascending_sort(endpoints_visits)
    end
  end

  def self.descending_sort(endpoints_visits)
    endpoints_visits.sort { |a, b| b.visits <=> a.visits }
  end

  def self.ascending_sort(endpoints_visits)
    endpoints_visits.sort { |a, b| a.visits <=> b.visits }
  end
end
