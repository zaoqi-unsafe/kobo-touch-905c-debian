-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

vicious = require("vicious")
marek = require("marek")
require("marek.widgets.kobo_battery")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/marek/theme.lua")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
--    awful.layout.suit.floating,
    awful.layout.suit.max,
--    awful.layout.suit.tile,
--    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
-- editor = os.getenv("EDITOR") or "editor"
-- editor_cmd = terminal .. " -e " .. editor
editor_cmd = "gnome-text-editor"

menuutils = {
    { "Terminal", terminal },
    { "Synaptic", "sudo synaptic" },
    { "Thunar", "thunar" }, 
    { "Editor", editor_cmd },
}
menuapps = {
    { "Emacs", "emacs" },
    { "GoldenDict", "goldendict" },
    { "Atril", "atril" },
    { "Midori", "midori" },
    { "LibreOffice", "libreoffice" },
    { "FBReader", "fbreader" },
    { "Calculator", "xcalc" },
}
menugames = {
    { "Nothing" },
}
menuconfig = {}
menuconfig[#menuconfig+1] = {"awesome", {
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", awesome.quit },
}, beautiful.awesome_icon}
menuconfig[#menuconfig+1] = {"WiFi", {
    { "Start", os.getenv("HOME") .. "/scripts/wifi-start" },
    { "Stop", os.getenv("HOME") .. "/scripts/wifi-stop" },
    { "Status", os.getenv("HOME") .. "/scripts/wifi-status" },
}}
menuconfig[#menuconfig+1] = {"Fcitx", {
    { "Start", "fcitx" },
    { "Config", "fcitx-configtool" },
}}

menupower={
    { "Poweroff", awesome.quit },
    { "Lock", function()
        awful.util.spawn(mylockscreen)
    end },
    --[WIP] { "Reboot to Nickel", function() awesome.exec("sudo /bin/sh -c 'mount -t proc proc /host/proc;mount -o bind /dev /host/dev;mount -o bind /dev/pts /host/dev/pts;mount -t sysfs sysfs /host/sys;chroot /host /nickel-start'") end  },
}

mymainmenu = awful.menu({ items = {
    { "Apps", menuapps },
    --[Disable] { "Games", menugames },
    { "Utils", menuutils },
    --[Disable] { "Debian", debian.menu.Debian_menu.Debian },
    { "Config", menuconfig },
    --[Disable] {"Power", menupower },
}})

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" }, "%H:%M", 61)

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mytopwibox = {}
myleftwibox = {}
myrightwibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

-- close app button
myclosebutton = widget({ type = "imagebox" })
myclosebutton.image = image("/usr/share/awesome/themes/default/titlebar/close_normal.png")
myclosebutton:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        local x = get_focus_client_ornil()
        if x then
            x:kill()
        end
    end)
))

-- lock button
mylockscreen="xlogo"
mylockbutton = widget({ type = "imagebox" })
mylockbutton.image = image("/usr/share/awesome/themes/default/titlebar/close_normal.png")
mylockbutton:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        awful.util.spawn(mylockscreen)
    end)
))

--
-- keyboard buttons
--

vkeyboard_upper = false

function show_vkeyboard()
    local clients = client.get()
    for i,c in ipairs(clients) do
        if c.class == "matchbox-keyboard" then
            c:kill()
        end
    end
    awful.util.spawn("matchbox-keyboard")
end

mykeybbottom = widget({ type = "imagebox" })
mykeybbottom.image = image(os.getenv("HOME") .. '/.config/awesome/images/matchbox-keyboard.png')
mykeybbottom:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        vkeyboard_upper = false
        show_vkeyboard()
    end)
))

mykeyupper = widget({ type = "imagebox" })
mykeyupper.image = image(os.getenv("HOME") .. '/.config/awesome/images/matchbox-keyboard.png')
mykeyupper:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        vkeyboard_upper = true
        show_vkeyboard()
    end)
))

-- memory usage

mymemory = widget({ type = "textbox" })
vicious.register(mymemory, vicious.widgets.mem, " M: $4+$8MB ", 11)

-- battery usage

mybattery = widget({ type = "textbox" })
vicious.register(mybattery, marek.widgets.kobo_battery, " B: $2% ($1) ", 63, "mc13892_bat")

-- spacer

myspacer = widget({ type = "textbox" })
myspacer.text = " "

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.client.swap.byidx( -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Top wibox
    mytopwibox[s] = awful.wibox({ position = "top", screen = s })
    mytopwibox[s].widgets = {
        {
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        myclosebutton,
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

    -- Bottom wibox
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s })
    mybottomwibox[s].widgets = {
        {
            mylauncher,
            myspacer,
            myspacer,
            mykeybbottom,
            mykeyupper,
            mylockbutton,
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mymemory,
        myspacer,
        mybattery,
        layout = awful.widget.layout.horizontal.rightleft
    }

    -- Left & Right wibox
    myleftwibox[s] = awful.wibox({ position = "left", width = "20", screen = s })
    myrightwibox[s] = awful.wibox({ position = "right", width = "20", screen = s })

end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({}, "XF86PowerOff", function()
        local x = get_focus_client_ornil()
        if x and x.instance == mylockscreen then
            x:kill()
local c = get_focus_client_ornil()
if c then
            maximize_client(c)
            toggle_client_maximize(c)
        end
        else
            awesome.quit()
        end
    end)
)

clientkeys = awful.util.table.join(
    awful.key({}, "XF86Launch1", function(c)
        local x = get_focus_client_ornil()
        if x and x.instance == mylockscreen then
            x:kill()
local c = get_focus_client_ornil()
if c then
            maximize_client(c)
            toggle_client_maximize(c)
        end 
        else
            toggle_client_maximize(c)
        end
end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },

    { rule = { instance = mylockscreen },
      callback = function(c)
c.ontop=true
          maximize_client(c)
      end },

    { rule = { class = "matchbox-keyboard" },
      properties = { floating = true },
      callback = function(c)
          c.above=true
          awful.titlebar.add(c, { modkey = modkey })
          if vkeyboard_upper then
              c:geometry({ x = 0, y = 0, width = 800, height = 250 })
          else
              c:geometry({ x = 0, y = 350, width = 800, height = 250 })
          end
      end },

    { rule = { instance = "luajit" },
      properties = { floating = true } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


function maximize_client(c)
    myrightwibox[mouse.screen].visible = false
    mybottomwibox[mouse.screen].visible = false
    c.fullscreen = true
end

function toggle_client_maximize(c)
    myrightwibox[mouse.screen].visible = c.fullscreen
    mybottomwibox[mouse.screen].visible = c.fullscreen
    c.fullscreen = not c.fullscreen
end


function get_focus_client_ornil()
        if client.focus then
            return client.focus
        else
            local visible = awful.client.visible(mouse.screen)
            if visible[1] then
                return visible[1]
            end
        end
end
