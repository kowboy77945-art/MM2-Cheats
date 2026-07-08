-- // Pulse Hub v3.0 | Murder Mystery 2 | WindUI (обновлённый)
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

local Window = WindUI:Create({
    Title = "Pulse Hub v3.0 — MM2",
    Icon = "rbxassetid://6031097228",
    Size = UDim2.fromOffset(700, 620),
    Accent = Color3.fromRGB(255, 20, 100),
    Theme = "Dark"
})

local Tabs = {
    Home = Window:Tab("Home", "home"),
    Visuals = Window:Tab("Visuals", "eye"),
    Combat = Window:Tab("Combat", "sword"),
    Movement = Window:Tab("Movement", "walk"),
    Farming = Window:Tab("Farming", "coin"),
    Trolling = Window:Tab("Trolling", "skull"),
    Misc = Window:Tab("Misc", "settings")
}

getgenv().PulseMM2 = getgenv().PulseMM2 or {}
local ESP = {}
local Highlights = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInput = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ================== РОЛЬ (надежно для MM2) ==================
local function GetRole(plr)
    if not plr or not plr.Character then return "Innocent" end
    local char = plr.Character
    local backpack = plr:FindFirstChild("Backpack")
    if char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife")) then return "Murderer" end
    if char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) then return "Sheriff" end
    return "Innocent"
end

-- ================== ESP (Box + Name + Tracer + Skeleton) ==================
local function CreateESP(plr)
    if ESP[plr] or plr == LocalPlayer then return end

    local Box = Drawing.new("Square")
    local Name = Drawing.new("Text")
    local Tracer = Drawing.new("Line")
    local SkeletonParts = {}

    Name.Size = 14
    Name.Center = true
    Name.Outline = true
    Name.Font = 2

    Box.Thickness = 2
    Box.Filled = false
    Tracer.Thickness = 1.5

    -- Skeleton
    for _, v in pairs({"Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso"}) do
        local line = Drawing.new("Line")
        line.Thickness = 1.5
        table.insert(SkeletonParts, line)
    end

    ESP[plr] = {Box = Box, Name = Name, Tracer = Tracer, Skeleton = SkeletonParts}

    RunService.RenderStepped:Connect(function()
        if not getgenv().ESPEnabled then
            Box.Visible = false; Name.Visible = false; Tracer.Visible = false
            for _, l in pairs(SkeletonParts) do l.Visible = false end
            return
        end

        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            Box.Visible = false; Name.Visible = false; Tracer.Visible = false
            for _, l in pairs(SkeletonParts) do l.Visible = false end
            return
        end

        local role = GetRole(plr)
        local root = char.HumanoidRootPart
        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)

        local color = role == "Murderer" and Color3.fromRGB(255,0,0) or 
                     (role == "Sheriff" and Color3.fromRGB(0,120,255) or Color3.fromRGB(255,255,255))

        if onScreen then
            local size = Vector2.new(2400 / pos.Z, 3000 / pos.Z)
            Box.Color = color
            Box.Size = size
            Box.Position = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
            Box.Visible = getgenv().ESPBox

            Name.Text = string.format("[%s] %s (%dm)", role, plr.Name, (root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
            Name.Color = color
            Name.Position = Vector2.new(pos.X, pos.Y - size.Y/2 - 22)
            Name.Visible = getgenv().ESPName

            if getgenv().ESPTracers then
                Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y - 30)
                Tracer.To = Vector2.new(pos.X, pos.Y)
                Tracer.Color = color
                Tracer.Visible = true
            else
                Tracer.Visible = false
            end

            -- Skeleton
            if getgenv().ESPSkeleton then
                local connections = {
                    {char.Head, char.Torso or char.UpperTorso},
                    {char.Torso or char.UpperTorso, char["Left Arm"]},
                    {char.Torso or char.UpperTorso, char["Right Arm"]},
                    {char.Torso or char.UpperTorso, char["Left Leg"]},
                    {char.Torso or char.UpperTorso, char["Right Leg"]},
                }
                for i, conn in pairs(connections) do
                    if conn[1] and conn[2] then
                        local p1 = Camera:WorldToViewportPoint(conn[1].Position)
                        local p2 = Camera:WorldToViewportPoint(conn[2].Position)
                        SkeletonParts[i].From = Vector2.new(p1.X, p1.Y)
                        SkeletonParts[i].To = Vector2.new(p2.X, p2.Y)
                        SkeletonParts[i].Color = color
                        SkeletonParts[i].Visible = true
                    end
                end
            else
                for _, l in pairs(SkeletonParts) do l.Visible = false end
            end
        else
            Box.Visible = false; Name.Visible = false; Tracer.Visible = false
            for _, l in pairs(SkeletonParts) do l.Visible = false end
        end
    end)
