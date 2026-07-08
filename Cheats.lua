-- // Pulse Hub | MM2 Edition | WindUI (Footagesus)
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

local Window = WindUI:Create({
    Title = "Pulse Hub — MM2",
    Icon = "rbxassetid://6031097228",
    Size = UDim2.fromOffset(650, 560),
    Accent = Color3.fromRGB(255, 30, 110),
    Theme = "Dark"
})

local Visuals  = Window:Tab("Visuals", "eye")
local Combat   = Window:Tab("Combat", "sword")
local Movement = Window:Tab("Movement", "walk")
local Misc     = Window:Tab("Misc", "settings")

getgenv().Pulse = getgenv().Pulse or {}
local ESPTable = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ================== ESP ПО РОЛЯМ (MM2) ==================
local function GetRole(plr)
    if not plr then return "Innocent" end
    local role = plr:FindFirstChild("Role") or (plr.Character and plr.Character:FindFirstChild("Role"))
    if role then
        return role.Value
    end
    return "Innocent"
end

local function CreateESP(plr)
    if ESPTable[plr] then return end
    if plr == LocalPlayer then return end

    local Box = Drawing.new("Square")
    Box.Thickness = 2
    Box.Filled = false
    Box.Transparency = 1

    local Name = Drawing.new("Text")
    Name.Size = 15
    Name.Center = true
    Name.Outline = true
    Name.Font = 2

    ESPTable[plr] = {Box = Box, Name = Name}

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not getgenv().ESPEnabled then 
            Box.Visible = false
            Name.Visible = false
            return 
        end

        local Character = plr.Character
        if not Character or not Character:FindFirstChild("HumanoidRootPart") then
            Box.Visible = false
            Name.Visible = false
            return
        end

        local Role = GetRole(plr)
        local Root = Character.HumanoidRootPart
        local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Root.Position)

        if OnScreen then
            local Size = Vector2.new(2200 / ScreenPos.Z, 2600 / ScreenPos.Z)
            
            -- Цвет по роли
            if Role == "Murderer" then
                Box.Color = Color3.fromRGB(255, 0, 0)
                Name.Color = Color3.fromRGB(255, 0, 0)
                Name.Text = "[Murderer] " .. plr.Name
            elseif Role == "Sheriff" then
                Box.Color = Color3.fromRGB(0, 100, 255)
                Name.Color = Color3.fromRGB(0, 100, 255)
                Name.Text = "[Sheriff] " .. plr.Name
            else
                Box.Color = Color3.fromRGB(255, 255, 255)
                Name.Color = Color3.fromRGB(255, 255, 255)
                Name.Text = "[Innocent] " .. plr.Name
            end

            Box.Size = Size
            Box.Position = Vector2.new(ScreenPos.X - Size.X/2, ScreenPos.Y - Size.Y/2)
            Box.Visible = true

            Name.Position = Vector2.new(ScreenPos.X, ScreenPos.Y - Size.Y/2 - 18)
            Name.Visible = true
        else
            Box.Visible = false
            Name.Visible = false
        end
    end)

    ESPTable[plr].Connection = connection
end

-- Автоматически создаём ESP для всех игроков + новые
for _, plr in pairs(Players:GetPlayers()) do
    CreateESP(plr)
end
Players.PlayerAdded:Connect(CreateESP)

-- Обновление ESP при смене роли / респавне
Players.PlayerRemoving:Connect(function(plr)
    if ESPTable[plr] then
        ESPTable[plr].Connection:Disconnect()
        ESPTable[plr].Box:Remove()
        ESPTable[plr].Name:Remove()
        ESPTable[plr] = nil
    end
end)

-- ================== VISUALS ==================
Visuals:Toggle({
    Title = "ESP (Роли)",
    Default = true,
    Callback = function(state)
        getgenv().ESPEnabled = state
    end
})

Visuals:Colorpicker({
    Title = "Innocent Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function() end
})

-- ================== COMBAT ==================
Combat:Toggle({
    Title = "Silent Aim (MM2)",
    Default = false,
    Callback = function(state)
        getgenv().SilentAimMM2 = state
    end
})

