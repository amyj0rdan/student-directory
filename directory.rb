def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while name is not empty, repeat this code
  while !name.empty? do
    # gets the corresponding cohort and sends to symbol
    puts "What cohort are they in?"
    cohort = gets.chomp.downcase
    #add the student hash to the array
    unless ["january", "february", "march", "april", "may", "june", "july",
      "august", "september", "october", "november", "december"].include? cohort
      puts "I don't recognise that - please try again"
      cohort = gets.chomp.downcase
    end
    cohort.to_sym
    students << {name: name, cohort: cohort.capitalize, hobby: :villainy}
    if students.count == 1
      puts "Now we have 1 student"
    else
    puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def cohort_list(students)
  cohorts = []
  students.each do |student|
    unless cohorts.include? student[:cohort]
      cohorts << student[:cohort]
    end
  end
  cohorts
end

def print_header
  puts "The students of Villains Academy".center(80)
  puts "-------------".center(80)
end

def print(students)
  students.each_with_index do |student, number|
    puts "#{number + 1}. #{student[:name]} (#{student[:cohort]} cohort, hobby: #{student[:hobby]})".center(80)
  end
end

def print_with_loop(students)
  count = 0
  until count == students.count
    puts "#{students[count][:name]} (#{students[count][:cohort]} cohort, hobby: #{students[count][:hobby]})"
    count += 1
  end
end

def print_start_with(students)
  students.each_with_index do |student|
    if student[:name].start_with?("D")
      puts "#{student[:name]} (#{student[:cohort]} cohort, hobby: #{student[:hobby]})"
    end
  end
end

def print_12_characters(students)
  students.each_with_index do |student|
    if student[:name].length < 12
      puts "#{student[:name]} (#{student[:cohort]} cohort, hobby: #{student[:hobby]})"
    end
  end
end

def print_by_cohort(students, cohorts)
  cohorts.each do |month|
    students.each do |student|
      if student[:cohort] == month
        puts "#{student[:name]} (#{student[:cohort]} cohort, hobby: #{student[:hobby]})"
      end
    end
  end
end

def print_footer(students)
puts "Overall, we have #{students.count} great students".center(80)
end

students = input_students
cohorts = cohort_list(students)
#nothing happens until we call the methods
# centered output based on standard Mac terminal size
print_header
print(students)
print_footer(students)
