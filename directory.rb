def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
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
    students << {name: name, cohort: cohort}
    
    # fix the grammar
    if students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name = gets.strip
  end
  # return the array of students
  students
end

def print_header(students)
  return nil if students.count == 0
  puts "The students of Villains Academy".center(35)
  puts "-------------".center(35)
end

def print(students) # students is an array of hashes
  if students.count == 0
    puts "nothing to show you here".center(35)
    return
  end
  grouped_by_cohort = Hash.new # a hash of hashes grouped by cohort.

  students.each do |student| 
    if grouped_by_cohort[ student[:cohort] ] == nil 
      grouped_by_cohort[ student[:cohort] ] = []
    end
    grouped_by_cohort[ student[:cohort] ].push( student[:name] )
  end
  
  grouped_by_cohort.each do |cohort, name|
    puts "#{cohort} cohort".center(35)
    puts name
    puts "\n"
  end
end

def print_footer(students)
  if students.count == 0
    return nil
  elsif students.count == 1
    puts "Overall, we have #{students.count} great student".center(35)
  else
    puts "Overall, we have #{students.count} great students".center(35)
  end
end

# nothing happens until we call the methods
students = input_students
print_header(students)
print(students)
print_footer(students)