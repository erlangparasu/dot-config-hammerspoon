local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local application = require 'hs.application'

local key2app = {
    a = 'Alacritty.app',
    -- b = '',
    c = 'Google Chrome.app',
    d = 'DBeaver.app',
    e = 'Finder.app',
    f = 'Firefox.app',
    -- g = '',
    -- h = '',
    -- i = '',
    -- j = '',
    k = 'kitty.app',
    -- l = '',
    m = 'Activity Monitor.app',
    -- n = '',
    o = 'Clock.app',
    p = 'draw.io.app',
    -- q = '',
    r = 'Calendar.app',
    s = 'System Settings.app',
    t = 'Telegram.app',
    u = 'Disk Utility.app',
    v = 'Visual Studio Code.app',
    w = 'WezTerm.app',
    -- x = '',
    -- y = '',
    -- z = '',
}

-- Toggle an application between being the frontmost app, and being hidden
local function toggle_application(_app)
    application.launchOrFocus(_app)
end

for key, app in pairs(key2app) do
    hotkey.bind({ 'alt' }, key, function()
        toggle_application(app)
    end)
end
