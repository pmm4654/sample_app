module ApplicationHelper
  def render_custom_table
    content_for(:custom_table) do
      render :partial => 'custom_index_templates/custom_table'
    end
  end
end
