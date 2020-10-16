
getgenv().Settings = {
	Toggle = false;
	Keys = {};
}
local UserInputService = game:GetService("UserInputService")
local mt = getrawmetatable(game.workspace.Camera)
local old__newindex = mt.__newindex
setreadonly(mt, false)
local Players = game:GetService"Players"
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService"UserInputService"
local Mouse = LocalPlayer:GetMouse()
local Key = Enum.KeyCode.LeftShift
---//local Toggle = false
--//local Keys = {}
function notify2()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Entry-Null/Noclip/main/Notification.lua", true))()
	Notify("Entry-Null", "q Look backwards t Reset to forwards. Left Shift to auto strafe", "", 4);
end
function notify1()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Entry-Null/Noclip/main/Notification.lua", true))()
	Notify("Entry-Null", "Welcome", "", 4);
end
Mouse.KeyDown:connect(function(key)
	if key == "q" then
		mt.__newindex = function(_, i, v)
			if i == "CoordinateFrame" then
				v = v * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0)
			end
			return old__newindex(_, i, v)
		end
	end
end)
Mouse.KeyDown:connect(function(key)
	if key == "t" then
		mt.__newindex = function(_, i, v)
			if i == "CoordinateFrame" then
				v = v * CFrame.fromEulerAnglesXYZ(0, math.rad(0), 0)
			end
			return old__newindex(_, i, v)
		end
	end
end)
local function GetKeyState(key)
	if ( getgenv().Settings.Keys[key] == nil) then
		getgenv().Settings.Keys[key] = false
	end
	return  getgenv().Settings.Keys[key]
end
local function PressKey(key)
	if (not GetKeyState(key)) then
		keypress(key)
		getgenv().Settings.Keys[key] = true
	end
end
local function ReleaseKey(key)
	if (GetKeyState(key)) then
		keyrelease(key)
		getgenv().Settings.Keys[key] = false
	end
end
local function ReleaseKeys()
	for i, v in next,  getgenv().Settings.Keys do
		if (v == true) then
			keyrelease(i)
			getgenv().Settings.Keys[i] = false
		end
	end
end
local Move = UIS.InputChanged:connect(function(input)
	if (getgenv().Settings.Toggle) then
		local delta = input.Delta
		if (deltaX == 0) then
			ReleaseKeys()
		elseif (delta.X < 0) then
			ReleaseKey(0x41) -- A
			PressKey(0x44) -- D
		elseif (delta.X > 0) then
			ReleaseKey(0x44) -- D
			PressKey(0x41) -- A
		end
	else
		ReleaseKeys()
	end
end)
local KeyDown = UIS.InputBegan:connect(function(input)
	if (input.KeyCode == Key) then
		PressKey(0x20)
		getgenv().Settings.Toggle = true
	end
end)
local KeyUp = UIS.InputEnded:connect(function(input)
	if (input.KeyCode == Key) then
		ReleaseKey(0x20)
		getgenv().Settings.Toggle = false
	end
end)
_G.AC_DC = function()
	KeyUp:disconnect()
	KeyDown:disconnect()
	Move:disconnect()
end
notify1()
notify2()
