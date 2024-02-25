# app/models/ship.rb
class Ship < ApplicationRecord
    validates_presence_of :name, :size, :symbol
  
    def sunk?
      hits.size == size
    end
  end
  