_SHWXLoaded = true
_Hawk = "ohhahtuhthttouttpwuttuaunbotwo"

for i, v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "HawkMini" or v.Name == "Hawk" or v.Name == "GameNotification" or v.Name == "HawkNotification" or v.Name == "HawkKeySystem" or v.Name == "HawkLoader" or v.Name == "Intro" or v.Name == "Load" or v.Name == "HawkAdmin" or v.Name == "amk" then
		v:Destroy()
	end
end

local HawkMini = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Logo = Instance.new("ImageLabel")
local UICorner_2 = Instance.new("UICorner")
local Glow = Instance.new("ImageLabel")
local Glow_2 = Instance.new("ImageLabel")
local Text = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")
local Text_2 = Instance.new("TextLabel")
local UICorner_4 = Instance.new("UICorner")
local Text_3 = Instance.new("TextLabel")
local UICorner_5 = Instance.new("UICorner")
local Bar = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local LoaderTexts = Instance.new("TextLabel")

HawkMini.Name = "HawkMini"
HawkMini.Parent = game.CoreGui
HawkMini.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HawkMini.ResetOnSpawn = false

Main.Name = "Main"
Main.Parent = HawkMini
Main.Active = true
Main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Main.BorderColor3 = Color3.fromRGB(35, 35, 35)
Main.Position = UDim2.new(0.5, -150, 0.5, -84)
Main.Size = UDim2.new(0, 301, 0, 169)

UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Main

Logo.Name = "Logo"
Logo.Parent = Main
Logo.Active = true
Logo.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Logo.BackgroundTransparency = 1.000
Logo.BorderColor3 = Color3.fromRGB(31, 31, 31)
Logo.Position = UDim2.new(0.385918379, 0, 0.0456755161, 0)
Logo.Size = UDim2.new(0, 66, 0, 62)
Logo.Image = "http://www.roblox.com/asset/?id=93569763849548"

UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = Logo

Glow.Name = "Glow"
Glow.Parent = Main
Glow.Active = true
Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Glow.BackgroundTransparency = 1.000
Glow.Position = UDim2.new(0, -15, 0, -15)
Glow.Size = UDim2.new(1, 30, 1, 30)
Glow.ZIndex = 0
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(24, 24, 276, 276)

Glow_2.Name = "Glow"
Glow_2.Parent = Main
Glow_2.Active = true
Glow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Glow_2.BackgroundTransparency = 1.000
Glow_2.Position = UDim2.new(0, -15, 0, -15)
Glow_2.Size = UDim2.new(1, 30, 1, 30)
Glow_2.ZIndex = 0
Glow_2.Image = "rbxassetid://5028857084"
Glow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
Glow_2.ScaleType = Enum.ScaleType.Slice
Glow_2.SliceCenter = Rect.new(24, 24, 276, 276)

Text.Name = "Text"
Text.Parent = Main
Text.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Text.BackgroundTransparency = 1.000
Text.BorderColor3 = Color3.fromRGB(35, 35, 35)
Text.Position = UDim2.new(0.162790701, 0, 0.408284068, 0)
Text.Size = UDim2.new(0, 200, 0, 16)
Text.Font = Enum.Font.GothamBold
Text.Text = "Welcome to Rise"
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.TextSize = 14.000
Text.TextXAlignment = Enum.TextXAlignment.Center

UICorner_3.Parent = Text

Text_2.Name = "Text"
Text_2.Parent = Main
Text_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Text_2.BackgroundTransparency = 1.000
Text_2.BorderColor3 = Color3.fromRGB(35, 35, 35)
Text_2.Position = UDim2.new(0.162790701, 0, 0.504930973, 0)
Text_2.Size = UDim2.new(0, 200, 0, 16)
Text_2.Font = Enum.Font.GothamBold
Text_2.Text = "Powered By WindUI"
Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Text_2.TextSize = 14.000
Text_2.TextXAlignment = Enum.TextXAlignment.Center

UICorner_4.Parent = Text_2

Text_3.Name = "Text"
Text_3.Parent = Main
Text_3.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Text_3.BackgroundTransparency = 1.000
Text_3.BorderColor3 = Color3.fromRGB(35, 35, 35)
Text_3.Position = UDim2.new(0.162790701, 0, 0.601577878, 0)
Text_3.Size = UDim2.new(0, 200, 0, 16)
Text_3.Font = Enum.Font.GothamBold
Text_3.Text = "https://dc.gg/shwxteam"
Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Text_3.TextSize = 14.000
Text_3.TextXAlignment = Enum.TextXAlignment.Center

UICorner_5.Parent = Text_3

Bar.Name = "Bar"
Bar.Parent = Main
Bar.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
Bar.BorderColor3 = Color3.fromRGB(83, 83, 83)
Bar.Position = UDim2.new(0, 0, 0.952662706, 0)
Bar.Size = UDim2.new(0, 8, 0, 8)
Bar.Visible = false

UICorner_6.CornerRadius = UDim.new(0, 5)
UICorner_6.Parent = Bar

LoaderTexts.Name = "LoaderTexts"
LoaderTexts.Parent = Main
LoaderTexts.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
LoaderTexts.BackgroundTransparency = 1.000
LoaderTexts.BorderColor3 = Color3.fromRGB(35, 35, 35)
LoaderTexts.Position = UDim2.new(0, 0, 0.840236664, 0)
LoaderTexts.Size = UDim2.new(0, 301, 0, 16)
LoaderTexts.Font = Enum.Font.GothamBold
LoaderTexts.Text = ""
LoaderTexts.TextColor3 = Color3.fromRGB(255, 255, 255)
LoaderTexts.TextSize = 14.000

Bar.Visible = true
Bar:TweenSize(UDim2.new(0, 64,0, 8))
LoaderTexts.Text = "Welcome to Rise, " .. game.Players.LocalPlayer.Name
wait(1.5)
Bar:TweenSize(UDim2.new(0, 147,0, 8))
LoaderTexts.Text = "Loading Scripts..."
wait(1.5)
Bar:TweenSize(UDim2.new(0, 182,0, 8))
LoaderTexts.Text = "UIs Are Being Validated..."
wait(1.5)
Bar:TweenSize(UDim2.new(0, 240,0, 8))
LoaderTexts.Text = "Checking Admin..."
wait(1.5)
Bar:TweenSize(UDim2.new(0, 282,0, 8))
LoaderTexts.Text = "Done!"
wait(1.5)
Bar:TweenSize(UDim2.new(0, 301,0, 8))
LoaderTexts.Text = "Dont Forget To Join Our Discord Server!"
wait(1.5)

for i, v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "HawkMini" or v.Name == "Hawk" or v.Name == "GameNotification" or v.Name == "HawkNotification" or v.Name == "HawkKeySystem" or v.Name == "HawkLoader" or v.Name == "Intro" or v.Name == "Load" or v.Name == "HawkAdmin" or v.Name == "amk" then
		v:Destroy()
	end
end

-- WindUI Library Load
local Wind = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

-- Create Window
local Window = Wind.CreateWindow({
	Name = "Rise",
	Icon = "shield",
	Author = "SHWX Team",
	Folder = "Rise",
	Size = UDim2.fromOffset(580, 460),
	Transparent = true,
	Theme = "Dark",
	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,
})

-- Notification Helper
local function SendNotification(title, description, duration)
	Wind.Notify({
		Title = title,
		Content = description,
		Duration = duration or 4,
		Icon = "info",
	})
end

SendNotification("Welcome to Rise!", "Please Join: dc.gg/shwxteam", 5)

-- ========================
-- TAB 1: HOME
-- ========================
local tab1 = Window:CreateTab("Home", "home")

tab1:CreateSection("Information")

tab1:CreateParagraph({
	Title = "Welcome To Rise!",
	Content = "Supported Game: Murder Mystery 2"
})

tab1:CreateParagraph({
	Title = "Enjoy using Rise",
	Content = "Thank you for choosing Rise."
})

tab1:CreateParagraph({
	Title = "Update List",
	Content = "No Update Yet :("
})

tab1:CreateSection("Links")

tab1:CreateButton({
	Name = "Discord Server",
	Description = "Copy Link",
	Callback = function()
		setclipboard("discord.gg/uPDMy5DpWN")
		SendNotification("Rise", "Successfully Copied Discord Link!", 3)
	end
})

-- ========================
-- TAB 2: PLAYERS
-- ========================
local tab2 = Window:CreateTab("Players", "users")

tab2:CreateSection("Movement")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local defaultSpeed = 16
local currentSpeed = 55
local speedEnabled = false

local function updateSpeed()
	local char = LocalPlayer.Character
	if char then
		local humanoid = char:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			if speedEnabled then
				humanoid.WalkSpeed = currentSpeed
			else
				humanoid.WalkSpeed = defaultSpeed
			end
		end
	end
end

LocalPlayer.CharacterAdded:Connect(updateSpeed)

tab2:CreateToggle({
	Name = "Speed Hack",
	Description = "Set Your New Speed",
	CurrentValue = false,
	Callback = function(value)
		speedEnabled = value
		updateSpeed()
	end
})

tab2:CreateSlider({
	Name = "Speed Ratio",
	Description = "Adjust Speed",
	Range = {80, 500},
	Increment = 1,
	CurrentValue = 55,
	Callback = function(value)
		currentSpeed = value
		updateSpeed()
	end
})

local tpWalkSpeed = 16
local tpwalking = false

tab2:CreateToggle({
	Name = "TpWalk",
	Description = "Set TpWalk Speed",
	CurrentValue = false,
	Callback = function(value)
		tpwalking = value
		if tpwalking then
			task.spawn(function()
				while tpwalking do
					local chr = LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					if chr and hum and hum.Parent then
						local delta = RunService.Heartbeat:Wait()
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection * delta * tpWalkSpeed)
						end
					else
						task.wait(0.1)
					end
				end
			end)
		end
	end
})

tab2:CreateSlider({
	Name = "TpWalk Ratio",
	Description = "Adjust your tpwalk speed",
	Range = {1, 100},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(value)
		tpWalkSpeed = value
	end
})

local infJump
local infJumpDebounce = false

tab2:CreateToggle({
	Name = "Infinite Jump",
	Description = "Your Character Can Jump Infinitely",
	CurrentValue = false,
	Callback = function(value)
		if value then
			if infJump then infJump:Disconnect() end
			infJumpDebounce = false
			infJump = UserInputService.JumpRequest:Connect(function()
				if not infJumpDebounce then
					infJumpDebounce = true
					local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
					if humanoid then
						humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end
					task.wait()
					infJumpDebounce = false
				end
			end)
		else
			if infJump then
				infJump:Disconnect()
				infJump = nil
			end
		end
	end
})

local Noclip = false

tab2:CreateToggle({
	Name = "Noclip",
	Description = "Walls can't stop you!!",
	CurrentValue = false,
	Callback = function(value)
		Noclip = value
	end
})

