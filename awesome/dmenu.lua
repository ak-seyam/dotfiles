local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")


return function(desc, prompt, lines, stdio, stdio_cb)
    -- get table keys separate them with \n
    -- add each key to dmenu with echo -e
    -- swich over the result
    n=""
    if stdio ~= nil then
        n = stdio:gsub("\n","\\n")
    else
        for k, _ in pairs(desc) do
            n = n .. k .. "\\n"
        end
        n = n:sub(1, -3)
    end
    if lines == nil then
        lines = 10
    end
    dmenu_cmd = "dmenu -nb \"" .. beautiful.bg_normal .. "\" -nf \"" .. beautiful.fg_normal .. "\" -sb \"" .. beautiful.bg_focus .. "\" -sf \"" .. beautiful.fg_focus .. "\"" .. " -l " .. lines .. " -fn '"  .. beautiful.font .. "'"
    if prompt ~= nil then
        dmenu_cmd = dmenu_cmd .. " -p \"" .. prompt .. "\""
    end
    cmd = "echo -e " .. n .. " | " .. dmenu_cmd
    awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr)
        if stderr ~= "" then
            naughty.notify{text = stderr, preset = {"critical"}}
        else
            if stdio ~= nil then
                stdio_cb(stdout)
            else
                if desc[stdout:sub(1,-2)] ~= nil then
                    desc[stdout:sub(1,-2)]()
                end
            end
        end
    end)
end
