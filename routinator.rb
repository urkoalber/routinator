#!/bin/env ruby
# encoding: utf-8

require 'rubygems'

class User
  attr_accessor :age, :bodyfat, :constitution, :gender, :activity_level, :weight_target, :aerobic_target,
                :anaerobic_target, :dedicated_days

  def set_constitution
    constitution = nil
    constitution = :thin if gender == 'hombre' and (
        ((15..20) === age and bodyfat <= 12) or ((21..35) === age and bodyfat <= 13) or
        ((36..50) === age and bodyfat <= 15) or (age > 50 and bodyfat <= 16))
    constitution = :healthy if gender == 'hombre' and (
        ((15..20) === age and (13..18) === bodyfat) or ((21..35) === age and (14..19) === bodyfat) or
        ((36..50) === age and (16..21) === bodyfat) or (age > 50 and (17..22) === bodyfat))
    constitution = :overweight if gender == 'hombre' and (
        ((15..20) === age and (19..24) === bodyfat) or ((21..35) === age and (20..25) === bodyfat) or
        ((36..50) === age and (22..27) === bodyfat) or (age > 50 and (23..28) === bodyfat))
    constitution = :obese if gender == 'hombre' and (
        ((15..20) === age and bodyfat >= 25) or ((21..35) === age and bodyfat >= 26) or
        ((36..50) === age and bodyfat >= 28) or (age > 50 and bodyfat >= 29))

    constitution = :thin if gender == 'mujer' and (
        ((15..20) === age and bodyfat <= 16) or ((21..35) === age and bodyfat <= 17) or
        ((36..50) === age and bodyfat <= 19) or (age > 50 and bodyfat <= 20))
    constitution = :healthy if gender == 'mujer' and (
        ((15..20) === age and (17..22) === bodyfat) or ((21..35) === age and (18..23) === bodyfat) or
        ((36..50) === age and (20..25) === bodyfat) or (age > 50 and (21..26) === bodyfat))
    constitution = :overweight if gender == 'mujer' and (
        ((15..20) === age and (23..28) === bodyfat) or ((21..35) === age and (24..29) === bodyfat) or
        ((36..50) === age and (26..31) === bodyfat) or (age > 50 and (27..32) === bodyfat))
    constitution = :obese if gender == 'mujer' and (
        ((15..20) === age and bodyfat >= 29) or ((21..35) === age and bodyfat >= 30) or
        ((36..50) === age and bodyfat >= 32) or (age > 50 and bodyfat >= 33))

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

  def initialize
    self.quadriceps, self.hamstring, self.lumbar, self.abdominal, self.shoulder, self.arm, self.chest, self.back,
        self.ankle, self.knee, self.wrist, self.elbow = false, false, false, false, false, false, false, false, false,
        false, false, false
  end

  def evaluate_injury(input)
    unless input == 'no'
      injury_list = input.gsub(' ', '').split(',')
      self.quadriceps = true if injury_list.include? 'cuadriceps'
      self.hamstring = true if injury_list.include? 'isquiotibial'
      self.lumbar = true if injury_list.include? 'lumbar'
      self.abdominal = true if injury_list.include? 'abdominal'
      self.shoulder = true if injury_list.include? 'hombro'
      self.arm = true if injury_list.include? 'brazo'
      self.chest = true if injury_list.include? 'pecho'
      self.back = true if injury_list.include? 'espalda'
      self.ankle = true if injury_list.include? 'tobillo'
      self.knee = true if injury_list.include? 'rodilla'
      self.wrist = true if injury_list.include? 'muñeca'
      self.elbow = true if injury_list.include? 'codo'
    end
  end
end

class WarmUp
  attr_accessor :length
end

class Routine
  attr_accessor :type, :muscle_days, :cardio_days

  def set_routine(dedicated_days, weight_target)
    if weight_target == 'perder'
      routine_attrs = case dedicated_days
                        when 2 then ['solo-cardio', 0, 2]
                        when 3 then ['fullbody', 1, 2]
                        when 4 then ['fullbody', 2, 2]
                        when 5 then ['fullbody', 2, 3]
                        when 6 then ['fullbody', 3, 3]
                        else []
                      end
    elsif weight_target == 'mantener'
      routine_attrs = case dedicated_days
                        when 2 then ['fullbody', 1, 1]
                        when 3 then ['fullbody', 2, 1]
                        when 4 then ['fullbody', 3, 1]
                        when 5 then ['fullbody', 3, 2]
                        when 6 then ['torso-pierna', 4, 2]
                        else []
                      end
    else
      routine_attrs = case dedicated_days
                        when 2 then ['fullbody', 2, 0]
                        when 3 then ['fullbody', 3, 0]
                        when 4 then ['torso-pierna', 4, 0]
                        when 5 then ['weider', 5, 0]
                        when 6 then ['weider', 6, 0]
                        else []
                      end
    end
    self.type = routine_attrs[0]
    self.muscle_days = routine_attrs[1]
    self.cardio_days = routine_attrs[2]
    nil
  end

end

user = User.new
routine = Routine.new
injury = Injury.new

puts 'Introduce tu edad:'
user.age = gets.chomp.to_i
puts 'Introduce tu bodyfat (sin porcentaje):'
user.bodyfat = gets.chomp.to_i
puts 'Introduce tu sexo (hombre, mujer):'
user.gender = gets.chomp
user.set_constitution # calculate constitution with age, bodyfat & gender
puts 'Indica tu nivel de actividad (activo, medio, sedentario):'
user.activity_level = gets.chomp
puts 'Indica tu objetivo de peso (ganar, mantener, perder):'
user.weight_target = gets.chomp
puts 'Indica tu objetivo anaeróbico (fuerza, hipertrofia, resistencia):'
user.anaerobic_target = gets.chomp
unless user.weight_target == 'ganar'
	puts 'Indica tu objetivo aeróbico (explosividad, media-distancia, larga-distancia):'
  user.aerobic_target = gets.chomp
end
puts 'Indica el numero de días que quieres dedicarle a la semana (2-6):'
user.dedicated_days = gets.chomp.to_i
routine.set_routine(user.dedicated_days, user.weight_target)

puts user
puts routine

puts '¿Tiene alguna lesión? (cuadriceps, isquiotibial, lumbar, abdominal, hombro, brazo, pecho, espalda, tobillo, rodilla, muñeca, codo).'
puts 'Introduzca el nombre de la lesión. Si son varios, sepárelos por coma. Introduzca "no" en caso negativo.'
injury.evaluate_injury(gets.chomp)

puts injury