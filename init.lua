local khotkey = require 'hs.hotkey'
local kwindow = require 'hs.window'
local kapplication = require 'hs.application'

-- NOTE: Common Applications
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
    kapplication.launchOrFocus(_app)
end

for key, app in pairs(key2app) do
    khotkey.bind({ 'alt' }, key, function()
        toggle_application(app)
    end)
end

-- NOTE: Android Emulator
local function focus_to_android_emulator()
  -- Get the list of all windows
  local allWindows = kwindow.allWindows()

  -- Filter the windows that contain the string "android emulator"
  local androidEmulatorWindow = nil
  for _, window in ipairs(allWindows) do
      local title = window:title()
      if title:lower():find("android emulator") then
          androidEmulatorWindow = window
          break
      end
  end

  -- If the window is found, focus it
  if androidEmulatorWindow then
      androidEmulatorWindow:focus()
  else
      -- If the window is not found, show an error message
      -- hs.alert.show("Window with 'android emulator' not found")
  end
end

khotkey.bind({ 'alt' }, 'x', function()
    focus_to_android_emulator()
end)


-- Eof
