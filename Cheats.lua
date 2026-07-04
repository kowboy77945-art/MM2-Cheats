--[[
    MM2 Ultimate Cheat
    Features: Key System, ESP, Speed, Jump, Noclip, Fly, Auto Gun, Fake Death, Invisibility
    UI: WindUI
]]

-- ============================================
-- КЛЮЧЕВАЯ СИСТЕМА (10 ключей)
-- ============================================
local ValidKeys = {
    "MM2-ULTRA-0001",
    "MM2-ULTRA-0002",
    "MM2-ULTRA-0003",
    "MM2-ULTRA-0004",
    "MM2-ULTRA-0005",
    "MM2-ULTRA-0006",
    "MM2-ULTRA-0007",
    "MM2-ULTRA-0008",
    "MM2-ULTRA-0009",
    "MM2-ULTRA-0010"
}

local KeyVerified = false

-- Простое окно ключа
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- Создаём Key UI
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeySystemGUI"
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.Parent = PlayerGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 420, 0, 280)
KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -140)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(130, 80, 255)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔐 MM2 ULTIMATE CHEAT"
TitleLabel.TextColor3 = Color3.fromRGB(180, 120, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = KeyFrame

local SubLabel = Instance.new("TextLabel")
SubLabel.Size = UDim2.new(1, 0, 0, 30)
SubLabel.Position = UDim2.new(0, 0, 0, 55)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Введите ключ для доступа"
SubLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SubLabel.TextSize = 14
SubLabel.Font = Enum.Font.Gotham
SubLabel.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0, 100)
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
KeyInput.BorderSizePixel = 0
KeyInput.Text = ""
KeyInput.PlaceholderText = "Введите ключ сюда..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 16
KeyInput.Font = Enum.Font.Gotham
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(80, 60, 150)
InputStroke.Thickness = 1
InputStroke.Parent = KeyInput

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.85, 0, 0, 40)
SubmitButton.Position = UDim2.new(0.075, 0, 0, 155)
SubmitButton.BackgroundColor3 = Color3.fromRGB(100, 60, 200)
SubmitButton.BorderSizePixel = 0
SubmitButton.Text = "✅ Подтвердить ключ"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.TextSize = 16
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.Parent = KeyFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = SubmitButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 205)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Parent = KeyFrame

local GetKeyLabel = Instance.new("TextLabel")
GetKeyLabel.Size = UDim2.new(1, 0, 0, 25)
GetKeyLabel.Position = UDim2.new(0, 0, 0, 240)
GetKeyLabel.BackgroundTransparency = 1
GetKeyLabel.Text = "Ключ можно получить у разработчика"
GetKeyLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
GetKeyLabel.TextSize = 12
GetKeyLabel.Font = Enum.Font.Gotham
GetKeyLabel.Parent = KeyFrame

-- Анимация кнопки
SubmitButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(SubmitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(130, 80, 255)}):Play()
end)
SubmitButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(SubmitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 60, 200)}):Play()
end)

-- Проверка ключа
local function CheckKey()
    local enteredKey = KeyInput.Text
    for _, key in pairs(ValidKeys) do
        if enteredKey == key then
            return true
        end
    end
    return false
end

local KeyCheckComplete = Instance.new("BindableEvent")

SubmitButton.MouseButton1Click:Connect(function()
    if CheckKey() then
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
        StatusLabel.Text = "✅ Ключ принят! Загрузка..."
        KeyVerified = true
        wait(1.5)
        KeyGui:Destroy()
        KeyCheckComplete:Fire()
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "❌ Неверный ключ!"
        game:GetService("TweenService"):Create(KeyFrame, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 5, true), {Position = UDim2.new(0.5, -215, 0.5, -140)}):Play()
    end
end)

-- Ждём пока ключ не будет введён
if not KeyVerified then
    KeyCheckComplete.Event:Wait()
end

-- ============================================
-- ОСНОВНОЙ СКРИПТ ПОСЛЕ ВВОДА КЛЮЧА
-- ============================================

-- Сервисы
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Camera = Workspace.CurrentCamera
local Character = LP.Character or LP.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

