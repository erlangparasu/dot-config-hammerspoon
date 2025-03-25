local khotkey = require("hs.hotkey")
local kwindow = require("hs.window")
local kapplication = require("hs.application")

-- NOTE: Common Applications
local key2app = {
	a = "Alacritty.app", -- [a]lacritty
	b = "Bruno.app", -- [b]runo
	c = "Google Chrome.app", -- [c]hrome
	d = "DBeaver.app", -- [d]beaver
	e = "Finder.app", -- [e]xplorer
	f = "Firefox.app", -- [f]irefox
	g = "Ghostty.app", -- [g]hostty
	h = "NeoHtop.app", -- [h]top
	i = "Discord.app", -- d[i]scord
	-- j = '',
	k = "kitty.app", -- [k]itty
	l = "Calendar.app", -- ca[l]endar
	m = "Activity Monitor.app", -- [m]onitor
	n = "Neovide.app", -- [n]eovide
	o = "Clock.app", -- cl[o]ck
	p = "draw.io.app", -- [p]aint
	-- q = '',
	-- r = '', -- android emulato[r]
	s = "System Settings.app", -- [s]ettings
	t = "Telegram.app", -- [t]elegram
	u = "Disk Utility.app", -- [u]tility
	v = "Visual Studio Code.app", -- [v]scode
	w = "WezTerm.app", -- [w]ezterm
	-- x = '',
	-- y = '',
	z = "Zen.app", -- [z]en
}

-- Toggle an application between being the frontmost app, and being hidden
local function toggle_application(_app)
	kapplication.launchOrFocus(_app)
end

for key, app in pairs(key2app) do
	khotkey.bind({ "alt" }, key, function()
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

khotkey.bind({ "alt" }, "r", function()
	focus_to_android_emulator()
end)

-- NOTE: Set window padding
local function setPadding(win, padding)
	local screen = win:screen()
	local frame = win:frame()
	frame.x = frame.x + padding
	frame.y = frame.y + padding
	frame.w = frame.w - (padding * 2)
	frame.h = frame.h - (padding * 2)
	win:setFrame(frame)
end

-- Set the padding value (in pixels)
local WINDOW_PADDING = 20

-- Apply the padding to the focused window
-- khotkey.bind({"cmd", "ctrl"}, "P", function()
--     local win = kwindow.focusedWindow()
--     setPadding(win, WINDOW_PADDING)
-- end)

-- Apply the padding to all windows
-- khotkey.bind({"cmd", "ctrl"}, "A", function()
--     for _, win in ipairs(kwindow.allWindows()) do
--         setPadding(win, WINDOW_PADDING)
--     end
-- end)

function CycleNeovideWindows()
	local current = hs.window.focusedWindow()

	local items = hs.fnutils.imap({ hs.application.find("com.neovide.neovide") }, function(app)
		local title = app:title()
		local status
		local win = app:mainWindow()

		if win ~= nil then
			title = win:title()
		end

		if win == current then
			status = "[CURRENT]"
		end

		return {
			text = title,
			subText = status,
			pid = app:pid(),
		}
	end)

	local callback = function(result)
		hs.application.applicationForPID(result.pid):activate()
	end

	hs.chooser.new(callback):choices(items):show()
end

hs.hotkey.bind({ "cmd", "ctrl" }, "`", CycleNeovideWindows)

-- Function to maximize the window with padding
function maximizeWithPadding(window, padding)
	local screen = window:screen()
	local frame = screen:frame() -- Get the screen frame

	-- Calculate the new frame with padding
	local newFrame = {
		x = frame.x + padding,
		y = frame.y + padding,
		w = frame.w - (2 * padding),
		h = frame.h - (2 * padding),
	}

	window:setFrame(newFrame) -- Set the new frame
end

-- Hotkey to maximize the focused window with padding
hs.hotkey.bind({ "cmd", "alt" }, "M", function()
	local window = hs.window.focusedWindow()
	if window then
		maximizeWithPadding(window, 20) -- Adjust padding value as needed
	end
end)

-- Eof
