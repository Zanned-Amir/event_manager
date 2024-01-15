require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

# Method to clean and format zip codes
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

# Method to fetch legislators based on a zip code using Google Civic Information API
def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

# Method to save thank-you letters in HTML format
def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

# Main script starts here
puts 'EventManager initialized.'

# Method to read the CSV file and return a CSV object
def open_csv
  CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
  )
end

# Method to clean and format phone numbers
def clean_phone_numbers(phone_number)
  phone_number.gsub!(/[()\-,. ]/, '')
  if phone_number.length == 11 && phone_number[0] == '1'
    phone_number.slice!(0)
  elsif phone_number.length > 10 || phone_number.length < 10
    phone_number = nil
  else
    phone_number
  end
end

# Method to find the most common registration day
def most_common_reg_day
  contents = open_csv
  reg_day_array = []
  contents.each do |row|
    reg_date = row[:regdate]
    reg_day = Time.strptime(reg_date, '%M/%d/%y %k:%M').strftime('%A')
    reg_day_array.push(reg_day)
  end
  most_common_day = reg_day_array.reduce(Hash.new(0)) do |hash, day|
    hash[day] += 1
    hash
  end
  most_common_day.max_by { |_k, v| v }[0]
end

# Method to find the most common registration hour
def most_common_hour
  contents = open_csv
  reg_hour_array = []
  contents.each do |row|
    reg_date = row[:regdate]
    reg_hour = Time.strptime(reg_date, '%M/%d/%y %k:%M').strftime('%k')
    reg_hour_array.push(reg_hour)
  end
  most_common_hour = reg_hour_array.reduce(Hash.new(0)) do |hash, hour|
    hash[hour] += 1
    hash
  end
  most_common_hour.max_by { |_k, v| v }[0]
end

#template_letter = File.read('form_letter.erb')
#erb_template = ERB.new template_letter
#contents=open_csv

#contents.each do |row|
  #id = row[0]
  #name = row[:first_name]
  #zipcode = clean_zipcode(row[:zipcode])
  #legislators = legislators_by_zipcode(zipcode)
  #phone_number = clean_phone_numbers(row[:homephone])

  #form_letter = erb_template.result(binding)

  #save_thank_you_letter(id,form_letter)
#end


# Output the most common registration hour and day
puts "\nThe most common hour of registration is: #{most_common_hour}:00"
puts "\nThe most common registration day is: #{most_common_reg_day}"