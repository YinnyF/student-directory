require 'csv'
@students = [] # an empty array accessible to all methods

def puts_title(string)
  puts "\n"
  puts "-------------".center(35)
  puts string.center(35)
  puts "-------------".center(35) 
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.strip
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "please enter the cohort"
    # convert their input to symbol
    cohort = STDIN.gets.strip.downcase.to_sym
    # default to :november if nothing is etnered
    cohort = :november if cohort.empty?
    # verify the correct info was given
    # ask for the hobbies
    puts "Please enter their hobbies"
    hobby = STDIN.gets.strip.downcase
    hobby = "none" if hobby.empty?
    
    puts "#{name} will be added to #{cohort} cohort with the hobbies #{hobby}, is this correct? Y/N"
    changes = STDIN.gets.strip.upcase
    # add the student hash to the array
    push_students(name, cohort, hobby)
    @students.pop if changes == "N" # remove the student from the hash if its not correct
    
    # fix the grammar
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    name = STDIN.gets.strip
  end
  # array of students doesnt need to be returned anymore.
end

def push_students(name, cohort, hobby)
   @students << {name: name, cohort: cohort.to_sym, hobby: hobby}
end

def print_header
  return nil if @students.count == 0
  puts_title("The Students of Villains Academy")
end

def group_students # creates new array containing a hash with key (cohort) and values (student names)
  @grouped_by_cohort = {} # an empty hash accessible to all methods, resets each time grouped.
  
  @students.each do |student| 
  if @grouped_by_cohort[student[:cohort]] == nil 
    @grouped_by_cohort[student[:cohort]] = []
  end
  @grouped_by_cohort[student[:cohort]].push(student[:name])
end
  
end

def print_students_list # @students is an array of hashes
  if @students.count == 0
    puts "nothing to show you here".center(35)
    return
  end
  
  group_students
  
  @grouped_by_cohort.each do |cohort, name|
    puts "#{cohort} cohort".center(35)
    puts name
    puts "\n"
  end
end

def print_footer
  if @students.count == 0
    return nil
  elsif @students.count == 1
    puts "Overall, we have #{@students.count} great student".center(35)
  else
    puts "Overall, we have #{@students.count} great students".center(35)
  end
end

def print_menu
  puts_title("Menu")
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the student list to .csv"
  puts "4. Load the student list from a .csv"
  puts "7. Display school logo"
  puts "8. View my insides"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      puts "You have selected to input the students..."
      sleep(2)
      input_students
    when "2"
      puts "Now showing the list of students..."
      sleep(2)
      show_students
    when "3"
      puts "What filename would you like to save as? Please type the .csv extension as well."
      save_students(STDIN.gets.chomp)
    when "4"
      puts "What filename would you like to load? Please type the .csv extenstion as well."
      load_students(STDIN.gets.chomp)
    when "7"
      school_logo
      sleep(3)
    when "8"
      source_code
    when "9"
      puts "Bye!"
      sleep(2)
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
      sleep(2)
  end
end

def interactive_menu
  loop do # 4. repeat from step 1
    # 1. print the menu and ask the user what to do
    print_menu
    # 2 + 3. get user input and do what the user has asked
    process(STDIN.gets.chomp)
  end
end

def save_students(filename)
  filename = "students.csv" if filename.empty? # default to students.csv if no filename given
  # check the file type is correct
  if filename[-4..-1]!=".csv"
    puts "The filename is incorrect, now returning to menu. Please try again."
    sleep(2)
    return
  end
  
  # use CSV library method called open to write to a file.
  CSV.open(filename, "wb") do |csv|
    # iterate over the array of students and append them to csv
    @students.each { |student| csv << [student[:name], student[:cohort], student[:hobby]] }  
  end
  
  puts "List of students was saved in #{filename}"
  sleep(2)
end

def load_students(filename)
  if File.exists?(filename) # check that the file exists
    # open the file and generate the hashes using CSV library
    CSV.foreach(filename) do |line|
      name, cohort, hobby = line # parallel assignment to name & cohort - line is an array of elements already separated.
      push_students(name, cohort, hobby)
    end
    puts "List of students was loaded from #{filename}"
    sleep(2)
  else 
    puts "The file does not exist, now returning to menu. Please try again."
    sleep(2)
  end
end

def try_load_students
  ARGV.first.nil? ? filename = "students.csv" : filename = ARGV.first
  if File.exists?(filename) # if the filename exists, a File class method
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def source_code
  puts "----- This is the beginning of the source code -----".center(50)
  puts File.read(__FILE__) 
  puts "----- This is the end of the source code -----".center(50)
  sleep(2)
end

def school_logo
  puts File.read("villains_logo.txt")
end
# nothing happens until we call the methods
try_load_students
interactive_menu
