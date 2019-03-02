require 'csv'

# @students instance variable no longer required outside of the methods
# as it is created immediately on opening the program with try_load_students & load_students

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load a list"
  puts "5. Exit" # deleted other exercise methods so renumbered Exit as 5
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    # removed @requested_file as instance variable and
    # put method that returns filename as argument for load_students
    load_students(open_which_file)
  when "5"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students\nTo finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    handle_students(name, :november)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
  puts "Students have been inputted"
end

def save_students
  print "Save as: "
  filename = STDIN.gets.chomp
  CSV.open(filename, "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
  puts "Students have been saved to #{filename}"
end

def open_which_file
  # removed variable requested_file as no longer required, as method is used as argument
  print "Open file: "
  STDIN.gets.chomp
end

def load_students(filename)
  @students = []
  if File.exist?(filename)
    CSV.foreach(filename) do |row|
      name, cohort = row
      handle_students(name, cohort)
    end
    puts "Loaded #{@students.count} students from #{filename}"
  else
    # removed unnecessary explicit return to interactive_menu method
    puts "Sorry, #{filename} doesn't exist."
  end
end

def handle_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def try_load_students
  filename = ARGV.first || "students.csv"
  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

interactive_menu
