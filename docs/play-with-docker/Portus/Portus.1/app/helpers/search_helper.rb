module SearchHelper
  def build_search_category_url(params, category)
    "#{search_index_path}?utf8=#{params[:utf8]}&search=#{params[:search]}&type=#{category}"
  end
end
