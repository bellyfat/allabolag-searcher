class ResultsController < ApplicationController
  def self.create(search_term, found, reg_number)
    if Result.search(search_term).empty?
      Result.create(search_term: search_term, found: found,
                    reg_number: reg_number).save!
    else
      Result.where('search_term LIKE ?', "%#{search_term}%")
      .update_all(found: found, reg_number: reg_number)
    end
  end
end
