ActiveRecord::Base.logger = Logger.new($stdout)

domain = Domain.create(name: 'example.com')
domain.mailboxes.create(username: 'jane.doe', password: 'foo')
