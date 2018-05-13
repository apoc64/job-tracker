Company.destroy_all
Job.destroy_all

COMPANIES = ["ESPN", "Aetna", "United Airlines", "Denver Public Schools", "Shopify", "Starbucks", "Pivotal Labs", "Captain U"]
JOBS = ["Engineering", "Development", "Dev Ops", "Quality Assurance", "Teacher", "Product Manager", "Consultant", "Community Manager"]
CITIES = ["Seattle", "Denver", "Portland", "Indianapolis", "Madison", "Orlando", "San Diego", "Austin", "Las Vegas", "Little Rock", "Boise", "Eugene", "Oakland"]
CATEGORIES = ['Development', 'Sanitation', 'Guinea Pig', 'Astronaut', 'Executive', 'Intern'].map do |title|
  Category.create!(title: title)
end
NAMES = ['Mary', 'Bob', 'Susan', 'Frank']
EMAILS = ['bob@bob.bob', 'dob@dob.dob', 'wob@wob.wob']
POSITIONS = ['CEO', 'RECRUITER', 'Person in a suit']

COMMENTS = ['Great Job', 'Left a voicemail', 'Scheduled an interview', 'Blew the interview']


COMPANIES.each do |name|
  company = Company.create!(name: name)
  puts "Created #{company.name}"
  10.times do |num|
    job = company.jobs.create!(title: JOBS.sample, description: "What a great position!", level_of_interest: num + rand(100), city: CITIES.sample, category: CATEGORIES.sample)
    puts "  Created #{job.title}"
    2.times do |num|
      job.job_comments.create!(content: COMMENTS.sample)
    end
  end
  3.times do |num|
    company.contacts.create!(full_name: NAMES.sample, position: POSITIONS.sample, email: EMAILS.sample)
    puts "  Created #{company.contacts[num].full_name}"
  end
end
