$ ->
  current_obj_path = $("body").data("current-obj-path")
  $("#main_nav > li").each ->
    nav_item_path = $(this).data("path")
    if current_obj_path.indexOf(nav_item_path) == 0
      $(this).addClass("active")