module IOStream

  def create_folder #create folder holding all of the user's information
    puts "Please enter the applicant's first and last name with an underscore connecting them"
    puts "[ex. John_Doe]"
    print ">> ".chomp

    full_name = gets.chomp!

    puts "Please enter the applicant's zipcode"
    puts "[ex. 77379]"
    print ">> ".chomp

    zipcode = gets.chomp!

    if Dir.exist?("/#{full_name + zipcode}")
      puts "There is already a user with that name"
    else
      Dir.mkdir("/#{full_name + zipcode}")
      puts "folder creation successful"
    end

    full_name + zipcode
  end

  def input_position #return inputted position
    puts "Please enter a position [ex. Software Engineer, Consultant, etc.]"
    print ">> ".chomp

    user_position_choice = gets.chomp!

    user_position_choice
  end

  def input_location #return inputted location
    puts "Please enter a location [ex. San Francisco CA, Texas, United Kingdom]"
    print ">> ".chomp

    user_location_choice = gets.chomp!

    user_location_choice
  end

  def input_keywords #takes in, saves, and returns desired keywords
    puts "Are there any specific keywords you'd like to search for?"
    puts "[ex. yes, no]"
    print ">> ".chomp

    keywords_decision = gets.chomp!

    if (keywords_decision)
      puts "Please enter specific keywords [ex. Ruby, Python, Leadership]"
      puts "Type 'done' when you are finished to exit the prompt"

      keywords = []

      while (true)
        print ">> ".chomp
        current_keyword = gets.chomp!
        break if current_keyword.downcase == "done"
        keywords << current_keyword
      end

      keywords.join("\n") #returns keywords on different lines
    else
      nil #returns nil if no desired keywords
    end
  end

  def input_blocked_keywords #takes in, saves, and returns blocked keywords
    puts "Please enter specific keywords you'd like us to avoid"
    puts "Anything you would like to avoid"
    puts "[ex. Microsoft, Senior, PHP, Los Angeles]"
    puts "Type 'done' when you are finished to exit the prompt"

    blocked_keywords = []

    while (true)
      print ">> ".chomp
      current_keyword = gets.chomp!
      break if current_keyword.downcase == "done"
      blocked_keywords << current_keyword
    end

    blocked_keywords.join("\n")
  end

  def input_application_count
    puts "Please enter the number of applications to apply for"
    print ">> ".chomp

    final_count = gets.chomp!

    final_count
  end

  def input_user_info(folder_name)
    if File.file?("#{folder_name}/login_info.txt")
      login_credentials = File.readlines("#{folder_name}/login_info.txt")
      email = login_credentials[0]
      password = login_credentials[1]

      return [email, password]
    end

    puts "Please enter your account email."
    print ">> ".chomp
    email = gets.chomp!

    puts "Please enter your account password."
    puts "This will not give anyone access to your login credentials."
    print ">> ".chomp
    password = gets.chomp!

    # Option to save login info
    puts "Would you like to save your login info for future use?"
    puts "This will not save your credentials to a database. It will simply write the credentials into a text file stored on your local machine under ./user_info/login_info.txt."
    puts "Anything but 'yes' will not save your login info."
    print ">> ".chomp
    to_save = gets.chomp!

    if to_save == 'yes'
      login_info_file = File.new("#{folder_name}/login_info.txt", "w+")
      login_info_file.puts(email)
      login_info_file.puts(password)
    end

    [email, password]
  end

  def input_coverletter(folder_name)
    if File.file?("#{folder_name}/coverletter.txt")
      coverletter_file = File.read_file("#{folder_name}/coverletter.txt")
      return coverletter_file
    end

    puts "Please enter your cover letter."
    print ">> ".chomp
    coverletter = gets.chomp!

    coverletter_file = File.new("#{folder_name}/coverletter.txt", 'w+')
    coverletter_file.puts(coverletter)
    coverletter_file.close

    coverletter
  end

  def applied_jobs(folder_name)
    applied_jobs_file = File.new("#{folder_name}/applied_jobs.txt", "w+")
    applied_jobs_file.puts("Applied Jobs")
    applied_jobs_file.puts("*********************************")
    applied_jobs_file.puts("")
    applied_jobs_file.close

    applied_jobs_file
  end

  def append_file(filename, input_array)
    File.open(filename, "a") do |file|
      input_array.each do |input|
        file.puts(input)
        file.puts("---------------------------------")
      end
    end
  end

  # returns array of file's content
  def read_file(filename)
    file_content = []
    File.open(filename, 'r') do |file|
      file.each_line do |line|
        line = line[0..-2] #take out carriage return character
        file_content << line
      end
    end

    p file_content
  end
end
