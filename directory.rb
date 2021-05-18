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
    # verify the correct info was given for cohort
    puts "student #{name} will be added to #{cohort} cohort, is this correct? Y/N"
    changes = STDIN.gets.strip.upcase
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
    name = STDIN.gets.strip
  end
  # array of students doesnt need to be returned anymore.
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
  # open the file for writing
  File.open(filename, "w") do |file|
    # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]] # new array with student info
      csv_line = student_data.join(",")
      file.puts csv_line # write csv line to the file using puts, onto a file.
    end
  end # each time you open a file, it needs to be closed. 
  puts "List of students was saved in #{filename}"
  sleep(2)
end

def load_students(filename)
  if File.exists?(filename)
    File.open(filename, "r") do |file|
      file.readlines.each do |line|
        name, cohort = line.chomp.split(',') # parallel assignment - assigning two variables at the same time.
          @students << {name: name, cohort: cohort.to_sym}
      end
    end # closes the file at the end of the block
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
  
# nothing happens until we call the methods
try_load_students
interactive_menu