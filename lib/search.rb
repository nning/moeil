# Search for resources.
module Search
  # Results for query.
  def self.for(mailbox, query)
    haystack = ::Domain.managable(mailbox)

    results = Search::Domain.search(haystack, query)

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
end
