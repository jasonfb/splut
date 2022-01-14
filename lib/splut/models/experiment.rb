

module Splut
  class Experiment < ActiveRecord::Base
    self.table_name = "experiments"

    has_many :variations


    def is_in_group?(splutable_thing)
      existing_segment_participant = SegmentParticipant.find_by(variation_id: self.variations.collect(&:id),
                                                                splutable: splutable_thing)

    end

    def participate!(splutable_thing)

      if self.variations.none?
        raise "participate! was called on experiment #{self.name} (id #{self.id} but there are no variations)"
      end
      # will return the segment participant if the
      # thing is already in the experiment
      #
      #
      # will put the participant into the experiment if not
      #
      segment_participant = Splut::SegmentParticipant.find_by(
        variation_id: self.variations.collect(&:id),
        splutable: splutable_thing)

      if !segment_participant
        random = rand(self.variations.count).floor

        this_variation = self.variations[random]

        puts "Putting #{splutable_thing} into variation #{this_variation}"

        segment_participant = this_variation.segment_participants.create!(splutable: splutable_thing)

      else
        puts " #{splutable_thing} was already in variation #{this_variation}"
        this_variation = segment_participant.variation
      end

      impression = this_variation.impressions.create!(splutable: splutable_thing,
                                                      segment_participant: segment_participant)

      impression
    end
  end
end