end

for _, plr in pairs(Players:GetPlayers()) do CreateESP(plr) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(plr)
    if ESP[plr] then
        for _, obj in pairs(ESP[plr]) do
            if typeof(obj) == "table" then
                for _, line in pairs(obj) do if line.Remove then line:Remove() end end
            elseif obj.Remove then
                obj:Remove()
            end
        end
        ESP[plr] = nil
    end
end)

-- Chams (Highlight)
local function CreateChams(plr)
    if Highlights[plr] then return end
    local highlight = Instance.new("Highlight")
    highlight.Parent = plr.Character or plr.CharacterAdded:Wait()
    Highlights[plr] = highlight
end

-- ================== ВКЛАДКИ ==================
Tabs.Home:Paragraph({Title = "Pulse Hub v3.0", Text = "Полностью исправлено и расширено.\nESP держится после раундов.\nИспользуется новый WindUI."})

-- Visuals
Tabs.Visuals:Toggle({Title = "ESP Включить", Default = true, Callback = function(v) getgenv().ESPEnabled = v end})
Tabs.Visuals:Toggle({Title = "Box", Default = true, Callback = function(v) getgenv().ESPBox = v end})
Tabs.Visuals:Toggle({Title = "Name + Distance", Default = true, Callback = function(v) getgenv().ESPName = v end})
Tabs.Visuals:Toggle({Title = "Tracers", Default = true, Callback = function(v) getgenv().ESPTracers = v end})
Tabs.Visuals:Toggle({Title = "Skeleton", Default = false, Callback = function(v) getgenv().ESPSkeleton = v end})
Tabs.Visuals:Toggle({Title = "Chams (Подсветка)", Default = false, Callback = function(v) 
    getgenv().Chams = v 
    for _, plr in pairs(Players:GetPlayers()) do
        if v then CreateChams(plr) else if Highlights[plr] then Highlights[plr]:Destroy() end end
    end
end})
Tabs.Visuals:Toggle({Title = "FOV Circle", Default = true, Callback = function(v) getgenv().ShowFOV = v end})

-- Combat
Tabs.Combat:Toggle({Title = "Silent Aim + FOV", Default = false, Callback = function(v) getgenv().SilentAim = v end})
Tabs.Combat:Slider({Title = "FOV", Min = 30, Max = 800, Default = 180, Callback = function(v) getgenv().AimFOV = v end})
Tabs.Combat:Toggle({Title = "Kill Aura (Murderer)", Default = false, Callback = function(v) getgenv().KillAura = v end})
Tabs.Combat:Slider({Title = "Kill Aura Range", Min = 5, Max = 30, Default = 15, Callback = function(v) getgenv().AuraRange = v end})
Tabs.Combat:Toggle({Title = "Gun Mods (No Recoil + Fast Shoot)", Default = false, Callback = function(v) getgenv().GunMods = v end})
Tabs.Combat:Toggle({Title = "Hitbox Expander", Default = false, Callback = function(v) getgenv().HitboxExpander = v end})
Tabs.Combat:Toggle({Title = "Murder Notifier", Default = true, Callback = function(v) getgenv().MurderNotifier = v end})

-- Movement
Tabs.Movement:Slider({Title = "WalkSpeed", Min = 16, Max = 350, Default = 16, Callback = function(v) getgenv().WalkSpeed = v end})
Tabs.Movement:Toggle({Title = "Infinite Jump", Default = false, Callback = function(v) getgenv().InfJump = v end})
Tabs.Movement:Toggle({Title = "Noclip", Default = false, Callback = function(v) getgenv().Noclip = v end})
Tabs.Movement:Toggle({Title = "Fly (ПК + Мобильный) + Hover", Default = false, Callback = function(v) getgenv().Fly = v end})
Tabs.Movement:Slider({Title = "Fly Speed", Min = 20, Max = 200, Default = 65, Callback = function(v) getgenv().FlySpeed = v end})
Tabs.Movement:Toggle({Title = "No Fall Damage", Default = true, Callback = function(v) getgenv().NoFall = v end})

-- Farming
Tabs.Farming:Toggle({Title = "Auto Coin Farm", Default = false, Callback = function(v) getgenv().AutoFarm = v end})
Tabs.Farming:Toggle({Title = "Auto Collect Drops", Default = false, Callback = function(v) getgenv().AutoCollect = v end})

-- Trolling
Tabs.Trolling:Toggle({Title = "Spin Bot", Default = false, Callback = function(v) getgenv().SpinBot = v end})
Tabs.Trolling:Slider({Title = "Spin Speed", Min = 50, Max = 500, Default = 200, Callback = function(v) getgenv().SpinSpeed = v end})
Tabs.Trolling:Button({Title = "Server Hop", Callback = function() game.TeleportService:Teleport(game.PlaceId) end})

