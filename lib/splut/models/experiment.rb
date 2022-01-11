

module Splut
  class Experiment < ActiveRecord::Base
    self.table_name = "experiments"

    has_many :variations


    def is_in_group?(splutable_thing)
      # only checks to see if they are already segemented
      # but will not segement them
    end

    def retrieve_group!(splutable_thing)
      # will return the segment participant if the
      # thing is already in the experiment
      #
      #
      # will put the participant into the experiment if not
    end


  end
end
