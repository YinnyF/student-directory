@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = gets.strip
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "please enter the cohort"
    # convert their input to symbol
    cohort = gets.strip.downcase.to_sym
    # default to :november if nothing is etnered
    cohort = :november if cohort.empty?
    # verify the correct info was given for cohort
    puts "student #{name} will be added to #{cohort} cohort, is this correct? Y/N"
    changes = gets.strip.upcase
    # start from next loop if wrong info was given
    next if changes =="N" 
    
    # add the student hash to the array
    @students << {name: name, cohort: cohort}
    
    # fix the grammar
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    name = gets.strip
  end
  # array of students doesnt need to be returned anymore.
end

def print_header
  return nil if @students.count == 0
  puts "The students of Villains Academy".center(35)
  puts "-------------".center(35)
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
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
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
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do # 4. repeat from step 1
    # 1. print the menu and ask the user what to do
    print_menu
    # 2 + 3. get user input and do what the user has asked
    process(gets.chomp)
  end
end

def save_students
  # opeb the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]] # new array with student info
    csv_line = student_data.join(",")
    file.puts csv_line # write csv line to the file using puts, onto a file.
  end
  file.close # each time you open a file, it needs to be closed. 
end
# nothing happens until we call the methods
interactive_menu