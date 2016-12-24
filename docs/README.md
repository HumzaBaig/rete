# Pabang Webcrawler

### Background

Pabang is a web browser automation script for Glassdoor that utilizes the Selenium webdriver.

Created by Humza Baig, Jay Hwang, and Michael Pak.

### Description

The user inputs keywords that trigger their corresponding action:

[Keyword] Website
- The script takes a keyword [Glassdoor] as an input and formats the keyword using Regex. The modified keyword triggers the webcrawler through Selenium webdriver, which opens the specified website's job listings page.

[Keyword] Search Criteria
- The script takes additional keywords ex. [Software Engineer, Back-end, Front-end, Full Stack], which is parsed with Regex to ensure the keywords meet the website's input format. The webcrawler is triggered displaying all relevant job postings within the website.

[Index] Job Postings List
- The script parse through the results and stores relevant information related to the job posting ex. (Title of Job, Relevant Dates, Location). With the gathered information, the script will numerically display a user-friendly list of all job postings that met the search criteria. Inputting a number will open that particular job listing in the web browser.

### Functionality & MVP

With this application, users will be able to:

- [X] Go to [keyword] URL specified by user
- [X] Search job postings within URL w/ keywords specified by user
- [X] Parse all job postings
- [X] Display summary of keywords to job postings

### Technologies & Technical Challenges

This application will be implemented using the Selenium webdriver, and Ruby, for user-friendly input/output.

Primary Technical Challenges:

- Teaching the script to grab specified HTML elements and inject user keywords
- Script customization based upon website design [Glassdoor, Hired, LinkedIn] including different website layout, possible user sign-in functionality, and daily modifications
- Parsing the data and displaying accurately in real-time

### Implementation Timeline

##### Day 1 - Day 2
- Learn the basics of Selenium and become familiar with API. Learning how to utilize Git in a small group working on the same project. Goals for Days 1 and 2:
  * [X] Learn the basics of Selenium
  * [X] Learn effective Github workflow

##### Day 3
- Initial Pabang setup. Create necessary files including the basic skeleton of app. Goals for Days 3:
   * [X] Write a basic terminal script asking for user input and writes and saves input into a separate text file for parsing
   * [X] Allow users to input keywords for search criteria

##### Day 4
- Write logic to handle the actual web-crawling, search the specified sites for the user keywords, and saves each individual listing that matches the search criteria. Goals for Day 4:
  * [X] Write logic for AI web-crawling
  * [X] Create script logic to parse through websites, search for keywords, and save matches

##### Day 5
- Add styling and display info in a neat, organized manner. Goals for Day 5:
  * [X] Clean/refactor code
  * [X] Add styling

### Additional Bonus

Upcoming Websites
- Hired
- LinkedIn

Upcoming Features
- Job Posting Criteria Keywords
The script takes additional keywords [Ruby, Python, Leadership, Teamwork] desired in the job posting.

- Job Posting Filter Keywords
The script takes additional keywords [CEO, Vice-President, No-Salary] NOT desired in the job posting.

### End Result

The Pabang Webcrawler creates a PASS/FAIL summary based upon keywords, results, and desired match percentage.

Summary
  - Job Title, Search Criteria, Filter Criteria
  - Pass/Fail w/ Match Percentage
    * Pass: reasons based upon Search Criteria
    * Fail: reasons based upon Filter Criteria
