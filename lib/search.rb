# Search for resources.
module Search
  # Results for query.
  def self.for(mailbox, query, sql: !Settings.elasticsearch)
    haystack = ::Domain.managable(mailbox)
    haystack_ids = haystack.pluck(:id)

    query = "%#{query}%" if sql

    results = {}
    
    Search::Domain.search(haystack, query, sql: sql).each do |domain|
      results[domain] ||= []
    end

    [Alias, Mailbox].each do |model|
      a = model.where(domain_id: haystack_ids)
      Search::Address.search(a, query, sql: sql).each do |result|
        results[result.domain] ||= []
        results[result.domain] << result
      end
    end

    results
  end
end
