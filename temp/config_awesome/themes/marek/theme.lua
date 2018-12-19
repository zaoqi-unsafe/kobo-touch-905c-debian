-------------------------------
--    "Sky" awesome theme    --
--  By Andrei "Garoth" Thorp --
-------------------------------
-- If you want SVGs and extras, get them from garoth.com/awesome/sky-theme

-- BASICS
theme = {}
theme.font          = "sans 20"

theme.bg_focus      = "#ffffff"
theme.bg_normal     = "#cccccc"
theme.bg_urgent     = "#888888"
theme.bg_minimize   = "#aaaaaa"

theme.fg_normal     = "#000000"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#000000"

theme.border_width  = "2"
theme.border_normal = "#dae3e0"
theme.border_focus  = "#729fcf"
theme.border_marked = "#eeeeec"

-- IMAGES
theme.layout_fairh           = "/usr/share/awesome/themes/sky/layouts/fairh.png"
theme.layout_fairv           = "/usr/share/awesome/themes/sky/layouts/fairv.png"
theme.layout_floating        = "/usr/share/awesome/themes/sky/layouts/floating.png"
theme.layout_magnifier       = "/usr/share/awesome/themes/sky/layouts/magnifier.png"
theme.layout_max             = "/usr/share/awesome/themes/sky/layouts/max.png"
theme.layout_fullscreen      = "/usr/share/awesome/themes/sky/layouts/fullscreen.png"
theme.layout_tilebottom      = "/usr/share/awesome/themes/sky/layouts/tilebottom.png"
theme.layout_tileleft        = "/usr/share/awesome/themes/sky/layouts/tileleft.png"
theme.layout_tile            = "/usr/share/awesome/themes/sky/layouts/tile.png"
theme.layout_tiletop         = "/usr/share/awesome/themes/sky/layouts/tiletop.png"
theme.layout_spiral          = "/usr/share/awesome/themes/sky/layouts/spiral.png"
theme.layout_dwindle         = "/usr/share/awesome/themes/sky/layouts/dwindle.png"

theme.awesome_icon           = "/usr/share/awesome/themes/sky/awesome-icon.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/sky/layouts/floating.png"

-- from default for now...
theme.menu_submenu_icon     = "/usr/share/awesome/themes/default/submenu.png"
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- MISC
theme.wallpaper_cmd         = { "awsetbg " .. os.getenv("HOME") .. "/.config/awesome/themes/marek/background.png" }
theme.taglist_squares       = "true"
theme.menu_height           = "15"
theme.menu_width            = "245"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

--theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
--theme.titlebar_ontop_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
--theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
--theme.titlebar_ontop_button_focus_active = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

--theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
--theme.titlebar_sticky_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
--theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
--theme.titlebar_sticky_button_focus_active = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

--theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
--theme.titlebar_floating_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
--theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
--theme.titlebar_floating_button_focus_active = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

--theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
--theme.titlebar_maximized_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
--theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
--theme.titlebar_maximized_button_focus_active = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

return theme
