# Search for domains.
module Search::Domain
  # Search indexed.
  def self.indexed_search(haystack, needle)
    haystack.search(needle, fields: Domain::SEARCH_FIELDS)
  end

  # Try indexed search and fall back to SQL.
  def self.search(haystack, needle)
    results = {}

    domains = begin
                indexed_search(haystack, needle)
              rescue Errno::ECONNREFUSED
                sql_search(haystack, "%#{needle}%")
              end

    domains.count

    domains.each do |domain|
      results[domain] ||= []
    end

    results
  end

  # Search via SQL.
  def self.sql_search(haystack, needle)
    haystack.where('name like ?', needle)
  end
end
