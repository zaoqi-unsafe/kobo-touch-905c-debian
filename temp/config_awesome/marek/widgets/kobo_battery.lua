---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2012, Marek Gibek
---------------------------------------------------

-- {{{ Grab environment
local setmetatable = setmetatable
local helpers = require("vicious.helpers")
local math = { floor = math.floor }
-- }}}


-- kobo-battery: provides state and charge for Kobo's battery
module("marek.widgets.kobo_battery")


-- {{{ Battery widget type
local function worker(format, warg)
    if not warg then return end

    local battery = helpers.pathtotable("/sys/class/power_supply/"..warg)
    local battery_state = {
        ["Full\n"]        = "!",
        ["Unknown\n"]     = "?",
        ["Charged\n"]     = "!",
        ["Charging\n"]    = "+",
        ["Discharging\n"] = "-"
    }

    -- Get state information
    local state = battery_state[battery.status] or battery_state["Unknown\n"]

    -- Get capacity information
    local capacity = math.floor(battery.capacity)

    return { state, capacity }
end
-- }}}

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
