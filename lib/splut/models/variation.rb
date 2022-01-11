
module Splut
  class Variation < ActiveRecord::Base
    self.table_name = "variations"
    belongs_to :experiment



    has_many :impressions
    has_many :segment_participants


  end
end