# Searches controller for search of resources.
class Admin::SearchesController < AdminController
  skip_authorization_check

  # Search models for query.
  def search
    @results = Search.for(current_mailbox, params[:q])
  rescue Elasticsearch::Transport::Transport::BadRequest
    if @already_retried
      raise
    else
      logger.warn 'Reindexing models, because we cought an bad request exception in elasticsearch transport.'
      [Alias, Domain, Mailbox].map(&:reindex)
      @already_retried = true
      retry
    end
  end
end
