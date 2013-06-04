module AliasAndMailboxHelper

  def parent
    Domain.where(id: params[:domain_id]).first
  end

end
