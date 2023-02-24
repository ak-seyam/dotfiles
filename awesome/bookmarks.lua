local dmenu = require("dmenu")
local awful = require("awful")
local gears = require("gears")

return function(browser, sep)
    if sep == nil or sep == "" then
        sep = "|||"
    end
    awful.spawn.easy_async(
    'sed "/^#/d" ' .. os.getenv("HOME") .. "/.bookmarks",
    function(stdout)
        bookmarksTable = {}
        for line in stdout:gmatch("([^\n]*)\n?") do
            local key = nil
            local value = nil
            for part in line:gmatch("[^=]+") do
                if key == nil then
                    key = part
                else
                    value = part
                end
            end
            bookmarksTable[key] = function()
                for url in string.gmatch(value, "([^"..sep.."]+)") do
                    local cmd = url
                    if gears.string.startswith(url, "http") or gears.string.startswith(url, "https") then
                        cmd = browser .. " " .. url
                    end
                    awful.spawn.easy_async_with_shell(cmd, function() end)
                end
            end
        end
        dmenu(bookmarksTable)
    end
    )
end
