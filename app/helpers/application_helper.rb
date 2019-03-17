module ApplicationHelper
  def sortable(column, title = nil)
    title ||= t column
    direction = column.eql?(_sort_column) && _sort_direction.eql?("asc") ? "desc" : "asc"

    sort_icon = if column.eql?(_sort_column)
                  _sort_direction.eql?("asc") ? fa_icon("sort-up") : fa_icon("sort-down")
                else
                  fa_icon("sort")
                end
    capture do
      concat title
      concat " "
      concat link_to sort_icon, sort: column, direction: direction, search_query: params[:search_query]
    end
  end
end