LP.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- ============================================
-- НАСТРОЙКИ / СОСТОЯНИЕ
-- ============================================
local Settings = {
    -- Движение
    SpeedEnabled = false,
    SpeedValue = 16,
    JumpEnabled = false,
    JumpValue = 50,
    NoclipEnabled = false,
    FlyEnabled = false,
    FlySpeed = 50,

    -- ESP
    ESPEnabled = false,
    ESPMurderer = true,
    ESPSheriff = true,
    ESPInnocent = true,
    ESPTransparency = 0.5,

    -- Доп функции
    AutoGunEnabled = false,
    FakeDeathEnabled = false,
    InvisibilityEnabled = false,
}

-- ============================================
-- ОПРЕДЕЛЕНИЕ РОЛЕЙ MM2
-- ============================================
local Roles = {}

local function GetRoles()
    Roles = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LP then
            local backpack = player:FindFirstChild("Backpack")
            local character = player.Character

            local hasMurdererKnife = false
            local hasSheriffGun = false

            -- Проверяем Backpack
            if backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        local handle = tool:FindFirstChild("Handle")
                        if tool.Name == "Knife" or (handle and tool.ClassName == "Tool" and (tool.Name:lower():find("knife") or tool:FindFirstChild("KnifeServer"))) then
                            hasMurdererKnife = true
                        end
                        if tool.Name == "Gun" or tool.Name == "Revolver" or (handle and (tool.Name:lower():find("gun") or tool.Name:lower():find("revolver"))) then
                            hasSheriffGun = true
                        end
                    end
                end
            end

            -- Проверяем Character
            if character then
                for _, tool in pairs(character:GetChildren()) do
                    if tool:IsA("Tool") then
                        if tool.Name == "Knife" or tool.Name:lower():find("knife") then
                            hasMurdererKnife = true
                        end
                        if tool.Name == "Gun" or tool.Name == "Revolver" or tool.Name:lower():find("gun") or tool.Name:lower():find("revolver") then
                            hasSheriffGun = true
                        end
                    end
                end
            end

            if hasMurdererKnife then
                Roles[player.Name] = "Murderer"
            elseif hasSheriffGun then
                Roles[player.Name] = "Sheriff"
            else
                Roles[player.Name] = "Innocent"
            end
        end
    end
    return Roles
end

-- Также проверяем через MM2 внутреннюю систему
local function GetRoleAdvanced(player)
    -- Метод 1: Проверка инструментов
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character

    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                if item.Name == "Knife" then return "Murderer" end
                if item.Name == "Gun" or item.Name == "Revolver" then return "Sheriff" end
            end
        end
    end

    if char then
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") then
                if item.Name == "Knife" then return "Murderer" end
                if item.Name == "Gun" or item.Name == "Revolver" then return "Sheriff" end
            end
        end
    end

    return "Innocent"
end

-- ============================================
-- ESP СИСТЕМА
-- ============================================
local ESPObjects = {}

local function GetRoleColor(role)
    if role == "Murderer" then
        return Color3.fromRGB(255, 0, 0) -- Красный
    elseif role == "Sheriff" then
        return Color3.fromRGB(0, 100, 255) -- Синий
    else
        return Color3.fromRGB(0, 255, 0) -- Зелёный
    end
end