Combat:Slider({
    Title = "FOV",
    Min = 10,
    Max = 800,
    Default = 180,
    Callback = function(v)
        getgenv().AimFOV = v
    end
})

-- Простой, но рабочий Silent Aim для MM2
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if method == "FireServer" and args[1] == "UpdateMousePos" and getgenv().SilentAimMM2 then
        local closest = nil
        local shortest = getgenv().AimFOV or 180

        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onscreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if onscreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = plr
                    end
                end
            end
        end

        if closest and closest.Character and closest.Character:FindFirstChild("Head") then
            args[2] = closest.Character.Head.Position
            return old(self, unpack(args))
        end
    end
    return old(self, ...)
end)

setreadonly(mt, true)

-- ================== MOVEMENT ==================
Movement:Slider({
    Title = "WalkSpeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(v)
        getgenv().Speed = v
    end
})

Movement:Toggle({
    Title = "Infinite Jump",
    Default = false,
    Callback = function(state)
        getgenv().InfJump = state
    end
})

Movement:Toggle({
    Title = "Noclip",
    Default = false,
    Callback = function(state)
        getgenv().Noclip = state
    end
})

-- ================== FLY (ПК + Телефон) + Hover + Анимация ==================
local flying = false
local flySpeed = 50
local BodyVelocity, BodyGyro

Movement:Toggle({
    Title = "Fly (ПК + Мобильный)",
    Default = false,
    Callback = function(state)
        flying = state
        local Character = LocalPlayer.Character
        if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

        if flying then
            BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            BodyVelocity.Velocity = Vector3.new(0,0,0)
            BodyVelocity.Parent = Character.HumanoidRootPart

            BodyGyro = Instance.new("BodyGyro")
            BodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            BodyGyro.P = 20000
            BodyGyro.Parent = Character.HumanoidRootPart

            Character.Humanoid.PlatformStand = true

            -- Анимация полёта (лёгкое покачивание)
            spawn(function()
                while flying and Character and Character:FindFirstChild("HumanoidRootPart") do
                    if BodyVelocity then
                        local move = game:GetService("UserInputService"):GetMouseDelta()
                        local cam = workspace.CurrentCamera.CFrame
                        local direction = cam.LookVector * (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) and flySpeed or 0) +
                                         cam.LookVector * (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) and -flySpeed or 0) +
                                         cam.RightVector * (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) and flySpeed or 0) +
                                         cam.RightVector * (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) and -flySpeed or 0)

                        BodyVelocity.Velocity = direction + Vector3.new(0, game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and 30 or (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and -30 or 0), 0)
                        BodyGyro.CFrame = cam
                    end
                    RunService.Heartbeat:Wait()
                end
            end)
        else
            if BodyVelocity then BodyVelocity:Destroy() end
            if BodyGyro then BodyGyro:Destroy() end
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.PlatformStand = false
            end
        end
    end
})

Movement:Slider({
    Title = "Fly Speed",
    Min = 20,
    Max = 200,
    Default = 50,
    Callback = function(v)
        flySpeed = v
    end
})

-- ================== Логика Speed, Noclip, Inf Jump ==================
RunService.Heartbeat:Connect(function()
    local Character = LocalPlayer.Character
    if not Character then return end
    local Humanoid = Character:FindFirstChild("Humanoid")
    local Root = Character:FindFirstChild("HumanoidRootPart")

    if Humanoid and getgenv().Speed then
        Humanoid.WalkSpeed = getgenv().Speed
    end

    if getgenv().Noclip and Root then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Infinite Jump
LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5)
    if getgenv().InfJump then
        char.Humanoid.JumpPower = 50
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- ================== ЗАГРУЗКА ==================
getgenv().ESPEnabled = true
WindUI:Notify({
    Title = "Pulse Hub — MM2",
    Content = "Загружен успешно!\nESP по ролям + Silent Aim + Fly (ПК+Телефон)",
    Type = "Success"
})
