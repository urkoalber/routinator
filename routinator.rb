#!/bin/env ruby
# encoding: utf-8

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

class Circumstance
  attr_accessor :pregnant
end

class MuscularExercise
  attr_accessor :series, :repetitions, :break_time

  def set_exercise(anaerobic_target, activity_level)
    if anaerobic_target == 'fuerza'
      self.repetitions = 5
      self.break_time = 120
    elsif anaerobic_target == 'hipertrofia'
      self.repetitions = 10
      self.break_time = 80
    else
      self.repetitions = 15
      self.break_time = 40
    end

    self.series = case activity_level
                    when 'sedentario' then 3
                    when 'medio' then 4
                    when 'activo' then 5
                    else 0
                  end

  end

  def to_s
    "Series: #{self.series}. Repeticiones: #{self.repetitions}. Descanso: #{self.break_time}."
  end
end

class CardioExercise
  attr_accessor :type, :duration, :intensity

  def set_exercise(aerobic_target, activity_level, constitution)
    if aerobic_target == 'explosividad'
      self.intensity = 'interválica-alta-baja'
      duration = 30
    elsif aerobic_target == 'larga-distancia'
      self.intensity = 'baja'
      duration = 75
    else
      self.intensity = 'media'
      duration = 45
    end

    duration = case activity_level
                 when 'sedentario' then duration - 0.1 * duration
                 when 'medio' then duration + 0.1 * duration
                 when 'activo' then duration + 0.2 * duration
                 else duration
               end
    self.duration = case constitution
                      when :thin then duration - 0.2 * duration
                      when :overweight then duration + 0.1 * duration
                      when :obese then duration + 0.2 * duration
                      else duration
                    end

    type = nil
    type = 'bici' if (activity_level == 'sedentario' and constitution != :thin)
    type = 'elíptica' if ((activity_level == 'sedentario' and constitution == :thin) or
        (activity_level == 'medio' and (constitution == :healthy or constitution == :overweight)) or
        (activity_level == 'activo' and (constitution == :obese or constitution == :overweight)))
    type = 'cinta' if (constitution == :healthy and activity_level == 'activo') or (constitution == :thin and
        (activity_level == 'medio' or activity_level == 'activo'))
    self.type = type
  end

  def set_exercise_type_when_problem(ankle, knee, pregnant)
    self.type = 'elíptica' if self.type == 'cinta' and (ankle or knee or pregnant)
    self.intensity = 'media' if self.intensity == 'interválica-alta-baja' and pregnant
  end

  def to_s
    "Tipo: #{self.type}. Duración: #{self.duration}. Intensidad: #{self.intensity}."
  end
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

  def set_warm_up(repetitions, activity_level)
    if (6..9) === repetitions
      length = 10
    elsif repetitions < 6
      length = 15
    else
      length = 5
    end
    length = length + 5 if activity_level == 'sedentario'
    length = length - 5 if activity_level == 'activo'

    self.length = length
  end

  def to_s
    "Duración del calentamiento: #{self.length}."
  end
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

  def set_routine_type_when_problem(wrist_injury, elbow_injury, pregnant)
    self.type = 'solo-pierna' if wrist_injury or elbow_injury
    if self.muscle_days > 0 and pregnant
      self.type = 'solo-cardio'
      self.cardio_days = self.cardio_days + self.muscle_days
      self.muscle_days = 0
    end
  end

  def to_s
    "Tipo: #{self.type}. Días de musculación: #{self.muscle_days}. Días de cardio: #{self.cardio_days}."
  end

end

class ForbbidenExercise
  attr_accessor :leg, :hamstring, :lumbar, :abdominal, :biceps, :triceps, :chest, :shoulder, :back

  def set_forbbiden_exercise(injury)
    self.leg = (injury.ankle or injury.knee or injury.lumbar or injury.quadriceps)
    self.abdominal = injury.abdominal
    self.hamstring = injury.hamstring
    self.shoulder = injury.shoulder

    self.biceps = injury.arm
    self.triceps = injury.arm

    self.chest = injury.chest
    self.back = injury.back

  end

  def to_s
    output = 'Ejercicios prohibidos: [ '
    output << 'pierna ' if self.leg
    output << 'femoral ' if self.hamstring
    output << 'lumbar ' if self.lumbar
    output << 'abdominal ' if self.abdominal
    output << 'bíceps ' if self.biceps
    output << 'tríceps ' if self.triceps
    output << 'pecho ' if self.chest
    output << 'hombros ' if self.shoulder
    output << 'espalda ' if self.back
    output << ']'
    output
  end

end

# Execution

user = User.new
routine = Routine.new
injury = Injury.new
circumstance = Circumstance.new
muscular_exercise = MuscularExercise.new
cardio_exercise = CardioExercise.new
warm_up = WarmUp.new
forbidden_exercies = ForbbidenExercise.new

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
if user.weight_target == 'ganar'
  user.aerobic_target = 'no-procede'
else
	puts 'Indica tu objetivo aeróbico (explosividad, media-distancia, larga-distancia):'
  user.aerobic_target = gets.chomp
end
puts 'Indica el numero de días que quieres dedicarle a la semana (2-6):'
user.dedicated_days = gets.chomp.to_i
routine.set_routine(user.dedicated_days, user.weight_target)

puts '¿Tiene alguna lesión? (cuadriceps, isquiotibial, lumbar, abdominal, hombro, brazo, pecho, espalda, tobillo, rodilla, muñeca, codo).'
puts 'Introduzca el nombre de la lesión. Si son varios, sepárelos por coma. Introduzca "no" en caso negativo.'
injury.evaluate_injury(gets.chomp)

if user.gender == 'mujer'
  puts '¿Está embarazada? (si/no)'
  circumstance.pregnant = gets.chomp == 'si' ? true : false
else
  circumstance.pregnant = false
end

if routine.muscle_days > 0
  muscular_exercise.set_exercise(user.anaerobic_target, user.activity_level)
  warm_up.set_warm_up(muscular_exercise.repetitions, user.activity_level)
end
cardio_exercise.set_exercise(user.aerobic_target, user.activity_level, user.constitution) if routine.cardio_days > 0
forbidden_exercies.set_forbbiden_exercise(injury)
cardio_exercise.set_exercise_type_when_problem(injury.ankle, injury.knee, circumstance.pregnant)
routine.set_routine_type_when_problem(injury.wrist, injury.elbow, circumstance.pregnant)

puts '================================================================'
puts 'Informe de ejercicios'
puts '================================================================'
puts 'Rutina:'
puts routine
puts '----------------------------------------------------------------'
puts 'Calentamiento:'
puts warm_up
puts '----------------------------------------------------------------'
puts 'Ejercicio de cardio:'
puts cardio_exercise if routine.cardio_days > 0
puts ' -- ' if routine.cardio_days <= 0
puts '----------------------------------------------------------------'
puts 'Ejercicio de musculación:'
puts muscular_exercise if routine.muscle_days > 0 or routine.type != 'solo-cardio'
puts ' -- ' if routine.muscle_days <= 0 or routine.type == 'solo-cardio'
puts '----------------------------------------------------------------'
puts forbidden_exercies
puts '================================================================'