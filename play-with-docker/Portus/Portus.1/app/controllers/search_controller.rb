class SearchController < ApplicationController
  def index
    search = params[:search].split(":").first
    @repositories = policy_scope(Repository).search(search)
    @teams = policy_scope(Team).search(search)
    @namespaces = policy_scope(Namespace).search(search)
  end
end