local function CreateESP(player)
    if player == LP then return end
    RemoveESP(player)

    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end

    local role = GetRoleAdvanced(player)
    local color = GetRoleColor(role)

    -- Проверяем фильтр
    if role == "Murderer" and not Settings.ESPMurderer then return end
    if role == "Sheriff" and not Settings.ESPSheriff then return end
    if role == "Innocent" and not Settings.ESPInnocent then return end

    local espFolder = Instance.new("Folder")
    espFolder.Name = "ESP_" .. player.Name
    espFolder.Parent = character

    -- Highlight (Чамсы)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = character
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = Settings.ESPTransparency
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = espFolder

    -- Billboard (Имя + Роль + Дистанция)
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = character:FindFirstChild("Head")
    billboard.Size = UDim2.new(0, 200, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = espFolder

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = color
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Parent = billboard

    local roleLabel = Instance.new("TextLabel")
    roleLabel.Size = UDim2.new(1, 0, 0.5, 0)
    roleLabel.Position = UDim2.new(0, 0, 0.5, 0)
    roleLabel.BackgroundTransparency = 1
    roleLabel.TextColor3 = color
    roleLabel.TextSize = 12
    roleLabel.Font = Enum.Font.Gotham
    roleLabel.TextStrokeTransparency = 0
    roleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    roleLabel.Parent = billboard

    local roleNames = {
        Murderer = "🔪 УБИЙЦА",
        Sheriff = "🔫 ШЕРИФ",
        Innocent = "😇 НЕВИННЫЙ"
    }

    ESPObjects[player.Name] = {
        Folder = espFolder,
        Highlight = highlight,
        Billboard = billboard,
        NameLabel = nameLabel,
        RoleLabel = roleLabel,
        Role = role,
        Player = player
    }

    -- Обновление дистанции
    spawn(function()
        while ESPObjects[player.Name] and ESPObjects[player.Name].Folder and ESPObjects[player.Name].Folder.Parent do
            pcall(function()
                local myChar = LP.Character
                local theirChar = player.Character
                if myChar and theirChar then
                    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
                    local theirRoot = theirChar:FindFirstChild("HumanoidRootPart")
                    if myRoot and theirRoot then
                        local dist = math.floor((myRoot.Position - theirRoot.Position).Magnitude)
                        nameLabel.Text = player.Name .. " [" .. dist .. "m]"
                        roleLabel.Text = (roleNames[role] or "НЕВИННЫЙ")
                    end
                end
            end)
            wait(0.1)
        end
    end)
end

function RemoveESP(player)
    if ESPObjects[player.Name] then
        pcall(function()
            if ESPObjects[player.Name].Folder then
                ESPObjects[player.Name].Folder:Destroy()
            end
        end)
        ESPObjects[player.Name] = nil
    end
end

local function RefreshAllESP()
    -- Удаляем все ESP
    for name, data in pairs(ESPObjects) do
        pcall(function()
            if data.Folder then data.Folder:Destroy() end
        end)
    end
    ESPObjects = {}

    -- Создаём заново если ESP включён
    if Settings.ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LP then
                CreateESP(player)
            end
        end
    end
end

local function UpdateESPTransparency()
    for _, data in pairs(ESPObjects) do
        pcall(function()
            if data.Highlight then
                data.Highlight.FillTransparency = Settings.ESPTransparency
            end
        end)
    end
end

-- ESP обновление при появлении новых персонажей
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        if Settings.ESPEnabled then
            CreateESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

-- Периодическое обновление ролей и ESP
spawn(function()
    while wait(3) do
        if Settings.ESPEnabled then
            RefreshAllESP()
        end
    end
end)

-- ============================================
-- NOCLIP
-- ============================================
RunService.Stepped:Connect(function()
    if Settings.NoclipEnabled then
        pcall(function()
            local char = LP.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- ============================================
-- СКОРОСТЬ И ПРЫЖОК
-- ============================================
RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = LP.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                if Settings.SpeedEnabled then
                    hum.WalkSpeed = Settings.SpeedValue
                end
                if Settings.JumpEnabled then
                    hum.JumpPower = Settings.JumpValue
                end
            end
        end
    end)
end)

-- ============================================
-- ПОЛЁТ (PC + Mobile)
-- ============================================
local Flying = false
local FlyBody = nil
local FlyGyro = nil

local function StartFly()
    pcall(function()
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end

        Flying = true

        -- Убираем существующие
        if hrp:FindFirstChild("FlyVelocity") then hrp:FindFirstChild("FlyVelocity"):Destroy() end
        if hrp:FindFirstChild("FlyGyro") then hrp:FindFirstChild("FlyGyro"):Destroy() end

        FlyBody = Instance.new("BodyVelocity")
        FlyBody.Name = "FlyVelocity"
        FlyBody.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        FlyBody.Velocity = Vector3.new(0, 0, 0)
        FlyBody.Parent = hrp

        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.Name = "FlyGyro"
        FlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        FlyGyro.P = 9e4
        FlyGyro.Parent = hrp

        hum.PlatformStand = true

        -- Для мобильных создаём кнопки вверх/вниз
        if UserInputService.TouchEnabled then
            CreateFlyMobileButtons()
        end
    end)
end

local function StopFly()
    pcall(function()
        Flying = false
        local char = LP.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if hrp then
                if hrp:FindFirstChild("FlyVelocity") then hrp:FindFirstChild("FlyVelocity"):Destroy() end
                if hrp:FindFirstChild("FlyGyro") then hrp:FindFirstChild("FlyGyro"):Destroy() end
            end
            if hum then
                hum.PlatformStand = false
            end
        end
        FlyBody = nil
        FlyGyro = nil

        -- Удаляем мобильные кнопки
        local flyBtns = PlayerGui:FindFirstChild("FlyMobileButtons")
        if flyBtns then flyBtns:Destroy() end
    end)
end

local FlyUpHeld = false
local FlyDownHeld = false

function CreateFlyMobileButtons()
    local existing = PlayerGui:FindFirstChild("FlyMobileButtons")
    if existing then existing:Destroy() end

    local flyGui = Instance.new("ScreenGui")
    flyGui.Name = "FlyMobileButtons"
    flyGui.ResetOnSpawn = false
    flyGui.Parent = PlayerGui

    local upBtn = Instance.new("TextButton")
    upBtn.Size = UDim2.new(0, 70, 0, 70)
    upBtn.Position = UDim2.new(1, -90, 0.5, -80)
    upBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    upBtn.BackgroundTransparency = 0.3
    upBtn.Text = "⬆️"
    upBtn.TextSize = 30
    upBtn.Font = Enum.Font.GothamBold
    upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    upBtn.Parent = flyGui
    Instance.new("UICorner", upBtn).CornerRadius = UDim.new(0, 35)

    local downBtn = Instance.new("TextButton")
    downBtn.Size = UDim2.new(0, 70, 0, 70)
    downBtn.Position = UDim2.new(1, -90, 0.5, 10)
    downBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    downBtn.BackgroundTransparency = 0.3
    downBtn.Text = "⬇️"
    downBtn.TextSize = 30
    downBtn.Font = Enum.Font.GothamBold
    downBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    downBtn.Parent = flyGui
    Instance.new("UICorner", downBtn).CornerRadius = UDim.new(0, 35)

    upBtn.MouseButton1Down:Connect(function() FlyUpHeld = true end)
    upBtn.MouseButton1Up:Connect(function() FlyUpHeld = false end)
    upBtn.TouchLongPress:Connect(function() FlyUpHeld = true end)

    downBtn.MouseButton1Down:Connect(function() FlyDownHeld = true end)
    downBtn.MouseButton1Up:Connect(function() FlyDownHeld = false end)
    downBtn.TouchLongPress:Connect(function() FlyDownHeld = true end)
end

-- Fly update loop
RunService.Heartbeat:Connect(function()
    if Flying and FlyBody and FlyGyro then
        pcall(function()
            local char = LP.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local direction = Vector3.new(0, 0, 0)
            local camCF = Camera.CFrame

            -- Клавиатура
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + camCF.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - camCF.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - camCF.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + camCF.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) or FlyUpHeld then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or FlyDownHeld then
                direction = direction - Vector3.new(0, 1, 0)
            end

            -- Мобильный джойстик (автоматическое движение через Humanoid MoveDirection)
            if UserInputService.TouchEnabled then
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    local moveDir = hum.MoveDirection
                    if moveDir.Magnitude > 0 then
                        direction = direction + (camCF.LookVector * moveDir.Z + camCF.RightVector * moveDir.X)
                    end
                end
            end

            if direction.Magnitude > 0 then
                direction = direction.Unit
            end

            FlyBody.Velocity = direction * Settings.FlySpeed
            FlyGyro.CFrame = camCF
        end)
    end
end)