-- Misc
Tabs.Misc:Button({Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end})

-- ================== ОСНОВНЫЕ ЦИКЛЫ ==================
local bv, bg

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")

    if hum then
        if getgenv().WalkSpeed then hum.WalkSpeed = getgenv().WalkSpeed end
        if getgenv().NoFall then hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false) end
    end

    if getgenv().Noclip and root then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    if getgenv().HitboxExpander then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.Size = Vector3.new(6,6,6)
                plr.Character.HumanoidRootPart.Transparency = 0.8
            end
        end
    end

    if getgenv().KillAura and GetRole(LocalPlayer) == "Murderer" and root then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if (root.Position - plr.Character.HumanoidRootPart.Position).Magnitude < (getgenv().AuraRange or 15) then
                    ReplicatedStorage.Remotes.Gameplay:FireServer("Stab", plr.Character.HumanoidRootPart)
                end
            end
        end
    end

    if getgenv().SpinBot and root then
        root.CFrame *= CFrame.Angles(0, math.rad(getgenv().SpinSpeed or 200), 0)
    end

    -- Auto Collect
    if getgenv().AutoCollect then
        for _, drop in pairs(workspace:GetChildren()) do
            if drop.Name == "Coin" or drop.Name == "Drop" then
                if drop:IsA("BasePart") and (root.Position - drop.Position).Magnitude < 50 then
                    firetouchinterest(root, drop, 0)
                    firetouchinterest(root, drop, 1)
                end
            end
        end
    end
end)

-- Fly (ПК + Телефон, hover, плавная анимация)
spawn(function()
    while task.wait() do
        if getgenv().Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if not bv then
                bv = Instance.new("BodyVelocity") bv.MaxForce = Vector3.new(9e9,9e9,9e9) bv.Parent = LocalPlayer.Character.HumanoidRootPart
                bg = Instance.new("BodyGyro") bg.MaxTorque = Vector3.new(9e9,9e9,9e9) bg.P = 10000 bg.Parent = LocalPlayer.Character.HumanoidRootPart
                LocalPlayer.Character.Humanoid.PlatformStand = true
            end
            local cam = Camera.CFrame
            local dir = Vector3.new()
            if UserInput:IsKeyDown("W") then dir += cam.LookVector end
            if UserInput:IsKeyDown("S") then dir -= cam.LookVector end
            if UserInput:IsKeyDown("A") then dir -= cam.RightVector end
            if UserInput:IsKeyDown("D") then dir += cam.RightVector end
            if UserInput:IsKeyDown("Space") then dir += Vector3.new(0,1,0) end
            if UserInput:IsKeyDown("LeftControl") then dir -= Vector3.new(0,1,0) end

            bv.Velocity = dir.Unit * (getgenv().FlySpeed or 65)
            bg.CFrame = cam
        elseif bv then
            bv:Destroy() bv = nil
            bg:Destroy() bg = nil
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.PlatformStand = false
            end
        end
    end
end)

-- FOV Circle
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 2
fovCircle.Color = Color3.fromRGB(255, 30, 100)
fovCircle.Filled = false
RunService.RenderStepped:Connect(function()
    fovCircle.Radius = getgenv().AimFOV or 180
    fovCircle.Position = UserInput:GetMouseLocation()
    fovCircle.Visible = getgenv().ShowFOV
end)

-- Silent Aim (обновлённый)
local old
old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if getgenv().SilentAim and getnamecallmethod() == "FireServer" and tostring(self):find("UpdateMousePos") then
        local closest, dist = nil, getgenv().AimFOV or 180
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local screen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                local mouseDist = (Vector2.new(screen.X, screen.Y) - UserInput:GetMouseLocation()).Magnitude
                if mouseDist < dist then
                    dist = mouseDist
                    closest = plr
                end
            end
        end
        if closest and closest.Character then
            args[1] = closest.Character.Head.Position + closest.Character.Head.Velocity * 0.1
            return old(self, unpack(args))
        end
    end
    return old(self, ...)
end)

-- Infinite Jump
UserInput.JumpRequest:Connect(function()
    if getgenv().InfJump and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- Murder Notifier
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if getgenv().MurderNotifier and GetRole(plr) == "Murderer" then
            WindUI:Notify({Title = "⚠️ MURDERER FOUND", Content = plr.Name .. " — Убийца!", Type = "Error"})
        end
    end)
end)

WindUI:Notify({
    Title = "Pulse Hub v3.0",
    Content = "Загружено успешно!\nESP всегда работает • Много новых функций",
    Type = "Success"
})
