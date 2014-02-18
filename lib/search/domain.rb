# Search for domains.
module Search::Domain
  # Search either via SQL or indexed (depending on settings or argument).
  def self.search(haystack, needle, sql: !Settings.elasticsearch)
    results = {}

    domains = if sql
                sql_search(haystack, needle)
              else
                indexed_search(haystack, needle)
              end

    domains.each { |d| results[d] ||= [] }

    results
  end

  private

  # Search indexed.
  def self.indexed_search(haystack, needle)
    haystack.search(needle, fields: Domain::SEARCH_FIELDS)
  end

  # Search via SQL.
  def self.sql_search(haystack, needle)
    haystack.where('name like ?', needle)
  end
end