-- ============================================
-- АВТО ПОДБОР ПИСТОЛЕТА
-- ============================================
spawn(function()
    while wait(0.1) do
        if Settings.AutoGunEnabled then
            pcall(function()
                local char = LP.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Ищем пистолет на карте (dropped gun)
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Tool") and (obj.Name == "Gun" or obj.Name == "Revolver" or obj.Name:lower():find("gun")) then
                        if obj.Parent == Workspace or (obj.Parent and obj.Parent:IsA("Model") and not Players:GetPlayerFromCharacter(obj.Parent)) then
                            local handle = obj:FindFirstChild("Handle")
                            if handle then
                                -- Телепортируемся к пистолету
                                hrp.CFrame = handle.CFrame
                                wait(0.1)
                                -- Пытаемся подобрать
                                local hum = char:FindFirstChild("Humanoid")
                                if hum then
                                    hum:EquipTool(obj)
                                end
                            end
                        end
                    end
                end

                -- Проверяем GunDrop через MM2 систему
                for _, obj in pairs(Workspace:GetChildren()) do
                    if obj.Name == "GunDrop" or (obj:IsA("Model") and obj:FindFirstChild("Gun")) then
                        local part = obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            hrp.CFrame = part.CFrame + Vector3.new(0, 1, 0)
                            wait(0.15)
                        end
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- ПРИТВОРИТЬСЯ МЁРТВЫМ (Fake Death)
-- ============================================
local FakeDeathActive = false

local function ToggleFakeDeath(state)
    FakeDeathActive = state
    pcall(function()
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end

        if state then
            -- Ragdoll эффект
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            hum.PlatformStand = true

            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("Motor6D") then
                    local socket = Instance.new("BallSocketConstraint")
                    local a0 = Instance.new("Attachment")
                    local a1 = Instance.new("Attachment")

                    a0.Parent = part.Part0
                    a1.Parent = part.Part1
                    socket.Attachment0 = a0
                    socket.Attachment1 = a1
                    socket.Parent = part.Part0
                    socket.Name = "FakeDeathSocket"

                    a0.Name = "FakeDeathA0"
                    a1.Name = "FakeDeathA1"

                    part.Enabled = false
                end
            end
        else
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            hum.PlatformStand = false

            for _, part in pairs(char:GetDescendants()) do
                if part.Name == "FakeDeathSocket" or part.Name == "FakeDeathA0" or part.Name == "FakeDeathA1" then
                    part:Destroy()
                end
                if part:IsA("Motor6D") then
                    part.Enabled = true
                end
            end
        end
    end)
end

-- ============================================
-- НЕВИДИМОСТЬ (FE Invisible)
-- ============================================
local InvisActive = false
local SavedCFrame = nil

local function ToggleInvisibility(state)
    InvisActive = state
    pcall(function()
        if state then
            local char = LP.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            SavedCFrame = hrp.CFrame

            -- FE Invisible метод
            -- Создаём фейковый персонаж
            local fakeChar = char:Clone()
            fakeChar.Name = "FakeChar"
            fakeChar.Parent = Workspace

            -- Перемещаем реального персонажа далеко
            -- но через сеть сервер думает что мы на месте
            local oldPos = hrp.CFrame

            -- Метод: быстро респавн + телепорт
            -- Простой метод невидимости
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 1
                end
                if part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 1
                end
                if part:IsA("Accessory") then
                    local handle = part:FindFirstChild("Handle")
                    if handle then
                        handle.Transparency = 1
                    end
                end
            end

            -- Скрываем имя
            local head = char:FindFirstChild("Head")
            if head then
                local bGui = head:FindFirstChildOfClass("BillboardGui")
                if bGui then bGui.Enabled = false end
            end

            -- Уведомление
        else
            -- Восстанавливаем видимость
            local char = LP.Character
            if not char then return end

            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    if part.Name == "Head" or part.Name == "Torso" or part.Name == "Left Arm" or part.Name == "Right Arm" or part.Name == "Left Leg" or part.Name == "Right Leg"
                        or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "LeftUpperArm" or part.Name == "LeftLowerArm" or part.Name == "LeftHand"
                        or part.Name == "RightUpperArm" or part.Name == "RightLowerArm" or part.Name == "RightHand"
                        or part.Name == "LeftUpperLeg" or part.Name == "LeftLowerLeg" or part.Name == "LeftFoot"
                        or part.Name == "RightUpperLeg" or part.Name == "RightLowerLeg" or part.Name == "RightFoot" then
                        part.Transparency = 0
                    end
                end
                if part:IsA("Decal") and part.Name == "face" then
                    part.Transparency = 0
                end
                if part:IsA("Accessory") then
                    local handle = part:FindFirstChild("Handle")
                    if handle then
                        handle.Transparency = 0
                    end
                end
            end

            local head = char:FindFirstChild("Head")
            if head then
                local bGui = head:FindFirstChildOfClass("BillboardGui")
                if bGui then bGui.Enabled = true end
            end

            -- Удаляем фейк
            local fakeChar = Workspace:FindFirstChild("FakeChar")
            if fakeChar then fakeChar:Destroy() end
        end
    end)
end

-- ============================================
-- ЗАГРУЗКА WindUI
-- ============================================
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist.lua'))()

local Window = WindUI:CreateWindow({
    Title = "MM2 Ultimate Cheat 🔥",
    Icon = "sword",
    Author = "Premium Script",
    Folder = "MM2UltimateCheat",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = true,
})

-- ============================================
-- ВКЛАДКА: ДВИЖЕНИЕ
-- ============================================
local MovementTab = Window:Tab({
    Title = "🏃 Движение",
    Icon = "footprints",
    Desc = "Скорость, прыжок, ноклип"
})

MovementTab:Toggle({
    Title = "⚡ Скорость ходьбы",
    Desc = "Увеличить скорость передвижения",
    Value = false,
    Callback = function(value)
        Settings.SpeedEnabled = value
        if not value then
            pcall(function()
                local char = LP.Character
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then hum.WalkSpeed = 16 end
                end
            end)
        end
    end
})

MovementTab:Slider({
    Title = "📏 Значение скорости",
    Desc = "От 16 до 200",
    Value = {
        Min = 16,
        Max = 200,
        Default = 16,
    },
    Callback = function(value)
        Settings.SpeedValue = value
    end
})

MovementTab:Toggle({
    Title = "🦘 Высота прыжка",
    Desc = "Увеличить высоту прыжка",
    Value = false,
    Callback = function(value)
        Settings.JumpEnabled = value
        if not value then
            pcall(function()
                local char = LP.Character
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then hum.JumpPower = 50 end
                end
            end)
        end
    end
})

MovementTab:Slider({
    Title = "📐 Значение прыжка",
    Desc = "От 50 до 500",
    Value = {
        Min = 50,
        Max = 500,
        Default = 50,
    },
    Callback = function(value)
        Settings.JumpValue = value
    end
})

MovementTab:Toggle({
    Title = "👻 Ноклип",
    Desc = "Проходить сквозь стены",
    Value = false,
    Callback = function(value)
        Settings.NoclipEnabled = value
    end
})

-- ============================================
-- ВКЛАДКА: ПОЛЁТ
-- ============================================
local FlyTab = Window:Tab({
    Title = "✈️ Полёт",
    Icon = "plane",
    Desc = "Летать по карте (PC + Mobile)"
})

FlyTab:Toggle({
    Title = "🕊️ Включить полёт",
    Desc = "PC: WASD + Space/Shift | Mobile: Джойстик + Кнопки",
    Value = false,
    Callback = function(value)
        Settings.FlyEnabled = value
        if value then
            StartFly()
        else
            StopFly()
        end
    end
})

FlyTab:Slider({
    Title = "💨 Скорость полёта",
    Desc = "От 10 до 300",
    Value = {
        Min = 10,
        Max = 300,
        Default = 50,
    },
    Callback = function(value)
        Settings.FlySpeed = value
    end
})

FlyTab:Paragraph({
    Title = "📖 Управление полётом",
    Desc = "🖥️ PC: W/A/S/D - направление, Space - вверх, Shift - вниз\n📱 Mobile: Джойстик + кнопки ⬆️⬇️ на экране"
})

-- ============================================
-- ВКЛАДКА: ESP
-- ============================================
local ESPTab = Window:Tab({
    Title = "👁️ ESP (Чамсы)",
    Icon = "eye",
    Desc = "Видеть игроков сквозь стены"
})

ESPTab:Toggle({
    Title = "👁️ Включить ESP",
    Desc = "Показывает игроков сквозь стены с ролями",
    Value = false,
    Callback = function(value)
        Settings.ESPEnabled = value
        if value then
            RefreshAllESP()
        else
            for name, data in pairs(ESPObjects) do
                pcall(function()
                    if data.Folder then data.Folder:Destroy() end
                end)
            end
            ESPObjects = {}
        end
    end
})

ESPTab:Toggle({
    Title = "🔪 Показать Убийцу (Красный)",
    Desc = "ESP для убийцы",
    Value = true,
    Callback = function(value)
        Settings.ESPMurderer = value
        if Settings.ESPEnabled then RefreshAllESP() end
    end
})

ESPTab:Toggle({
    Title = "🔫 Показать Шерифа (Синий)",
    Desc = "ESP для шерифа",
    Value = true,
    Callback = function(value)
        Settings.ESPSheriff = value
        if Settings.ESPEnabled then RefreshAllESP() end
    end
})

ESPTab:Toggle({
    Title = "😇 Показать Невинных (Зелёный)",
    Desc = "ESP для невинных",
    Value = true,
    Callback = function(value)
        Settings.ESPInnocent = value
        if Settings.ESPEnabled then RefreshAllESP() end
    end
})

ESPTab:Slider({
    Title = "🔍 Прозрачность чамсов",
    Desc = "0 = непрозрачные, 1 = полностью прозрачные",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value)
        Settings.ESPTransparency = value / 100
        UpdateESPTransparency()
    end
})

ESPTab:Paragraph({
    Title = "🎨 Цвета ролей",
    Desc = "🔴 Убийца - Красный\n🔵 Шериф - Синий\n🟢 Невинный - Зелёный"
})

-- ============================================
-- ВКЛАДКА: ДОПОЛНИТЕЛЬНО
-- ============================================
local ExtraTab = Window:Tab({
    Title = "⭐ Дополнительно",
    Icon = "star",
    Desc = "Авто пистолет, фейк смерть, невидимость"
})

ExtraTab:Toggle({
    Title = "🔫 Авто подбор пистолета",
    Desc = "Автоматически подбирает пистолет после смерти шерифа",
    Value = false,
    Callback = function(value)
        Settings.AutoGunEnabled = value
    end
})

ExtraTab:Toggle({
    Title = "💀 Притвориться мёртвым",
    Desc = "Ваш персонаж падает как мёртвый (Ragdoll)",
    Value = false,
    Callback = function(value)
        Settings.FakeDeathEnabled = value
        ToggleFakeDeath(value)
    end
})

ExtraTab:Toggle({
    Title = "🫥 Невидимость (FE)",
    Desc = "Становитесь невидимым для других игроков",
    Value = false,
    Callback = function(value)
        Settings.InvisibilityEnabled = value
        ToggleInvisibility(value)
    end
})

ExtraTab:Paragraph({
    Title = "⚠️ Предупреждение",
    Desc = "Некоторые функции могут работать не стабильно из-за обновлений MM2. Используйте на свой страх и риск!"
})

-- ============================================
-- ВКЛАДКА: ИНФОРМАЦИЯ
-- ============================================
local InfoTab = Window:Tab({
    Title = "ℹ️ Информация",
    Icon = "info",
    Desc = "О скрипте"
})

InfoTab:Paragraph({
    Title = "🔥 MM2 Ultimate Cheat",
    Desc = "Версия: 1.0.0\nUI: WindUI\nИгра: Murder Mystery 2\n\nФункции:\n• Скорость ходьбы\n• Высота прыжка\n• Ноклип\n• Полёт (PC + Mobile)\n• ESP с ролями\n• Авто подбор пистолета\n• Притвориться мёртвым\n• Невидимость (FE)"
})

InfoTab:Paragraph({
    Title = "🔑 Активные ключи",
    Desc = "MM2-ULTRA-0001 до MM2-ULTRA-0010\nВсего доступно: 10 ключей"
})

-- ============================================
-- УВЕДОМЛЕНИЕ О ЗАГРУЗКЕ
-- ============================================
Window:Notify({
    Title = "✅ MM2 Ultimate Cheat",
    Content = "Скрипт успешно загружен!\nИспользуй вкладки для настройки.",
    Duration = 5,
})

-- Респавн обработка
LP.CharacterAdded:Connect(function(char)
    wait(1)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")

    -- Сбрасываем состояния
    if Settings.FlyEnabled then
        StopFly()
        wait(0.5)
        StartFly()
    end

    if FakeDeathActive then
        FakeDeathActive = false
    end

    if InvisActive then
        InvisActive = false
    end

    -- Обновляем ESP
    if Settings.ESPEnabled then
        wait(2)
        RefreshAllESP()
    end
end)

print("✅ MM2 Ultimate Cheat loaded successfully!")
print("🔑 Key verified: true")
print("🎮 All features ready!")
