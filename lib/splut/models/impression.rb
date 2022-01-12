require 'counter_culture'


module Splut
  class Impression < ActiveRecord::Base
    self.table_name = "impressions"

    belongs_to :variation

    belongs_to :splutable, polymorphic: true
    belongs_to :segment_participant

    counter_culture :variation,  column_name: '_impression_total'
    counter_culture :variation,  column_name: proc {|model| model.success  ? '_impression_success' : nil }


    def success!
      # set this impression to successful
      # set the segment participant to successufl
      #
      #
    end
  end
end