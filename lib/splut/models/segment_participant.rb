
require 'counter_culture'

module Splut
  class SegmentParticipant < ActiveRecord::Base
    self.table_name = "segment_participants"

    belongs_to :variation
    belongs_to :splutable, polymorphic: true
    has_many :impressions

    counter_culture :variation,  column_name: :_segment_total
    counter_culture :variation,  column_name: proc {|model| model.success  ? '_segment_success' : nil }

    def success!

      self.update(success: true, success_at: DateTime.current)
      self.impressions.last.update(success: true, success_at: DateTime.current)
    end
  end
end
