def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "please enter the cohort"
    # convert their input to symbol
    cohort = gets.chomp.downcase.to_sym
    # default to :november if nothing is etnered
    cohort = :november if cohort.empty?
    # verify the correct info was given for cohort
    puts "student #{name} will be added to #{cohort} cohort, is this correct? Y/N"
    changes = gets.chomp.upcase
    # start from next loop if wrong info was given
    next if changes =="N" 
    
    # add the student hash to the array
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(35)
  puts "-------------".center(35)
end

def print(students) # students is an array of hashes
  i = 0 
  while i < students.length
    puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)".center(35)
    i += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(35)
end

# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)