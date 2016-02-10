# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

mt = MeasurementType.create(name: "Temperature")
unit1 = mt.units.create(name: "Celcius")
unit2 = mt.units.create(name: "Fahrenheit")
c = mt.conversions.create(source_unit: unit1,target_unit: unit2,forward_formula: 'input*9/5+32' ,
                         backward_formula: '(input - 32)* 5/9')


mt1 = MeasurementType.create(name: "Time")
unit3 = mt1.units.create(name: "Second")
unit4 = mt1.units.create(name: "Minute")
c1 = mt1.conversions.create(source_unit: unit3,target_unit: unit4,forward_formula: 'input/60' ,
                          backward_formula: 'input*60')