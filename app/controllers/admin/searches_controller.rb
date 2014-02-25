# Searches controller for search of resources.
class Admin::SearchesController < AdminController
  skip_authorization_check

  # Search models for query.
  def search
    @results = Search.for(current_mailbox, params[:q])
  end
end
