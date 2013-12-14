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

def check_constitution(gender, age, bodyfat)
	if gender == "hombre" and age >= 15 and age <= 20 and bodyfat <= 12 then #R1
		constitution = "delgado"
		return constitution
		elsif gender == "hombre" and age >= 15 and age <= 20 and bodyfat >= 13 and bodyfat <= 18 then #R2
			constitution = "saludable"
			return constitution
			elsif gender == "hombre" and age >= 15 and age <= 20 and bodyfat >= 19 and bodyfat <= 24 then #R3
				constitution = "sobrepeso"
				return constitution
				elsif gender == "hombre" and age >= 15 and age <= 20 and bodyfat >= 25 then #R4
					constitution = "obeso"
					return constitution
					elsif gender == "hombre" and age >= 20 and age <= 35 and bodyfat <= 13 then  #R5
						constitution = "delgado"
						return constitution
						elsif gender == "hombre" and age >= 20 and age <=35 and bodyfat >= 14 and bodyfat <=19 then  #R6
							constitution = "saludable"
							return constitution
							elsif gender == "hombre" and age >= 20 and age <=35 and bodyfat >= 20 and bodyfat <=25 then #R7
								constitution = "sobrepeso"
								return constitution
								elsif gender == "hombre" and age >= 20 and age <=35 and bodyfat >= 26 then #
									constitution = "obeso"
									return constitution
									elsif gender == "hombre" and age >= 35 and age <=50 and bodyfat <=15 then #R9
										constitution = "delgado"
										return constitution
										elsif gender == "hombre" and age >= 35 and age <=50 and bodyfat >= 16 and bodyfat <=21 then #R10
											constitution = "saludable"
											return constitution
	end	
end


puts "Introduce tu edad"
age = gets.chomp.to_i
puts "Introduce tu bodyfat (sin porcentaje)"
bodyfat = gets.chomp.to_i
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
dedicated_days = gets.chomp.to_i

constitution = check_constitution(gender, age, bodyfat)
