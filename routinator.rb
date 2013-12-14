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

puts "Introduce tu edad"
age = gets.chomp
puts "Introduce tu bodyfat (sin porcentaje)"
bodyfat = gets.chomp
puts "Introduce tu sexo"
gender = gets.chomp
puts "Indica tu nivel de actividad (activo, medio, sedentario)"
activity_level = gets.chomp
puts "Indica tu objetivo de peso (ganar, mantener, perder)"
weight_target = gets.chomp
puts "Indica tu objetivo anaeróbico (fuerza, hipertrofia, resistencia)"
anaerobic_target = gets.chomp
if weight_target != "ganar" then
	puts "Indica tu objetivo aeróbico (explosividad, media-distancia, larga-distancia)"
	aerobic_target = gets.chomp
end
puts "Indica el numero de días que quieres dedicarle a la semana (2-6)"
dedicated_days = gets.chomp

if gender == "hombre" and edad >=15 and edad<=20 and bodyfat<=12 then
	constitution="delgado"
end


