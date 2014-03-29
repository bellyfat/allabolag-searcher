class Result < ActiveRecord::Base
  attr_accessible :search_term, :found, :reg_number, :created_at, :updated_at

    def self.search(term)
      if term
        find(:all, :conditions => ['search_term LIKE ?', "%#{term}%"])
      else
        find(:all)
      end
    end
end