RunService.Stepped:Connect(function()
	if Noclip and LocalPlayer.Character then
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- ========================
-- TAB 3: COMBAT
-- ========================
local tab3 = Window:CreateTab("Combat", "sword")

tab3:CreateSection("Murders")

local killMode = "Kill Aura"
local killAuraRadius = 10
local autoKillEnabled = false
local showAuraCircle = false
local autoEquipKnife = false
local killConnection = nil
local auraConnection = nil
local anchoredPlayers = {}
local auraCircle = nil

local function findMurderer()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife")) then
			return plr
		end
	end
	return nil
end

local function equipKnife()
	if not LocalPlayer.Character then return false end
	if not LocalPlayer.Character:FindFirstChild("Knife") then
		if LocalPlayer.Backpack:FindFirstChild("Knife") then
			LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(LocalPlayer.Backpack:FindFirstChild("Knife"))
			return true
		end
		return false
	end
	return true
end

local function updateAuraCircle()
	if auraCircle and LocalPlayer.Character then
		local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if root then
			auraCircle.CFrame = root.CFrame * CFrame.Angles(0, 0, math.rad(90))
		end
	end
end

local function createAuraCircle()
	if auraCircle then
		auraCircle:Destroy()
		auraCircle = nil
	end
	if showAuraCircle and LocalPlayer.Character then
		local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if root then
			auraCircle = Instance.new("Part")
			auraCircle.Name = "AuraRange"
			auraCircle.Shape = Enum.PartType.Cylinder
			auraCircle.Material = Enum.Material.Neon
			auraCircle.BrickColor = BrickColor.new("Bright red")
			auraCircle.Transparency = 0.7
			auraCircle.Anchored = true
			auraCircle.CanCollide = false
			auraCircle.Size = Vector3.new(1, killAuraRadius * 2, killAuraRadius * 2)
			auraCircle.CFrame = root.CFrame * CFrame.Angles(0, 0, math.rad(90))
			auraCircle.Parent = workspace
			if auraConnection then auraConnection:Disconnect() end
			auraConnection = RunService.Heartbeat:Connect(updateAuraCircle)
		end
	else
		if auraConnection then auraConnection:Disconnect() auraConnection = nil end
		if auraCircle then auraCircle:Destroy() auraCircle = nil end
	end
end

local function unanchorPlayers()
	for _, targetPlayer in pairs(anchoredPlayers) do
		if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			targetPlayer.Character.HumanoidRootPart.Anchored = false
			targetPlayer.Character.HumanoidRootPart.CanCollide = true
		end
	end
	anchoredPlayers = {}
end

local function disablePlayerCollision(character)
	if character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end
end

local function killAura()
	local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not localRoot then return end
	local hasTargetInRange = false
	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		if targetPlayer ~= LocalPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local targetRoot = targetPlayer.Character.HumanoidRootPart
			local distance = (targetRoot.Position - localRoot.Position).Magnitude
			if distance <= tonumber(killAuraRadius) then
				hasTargetInRange = true
				targetRoot.Anchored = true
				targetRoot.CanCollide = false
				anchoredPlayers[targetPlayer] = targetPlayer
				targetRoot.CFrame = localRoot.CFrame + localRoot.CFrame.LookVector * 2
				disablePlayerCollision(targetPlayer.Character)
			end
		end
	end
	if autoEquipKnife and hasTargetInRange then equipKnife() end
	local knife = LocalPlayer.Character:FindFirstChild("Knife")
	if (knife and knife:FindFirstChild("Stab")) then
		for i = 1, 3 do knife.Stab:FireServer("Down") end
	end
end

local function killNearby()
	local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not localRoot then return end
	local hasTargetClose = false
	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		if targetPlayer ~= LocalPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			if (targetPlayer.Character.HumanoidRootPart.Position - localRoot.Position).Magnitude <= 5 then
				hasTargetClose = true
				break
			end
		end
	end
	if autoEquipKnife and hasTargetClose then equipKnife() end
	local knife = LocalPlayer.Character:FindFirstChild("Knife")
	if (knife and knife:FindFirstChild("Stab")) then
		for i = 1, 5 do
			for j = 1, 3 do knife.Stab:FireServer("Down") end
			task.wait(0.1)
		end
	end
end

local function killAll()
	if autoEquipKnife then equipKnife() end
	local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not localRoot then return end
	for _, targetPlayer in ipairs(Players:GetPlayers()) do
		if targetPlayer ~= LocalPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local targetRoot = targetPlayer.Character.HumanoidRootPart
			targetRoot.Anchored = true
			targetRoot.CanCollide = false
			anchoredPlayers[targetPlayer] = targetPlayer
			targetRoot.CFrame = localRoot.CFrame + localRoot.CFrame.LookVector * 2
			disablePlayerCollision(targetPlayer.Character)
		end
	end
	local knife = LocalPlayer.Character:FindFirstChild("Knife")
	if (knife and knife:FindFirstChild("Stab")) then
		for i = 1, 3 do knife.Stab:FireServer("Down") end
	end
end

local function startAutoKill()
	if killConnection then return end
	killConnection = RunService.Heartbeat:Connect(function()
		if autoKillEnabled then
			if findMurderer() == LocalPlayer then
				if killMode == "Kill Aura" then killAura()
				elseif killMode == "Kill Nearby" then killNearby()
				elseif killMode == "Kill All" then
					local bpKnife = LocalPlayer.Backpack:FindFirstChild("Knife")
					if bpKnife then bpKnife.Parent = LocalPlayer.Character end
					killAll()
				end
			end
		end
	end)
end

local function stopAutoKill()
	if killConnection then killConnection:Disconnect() killConnection = nil end
	unanchorPlayers()
end

tab3:CreateToggle({
	Name = "Auto Equip Knife",
	Description = "Automatically holds out knife",
	CurrentValue = false,
	Callback = function(value)
		autoEquipKnife = value
	end
})

tab3:CreateDropdown({
	Name = "Kill Mode",
	Description = "Select attack method",
	Options = {"Kill Aura", "Kill Nearby", "Kill All"},
	CurrentOption = {"Kill Aura"},
	MultipleOptions = false,
	Callback = function(value)
		if type(value) == "table" then
			killMode = value[1]
		else
			killMode = value
		end
		unanchorPlayers()
	end
})

tab3:CreateSlider({
	Name = "Knife Aura Range",
	Description = "Adjust the kill distance",
	Range = {1, 50},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(value)
		killAuraRadius = tonumber(value)
		if auraCircle then
			auraCircle.Size = Vector3.new(1, killAuraRadius * 2, killAuraRadius * 2)
		end
	end
})

tab3:CreateToggle({
	Name = "Show Aura Circle",
	Description = "Visualizes the kill range",
	CurrentValue = false,
	Callback = function(value)
		showAuraCircle = value
		createAuraCircle()
	end
})

tab3:CreateToggle({
	Name = "Auto Kill",
	Description = "Enables the selected kill mode",
	CurrentValue = false,
	Callback = function(value)
		autoKillEnabled = value
		if value then startAutoKill() else stopAutoKill() end
	end
})

tab3:CreateSection("Sheriffs")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local sheriffGui = nil
local sheriffButtonActive = false
local autoShootEnabled = false
local shootOffset = 0
local pingMultiplier = 0
local murderTpEnabled = false
local murderTpConnection = nil

local lastNotifyTime = 0
local notifyCooldown = 25

local function SendNotif(title, description)
	if tick() - lastNotifyTime < notifyCooldown then return end
	lastNotifyTime = tick()
	SendNotification(title, description, 4)
end

local function makeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then update(input) end
	end)
end

local getPlayerDataRemote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)

local function GetMurderer()
	local success, roles = pcall(function()
		return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
	end)
	if success and roles then
		for name, data in pairs(roles) do
			if data.Role == "Murderer" then
				return Players:FindFirstChild(name)
			end
		end
	end
	return nil
end

local function ShootMurderer()
	if not LocalPlayer.Character then return false end
	local murderer = GetMurderer()
	if not murderer or not murderer.Character then
		SendNotif("Gun System", "Murderer not found!")
		return false
	end
	local gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
	if not gun then
		SendNotif("Gun System", "Gun not found in inventory!")
		return false
	end
	if gun.Parent ~= LocalPlayer.Character then
		gun.Parent = LocalPlayer.Character
		task.wait(0.1)
	end
	gun = LocalPlayer.Character:FindFirstChild("Gun")
	if gun and gun:FindFirstChild("KnifeLocal") then
		local targetPart = murderer.Character:FindFirstChild("HumanoidRootPart")
		if targetPart then
			local targetPos = targetPart.Position
			local mHum = murderer.Character:FindFirstChild("Humanoid")
			if shootOffset ~= 0 and mHum then
				local moveDir = mHum.MoveDirection
				if moveDir.Magnitude > 0 then
					local finalOffset = shootOffset + (pingMultiplier * 0.5)
					targetPos = targetPos + (moveDir.Unit * finalOffset)
				end
			end
			pcall(function()
				gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(1, targetPos, "AH2")
			end)
			SendNotif("Gun System", "Shot fired at Murderer!")
			return true
		end
	end
	return false
end

local function startAutoShoot()
	while autoShootEnabled do
		ShootMurderer()
		task.wait(0.25)
	end
end

local function createSheriffGui()
	if sheriffGui then sheriffGui:Destroy() end
	sheriffGui = Instance.new("ScreenGui")
	sheriffGui.Name = "SheriffGui"
	sheriffGui.Parent = game:GetService("CoreGui")
	sheriffGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local Frame = Instance.new("Frame")
	Frame.Parent = sheriffGui
	Frame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Frame.BackgroundTransparency = 0.450
	Frame.Position = UDim2.new(0.5, -80, 0.2, 0)
	Frame.Size = UDim2.new(0, 161, 0, 78)
	Frame.Active = true
	Instance.new("UICorner").Parent = Frame
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Parent = Frame
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(0, 0, 0.1025, 0)
	TextLabel.Size = UDim2.new(0, 161, 0, 29)
	TextLabel.Font = Enum.Font.Michroma
	TextLabel.Text = "Auto Shot"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	local TriggerButton = Instance.new("TextButton")
	TriggerButton.Parent = Frame
	TriggerButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	TriggerButton.Position = UDim2.new(0.0496, 0, 0.5512, 0)
	TriggerButton.Size = UDim2.new(0, 144, 0, 27)
	TriggerButton.Font = Enum.Font.Michroma
	TriggerButton.Text = "FIRE"
	TriggerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TriggerButton.TextScaled = true
	Instance.new("UICorner").Parent = TriggerButton
	makeDraggable(Frame)
	TriggerButton.MouseButton1Click:Connect(function()
		ShootMurderer()
	end)
	sheriffButtonActive = true
end

local function removeSheriffGui()
	if sheriffGui then sheriffGui:Destroy() sheriffGui = nil end
	sheriffButtonActive = false
end

local function TeleportToMurdererOnce()
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local murderer = GetMurderer()
	if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
		local mRoot = murderer.Character.HumanoidRootPart
		root.CFrame = mRoot.CFrame * CFrame.new(0, 2, 3)
	else
		SendNotif("Teleport", "Murderer not found!")
	end
end

local tpOffset = Vector3.new(0, 5, -5)

local function StartMurderTp()
	if murderTpConnection then return end
	murderTpConnection = RunService.Heartbeat:Connect(function()
		if not murderTpEnabled then return end
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local murderer = GetMurderer()
		if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
			local mRoot = murderer.Character.HumanoidRootPart
			root.CFrame = mRoot.CFrame + tpOffset
			root.Velocity = Vector3.zero
		end
	end)
