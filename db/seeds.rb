ActiveRecord::Base.logger = Logger.new($stdout)

['example.com', 'example.org'].each do |d|
  d = Domain.create(name: d)
  d.mailboxes.create(username: 'jane.doe', password: 'foobar', admin: true)
end
