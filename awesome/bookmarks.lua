local dmenu = require("dmenu")
local awful = require("awful")

return function(browser)
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
                    for url in string.gmatch(value, "%S+") do
                        local cmd = browser .. " " .. url
                        awful.spawn.easy_async_with_shell(cmd)
                    end
                end
            end
            dmenu(bookmarksTable)
        end
    )
end