end

local function StopMurderTp()
	if murderTpConnection then murderTpConnection:Disconnect() murderTpConnection = nil end
end

local GunSystem = {
	AutoGrabEnabled = false,
	NotifyGun = false,
	GunDropCheckInterval = 1,
	ActiveGunDrops = {},
	Mode = "Grab only"
}

local function ScanForGunDrops()
	GunSystem.ActiveGunDrops = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj.Name == "GunDrop" and obj:IsA("BasePart") then
			table.insert(GunSystem.ActiveGunDrops, obj)
		end
	end
end

local function EquipGun()
	local char = LocalPlayer.Character
	if not char then return false end
	if char:FindFirstChild("Gun") then return true end
	local backpackGun = LocalPlayer.Backpack:FindFirstChild("Gun")
	if backpackGun then
		backpackGun.Parent = char
		task.wait(0.1)
		return true
	end
	return false
end

local function ManualGrab()
	if LocalPlayer.Backpack:FindFirstChild("Knife") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Knife")) then
		SendNotif("Gun System", "You cannot pick up the gun (You are Murderer)!")
		return
	end
	ScanForGunDrops()
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if #GunSystem.ActiveGunDrops > 0 and root then
		local prevPos = root.CFrame
		local targetGun = GunSystem.ActiveGunDrops[1]
		root.CFrame = targetGun.CFrame
		task.wait(0.2)
		local prompt = targetGun:FindFirstChildOfClass("ProximityPrompt")
		if prompt then
			fireproximityprompt(prompt)
			SendNotif("Gun System", "Attempting to grab gun...")
		end
		task.wait(0.2)
		root.CFrame = prevPos
		if GunSystem.Mode == "Grab & shoot murderer" then
			task.wait(0.5)
			if EquipGun() then ShootMurderer() end
		end
	else
		SendNotif("Gun System", "No gun drops found!")
	end
end

local function AutoGrabLoop()
	while GunSystem.AutoGrabEnabled do
		local hasKnife = LocalPlayer.Backpack:FindFirstChild("Knife") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Knife"))
		if not hasKnife then ManualGrab() end
		task.wait(2)
	end
end

workspace.DescendantAdded:Connect(function(child)
	if GunSystem.NotifyGun and child.Name == "GunDrop" and child:IsA("BasePart") then
		SendNotif("Gun Spawned!", "A gun has dropped on the map.")
	end
end)

tab3:CreateSection("Auto Shoot System")

tab3:CreateToggle({
	Name = "Auto Shoot Murderer",
	Description = "Automatically shoots when visible",
	CurrentValue = false,
	Callback = function(state)
		autoShootEnabled = state
		if state then task.spawn(startAutoShoot) end
	end
})

tab3:CreateToggle({
	Name = "Manuel Auto-Shoot Button",
	Description = "Shows the manual fire button",
	CurrentValue = false,
	Callback = function(state)
		if state then createSheriffGui() else removeSheriffGui() end
	end
})

tab3:CreateSlider({
	Name = "Shoot Prediction",
	Description = "Adjust offset for moving targets",
	Range = {0, 20},
	Increment = 1,
	CurrentValue = 0,
	Callback = function(value)
		shootOffset = tonumber(value)
	end
})

tab3:CreateSlider({
	Name = "Ping Multiplier",
	Description = "Adjust based on latency",
	Range = {0, 10},
	Increment = 1,
	CurrentValue = 0,
	Callback = function(value)
		pingMultiplier = tonumber(value)
	end
})

tab3:CreateButton({
	Name = "Shoot Murderer (Legit)",
	Description = "Fires once immediately",
	Callback = function()
		ShootMurderer()
	end
})

tab3:CreateSection("Murderer Teleport")

tab3:CreateButton({
	Name = "TP to Murderer",
	Description = "You'll be beamed to the Murder.",
	Callback = function()
		TeleportToMurdererOnce()
	end
})

tab3:CreateToggle({
	Name = "Loop Murder TP",
	Description = "You beam into the murder mind within a loop.",
	CurrentValue = false,
	Callback = function(state)
		murderTpEnabled = state
		if state then StartMurderTp() else StopMurderTp() end
	end
})

tab3:CreateSlider({
	Name = "TP Height Offset",
	Description = "Height above murderer (For Loop)",
	Range = {0, 30},
	Increment = 1,
	CurrentValue = 5,
	Callback = function(value)
		tpOffset = Vector3.new(0, value, 0)
	end
})

tab3:CreateSection("Gun Grabber")

tab3:CreateToggle({
	Name = "Auto Grab Gun",
	Description = "Teleports to dropped guns",
	CurrentValue = false,
	Callback = function(state)
		GunSystem.AutoGrabEnabled = state
		if state then task.spawn(AutoGrabLoop) end
	end
})

tab3:CreateDropdown({
	Name = "Grab Mode",
	Description = "Action after grabbing",
	Options = {"Grab only", "Grab & shoot murderer"},
	CurrentOption = {"Grab only"},
	MultipleOptions = false,
	Callback = function(value)
		if type(value) == "table" then
			GunSystem.Mode = value[1]
		else
			GunSystem.Mode = value
		end
	end
})

tab3:CreateButton({
	Name = "Manual Grab Gun",
	Description = "Teleport to gun once",
	Callback = function()
		ManualGrab()
	end
})

tab3:CreateToggle({
	Name = "Notify Gun Events",
	Description = "Alerts when gun drops/picked up",
	CurrentValue = false,
	Callback = function(state)
		GunSystem.NotifyGun = state
	end
})

-- ========================
-- TAB 4: ESP
-- ========================
local tab4 = Window:CreateTab("ESP", "eye")

local Workspace = game:GetService("Workspace")
local camera = Workspace.CurrentCamera

local featureStates = {
	InnocentESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "2D"},
	MurderESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "2D"},
	HeroSheriffESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "2D"},
	GunESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "3D"},
	CoinESP = {names = false, boxes = false, tracers = false, distance = false, boxType = "3D"},
	InnocentHighlights = false,
	MurderHighlights = false,
	SheriffHeroHighlights = false,
	CoinHighlights = false,
	GunHighlights = false
}

local innocentEspElements = {}
local murderEspElements = {}
local sheriffEspElements = {}
local coinEspElements = {}
local gunEspElements = {}

local playerEspConnection = nil
local roleUpdateConnection = nil
local coinEspConnection = nil
local gunEspConnection = nil
local HighlightsConnection = nil

local roleData = {}
local lastRoleUpdate = 0
local roleUpdating = false
local lastCoinSearch = 0
local lastGunSearch = 0
local coinCache = {}
local gunCache = {}
local cachedPlayers = {}
local lastPlayerCacheUpdate = 0

local function IsAliveESP(plr)
	return plr and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0
end

local function getOutlineColor(color)
	if color.R > 0.8 and color.G > 0.8 and color.B > 0.8 then return Color3.new(0,0,0) end
	return Color3.new(1,1,1)
end

