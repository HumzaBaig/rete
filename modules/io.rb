module IOStream

  def input_sites
    system "clear"
    puts "Please enter a keyword from the following sites [Glassdoor]"
    print ">> ".chomp

    user_site_choice = gets.chomp!.capitalize!

    while user_site_choice != "Glassdoor"
      puts "Invalid choice"
      puts "Please enter a keyword from the following sites [Glassdoor]"
      print ">> ".chomp

      user_site_choice = gets.chomp!.capitalize!
    end
  end

  def input_positions
    puts "Please enter a position [ex. Software Engineer, Front-end, Back-end, Full-stack]"
    print ">> ".chomp

    user_position_choice = gets.chomp!

    user_position_choice
  end

  def input_locations
    puts "Please enter a location [ex. San Francisco CA, Los Angeles CA]"
    print ">> ".chomp

    user_location_choice = gets.chomp!

    user_location_choice
  end

  def input_keywords
    puts "Please enter specific keywords [ex. Ruby, Python, Leadership]"
    puts "Type 'done' when you are finished to exit the prompt"

    user_keywords = []

    while (true)
      print ">> ".chomp
      current_keyword = gets.chomp!
      break if current_keyword.downcase == "done"
      user_keywords << current_keyword
    end

    user_keywords.join("\n")
  end

  def input_login
    if File.file?('user_info/login_info.txt')
      login_credentials = File.readlines('user_info/login_info.txt')
      email = login_credentials[0]
      password = login_credentials[1]

      return [email, password]
    end

    puts "Please enter your Glassdoor account email."
    print ">> ".chomp
    email = gets.chomp!

    puts "Please enter your Glassdoor account password."
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
      login_info_file = File.new('user_info/login_info.txt', "w+")
      login_info_file.puts(email)
      login_info_file.puts(password)
    end

    [email, password]
  end

  def input_name_email
    if File.file?('user_info/user_info.txt')
      user_info_file = File.readlines('user_info/user_info.txt')
      name = user_info_file[0]
      email = user_info_file[1]

      return [name, email]
    end

    puts "Please enter your full name."
    print ">> ".chomp
    name = gets.chomp!

    puts "Please enter your email."
    print ">> ".chomp
    email = gets.chomp!

    user_info_file = File.new('user_info/user_info.txt', 'w+')
    user_info_file.puts(name)
    user_info_file.puts(email)
    user_info_file.close

    [name, email]
  end

  def input_coverletter
    if File.file?('user_info/coverletter.txt')
      coverletter_file = File.read_file('user_info/coverletter.txt')
      return coverletter_file
    end

    puts "Please enter your cover letter."
    print ">> ".chomp
    coverletter = gets.chomp!

    coverletter_file = File.new('user_info/coverletter.txt', 'w+')
    coverletter_file.puts(coverletter)
    coverletter_file.close

    coverletter
  end

  def create_file
    filename = "Summary.txt"
    index = 1

    while File.file?(filename)
      filename = "#{"Summary_" + index.to_s + ".txt"}"
      index += 1
    end

    summary_file = File.new(filename, "w+")
    summary_file.puts("Results Summary")
    summary_file.puts("*********************************")
    summary_file.puts("")
    summary_file.close

    filename
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
