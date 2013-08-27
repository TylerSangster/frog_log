module StarsHelper

  def star_classes(score_to_convert)
    full_stars = score_to_convert.floor
    partial = score_to_convert - score_to_convert.floor
    if partial < 0.125
      partial_boolean = false
    else partial_boolean = true
      if partial < 0.375
        partial_stars = "qtr"
      elsif partial < 0.625
        partial_stars = "half"
      else partial_stars = "3qtr"
      end
    end
    star_classes = "star star-#{full_stars} " + if partial_boolean then "star-#{partial_stars}" else "" end
    return star_classes
  end

end