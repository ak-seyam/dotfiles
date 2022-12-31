local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

return function(desc, prompt, lines)
    -- get table keys separate them with \n
    -- add each key to dmenu with echo -e
    -- swich over the result
    n=""
    for k, _ in pairs(desc) do
        n = n .. k .. "\\n"
    end
    n = n:sub(1, -3)
    if line == nil then
        line = 10
    end
    dmenu_cmd = "dmenu -sb \"" .. beautiful.bg_normal .. "\" -sf \"" .. beautiful.fg_normal .. "\" -nb \"" .. beautiful.bg_focus .. "\" -nf \"" .. beautiful.fg_focus .. "\"" .. " -l " .. line
    if prompt ~= nil then
        dmenu_cmd = dmenu_cmd .. " -p " .. prompt
    end
    cmd = "echo -e " .. n .. " | " .. dmenu_cmd
    awful.spawn.easy_async_with_shell(cmd, function(stdout)
        if desc[stdout:sub(1,-2)] ~= nil then
            desc[stdout:sub(1,-2)]()
        end
    end)
end
