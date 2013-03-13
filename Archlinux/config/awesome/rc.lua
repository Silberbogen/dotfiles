-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Revelation - für den Expose-Effekt
-- require("revelation")
-- Für die Statusbar
require("vicious")
-- FÜr den Expose-Effekt
require("revelation")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/saschakb/.config/awesome/themes/zenburn/theme.lua")

--wallpaper_cmd = { "nitrogen --restore" } 

-- This is used later as the default terminal and editor to run.
terminal = "st"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
mailview = terminal .. " -e mutt -R"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a Network usage widget
netwidget = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.net, '• <span color="#7F9F7F">${wlan0 down_kb}</span> <span color="#CC9393">${wlan0 up_kb}</span> • ', 3)

-- Initialize widget
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, '• <span color="#0BB5D4">$1%</span> • <span color="#F0E0AF">$2MB</span>/<span color="#D4E108">$3MB</span> ', 13)

-- Initialize widget
cpuwidget = widget({ type = "textbox" })
-- -- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, '• <span color="#F0E0AF">$1%</span> ')

-- Initialize widget
--mpdwidget = widget({ type = "textbox" })
-- -- Register widget
--vicious.register(mpdwidget, vicious.widgets.mpd,
--    function (widget, args)
--        if args["{state}"] == "Stop" then 
--            return " - "
--        else 
--            return args["{Artist}"]..' - '.. args["{Title}"]
--        end
--    end, 10)

-- Create a wibox for each screen and add it
mywibox = {}
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
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
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

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
		s == 1 and mysystray or nil,
		netwidget,		-- The netwidget
		memwidget,
		cpuwidget,
--		mpdwidget,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
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
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
	awful.key({ modkey,           }, "e", revelation.revelation),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({                   }, "Print",  function () awful.util.spawn("scrot -e 'mv $f ~/Bilder/Bildschirmfotos/ 2>/dev/null'") end),
    awful.key({                   }, "XF86HomePage",  function () awful.util.spawn("firefox") end),
	awful.key({                   }, "XF86Calculator",  function () awful.util.spawn("speedcrunch") end),
    awful.key({                   }, "XF86Mail",  function () awful.util.spawn("thunderbird") end),
    awful.key({ modkey,         }, "p",     function () awful.util.spawn("dmenu_run") end),
	awful.key({                   }, "XF86AudioMute",  function () awful.util.spawn("amixer set Master toggle") end),
	awful.key({                   }, "XF86AudioRaiseVolume",  function () awful.util.spawn("amixer set Master 5%+ unmute") end),
	awful.key({                   }, "XF86AudioLowerVolume",  function () awful.util.spawn("amixer set Master 5%- unmute") end),
	awful.key({ modkey, "Mod1",           }, "a",     function () awful.util.spawn("audacious2") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "a",     function () awful.util.spawn("apvlv") end),
	awful.key({ modkey, "Mod1",           }, "c",     function () awful.util.spawn("cherrytree") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "c",     function () awful.util.spawn("chromium --ignore-gpu-blacklist") end),
	awful.key({ modkey, "Mod1",           }, "d",     function () awful.util.spawn("deluge") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "d",     function () awful.util.spawn("dropbox start") end),
	awful.key({ modkey, "Mod1",           }, "e",     function () awful.util.spawn("gvim") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "e",     function () awful.util.spawn("emacs") end),
	awful.key({ modkey, "Mod1",           }, "f",     function () awful.util.spawn("thunar") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "f",	  function () awful.util.spawn("uxterm -fg black -bg yellow -e torify finch") end),
	awful.key({ modkey, "Mod1",           }, "h",     function () awful.util.spawn("torify heybuddy") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "h",     function () awful.util.spawn("hotot") end),
	awful.key({ modkey, "Mod1",           }, "i",     function () awful.util.spawn("st -e torify irssi") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "i",     function () awful.util.spawn("uxterm -fg white -bg darkgreen -e identica") end),
	awful.key({ modkey, "Mod1",           }, "k",     function () awful.util.spawn("keepassx") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "k",     function () awful.util.spawn("kaffeine") end),
	awful.key({ modkey, "Mod1",           }, "l",     function () awful.util.spawn("slock") end),
	awful.key({ modkey, "Mod1",           }, "m",     function () awful.util.spawn("uxterm -e mc") end),
--	awful.key({ modkey, "Mod1", "Shift"   }, "m",     function () awful.util.spawn("uxterm -fg white -bg black -e torify mutt") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "m",     function () awful.util.spawn(mailview) end),
	awful.key({ modkey, "Mod1",           }, "n",     function () awful.util.spawn("uxterm -fg white -bg black -e 'torify newsbeuter'") end),
	awful.key({ modkey, "Mod1",           }, "o",     function () awful.util.spawn("opera") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "o",     function () awful.util.spawn("okular") end),
	awful.key({ modkey, "Mod1",           }, "p",     function () awful.util.spawn("pidgin") end),
	awful.key({ modkey, "Mod1",           }, "r",     function () awful.util.spawn("rednotebook") end),
	awful.key({ modkey, "Mod1",           }, "s",     function () awful.util.spawn("surf") end),
	awful.key({ modkey, "Mod1",           }, "t",     function () awful.util.spawn("uxterm -fg white -bg blue -e 'twitter'") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "t",     function () awful.util.spawn("uxterm -fg white -bg black -e 'telecomix'") end),
	awful.key({ modkey, "Mod1",           }, "u",     function () awful.util.spawn("uzbl-browser") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "u",     function () awful.util.spawn("uzbl-tabbed") end),
	awful.key({ modkey, "Mod1",           }, "v",     function () awful.util.spawn("vlc") end),
	awful.key({ modkey, "Mod1",           }, "w",     function () awful.util.spawn("dwb") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "w",     function () awful.util.spawn("uxterm -fg black -bg white -e 'w3m http://ddg.gg'") end),
	awful.key({ modkey, "Mod1",           }, "x",     function () awful.util.spawn("xchat") end),
	awful.key({ modkey, "Mod1",           }, "y",     function () awful.util.spawn("synclient touchpadoff=1") end),
	awful.key({ modkey, "Mod1", "Shift"   }, "y",     function () awful.util.spawn("synclient touchpadoff=0") end),
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
	
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
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
--    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
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
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[9] }, { floating = false } },
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

