# Search for resources.
class Search
  # Results for query.
  def self.for(mailbox, query)
    results = {}
    query = "%#{query}%"

    haystack = Domain.managable(mailbox)

    domains = haystack.where('name like ?', query)
    domains.each { |domain| results[domain] ||= [] }

    haystack.all.each do |domain|
      [:mailboxes, :aliases].each do |model|
        domain.send(model).where('username like ?', query).each do |result|
          results[result.domain] ||= []
          results[result.domain] << result
        end
      end
    end

    results
  end

  # Random substring of string.
  def self.random_substring(string)
    x = [0, 0].map { random_index(string) }.sort
    string[x[0]..x[1]]
  end

  private

  # Random index in string.
  def self.random_index(string)
    rand(string.size - 1)
  end
end
