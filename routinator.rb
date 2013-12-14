#!/bin/env ruby
# encoding: utf-8

require 'rubygems'

class User
  attr_accessor :age, :bodyfat, :constitution, :gender, :activity_level, :weight_target, :aerobic_target,
                :anaerobic_target, :dedicated_days

  def set_constitution
    constitution = nil
    constitution = :thin if gender == "hombre" and (((15..20) === age and bodyfat <= 12) or ((21..35) === age and bodyfat <= 13) or ((36..50) === age and bodyfat <= 15) or (age > 50 and bodyfat <= 16))
    constitution = :healthy if gender == "hombre" and (((15..20) === age and (13..18) === bodyfat) or ((21..35) === age and (14..19) === bodyfat) or ((36..50) === age and (16..21) === bodyfat) or (age > 50 and (17..22) === bodyfat))
    constitution = :overweight if gender == "hombre" and (((15..20) === age and (19..24) === bodyfat) or ((21..35) === age and (20..25) === bodyfat) or ((36..50) === age and (22..27) === bodyfat) or (age > 50 and (23..28) === bodyfat))
    constitution = :obese if gender == "hombre" and (((15..20) === age and bodyfat >= 25) or ((21..35) === age and bodyfat >= 26) or ((36..50) === age and bodyfat >= 28) or (age > 50 and bodyfat >= 29))

    constitution = :thin if gender == "mujer" and (((15..20) === age and bodyfat <= 16) or ((21..35) === age and bodyfat <= 17) or ((36..50) === age and bodyfat <= 19) or (age > 50 and bodyfat <= 20))
    constitution = :healthy if gender == "mujer" and (((15..20) === age and (17..22) === bodyfat) or ((21..35) === age and (18..23) === bodyfat) or ((36..50) === age and (20..25) === bodyfat) or (age > 50 and (21..26) === bodyfat))
    constitution = :overweight if gender == "mujer" and (((15..20) === age and (23..28) === bodyfat) or ((21..35) === age and (24..29) === bodyfat) or ((36..50) === age and (26..31) === bodyfat) or (age > 50 and (27..32) === bodyfat))
    constitution = :obese if gender == "mujer" and (((15..20) === age and bodyfat >= 29) or ((21..35) === age and bodyfat >= 30) or ((36..50) === age and bodyfat >= 32) or (age > 50 and bodyfat >= 33))

    self.constitution = constitution
  end
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

user = User.new
puts "Introduce tu edad:"
user.age = gets.chomp.to_i
puts "Introduce tu bodyfat (sin porcentaje):"
user.bodyfat = gets.chomp.to_i
puts "Introduce tu sexo:"
user.gender = gets.chomp
puts "Indica tu nivel de actividad (activo, medio, sedentario):"
user.activity_level = gets.chomp
puts "Indica tu objetivo de peso (ganar, mantener, perder):"
user.weight_target = gets.chomp
puts "Indica tu objetivo anaeróbico (fuerza, hipertrofia, resistencia):"
user.anaerobic_target = gets.chomp
unless user.weight_target == "ganar"
	puts "Indica tu objetivo aeróbico (explosividad, media-distancia, larga-distancia):"
  user.aerobic_target = gets.chomp
end
puts "Indica el numero de días que quieres dedicarle a la semana (2-6):"
user.dedicated_days = gets.chomp.to_i
user.set_constitution
