local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local startup = {
    cmds = {},
    tmp_file_path = "/tmp/awesomwm_startup",
    shell_change_notification = true
}

function startup.start() 
    if not gears.filesystem.file_readable(startup.tmp_file_path) then
        current_shell = awful.util.shell
        if awful.util.shell ~= "/usr/bin/sh" and shell_change_notification then
            naughty.notify{text="awful.util.shell is not set to posix shell will set it temporarly to sh to execute commands as expected currently " .. current_shell }
            awful.util.shell = "/usr/bin/sh"
        end

        for k, cmd in pairs(startup.cmds) do
            awful.spawn.with_shell(cmd)
        end
        awful.spawn.once("touch " .. startup.tmp_file_path)
        awful.util.shell = current_shell
    end
end

function startup.distroy_tmp_file()
    awful.spawn("rm " .. startup.tmp_file_path)
end

return startup