local function getDistanceFromPlayer(targetPosition)
	if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return 0 end
	return (targetPosition - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
end

local function cleanupDrawingTable(drawingTable)
	if not drawingTable then return end
	for _, drawing in pairs(drawingTable) do
		if type(drawing) == "table" then
			for _, line in ipairs(drawing) do
				if line and line.Remove then pcall(line.Remove, line) end
			end
		else
			if drawing and drawing.Remove then pcall(drawing.Remove, drawing) end
		end
	end
end

local function createESPObject()
	return {box = Drawing.new("Square"), tracer = Drawing.new("Line"), name = Drawing.new("Text"), distance = Drawing.new("Text"), boxLines = {}}
end

local function setupESPObject(esp)
	esp.box.Thickness = 2 esp.box.Filled = false esp.box.Visible = false
	esp.tracer.Thickness = 1 esp.tracer.Visible = false
	esp.name.Size = 14 esp.name.Center = true esp.name.Outline = true esp.name.Visible = false
	esp.distance.Size = 14 esp.distance.Center = true esp.distance.Outline = true esp.distance.Visible = false
end

local function draw3DBox(esp, cf, pos, cam, boxColor, boxSize)
	if not cf or not cam then return end
	boxSize = boxSize or Vector3.new(4, 5, 3)
	local size = boxSize
	local offsets = {
		Vector3.new( size.X/2,  size.Y/2,  size.Z/2), Vector3.new( size.X/2,  size.Y/2, -size.Z/2),
		Vector3.new( size.X/2, -size.Y/2,  size.Z/2), Vector3.new( size.X/2, -size.Y/2, -size.Z/2),
		Vector3.new(-size.X/2,  size.Y/2,  size.Z/2), Vector3.new(-size.X/2,  size.Y/2, -size.Z/2),
		Vector3.new(-size.X/2, -size.Y/2,  size.Z/2), Vector3.new(-size.X/2, -size.Y/2, -size.Z/2),
	}
	local screenPoints = {}
	local anyPointOnScreen = false
	for i, offset in ipairs(offsets) do
		local success, vec, onScreen = pcall(function()
			local worldPos = cf * CFrame.Angles(0, math.rad(90), 0) * offset
			return cam:WorldToViewportPoint(worldPos)
		end)
		if success then
			screenPoints[i] = {pos = Vector2.new(vec.X, vec.Y), depth = vec.Z, onScreen = onScreen}
			if onScreen and vec.Z > 0 then anyPointOnScreen = true end
		end
	end
	if not esp.boxLines or #esp.boxLines == 0 then
		esp.boxLines = {}
		for i = 1, 12 do
			local line = Drawing.new("Line")
			line.Thickness = 1 line.ZIndex = 2
			table.insert(esp.boxLines, line)
		end
	end
	local edges = {{1,2},{1,3},{1,5},{2,4},{2,6},{3,4},{3,7},{5,6},{5,7},{4,8},{6,8},{7,8}}
	local dist = getDistanceFromPlayer(pos) or 10
	local thickness = math.clamp(3 / (dist / 50), 1, 3)
	for i, edge in ipairs(edges) do
		local line = esp.boxLines[i]
		if line then
			local p1, p2 = screenPoints[edge[1]], screenPoints[edge[2]]
			line.Color = boxColor or Color3.fromRGB(255, 255, 255)
			line.Thickness = thickness line.Transparency = 1
			if anyPointOnScreen and p1 and p2 and p1.depth > 0 and p2.depth > 0 then
				line.From = p1.pos line.To = p2.pos line.Visible = true
			else line.Visible = false end
		end
	end
end

local function isAnyRoleESPActive()
	local roles = {"InnocentESP", "MurderESP", "HeroSheriffESP", "CoinESP", "GunESP"}
	for _, role in ipairs(roles) do
		local states = featureStates[role]
		if states and (states.names or states.boxes or states.tracers or states.distance) then return true end
	end
	return false
end

local function checkAnyHighlights()
	return featureStates.InnocentHighlights or featureStates.MurderHighlights or featureStates.SheriffHeroHighlights or featureStates.CoinHighlights or featureStates.GunHighlights
end

local function isAnyRoleNeeded()
	return isAnyRoleESPActive() or checkAnyHighlights()
end

local function findCoinServerParts()
	if tick() - lastCoinSearch < 3 then return coinCache end
	lastCoinSearch = tick()
	coinCache = {}
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("Part") and obj.Name == "Coin_Server" then table.insert(coinCache, obj) end
	end
	return coinCache
end

local function findDropGunParts()
	if tick() - lastGunSearch < 3 then return gunCache end
	lastGunSearch = tick()
	gunCache = {}
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("Part") and obj.Name == "DropGun" then table.insert(gunCache, obj) end
	end
	return gunCache
end

local function getCachedPlayers()
	if tick() - lastPlayerCacheUpdate < 1 then return cachedPlayers end
	lastPlayerCacheUpdate = tick()
	cachedPlayers = Players:GetPlayers()
	return cachedPlayers
end

local function refreshHighlights() end

local function clearAllHighlights()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr.Character then
			local h = plr.Character:FindFirstChild("PlayerHighlight")
			if h then h:Destroy() end
		end
	end
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj.Name == "Coin_Server" or obj.Name == "DropGun" then
			local h = obj:FindFirstChild("ItemHighlight")
			if h then h:Destroy() end
		end
	end
end

local function updateRoles_ESP()
	if not getPlayerDataRemote then return end
	if tick() - lastRoleUpdate < 2 then return end
	lastRoleUpdate = tick()
	local success, roles = pcall(function()
		return getPlayerDataRemote:InvokeServer()
	end)
	if success and roles then
		roleData = {}
		for key, v in pairs(roles) do
			if v then roleData[key] = v end
		end
	end
end

local function startRoleUpdating()
	if roleUpdating then return end
	roleUpdating = true
	updateRoles_ESP()
	roleUpdateConnection = RunService.Heartbeat:Connect(function()
		updateRoles_ESP()
	end)
end

local function stopRoleUpdating()
	if roleUpdateConnection then roleUpdateConnection:Disconnect() roleUpdateConnection = nil end
	roleUpdating = false roleData = {}
end

local function manageRoleUpdating()
	if isAnyRoleNeeded() then startRoleUpdating() else stopRoleUpdating() end
end

local function getPlayerRole(plr)
	local playerKey = plr.Name
	return roleData[playerKey] and roleData[playerKey].Role
end

local function updateRoleHighlights()
	if not roleData then return end
	local sheriffName = nil
	for name, data in pairs(roleData) do
		if data.Role == "Sheriff" then sheriffName = name break end
	end
	local sheriffPlayer = sheriffName and Players:FindFirstChild(sheriffName)
	local isSheriffAlive = sheriffPlayer and IsAliveESP(sheriffPlayer)
	for _, plr in ipairs(getCachedPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local model = plr.Character
			local highlight = model:FindFirstChild("PlayerHighlight")
			local data = roleData[plr.Name]
			local role = data and data.Role
			local isAlivePlayer = IsAliveESP(plr)
			local highlightEnabled = false
			if not role then highlightEnabled = featureStates.InnocentHighlights
			elseif role == "Murderer" then highlightEnabled = featureStates.MurderHighlights
			elseif role == "Sheriff" or role == "Hero" then highlightEnabled = featureStates.SheriffHeroHighlights
			else highlightEnabled = featureStates.InnocentHighlights end
			if highlightEnabled then
				local color = Color3.new(1,1,1)
				if isAlivePlayer then
					if role == "Murderer" then color = Color3.fromRGB(225, 0, 0)
					elseif role == "Sheriff" then color = Color3.fromRGB(0, 0, 225)
					elseif role == "Hero" and not isSheriffAlive then color = Color3.fromRGB(255, 250, 0)
					else color = Color3.fromRGB(0, 225, 0) end
				end
				if not highlight then
					highlight = Instance.new("Highlight")
					highlight.Name = "PlayerHighlight"
					highlight.Adornee = model
					highlight.FillTransparency = 0.5
					highlight.OutlineTransparency = 0
					highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					highlight.Parent = model
				end
				highlight.FillColor = color
				highlight.OutlineColor = getOutlineColor(color)
			else
				if highlight then highlight:Destroy() end
			end
		end
	end
	if featureStates.CoinHighlights then
		for _, coin in ipairs(findCoinServerParts()) do
			if coin and coin.Parent then
				local h = coin:FindFirstChild("ItemHighlight")
				if not h then
					h = Instance.new("Highlight")
					h.Name = "ItemHighlight" h.Adornee = coin h.FillTransparency = 0.5 h.Parent = coin
				end
				h.FillColor = Color3.fromRGB(255, 215, 0) h.OutlineColor = Color3.new(0,0,0)
			end
		end
	end
	if featureStates.GunHighlights then
		for _, gun in ipairs(findDropGunParts()) do
			if gun and gun.Parent then
				local h = gun:FindFirstChild("ItemHighlight")
				if not h then
					h = Instance.new("Highlight")
					h.Name = "ItemHighlight" h.Adornee = gun h.FillTransparency = 0.5 h.Parent = gun
				end
				h.FillColor = Color3.fromRGB(255, 0, 255) h.OutlineColor = Color3.new(1,1,1)
			end
		end
	end
end

local function manageHighlightsConnection()
	if checkAnyHighlights() then
		if not HighlightsConnection then
			HighlightsConnection = RunService.Heartbeat:Connect(updateRoleHighlights)
		end
	else
		if HighlightsConnection then
			HighlightsConnection:Disconnect() HighlightsConnection = nil
			clearAllHighlights()
		end
	end
	manageRoleUpdating()
end

refreshHighlights = function()
	if HighlightsConnection then clearAllHighlights() end
end

local function updateRoleESP()
	local cam = Workspace.CurrentCamera
	if not cam then return end
	local screenBottomCenter = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
	local currentTargets = {Innocent={}, Murder={}, Sheriff={}}
	for _, otherPlayer in ipairs(getCachedPlayers()) do
		if otherPlayer ~= LocalPlayer and otherPlayer.Character then
			local hrp = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
			local hum = otherPlayer.Character:FindFirstChild("Humanoid")
			if hrp and hum then
				local role = getPlayerRole(otherPlayer)
				local isDead = hum.Health <= 0
				local config, elements, targetTable, color
				if isDead then
					config = featureStates.InnocentESP elements = innocentEspElements targetTable = currentTargets.Innocent color = Color3.fromRGB(200, 200, 200)
				elseif role == "Murderer" then
					config = featureStates.MurderESP elements = murderEspElements targetTable = currentTargets.Murder color = Color3.fromRGB(255, 0, 0)
				elseif role == "Sheriff" or role == "Hero" then
					config = featureStates.HeroSheriffESP elements = sheriffEspElements targetTable = currentTargets.Sheriff color = Color3.fromRGB(0, 0, 255)
				else
					config = featureStates.InnocentESP elements = innocentEspElements targetTable = currentTargets.Innocent color = Color3.fromRGB(0, 255, 0)
				end
				if config.names or config.boxes or config.tracers or config.distance then
					targetTable[otherPlayer.Character] = true
					if not elements[otherPlayer.Character] then
						elements[otherPlayer.Character] = createESPObject()
						setupESPObject(elements[otherPlayer.Character])
					end
					local esp = elements[otherPlayer.Character]
					local vec, onScreen = cam:WorldToViewportPoint(hrp.Position)
					if onScreen then
						local topY = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y
						local bottomY = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y
						local sizeY = math.abs(bottomY - topY)
						local sizeX = sizeY / 2
						if config.boxes then
							if config.boxType == "2D" then
								esp.box.Visible = true esp.box.Size = Vector2.new(sizeX, sizeY)
								esp.box.Position = Vector2.new(vec.X - sizeX/2, vec.Y - sizeY/2)
								esp.box.Color = color
								for _, l in ipairs(esp.boxLines) do l.Visible = false end
							else
								esp.box.Visible = false
								draw3DBox(esp, hrp.CFrame, hrp.Position, cam, color, Vector3.new(2, 5, 2))
							end
						else
							esp.box.Visible = false
							for _, l in ipairs(esp.boxLines) do l.Visible = false end
						end
						if config.tracers then esp.tracer.Visible = true esp.tracer.From = screenBottomCenter esp.tracer.To = Vector2.new(vec.X, vec.Y) esp.tracer.Color = color else esp.tracer.Visible = false end
						if config.names then esp.name.Visible = true esp.name.Text = otherPlayer.Name esp.name.Position = Vector2.new(vec.X, vec.Y - sizeY/2 - 15) esp.name.Color = color else esp.name.Visible = false end
						if config.distance then esp.distance.Visible = true esp.distance.Text = math.floor((hrp.Position - cam.CFrame.Position).Magnitude) .. "m" esp.distance.Position = Vector2.new(vec.X, vec.Y + sizeY/2 + 5) esp.distance.Color = color else esp.distance.Visible = false end
					else
						esp.box.Visible = false esp.tracer.Visible = false esp.name.Visible = false esp.distance.Visible = false
						for _, l in ipairs(esp.boxLines) do l.Visible = false end
					end
				end
			end
		end
	end
	for target, esp in pairs(innocentEspElements) do if not currentTargets.Innocent[target] then cleanupDrawingTable(esp) innocentEspElements[target] = nil end end
	for target, esp in pairs(murderEspElements) do if not currentTargets.Murder[target] then cleanupDrawingTable(esp) murderEspElements[target] = nil end end
	for target, esp in pairs(sheriffEspElements) do if not currentTargets.Sheriff[target] then cleanupDrawingTable(esp) sheriffEspElements[target] = nil end end
end

local function managePlayerESPConnection()
	if isAnyRoleESPActive() then
		if not playerEspConnection then playerEspConnection = RunService.RenderStepped:Connect(updateRoleESP) end
	else
		if playerEspConnection then playerEspConnection:Disconnect() playerEspConnection = nil
			for _, tbl in pairs({innocentEspElements, murderEspElements, sheriffEspElements}) do
				for _, esp in pairs(tbl) do cleanupDrawingTable(esp) end
			end
			innocentEspElements = {} murderEspElements = {} sheriffEspElements = {}
		end
	end
	manageRoleUpdating()
end

local function updateItemESP(config, elementTable, findFunc, itemName, color)
	local cam = Workspace.CurrentCamera
	if not cam then return end
	local screenBot = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
	local currentItems = {}
	for _, item in ipairs(findFunc()) do
		if item and item.Parent then
			currentItems[item] = true
			if not elementTable[item] then elementTable[item] = createESPObject() setupESPObject(elementTable[item]) end
			local esp = elementTable[item]
			local vec, onScreen = cam:WorldToViewportPoint(item.Position)
			if onScreen and (config.names or config.boxes or config.tracers or config.distance) then
				local size = 20
				if config.boxes then
					if config.boxType == "2D" then
						esp.box.Visible = true esp.box.Size = Vector2.new(size, size)
						esp.box.Position = Vector2.new(vec.X - size/2, vec.Y - size/2) esp.box.Color = color
						for _, l in ipairs(esp.boxLines) do l.Visible = false end
					else
						esp.box.Visible = false
						draw3DBox(esp, item.CFrame, item.Position, cam, color, Vector3.new(2,2,2))
					end
				else
					esp.box.Visible = false
					for _, l in ipairs(esp.boxLines) do l.Visible = false end
				end
				if config.tracers then esp.tracer.Visible = true esp.tracer.From = screenBot esp.tracer.To = Vector2.new(vec.X, vec.Y) esp.tracer.Color = color else esp.tracer.Visible = false end
				if config.names then esp.name.Visible = true esp.name.Text = itemName esp.name.Position = Vector2.new(vec.X, vec.Y - size/2 - 15) esp.name.Color = color else esp.name.Visible = false end
				if config.distance then esp.distance.Visible = true esp.distance.Text = math.floor((item.Position - cam.CFrame.Position).Magnitude) .. "m" esp.distance.Position = Vector2.new(vec.X, vec.Y + size/2 + 5) esp.distance.Color = color else esp.distance.Visible = false end
			else
				esp.box.Visible = false esp.tracer.Visible = false esp.name.Visible = false esp.distance.Visible = false
				for _, l in ipairs(esp.boxLines) do l.Visible = false end
			end
		end
	end
	for item, esp in pairs(elementTable) do
		if not currentItems[item] then cleanupDrawingTable(esp) elementTable[item] = nil end
	end
end

local function manageCoinESPConnection()
	local c = featureStates.CoinESP
	if c.names or c.boxes or c.tracers or c.distance then
		if not coinEspConnection then
			coinEspConnection = RunService.RenderStepped:Connect(function()
				updateItemESP(featureStates.CoinESP, coinEspElements, findCoinServerParts, "Coin", Color3.fromRGB(255, 215, 0))
			end)
		end
	else
		if coinEspConnection then coinEspConnection:Disconnect() coinEspConnection = nil
			for _, esp in pairs(coinEspElements) do cleanupDrawingTable(esp) end coinEspElements = {}
		end
	end
end

local function manageGunESPConnection()
	local g = featureStates.GunESP
	if g.names or g.boxes or g.tracers or g.distance then
		if not gunEspConnection then
			gunEspConnection = RunService.RenderStepped:Connect(function()
				updateItemESP(featureStates.GunESP, gunEspElements, findDropGunParts, "Gun", Color3.fromRGB(255, 0, 255))
			end)
		end
	else
		if gunEspConnection then gunEspConnection:Disconnect() gunEspConnection = nil
			for _, esp in pairs(gunEspElements) do cleanupDrawingTable(esp) end gunEspElements = {}
		end
	end
end

tab4:CreateSection("Highlights (Chams)")
tab4:CreateToggle({Name = "Innocent Highlight", CurrentValue = false, Callback = function(v) featureStates.InnocentHighlights = v manageHighlightsConnection() refreshHighlights() end})
tab4:CreateToggle({Name = "Murder Highlight", CurrentValue = false, Callback = function(v) featureStates.MurderHighlights = v manageHighlightsConnection() refreshHighlights() end})
tab4:CreateToggle({Name = "Sheriff Highlight", CurrentValue = false, Callback = function(v) featureStates.SheriffHeroHighlights = v manageHighlightsConnection() refreshHighlights() end})
tab4:CreateToggle({Name = "Gun Highlight", CurrentValue = false, Callback = function(v) featureStates.GunHighlights = v manageHighlightsConnection() refreshHighlights() end})
tab4:CreateToggle({Name = "Coin Highlight", CurrentValue = false, Callback = function(v) featureStates.CoinHighlights = v manageHighlightsConnection() refreshHighlights() end})

tab4:CreateSection("3D Box Options (Overrides 2D)")
tab4:CreateToggle({Name = "Innocent 3D Mode", Description = "Enable 3D box for Innocent", CurrentValue = false, Callback = function(v) featureStates.InnocentESP.boxType = v and "3D" or "2D" end})
tab4:CreateToggle({Name = "Murder 3D Mode", Description = "Enable 3D box for Murder", CurrentValue = false, Callback = function(v) featureStates.MurderESP.boxType = v and "3D" or "2D" end})
tab4:CreateToggle({Name = "Sheriff 3D Mode", Description = "Enable 3D box for Sheriff", CurrentValue = false, Callback = function(v) featureStates.HeroSheriffESP.boxType = v and "3D" or "2D" end})
tab4:CreateToggle({Name = "Gun 3D Mode", Description = "Enable 3D box for Gun", CurrentValue = true, Callback = function(v) featureStates.GunESP.boxType = v and "3D" or "2D" end})
tab4:CreateToggle({Name = "Coin 3D Mode", Description = "Enable 3D box for Coin", CurrentValue = true, Callback = function(v) featureStates.CoinESP.boxType = v and "3D" or "2D" end})

tab4:CreateSection("Box ESP")
tab4:CreateToggle({Name = "Innocent Box", CurrentValue = false, Callback = function(v) featureStates.InnocentESP.boxes = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Murder Box", CurrentValue = false, Callback = function(v) featureStates.MurderESP.boxes = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Sheriff Box", CurrentValue = false, Callback = function(v) featureStates.HeroSheriffESP.boxes = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Gun Box", CurrentValue = false, Callback = function(v) featureStates.GunESP.boxes = v manageGunESPConnection() end})
tab4:CreateToggle({Name = "Coin Box", CurrentValue = false, Callback = function(v) featureStates.CoinESP.boxes = v manageCoinESPConnection() end})

tab4:CreateSection("Name ESP")
tab4:CreateToggle({Name = "Innocent Name", CurrentValue = false, Callback = function(v) featureStates.InnocentESP.names = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Murder Name", CurrentValue = false, Callback = function(v) featureStates.MurderESP.names = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Sheriff Name", CurrentValue = false, Callback = function(v) featureStates.HeroSheriffESP.names = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Gun Name", CurrentValue = false, Callback = function(v) featureStates.GunESP.names = v manageGunESPConnection() end})
tab4:CreateToggle({Name = "Coin Name", CurrentValue = false, Callback = function(v) featureStates.CoinESP.names = v manageCoinESPConnection() end})

tab4:CreateSection("Tracer ESP")
tab4:CreateToggle({Name = "Innocent Tracer", CurrentValue = false, Callback = function(v) featureStates.InnocentESP.tracers = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Murder Tracer", CurrentValue = false, Callback = function(v) featureStates.MurderESP.tracers = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Sheriff Tracer", CurrentValue = false, Callback = function(v) featureStates.HeroSheriffESP.tracers = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Gun Tracer", CurrentValue = false, Callback = function(v) featureStates.GunESP.tracers = v manageGunESPConnection() end})
tab4:CreateToggle({Name = "Coin Tracer", CurrentValue = false, Callback = function(v) featureStates.CoinESP.tracers = v manageCoinESPConnection() end})

tab4:CreateSection("Distance ESP")
tab4:CreateToggle({Name = "Innocent Distance", CurrentValue = false, Callback = function(v) featureStates.InnocentESP.distance = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Murder Distance", CurrentValue = false, Callback = function(v) featureStates.MurderESP.distance = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Sheriff Distance", CurrentValue = false, Callback = function(v) featureStates.HeroSheriffESP.distance = v managePlayerESPConnection() end})
tab4:CreateToggle({Name = "Gun Distance", CurrentValue = false, Callback = function(v) featureStates.GunESP.distance = v manageGunESPConnection() end})
tab4:CreateToggle({Name = "Coin Distance", CurrentValue = false, Callback = function(v) featureStates.CoinESP.distance = v manageCoinESPConnection() end})

-- ========================
-- TAB 5: EXPLOIT
-- ========================
local tab5 = Window:CreateTab("Exploit", "zap")

tab5:CreateSection("God Mode")

local godModeEnabled = false
local godModeConnection = nil
local godModeMethod = "Health Math.huge"

local function applyHumanoidReplacement()
	local Char = LocalPlayer.Character
	local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
	if not Human then return end
	local nHuman = Human:Clone()
	nHuman.Parent = Char
	LocalPlayer.Character = nil
	nHuman:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	nHuman:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	nHuman:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
	nHuman.BreakJointsOnDeath = true
	nHuman.MaxHealth = math.huge
	nHuman.Health = math.huge
	Human:Destroy()
	LocalPlayer.Character = Char
	nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	local Script = Char:FindFirstChild("Animate")
	if Script then Script.Disabled = true task.wait() Script.Disabled = false end
end

local function applyHealthMathHuge()
	local Char = LocalPlayer.Character
	local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
	if not Human then return end
	Human.MaxHealth = math.huge
	Human.Health = math.huge
	local connection
	connection = Human:GetPropertyChangedSignal("Health"):Connect(function()
		if godModeEnabled and Human.Health < Human.MaxHealth then Human.Health = Human.MaxHealth
		else if not godModeEnabled and connection then connection:Disconnect() end end
	end)
end

local function applyGodMode()
	if godModeMethod == "Humanoid Replacement (Very buggy)" then applyHumanoidReplacement()
	elseif godModeMethod == "Health Math.huge" then applyHealthMathHuge() end
end

local function startGodMode()
	if godModeConnection then return end
	godModeConnection = RunService.Heartbeat:Connect(function()
		if godModeEnabled and LocalPlayer.Character then
			local Human = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
			if Human and Human.Health < math.huge then applyGodMode() end
		end
	end)
end

local function stopGodMode()
	if godModeConnection then godModeConnection:Disconnect() godModeConnection = nil end
end

tab5:CreateToggle({
	Name = "God Mode",
	Description = "Become invincible",
	CurrentValue = false,
	Callback = function(value)
		godModeEnabled = value
		if value then applyGodMode() startGodMode() else stopGodMode() end
	end
})

tab5:CreateDropdown({
	Name = "God Mode Method",
	Description = "Select method",
	Options = {"Health Math.huge", "Humanoid Replacement (Very buggy)"},
	CurrentOption = {"Health Math.huge"},
	MultipleOptions = false,
	Callback = function(value)
		if type(value) == "table" then godModeMethod = value[1] else godModeMethod = value end
		if godModeEnabled then applyGodMode() end
	end
})

tab5:CreateSection("Emotes")

tab5:CreateButton({
	Name = "Unlock All Emotes",
	Description = "Unlocks all emotes/toys locally (visual)",
	Callback = function()
		local PlayEmote = ReplicatedStorage:FindFirstChild("Remotes")
			and ReplicatedStorage.Remotes:FindFirstChild("Misc")
			and ReplicatedStorage.Remotes.Misc:FindFirstChild("PlayEmote")
		if not PlayEmote then warn("PlayEmote remote not found!") return end
		local ItemServiceModule = ReplicatedStorage:FindFirstChild("ClientServices")
			and ReplicatedStorage.ClientServices:FindFirstChild("ItemService")
		if not ItemServiceModule then return end
		local ItemService = require(ItemServiceModule)
		local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

		local function getAllEmotes()
			local emotes = {} local added = {}
			local success, syncModule = pcall(require, ReplicatedStorage.Database.Sync)
			if success and syncModule then
				if syncModule.Emotes then for emoteName, _ in pairs(syncModule.Emotes) do if not added[emoteName] then table.insert(emotes, emoteName) added[emoteName] = true end end end
				if syncModule.Toys then for toyName, _ in pairs(syncModule.Toys) do if not added[toyName] then table.insert(emotes, toyName) added[toyName] = true end end end
			end
			local defaultEmotes = {"wave", "cheer", "laugh", "dance1", "dance2", "dance3"}
			for _, emote in ipairs(defaultEmotes) do if not added[emote] then table.insert(emotes, emote) added[emote] = true end end
			return emotes
		end

		local AllEmotes = getAllEmotes()

		local function runUnlocker()
			local Cross = PlayerGui:FindFirstChild("CrossPlatform")
			if not Cross then return end
			local Emotes = Cross:FindFirstChild("Emotes")
			if not Emotes then return end
			local Controller = Emotes:FindFirstChild("EmoteController")
			local Window2 = Emotes:FindFirstChild("EmoteWindow")
			if not Controller or not Window2 then return end
			local GameEmotes = Window2.EmoteContainer.EmotePages:FindFirstChild("Game Emotes")
			local FrameTemplate = Controller:FindFirstChild("EmoteFrame")
			if not GameEmotes or not FrameTemplate then return end
			for _, v in pairs(GameEmotes:GetChildren()) do
				if v.Name:match("^Row") or v.Name:match("^Emote") then v:Destroy() end
			end
			for index, emote in ipairs(AllEmotes) do
				local info = ItemService:GetItemInfo(emote, "Emotes")
				if not info then info = ItemService:GetItemInfo(emote, "Toys") end
				if info then
					local frame = FrameTemplate:Clone()
					frame.Name = "Emote"..index
					frame:SetAttribute("EmoteName", emote)
					if frame:FindFirstChild("EmoteName") then frame.EmoteName.Text = info.Name or emote end
					if frame:FindFirstChild("EmoteIcon") then frame.EmoteIcon.Image = ItemService:GetItemImage(info) end
					frame.LayoutOrder = index
					frame.Parent = GameEmotes
					if frame:FindFirstChild("PlayButton") then
						frame.PlayButton.Activated:Connect(function() PlayEmote:Fire(emote) end)
					end
				end
			end
		end

		if PlayerGui:FindFirstChild("CrossPlatform") then runUnlocker()
		else PlayerGui:WaitForChild("CrossPlatform", 10) task.wait(1) runUnlocker() end
	end
})

local emoteInputValue = ""

tab5:CreateInput({
	Name = "Emote Name Input",
	Description = "Type emote name to play (e.g., zen)",
	PlaceholderText = "Emote name...",
	RemoveTextAfterFocusLost = false,
	Callback = function(text)
		emoteInputValue = text
	end
})

tab5:CreateButton({
	Name = "Play Emote",
	Description = "Plays the emote typed above",
	Callback = function()
		if emoteInputValue and emoteInputValue ~= "" then
			local PlayEmote = ReplicatedStorage.Remotes.Misc.PlayEmote
			if PlayEmote then PlayEmote:Fire(emoteInputValue) end
		else
			warn("Please enter an emote name first!")
		end
	end
})

tab5:CreateSection("Fling")

local flingActive = false
local flingMode = 1
local flingInputValue = ""
local currentInput = ""
local processedPlayers = {}
local roles_fling = {}
local Murder_fling = nil
local Sheriff_fling = nil
local Hero_fling = nil
local FlingToggleRef = nil

local antiVoidActive = false
local originalDestroyHeight = workspace.FallenPartsDestroyHeight

local function enableAntiVoid()
	if antiVoidActive then return end
	antiVoidActive = true
	originalDestroyHeight = workspace.FallenPartsDestroyHeight
	workspace.FallenPartsDestroyHeight = -math.huge
	SendNotification("Anti Void", "Enabled: You won't fall into the void.", 3)
end

local function disableAntiVoid()
	if not antiVoidActive then return end
	workspace.FallenPartsDestroyHeight = originalDestroyHeight
	antiVoidActive = false
	SendNotification("Anti Void", "Disabled.", 3)
end

local function IsAlive_fling(Player)
	for i, v in pairs(roles_fling) do
		if Player.Name == i then
			if not v.Killed and not v.Dead then return true else return false end
		end
	end
	return false
end

local function updateRoles_fling()
	local success, result = pcall(function()
		return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
	end)
	if success and result then
		roles_fling = result
		Murder_fling = nil Sheriff_fling = nil Hero_fling = nil
		for i, v in pairs(roles_fling) do
			if v.Role == "Murderer" then Murder_fling = i
			elseif v.Role == "Sheriff" then Sheriff_fling = i
			elseif v.Role == "Hero" then Hero_fling = i end
		end
	end
end

RunService.RenderStepped:Connect(updateRoles_fling)

local function sortPlayersAlphabetically(playersList)
	table.sort(playersList, function(a, b) return string.lower(a.Name) < string.lower(b.Name) end)
	return playersList
end

local function getPlayers_fling(input)
	local playersList = {}
	input = string.lower(input or "")
	if input == "all" then
		for _, plr in ipairs(Players:GetPlayers()) do if plr ~= LocalPlayer then table.insert(playersList, plr) end end
		playersList = sortPlayersAlphabetically(playersList)
	elseif input == "nonfriends" then
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				local success, isFriend = pcall(function() return plr:IsFriendsWith(LocalPlayer.UserId) end)
				if not (success and isFriend) then table.insert(playersList, plr) end
			end
		end
		playersList = sortPlayersAlphabetically(playersList)
	elseif input == "murder" then
		if Murder_fling then
			local mp = Players:FindFirstChild(Murder_fling)
			if mp and mp ~= LocalPlayer and mp.Character and IsAlive_fling(mp) then table.insert(playersList, mp) end
		end
	elseif input == "sheriff" or input == "hero" then
		if Sheriff_fling then
			local sp = Players:FindFirstChild(Sheriff_fling)
			if sp and sp ~= LocalPlayer and sp.Character and IsAlive_fling(sp) then table.insert(playersList, sp) end
		end
		if Hero_fling then
			local hp = Players:FindFirstChild(Hero_fling)
			if hp and hp ~= LocalPlayer and hp.Character and IsAlive_fling(hp) then table.insert(playersList, hp) end
		end
	else
		local searchTerms = {}
		for term in string.gmatch(input, "([^,]+)") do
			term = string.match(term, "^%s*(.-)%s*$")
			if term ~= "" then table.insert(searchTerms, term) end
		end
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				local playerName = string.lower(plr.Name)
				local displayName = plr.DisplayName and string.lower(plr.DisplayName) or ""
				for _, term in ipairs(searchTerms) do
					if string.find(playerName, term) or string.find(displayName, term) then table.insert(playersList, plr) break end
				end
			end
		end
	end
	return playersList
end

local function Flinger(TargetPlayer, duration)
	local startTime = tick()
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Humanoid and Humanoid.RootPart
	local TCharacter = TargetPlayer.Character
	local THumanoid, TRootPart, THead, Accessory, Handle
	if TCharacter:FindFirstChildOfClass("Humanoid") then THumanoid = TCharacter:FindFirstChildOfClass("Humanoid") end
	if THumanoid and THumanoid.RootPart then TRootPart = THumanoid.RootPart end
	if TCharacter:FindFirstChild("Head") then THead = TCharacter.Head end
	if TCharacter:FindFirstChildOfClass("Accessory") then Accessory = TCharacter:FindFirstChildOfClass("Accessory") end
	if Accessory and Accessory:FindFirstChild("Handle") then Handle = Accessory.Handle end
	if Character and Humanoid and RootPart then
		if RootPart.Velocity.Magnitude < 50 then getgenv().OldPos = RootPart.CFrame end
		if THead then workspace.CurrentCamera.CameraSubject = THead
		elseif not THead and Handle then workspace.CurrentCamera.CameraSubject = Handle
		elseif THumanoid and TRootPart then workspace.CurrentCamera.CameraSubject = THumanoid end
		if not TCharacter:FindFirstChildWhichIsA("BasePart") then return end
		local FPos = function(BasePart, Pos, Ang)
			RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
			Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
			RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
			RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
		end
		local SFBasePart = function(BasePart)
			local TimeToWait = duration or 2
			local Time = tick()
			local Angle = 0
			repeat
				if RootPart and THumanoid then
					if BasePart.Velocity.Magnitude < 50 then
						Angle = Angle + 100
						FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
						task.wait()
						FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
						task.wait()
					else
						FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
						task.wait()
						FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
						task.wait()
					end
				else break end
			until not flingActive or BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= game.Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or tick() > Time + TimeToWait
		end
		local previousDestroyHeight = workspace.FallenPartsDestroyHeight
		workspace.FallenPartsDestroyHeight = 0/0
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.Name = "EpixVel" BV.Velocity = Vector3.new(9e8, 9e8, 9e8) BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		if TRootPart and THead then
			if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then SFBasePart(THead) else SFBasePart(TRootPart) end
		elseif TRootPart and not THead then SFBasePart(TRootPart)
		elseif not TRootPart and THead then SFBasePart(THead)
		elseif not TRootPart and not THead and Accessory and Handle then SFBasePart(Handle) end
		BV:Destroy()
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		workspace.CurrentCamera.CameraSubject = Humanoid
		repeat
			if Character and Humanoid and RootPart and getgenv().OldPos then
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
				Humanoid:ChangeState("GettingUp")
				for _, x in pairs(Character:GetChildren()) do
					if x:IsA("BasePart") then x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new() end
				end
			end
			task.wait()
		until not flingActive or (RootPart and getgenv().OldPos and (RootPart.Position - getgenv().OldPos.p).Magnitude < 25)
		workspace.FallenPartsDestroyHeight = previousDestroyHeight
	end
end

local function shhhlol(TargetPlayer)
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Humanoid and Humanoid.RootPart
	local TCharacter = TargetPlayer.Character
	local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
	local TRootPart = THumanoid and THumanoid.RootPart
	local THead = TCharacter and TCharacter:FindFirstChild("Head")
	if Character and Humanoid and RootPart then
		if RootPart.Velocity.Magnitude < 50 then getgenv().OldPos = RootPart.CFrame end
		if not TCharacter:FindFirstChildWhichIsA("BasePart") then return end
		local function mmmm(comkid, Pos, Ang)
			RootPart.CFrame = CFrame.new(comkid.Position) * Pos * Ang
			RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
		end
		local function wtf(comkid)
			local TimeToWait = 0.134
			local Time = tick()
			local Att1 = Instance.new("Attachment", RootPart)
			local Att2 = Instance.new("Attachment", comkid)
			repeat
				if RootPart and THumanoid then
					if comkid.Velocity.Magnitude < 30 then
						mmmm(comkid, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * comkid.Velocity.Magnitude / 5, CFrame.Angles(math.rad(180), math.rad(180), math.rad(180)))
						task.wait()
						mmmm(comkid, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * comkid.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)))
						task.wait()
					else
						mmmm(comkid, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(0), 0, 0))
						task.wait()
					end
				else break end
			until comkid.Velocity.Magnitude > 1000 or comkid.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= game.Players or not TargetPlayer.Character == TCharacter or Humanoid.Health <= 0 or tick() > Time + TimeToWait or not flingActive
			Att1:Destroy() Att2:Destroy()
		end
		local previousDestroyHeight = workspace.FallenPartsDestroyHeight
		workspace.FallenPartsDestroyHeight = 0/0
		local BV = Instance.new("BodyVelocity", RootPart)
		BV.Velocity = Vector3.new(-9e99, 9e99, -9e99) BV.MaxForce = Vector3.new(-9e9, 9e9, -9e9)
		if TRootPart and THead then
			if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then wtf(THead) else wtf(TRootPart) end
		elseif TRootPart and not THead then wtf(TRootPart)
		elseif not TRootPart and THead then wtf(THead) end
		BV:Destroy()
		repeat
			if Character and Humanoid and RootPart and getgenv().OldPos then
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
				Humanoid:ChangeState("GettingUp")
				for _, x in pairs(Character:GetDescendants()) do
					if x:IsA("BasePart") then x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new() end
				end
			end
			task.wait()
		until not flingActive or (RootPart and getgenv().OldPos and (RootPart.Position - getgenv().OldPos.p).Magnitude < 25)
		workspace.FallenPartsDestroyHeight = previousDestroyHeight
	end
end

local function yeet(targetPlayer)
	local character = LocalPlayer.Character
	local targetCharacter = targetPlayer.Character
	if not character or not targetCharacter or not targetCharacter:FindFirstChild("HumanoidRootPart") then return false end
	if character.HumanoidRootPart.Velocity.Magnitude < 50 then getgenv().OldPos = character.HumanoidRootPart.CFrame end
	local existingForce = character.HumanoidRootPart:FindFirstChild("YeetForce")
	if existingForce then existingForce:Destroy() end
	local Thrust = Instance.new("BodyThrust", character.HumanoidRootPart)
	Thrust.Force = Vector3.new(9999, 9999, 9999) Thrust.Name = "YeetForce"
	local previousDestroyHeight = workspace.FallenPartsDestroyHeight
	workspace.FallenPartsDestroyHeight = 0/0
	local startTime = tick()
	local dur = (currentInput == "all" or currentInput == "nonfriends") and 5 or math.huge
	local yeetConnection
	yeetConnection = RunService.Heartbeat:Connect(function()
		if not targetCharacter or not targetCharacter:FindFirstChild("HumanoidRootPart") or not flingActive or tick() > startTime + dur then
			yeetConnection:Disconnect() Thrust:Destroy()
			workspace.FallenPartsDestroyHeight = previousDestroyHeight
			if character and character.HumanoidRootPart and getgenv().OldPos then
				character.HumanoidRootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				character.Humanoid:ChangeState("GettingUp")
				for _, x in pairs(character:GetDescendants()) do
					if x:IsA("BasePart") then x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new() end
				end
			end
			return
		end
		local targetHRP = targetCharacter.HumanoidRootPart
		local offsetPosition = targetHRP.Position + (targetHRP.Velocity.Magnitude > 0.1 and (targetHRP.Velocity.Unit * targetHRP.Velocity.Magnitude) or Vector3.zero)
		character.HumanoidRootPart.CFrame = CFrame.new(offsetPosition)
		Thrust.Location = targetHRP.Position
	end)
	return true
end

local function addPlayerToProcessed(plr)
	if not plr or plr == LocalPlayer then return end
	local matchesFilter = false
	local inp = string.lower(currentInput)
	if inp == "all" then matchesFilter = true
	elseif inp == "nonfriends" then
		local success, isFriend = pcall(function() return plr:IsFriendsWith(LocalPlayer.UserId) end)
		matchesFilter = not (success and isFriend)
	elseif inp == "murder" then
		if Murder_fling and plr.Name == Murder_fling then matchesFilter = IsAlive_fling(plr) end
	elseif inp == "sheriff" or inp == "hero" then
		if (Sheriff_fling and plr.Name == Sheriff_fling) or (Hero_fling and plr.Name == Hero_fling) then matchesFilter = IsAlive_fling(plr) end
	else
		local searchTerms = {}
		for term in string.gmatch(inp, "([^,]+)") do
			term = string.match(term, "^%s*(.-)%s*$")
			if term ~= "" then table.insert(searchTerms, term) end
		end
		local playerName = string.lower(plr.Name)
		local displayName = plr.DisplayName and string.lower(plr.DisplayName) or ""
		for _, term in ipairs(searchTerms) do
			if string.find(playerName, term) or string.find(displayName, term) then matchesFilter = true break end
		end
	end
	if matchesFilter then processedPlayers[plr] = true end
end

local function flingPlayers()
	local playersList = {}
	for plr, _ in pairs(processedPlayers) do
		if plr and plr.Character and plr.Character.Parent ~= nil then table.insert(playersList, plr) end
	end
	if currentInput == "all" or currentInput == "nonfriends" then
		playersList = sortPlayersAlphabetically(playersList)
	end
	for _, plr in ipairs(playersList) do
		if not flingActive then break end
		if plr and plr.Character and plr.Character.Parent ~= nil then
			local dur = (currentInput == "all" or currentInput == "nonfriends") and 1.5 or nil
			if flingMode == 1 then Flinger(plr, dur)
			elseif flingMode == 2 then shhhlol(plr)
			elseif flingMode == 3 then yeet(plr)
				if currentInput == "all" or currentInput == "nonfriends" then task.wait(1.5) end
			end
		end
	end
	if flingActive then task.wait() flingPlayers() end
end

tab5:CreateInput({
	Name = "Fling Target Input",
	Description = "Type: nickname, all, nonfriends, murder, sheriff",
	PlaceholderText = "Target...",
	RemoveTextAfterFocusLost = false,
	Callback = function(value)
		flingInputValue = value
		currentInput = string.lower(value)
	end
})

tab5:CreateDropdown({
	Name = "Fling Mode",
	Description = "Select a method",
	Options = {"Flinger", "Shhhlol", "Yeet"},
	CurrentOption = {"Flinger"},
	MultipleOptions = false,
	Callback = function(value)
		local selected = type(value) == "table" and value[1] or value
		if selected == "Flinger" then flingMode = 1
		elseif selected == "Shhhlol" then flingMode = 2
		elseif selected == "Yeet" then flingMode = 3 end
	end
})

FlingToggleRef = tab5:CreateToggle({
	Name = "Fling Active",
	Description = "Start flinging targeted players",
	CurrentValue = false,
	Callback = function(state)
		flingActive = state
		if flingActive then
			currentInput = string.lower(flingInputValue or "")
			local playersList = getPlayers_fling(currentInput)
			if #playersList == 0 then
				SendNotification("Fling Target", "Invalid Input or Player not found: " .. currentInput, 4)
				flingActive = false
				return
			end
			processedPlayers = {}
			for _, plr in ipairs(playersList) do addPlayerToProcessed(plr) end
			SendNotification("Fling Target", "Flinging " .. #playersList .. " players...", 3)
			coroutine.wrap(flingPlayers)()
		else
			processedPlayers = {}
		end
	end
})

tab5:CreateButton({
	Name = "Fling Murderer",
	Description = "Fling only the murderer (10s)",
	Callback = function()
		if flingActive then SendNotification("Fling Target", "Stop current fling first!", 3) return end
		currentInput = "murder"
		local playersList = getPlayers_fling(currentInput)
		if #playersList == 0 then SendNotification("Fling Target", "No alive murderer found", 3) return end
		flingActive = true
		processedPlayers = {}
		for _, plr in ipairs(playersList) do addPlayerToProcessed(plr) end
		SendNotification("Fling Target", "Flinging Murderer for 10s", 3)
		local startTime = tick()
		coroutine.wrap(function()
			while flingActive and tick() - startTime < 10 do task.wait(1) end
			flingActive = false processedPlayers = {}
		end)()
		coroutine.wrap(flingPlayers)()
	end
})

tab5:CreateButton({
	Name = "Fling Sheriff/Hero",
	Description = "Fling only the sheriff (10s)",
	Callback = function()
		if flingActive then SendNotification("Fling Target", "Stop current fling first!", 3) return end
		currentInput = "sheriff"
		local playersList = getPlayers_fling(currentInput)
		if #playersList == 0 then SendNotification("Fling Target", "No alive Sheriff/Hero found", 3) return end
		flingActive = true
		processedPlayers = {}
		for _, plr in ipairs(playersList) do addPlayerToProcessed(plr) end
		SendNotification("Fling Target", "Flinging Sheriff for 10s", 3)
		local startTime = tick()
		coroutine.wrap(function()
			while flingActive and tick() - startTime < 10 do task.wait(1) end
			flingActive = false processedPlayers = {}
		end)()
		coroutine.wrap(flingPlayers)()
	end
})

tab5:CreateToggle({
	Name = "Anti Void Damage",
	Description = "Prevent void death",
	CurrentValue = false,
	Callback = function(state)
		if state then enableAntiVoid() else disableAntiVoid() end
	end
})

Players.PlayerAdded:Connect(function(plr)
	if flingActive then
		addPlayerToProcessed(plr)
		if plr.Character then
			local dur = (currentInput == "all" or currentInput == "nonfriends") and 1.5 or nil
			if flingMode == 1 then Flinger(plr, dur)
			elseif flingMode == 2 then shhhlol(plr)
			elseif flingMode == 3 then yeet(plr) end
		else
			plr.CharacterAdded:Connect(function()
				if flingActive then
					addPlayerToProcessed(plr)
					if flingMode == 1 then Flinger(plr)
					elseif flingMode == 2 then shhhlol(plr)
					elseif flingMode == 3 then yeet(plr) end
				end
			end)
		end
	end
end)

LocalPlayer.CharacterAdded:Connect(function()
	if flingActive then task.wait(1) coroutine.wrap(flingPlayers)() end
end)

-- ========================
-- TAB 6: TELEPORTS
-- ========================
local tab6 = Window:CreateTab("Teleports", "map-pin")

tab6:CreateSection("Player Teleports")

local selectedPlayerName = nil
local playerDropdownRef = nil

local function GetPlayerList()
	local list = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then table.insert(list, plr.Name) end
	end
	if #list == 0 then table.insert(list, "No Players Found") end
	return list
end

local function FindMurderer_tp()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife")) then return plr end
	end
	return nil
end

local function FindSheriff_tp()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Backpack:FindFirstChild("Gun") or (plr.Character and plr.Character:FindFirstChild("Gun")) then return plr end
	end
	return nil
end

local function TeleportToCoin_tp()
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local coinServer = workspace:FindFirstChild("Coin_Server")
	if not coinServer then return end
	local coins = {}
	for _, coin in ipairs(coinServer:GetChildren()) do
		if coin:IsA("BasePart") then table.insert(coins, coin) end
	end
	if #coins > 0 then
		local targetCoin = coins[math.random(1, #coins)]
		root.CFrame = CFrame.new(targetCoin.Position + Vector3.new(0, 5, 0))
	end
end

local function TeleportToMap_tp()
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local spawnParts = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "Spawn" then
			local isInLobby = false
			local parent = obj.Parent
			while parent ~= nil do
				if parent.Name == "Lobby" and parent.Parent == workspace then isInLobby = true break end
				parent = parent.Parent
			end
			if not isInLobby then table.insert(spawnParts, obj) end
		end
	end
	if #spawnParts > 0 then
		local randomSpawn = spawnParts[math.random(1, #spawnParts)]
		root.CFrame = randomSpawn.CFrame + Vector3.new(0, 5, 0)
	end
end

local function TeleportToLobby_tp()
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local lobby = workspace:FindFirstChild("Lobby")
	if not lobby then return end
	local spawns = lobby:FindFirstChild("Spawns")
	if not spawns then return end
	local spawnLocations = {}
	for _, obj in pairs(spawns:GetChildren()) do
		if obj:IsA("SpawnLocation") then table.insert(spawnLocations, obj) end
	end
	if #spawnLocations > 0 then
		local randomSpawn = spawnLocations[math.random(1, #spawnLocations)]
		root.CFrame = randomSpawn.CFrame + Vector3.new(0, 3, 0)
	end
end

playerDropdownRef = tab6:CreateDropdown({
	Name = "Select Player",
	Description = "Choose a player to teleport to",
	Options = GetPlayerList(),
	CurrentOption = {GetPlayerList()[1]},
	MultipleOptions = false,
	Callback = function(value)
		if type(value) == "table" then selectedPlayerName = value[1] else selectedPlayerName = value end
	end
})

tab6:CreateButton({
	Name = "Refresh Player List",
	Description = "Updates the player dropdown",
	Callback = function()
		if playerDropdownRef and playerDropdownRef.Refresh then
			playerDropdownRef:Refresh(GetPlayerList(), false)
		end
	end
})

tab6:CreateButton({
	Name = "Teleport to Selected",
	Description = "TP to player chosen in dropdown",
	Callback = function()
		if selectedPlayerName then
			local targetPlayer = Players:FindFirstChild(selectedPlayerName)
			if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
				end
			end
		end
	end
})

tab6:CreateButton({
	Name = "Teleport to Random",
	Description = "TP to a random player",
	Callback = function()
		local otherPlayers = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				table.insert(otherPlayers, plr)
			end
		end
		if #otherPlayers > 0 then
			local randomPlayer = otherPlayers[math.random(1, #otherPlayers)]
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
			end
		end
	end
})

tab6:CreateButton({
	Name = "Teleport to Innocent",
	Description = "TP to a random innocent",
	Callback = function()
		local murderer = FindMurderer_tp()
		local sheriff = FindSheriff_tp()
		local innocents = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr ~= murderer and plr ~= sheriff and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local hasKnife = plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife"))
				local hasGun = plr.Backpack:FindFirstChild("Gun") or (plr.Character and plr.Character:FindFirstChild("Gun"))
				if not hasKnife and not hasGun then table.insert(innocents, plr) end
			end
		end
		if #innocents > 0 then
			local randomInnocent = innocents[math.random(1, #innocents)]
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = randomInnocent.Character.HumanoidRootPart.CFrame
			end
		end
	end
})

tab6:CreateButton({
	Name = "Teleport to Murderer",
	Description = "TP to the Murderer",
	Callback = function()
		local murderer = FindMurderer_tp()
		if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = murderer.Character.HumanoidRootPart.CFrame
			end
		end
	end
})

tab6:CreateButton({
	Name = "Teleport to Sheriff",
	Description = "TP to the Sheriff",
	Callback = function()
		local sheriff = FindSheriff_tp()
		if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") then
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = sheriff.Character.HumanoidRootPart.CFrame
			end
		end
	end
})

tab6:CreateButton({
	Name = "Teleport to Gun",
	Description = "TP to dropped gun",
	Callback = function()
		local gun = workspace:FindFirstChild("DropGun")
		if gun and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(gun.Position)
		end
	end
})

tab6:CreateButton({
	Name = "Teleport to Coin",
	Description = "TP to a random coin",
	Callback = function()
		TeleportToCoin_tp()
	end
})

tab6:CreateButton({
	Name = "Teleport to Map",
	Description = "TP to map spawn points",
	Callback = function()
		TeleportToMap_tp()
	end
})

tab6:CreateButton({
	Name = "Teleport to Lobby",
	Description = "TP to lobby spawn",
	Callback = function()
		TeleportToLobby_tp()
	end
})

local function AutoUpdateList_tp()
	if playerDropdownRef and playerDropdownRef.Refresh then
		playerDropdownRef:Refresh(GetPlayerList(), false)
	end
end

Players.PlayerAdded:Connect(AutoUpdateList_tp)
Players.PlayerRemoving:Connect(AutoUpdateList_tp)

-- ========================
-- TAB 7: AUTO-FARMS
-- ========================
local tab7 = Window:CreateTab("Auto-Farms", "dollar-sign")

tab7:CreateSection("Anti AFK")

local VirtualUser = game:GetService("VirtualUser")
local AntiAFKConnection = nil

local function startAntiAFK()
	if AntiAFKConnection then return end
	AntiAFKConnection = LocalPlayer.Idled:Connect(function()
		VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	end)
end

local function stopAntiAFK()
	if AntiAFKConnection then AntiAFKConnection:Disconnect() AntiAFKConnection = nil end
end

tab7:CreateToggle({
	Name = "Anti AFK",
	Description = "Prevents being kicked for inactivity",
	CurrentValue = false,
	Callback = function(value)
		if value then startAntiAFK() else stopAntiAFK() end
	end
})

tab7:CreateSection("Auto-Farm BETA [Dont Open Lobby]")

local AutoFarm = {
	Enabled = false,
	Mode = "Teleport",
	TeleportDelay = 0,
	MoveSpeed = 50,
	CoinCheckInterval = 0.5,
	CoinContainers = {
		"Factory", "Hospital3", "MilBase", "House2", "Workplace",
		"Mansion2", "BioLab", "Hotel", "Bank2", "PoliceStation",
		"ResearchFacility", "Lobby"
	},
	Connection = nil
}

local function getHumanoidRootPart_af()
	if not LocalPlayer.Character then return nil end
	return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function findNearestCoin_af()
	local hrp = getHumanoidRootPart_af()
	if not hrp then return nil end
	local closestCoin local shortestDistance = math.huge
	for _, containerName in ipairs(AutoFarm.CoinContainers) do
		local container = workspace:FindFirstChild(containerName)
		if container then
			local coinContainer = (containerName == "Lobby") and container or container:FindFirstChild("CoinContainer")
			if coinContainer then
				for _, coin in ipairs(coinContainer:GetChildren()) do
					if coin:IsA("BasePart") and coin.Parent then
						local distance = (hrp.Position - coin.Position).Magnitude
						if distance < shortestDistance then shortestDistance = distance closestCoin = coin end
					end
				end
			end
		end
	end
	return closestCoin
end

local function teleportToCoin_af(coin)
	local hrp = getHumanoidRootPart_af()
	if hrp and coin then hrp.CFrame = CFrame.new(coin.Position + Vector3.new(0, 3, 0)) task.wait(AutoFarm.TeleportDelay) end
end

local function smoothMoveToCoin_af(coin)
	local hrp = getHumanoidRootPart_af()
	if not hrp or not coin then return end
	local startPos = hrp.Position
	local endPos = coin.Position + Vector3.new(0, 3, 0)
	local distance = (endPos - startPos).Magnitude
	local duration = distance / AutoFarm.MoveSpeed
	local startTime = tick()
	while tick() - startTime < duration and AutoFarm.Enabled do
		if not coin.Parent then break end
		local progress = math.min((tick() - startTime) / duration, 1)
		hrp.CFrame = CFrame.new(startPos:Lerp(endPos, progress))
		task.wait()
	end
end

local function walkToCoin_af(coin)
	if not LocalPlayer.Character or not coin then return end
	local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	humanoid.WalkSpeed = 16
	humanoid:MoveTo(coin.Position + Vector3.new(0, 0, 3))
	local startTime = tick()
	while AutoFarm.Enabled and humanoid.MoveDirection.Magnitude > 0 and tick() - startTime < 10 do task.wait(0.5) end
end

local function collectCoin_af(coin)
	local hrp = getHumanoidRootPart_af()
	if hrp and coin and coin.Parent then
		firetouchinterest(hrp, coin, 0)
		firetouchinterest(hrp, coin, 1)
		task.wait(1)
	end
end

local function farmLoop_af()
	while AutoFarm.Enabled do
		local coin = findNearestCoin_af()
		if coin then
			if AutoFarm.Mode == "Teleport" then teleportToCoin_af(coin)
			elseif AutoFarm.Mode == "Smooth" then smoothMoveToCoin_af(coin)
			else walkToCoin_af(coin) end
			collectCoin_af(coin)
		else task.wait(1) end
		task.wait(AutoFarm.CoinCheckInterval)
	end
end

tab7:CreateToggle({
	Name = "Auto-Farm",
	Description = "Starts collecting coins automatically",
	CurrentValue = false,
	Callback = function(value)
		AutoFarm.Enabled = value
		if value then
			if AutoFarm.Connection then task.cancel(AutoFarm.Connection) end
			AutoFarm.Connection = task.spawn(farmLoop_af)
		else
			if AutoFarm.Connection then task.cancel(AutoFarm.Connection) AutoFarm.Connection = nil end
		end
	end
})

tab7:CreateDropdown({
	Name = "Movement Mode",
	Description = "Select how to travel to coins",
	Options = {"Teleport", "Smooth", "Walk"},
	CurrentOption = {"Teleport"},
	MultipleOptions = false,
	Callback = function(value)
		if type(value) == "table" then AutoFarm.Mode = value[1] else AutoFarm.Mode = value end
	end
})

tab7:CreateSlider({
	Name = "Teleport Delay",
	Description = "Wait time after TP (Seconds)",
	Range = {0, 2},
	Increment = 0.1,
	CurrentValue = 0,
	Callback = function(value)
		AutoFarm.TeleportDelay = tonumber(value)
	end
})

tab7:CreateSlider({
	Name = "Smooth Move Speed",
	Description = "Speed for Smooth Mode",
	Range = {20, 200},
	Increment = 1,
	CurrentValue = 50,
	Callback = function(value)
		AutoFarm.MoveSpeed = tonumber(value)
	end
})

tab7:CreateSlider({
	Name = "Check Interval",
	Description = "Coin scan frequency",
	Range = {1, 20},
	Increment = 1,
	CurrentValue = 5,
	Callback = function(value)
		AutoFarm.CoinCheckInterval = tonumber(value) / 10
	end
})

-- ========================
-- TAB 8: CREDITS
-- ========================
local tab8 = Window:CreateTab("Credits", "heart")

tab8:CreateSection("Rise Producers")

tab8:CreateParagraph({
	Title = "Development Team",
	Content = "ShadowBey (OWNER)\nWreston (OWNER OF LUMINARY)\nHanki (CO-OWNER)\nRIGHTHIT (CO-OWNER)\nUchiha İtachi (Developer)"
})

tab8:CreateParagraph({
	Title = "Special Thanks",
	Content = "Hanki (CO-OWNER)\nLoadFent (Developer)\nTuaxa (Developer)\nThanks for their help ❤"
})

tab8:CreateSection("Links")

tab8:CreateButton({
	Name = "Join Discord",
	Description = "dc.gg/shwxteam",
	Callback = function()
		setclipboard("dc.gg/shwxteam")
		SendNotification("Rise", "Discord link copied!", 3)
	end
})
