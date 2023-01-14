local dmenu = require("dmenu")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

return function(browser)
    awful.spawn.easy_async(
        'sed "/^#/d" ' .. os.getenv("HOME") .. "/.bookmarks",
        function(stdout)
            bookmarksTable = {}
            for line in stdout:gmatch("([^\n]*)\n?") do
                local key = nil
                local value = nil
                for part in line:gmatch("[^>]+") do
                    if key == nil then
                        key = part
                    else
                        value = part
                    end
                end
                bookmarksTable[key] = function()
                    for part in string.gmatch(value, "[^|||]+") do
                        naughty.notify{ text = part}
                        if part ~= nil or part ~= ""  then
                            local cmd = ""
                            if gears.string.startswith(part, "https") or gears.string.startswith(part, "http") then
                                cmd = browser .. " \"" .. part .. "\""
                            else
                                cmd = part
                            end
                            awful.spawn.easy_async_with_shell(cmd, function() end)
                        end
                    end
                end
            end
            dmenu(bookmarksTable)
        end
    )
end
