module ApplicationHelper

  @@base_title = "Code Dojo"

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    if page_title.empty?
      @@base_title
    else
      "#{@@base_title} | #{page_title}"
    end
  end

  # Returns the header on a per-page basis.
  def header_text(page_title)
    page_title || @@base_title
  end

  def cost_to_display(cost, cost_type)
    if cost == 0 
      "Free"
    elsif cost_type == "one-time" 
      number_to_currency(cost)
    else "#{number_to_currency(cost)} #{cost_type}"
    end
  end

  def review_exists?(resource)
    @existing_review = Review.find_by(user_id: current_user.id, 
                                    resource_id: resource.id) if current_user
    
  end

end