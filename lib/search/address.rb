# Search for aliases or mailboxes.
module Search::Address
  @model = nil

  # Search either via SQL or indexed (depending on settings or argument).
  def self.search(haystack, needle, options = {})
    sql = options[:sql] || !Settings.elasticsearch

    @model = Object.const_get haystack.model_name

    if sql
      sql_search(haystack, needle)
    else
      indexed_search(haystack, needle)
    end
  end

  private

  # Search indexed.
  def self.indexed_search(haystack, needle)
    haystack.search(needle, fields: @model.const_get('SEARCH_FIELDS'))
  end

  # Search via SQL.
  def self.sql_search(haystack, needle)
    haystack.where('username like ?', needle)
  end
end
