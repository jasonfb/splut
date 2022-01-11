
require 'counter_culture'

module Splut
  class SegementParticipant < ActiveRecord::Base
    self.table_name = "segment_participants"

    belongs_to :variation
    belongs_to :splutable, polymorphic: true

    counter_culture :variation,  column_name: :_segment_total
    counter_culture :variation,  column_name: proc {|model| model.success  ? '_segment_success' : nil }

    def success!
      # since we don't know the impression, just guess
      # that the last impression was the successful one
      #
      #
      # set this + the last impression to successful
    end
  end
end
