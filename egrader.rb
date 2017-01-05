#!/usr/bin/env ruby

require 'optparse'
require 'faker'

# This will hold the options we parse
options = {}

options[:count]=1

OptionParser.new do |parser|

  parser.on("-c", "--count COUNT", Integer, "Repeat the message COUNT times") do |v|
    options[:count] = v
  end
  
end.parse!

# This items should be the same for all students

enrl_cd = Faker::Number.number(5)   # might differ when multiple sections
grade = ""                          # blank for course rosters before grades assigned
final_units = "4.0"                 # typically 4.0
quarter = "W17"
course="CMPSC596"
section= Faker::Number.number(4)    # might differ for multiple sections
time_loc="T.B.A."
date_time=Time.now.strftime("%-m/%-e/%Y %-l:%M:%S %p") # e.g. 1/4/2017 6:11:49 PM

puts "Enrl Cd,Perm #,Grade,Final Units,Student Last,Student First Middle,Quarter,Course ID,Section,Meeting Time(s) / Location(s),Email,ClassLevel,Major1,Major2,Date/Time"
puts ""
(1..options[:count]).each do |i| 

  perm = Faker::Number.unique.number(7)
  student_last = Faker::Name.last_name
  student_first = Faker::Name.first_name
  student_middle = ["", " "+Faker::Name.first_name].sample
  name_to_feed_email = [student_first+" "+student_last,
                        student_first + student_last[0],
                        student_first[0] + " " +student_last].sample
  email = Faker::Internet.unique.user_name(name_to_feed_email)+"@umail.ucsb.edu"
  classlevel=["FR","SO","JR","SR"].sample
  major1=["ACTSC","CHEM","COMM","CMPSC","CMPEN","GEOG","PRMTH","MATH"].sample
  major2=""

  puts [enrl_cd, perm, grade, final_units, student_last.upcase, student_first.upcase+student_middle.upcase, quarter,course,section,time_loc,email,classlevel,major1,major2,date_time ].join(",")
end
