$ ->
  checkedId = $("input:checked").attr("id")
  $("label[for=" + checkedId + "]").prevAll().andSelf().addClass "bright"

$(document).ready ->
  
  # Makes stars glow on hover.
  $("label").hover (-> # mouseover
    $(this).prevAll().andSelf().addClass "glow"
  ), -> # mouseout
    $(this).siblings().andSelf().removeClass "glow"

  
  # Makes stars stay glowing after click.
  $("label").click ->
    $(this).siblings().removeClass "bright"
    $(this).prevAll().andSelf().addClass "bright"