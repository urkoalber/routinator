#!/bin/env ruby
# encoding: utf-8

require 'rubygems'

class User
  attr_accessor :age, :bodyfat, :constitution, :gender, :activity_level, :weight_target, :aerobic_target,
                :anaerobic_target, :dedicated_days
end

class Problem
  attr_accessor :muscular, :articular, :circumstancial
end

class MuscularExercise
  attr_accessor :name, :series, :repetitions, :break_time
end

class CardioExercise
  attr_accessor :name, :duration, :intensity
end

class Injury
  attr_accessor :quadriceps, :hamstring, :lumbar, :abdominal, :shoulder, :arm, :chest, :back, :ankle, :knee, :wrist,
                :elbow
end

class WarmUp
  attr_accessor :length
end

class Routine
  attr_accessor :type, :muscle_days, :cardio_days
end

