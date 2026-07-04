--[[
    ╔══════════════════════════════════════════════╗
    ║          MM2 ELITE HUB v2.0                  ║
    ║     WindUI | PC & Mobile Optimized           ║
    ╚══════════════════════════════════════════════╝
]]

------------------------------------------------------------
-- СЕРВИСЫ
------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

------------------------------------------------------------
-- ЗАГРУЗКА WINDUI
------------------------------------------------------------
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

------------------------------------------------------------
-- СОСТОЯНИЕ СКРИПТА (Центральная таблица)
------------------------------------------------------------
local State = {
    -- Combat Main
    AutoKillMurderer = false,
    AutoGrabGun = false,
    KillAura = false,
    KillAuraRadius = 15,

    -- Combat Settings
    SilentAim = false,
    TargetPart = "HumanoidRootPart",
    WallCheck = true,

    -- Visuals
    PlayerESP = false,
    ESPFillTransparency = 0.5,
    GunESP = false,

    -- Movement
    SpeedEnabled = false,
    SpeedValue = 16,
    JumpEnabled = false,
    JumpValue = 50,
    InfiniteJump = false,
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    AutoEvade = false,
    AutoEvadeDistance = 18,

    -- Misc
    FakeDead = false,
    FakeDeadPose = "На живот",
    FEInvisible = false,
}

------------------------------------------------------------
-- УТИЛИТЫ
------------------------------------------------------------
local Connections = {} -- Все RBXScriptConnection для очистки

local function AddConnection(conn)
    table.insert(Connections, conn)
    return conn
end

local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

------------------------------------------------------------
-- ОПРЕДЕЛЕНИЕ РОЛЕЙ MM2
------------------------------------------------------------
-- MM2 хранит оружие в Backpack / Character
-- Нож (Knife) = Убийца, Пистолет (Gun/Revolver) = Шериф

local function GetPlayerRole(player)
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    
    -- Проверка в руках (Character)
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                local handle = tool:FindFirstChild("Handle")
                -- Проверяем по имени и по наличию Mesh/конфигурации
                if tool.Name == "Knife" or tool:FindFirstChild("KnifeServer") 
                   or tool:FindFirstChild("Stab") then
                    return "Murderer"
                end
                if tool.Name == "Gun" or tool.Name == "Revolver" 
                   or tool:FindFirstChild("GunServer") or tool:FindFirstChild("Shoot") then
                    return "Sheriff"
                end
            end
        end
    end
    
    -- Проверка в инвентаре (Backpack)
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                if tool.Name == "Knife" or tool:FindFirstChild("KnifeServer") 
                   or tool:FindFirstChild("Stab") then
                    return "Murderer"
                end
                if tool.Name == "Gun" or tool.Name == "Revolver" 
                   or tool:FindFirstChild("GunServer") or tool:FindFirstChild("Shoot") then
                    return "Sheriff"
                end
            end
        end
    end
    
    return "Innocent"
end

local function GetLocalRole()
    return GetPlayerRole(LocalPlayer)
end

local function FindMurderer()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and GetPlayerRole(player) == "Murderer" then
            return player
        end
    end
    return nil
end

local function FindSheriff()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and GetPlayerRole(player) == "Sheriff" then
            return player
        end
    end
    return nil
end

-- Получить оружие (Gun) из инвентаря LocalPlayer
local function GetGunTool()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = GetCharacter()
    
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name == "Gun" or tool.Name == "Revolver" 
               or tool:FindFirstChild("GunServer") or tool:FindFirstChild("Shoot")) then
                return tool, true -- tool, уже экипирован
            end
        end
    end
    
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name == "Gun" or tool.Name == "Revolver" 
               or tool:FindFirstChild("GunServer") or tool:FindFirstChild("Shoot")) then
                return tool, false -- tool, не экипирован
            end
        end
    end
    
    return nil, false
end

-- Получить нож из инвентаря
local function GetKnifeTool()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = GetCharacter()
    
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name == "Knife" or tool:FindFirstChild("KnifeServer") 
               or tool:FindFirstChild("Stab")) then
                return tool, true
            end
        end
    end
    
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name == "Knife" or tool:FindFirstChild("KnifeServer") 
               or tool:FindFirstChild("Stab")) then
                return tool, false
            end
        end
    end
    
    return nil, false
end

------------------------------------------------------------
-- RAYCAST ПРОВЕРКА СТЕН
------------------------------------------------------------
local function IsVisible(fromPos, toPos)
    local direction = (toPos - fromPos)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {GetCharacter(), Camera}
    
    local result = Workspace:Raycast(fromPos, direction, rayParams)
    
    if result then
        -- Если луч попал в персонажа цели — видимый
        local hitPart = result.Instance
        local hitModel = hitPart:FindFirstAncestorOfClass("Model")
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character == hitModel then
                return true
            end
        end
        return false
    end
    
    return true -- Ничего не заблокировало
end

------------------------------------------------------------
-- СОЗДАНИЕ ОКНА WINDUI
------------------------------------------------------------
local Window = WindUI:CreateWindow({
    Title = "MM2 Elite Hub",
    Icon = "rbxassetid://18220853753",
    Author = "Elite Dev",
    Folder = "MM2EliteHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

-- Стартовое уведомление
WindUI:Notify({
    Title = "MM2 Elite Hub",
    Content = "✅ Хаб успешно загружен!\n🎯 Все модули готовы к работе.\n📱 Платформа: " .. (IsMobile() and "Мобильное" or "ПК"),
    Duration = 5,
})

------------------------------------------------------------
-- ВКЛАДКА 1: COMBAT (MAIN)
------------------------------------------------------------
local CombatTab = Window:Tab({
    Title = "Combat (Main)",
    Icon = "swords",
})

-- === FULL AUTO-KILL MURDERER ===
CombatTab:Toggle({
    Title = "Full Auto-Kill Murderer",
    Description = "Автоматический выстрел в убийцу при линии видимости",
    Default = false,
    Callback = function(value)
        State.AutoKillMurderer = value
    end,
})

task.spawn(function()
    while task.wait(0.1) do
        if State.AutoKillMurderer then
            pcall(function()
                local myRole = GetLocalRole()
                -- Работает только если мы Шериф или подобрали пистолет
                if myRole == "Sheriff" or myRole == "Innocent" then
                    local gunTool, equipped = GetGunTool()
                    if gunTool then
                        local murderer = FindMurderer()
                        if murderer and murderer.Character then
                            local murdererRoot = murderer.Character:FindFirstChild("HumanoidRootPart")
                            local murdererHum = murderer.Character:FindFirstChildOfClass("Humanoid")
                            local myRoot = GetRootPart()
                            
                            if murdererRoot and murdererHum and murdererHum.Health > 0 and myRoot then
                                local targetPart = murderer.Character:FindFirstChild(State.TargetPart) or murdererRoot
                                
                                -- Проверка видимости
                                local canShoot = true
                                if State.WallCheck then
                                    canShoot = IsVisible(myRoot.Position, targetPart.Position)
                                end
                                
                                if canShoot then
                                    -- Экипировать оружие если не в руках
                                    if not equipped then
                                        local humanoid = GetHumanoid()
                                        if humanoid then
                                            humanoid:EquipTool(gunTool)
                                            task.wait(0.1)
                                        end
                                    end
                                    
                                    -- Стрельба через Remote
                                    -- MM2 использует RemoteEvent для стрельбы
                                    local char = GetCharacter()
                                    local tool = char and char:FindFirstChildWhichIsA("Tool")
                                    if tool then
                                        -- Ищем Remote в инструменте
                                        local remote = tool:FindFirstChild("GunEvent") 
                                            or tool:FindFirstChild("RemoteEvent")
                                            or tool:FindFirstChildOfClass("RemoteEvent")
                                        
                                        if remote then
                                            remote:FireServer(targetPart.Position)
                                        else
                                            -- Альтернативный способ — активация через Tool
                                            -- Направляем мышь на цель
                                            local shootFunc = tool:FindFirstChild("Shoot") 
                                                or tool:FindFirstChildOfClass("RemoteFunction")
                                            if shootFunc then
                                                pcall(function()
                                                    shootFunc:InvokeServer(targetPart.Position)
                                                end)
                                            else
                                                -- Последний способ — firesignal/mouse1click
                                                tool:Activate()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- === AUTO-GRAB GUN ===
CombatTab:Toggle({
    Title = "Auto-Grab Gun",
    Description = "Автоматически подбирает выпавший пистолет",
    Default = false,
    Callback = function(value)
        State.AutoGrabGun = value
    end,
})

task.spawn(function()
    while task.wait(0.2) do
        if State.AutoGrabGun then
            pcall(function()
                local root = GetRootPart()
                if not root then return end
                
                -- Ищем GunDrop в workspace
                local gunDrop = Workspace:FindFirstChild("GunDrop")
                if not gunDrop then
                    -- Альтернативный поиск
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name == "GunDrop" or (obj:IsA("Tool") and 
                           (obj.Name == "Gun" or obj.Name == "Revolver")) then
                            gunDrop = obj
                            break
                        end
                    end
                end
                
                if gunDrop then
                    local handle = gunDrop:FindFirstChild("Handle") or gunDrop:FindFirstChildWhichIsA("BasePart")
                    if handle then
                        -- Телепорт к пистолету
                        root.CFrame = handle.CFrame * CFrame.new(0, 2, 0)
                        task.wait(0.15)
                        
                        -- Попытка поднять (TouchInterest / ProximityPrompt)
                        local touchInterest = handle:FindFirstChildOfClass("TouchInterest")
                        if touchInterest then
                            firetouchinterest(root, handle, 0)
                            task.wait()
                            firetouchinterest(root, handle, 1)
                        end
                    end
                end
            end)
        end
    end
end)

-- === KILL AURA ===
CombatTab:Toggle({
    Title = "Kill Aura (Убийца)",
    Description = "Автоматически убивает игроков в радиусе",
    Default = false,
    Callback = function(value)
        State.KillAura = value
    end,
})

CombatTab:Slider({
    Title = "Kill Aura Radius",
    Description = "Радиус действия Kill Aura",
    Value = {
        Min = 5,
        Max = 40,
        Default = 15,
    },
    Callback = function(value)
        State.KillAuraRadius = value
    end,
})

task.spawn(function()
    while task.wait(0.15) do
        if State.KillAura then
            pcall(function()
                local myRole = GetLocalRole()
                if myRole ~= "Murderer" then return end
                
                local root = GetRootPart()
                if not root then return end
                
                -- Экипировать нож
                local knife, equipped = GetKnifeTool()
                if knife and not equipped then
                    local humanoid = GetHumanoid()
                    if humanoid then
                        humanoid:EquipTool(knife)
                        task.wait(0.1)
                    end
                end
                
                -- Найти ближайших игроков
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        local targetHum = player.Character:FindFirstChildOfClass("Humanoid")
                        
                        if targetRoot and targetHum and targetHum.Health > 0 then
                            local distance = (root.Position - targetRoot.Position).Magnitude
                            
                            if distance <= State.KillAuraRadius then
                                -- Активировать нож на цели
                                local char = GetCharacter()
                                local tool = char and char:FindFirstChildWhichIsA("Tool")
                                if tool then
                                    local remote = tool:FindFirstChild("KnifeEvent")
                                        or tool:FindFirstChild("RemoteEvent")
                                        or tool:FindFirstChildOfClass("RemoteEvent")
                                    
                                    if remote then
                                        remote:FireServer(targetRoot.Position)
                                    else
                                        -- Телепорт к жертве + активация
                                        local origCFrame = root.CFrame
                                        root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -2)
                                        tool:Activate()
                                        task.wait(0.05)
                                        root.CFrame = origCFrame
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

------------------------------------------------------------
-- ВКЛАДКА 2: COMBAT (SETTINGS)
------------------------------------------------------------
local CombatSettingsTab = Window:Tab({
    Title = "Combat (Settings)",
    Icon = "settings",
})

-- === SILENT AIM ===
CombatSettingsTab:Toggle({
    Title = "Silent Aim",
    Description = "Пули автоматически перенаправляются в убийцу",
    Default = false,
    Callback = function(value)
        State.SilentAim = value
    end,
})

-- === TARGET PART ===
CombatSettingsTab:Dropdown({
    Title = "Target Part",
    Description = "Часть тела, куда летит пуля",
    Values = {"HumanoidRootPart", "Head"},
    Value = "HumanoidRootPart",
    Callback = function(value)
        State.TargetPart = value
    end,
})

-- === WALL CHECK ===
CombatSettingsTab:Toggle({
    Title = "Wall Check",
    Description = "Проверка стен (Raycast) перед выстрелом",
    Default = true,
    Callback = function(value)
        State.WallCheck = value
    end,
})

-- Silent Aim Hook — Перехват RemoteEvent
task.spawn(function()
    -- Hookим namecall для перенаправления позиции выстрела
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        if State.SilentAim and (method == "FireServer" or method == "InvokeServer") then
            -- Проверяем что это событие стрельбы из пистолета
            if self:IsA("RemoteEvent") or self:IsA("RemoteFunction") then
                local parent = self.Parent
                if parent and parent:IsA("Tool") then
                    local toolName = parent.Name:lower()
                    if toolName == "gun" or toolName == "revolver" or 
                       parent:FindFirstChild("GunServer") or parent:FindFirstChild("Shoot") then
                        
                        local murderer = FindMurderer()
                        if murderer and murderer.Character then
                            local targetPartObj = murderer.Character:FindFirstChild(State.TargetPart) 
                                or murderer.Character:FindFirstChild("HumanoidRootPart")
                            
                            if targetPartObj then
                                local myRoot = GetRootPart()
                                local canShoot = true
                                
                                if State.WallCheck and myRoot then
                                    canShoot = IsVisible(myRoot.Position, targetPartObj.Position)
                                end
                                
                                if canShoot then
                                    -- Заменяем позицию выстрела на позицию убийцы
                                    local newArgs = {}
                                    for i, arg in pairs(args) do
                                        if typeof(arg) == "Vector3" then
                                            newArgs[i] = targetPartObj.Position
                                        elseif typeof(arg) == "CFrame" then
                                            newArgs[i] = targetPartObj.CFrame
                                        else
                                            newArgs[i] = arg
                                        end
                                    end
                                    return oldNamecall(self, unpack(newArgs))
                                end
                            end
                        end
                    end
                end
            end
        end
        
        return oldNamecall(self, ...)
    end))
end)

------------------------------------------------------------
-- ВКЛАДКА 3: VISUALS
------------------------------------------------------------
local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye",
})

-- Хранилище ESP объектов
local ESPHighlights = {}
local GunESPHighlight = nil

-- === PLAYER ESP ===
VisualsTab:Toggle({
    Title = "Player ESP",
    Description = "Цветная подсветка игроков по ролям",
    Default = false,
    Callback = function(value)
        State.PlayerESP = value
        if not value then
            -- Удаляем все Highlight
            for player, highlight in pairs(ESPHighlights) do
                if highlight and highlight.Parent then
                    highlight:Destroy()
                end
            end
            ESPHighlights = {}
        end
    end,
})

VisualsTab:Slider({
    Title = "ESP Fill Transparency",
    Description = "Прозрачность заливки ESP",
    Value = {
        Min = 0,
        Max = 1,
        Default = 0.5,
    },
    Callback = function(value)
        State.ESPFillTransparency = value
        -- Обновляем все существующие highlight
        for _, highlight in pairs(ESPHighlights) do
            if highlight and highlight.Parent then
                highlight.FillTransparency = value
            end
        end
    end,
})

-- Функция создания/обновления ESP для игрока
local function UpdatePlayerESP(player)
    if player == LocalPlayer then return end
    if not State.PlayerESP then return end
    
    local char = player.Character
    if not char then
        -- Удаляем старый highlight если персонажа нет
        if ESPHighlights[player] and ESPHighlights[player].Parent then
            ESPHighlights[player]:Destroy()
        end
        ESPHighlights[player] = nil
        return
    end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        -- Не удаляем — оставляем для мертвых тоже (чтобы видеть трупы)
    end
    
    local role = GetPlayerRole(player)
    local color
    if role == "Murderer" then
        color = Color3.fromRGB(255, 0, 0) -- Красный
    elseif role == "Sheriff" then
        color = Color3.fromRGB(0, 100, 255) -- Синий
    else
        color = Color3.fromRGB(0, 255, 0) -- Зелёный
    end
    
    -- Создаём или обновляем Highlight
    local highlight = ESPHighlights[player]
    if not highlight or not highlight.Parent then
        highlight = Instance.new("Highlight")
        highlight.Name = "MM2ESP_" .. player.Name
        highlight.Adornee = char
        highlight.Parent = char
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        ESPHighlights[player] = highlight
    end
    
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = State.ESPFillTransparency
    highlight.OutlineTransparency = 0.1
    highlight.Adornee = char
end

-- Незатухающий ESP цикл
task.spawn(function()
    while task.wait(0.5) do
        if State.PlayerESP then
            for _, player in pairs(Players:GetPlayers()) do
                pcall(function()
                    UpdatePlayerESP(player)
                end)
            end
        end
    end
end)

-- Подключаем новых игроков
AddConnection(Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if State.PlayerESP then
            pcall(function()
                UpdatePlayerESP(player)
            end)
        end
    end)
end))

-- Подключаем CharacterAdded для существующих игроков
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            if State.PlayerESP then
                pcall(function()
                    UpdatePlayerESP(player)
                end)
            end
        end)
    end
end

AddConnection(Players.PlayerRemoving:Connect(function(player)
    if ESPHighlights[player] then
        if ESPHighlights[player].Parent then
            ESPHighlights[player]:Destroy()
        end
        ESPHighlights[player] = nil
    end
end))

-- === GUN ESP ===
VisualsTab:Toggle({
    Title = "Gun ESP",
    Description = "Золотая подсветка выпавшего пистолета",
    Default = false,
    Callback = function(value)
        State.GunESP = value
        if not value and GunESPHighlight then
            GunESPHighlight:Destroy()
            GunESPHighlight = nil
        end
    end,
})

task.spawn(function()
    while task.wait(0.5) do
        if State.GunESP then
            pcall(function()
                local gunDrop = Workspace:FindFirstChild("GunDrop")
                if not gunDrop then
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name == "GunDrop" then
                            gunDrop = obj
                            break
                        end
                    end
                end
                
                if gunDrop then
                    if not GunESPHighlight or GunESPHighlight.Parent ~= gunDrop then
                        if GunESPHighlight then
                            GunESPHighlight:Destroy()
                        end
                        GunESPHighlight = Instance.new("Highlight")
                        GunESPHighlight.Name = "GunESP"
                        GunESPHighlight.FillColor = Color3.fromRGB(255, 215, 0)
                        GunESPHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                        GunESPHighlight.FillTransparency = 0.3
                        GunESPHighlight.OutlineTransparency = 0
                        GunESPHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        GunESPHighlight.Adornee = gunDrop
                        GunESPHighlight.Parent = gunDrop
                    end
                else
                    if GunESPHighlight then
                        GunESPHighlight:Destroy()
                        GunESPHighlight = nil
                    end
                end
            end)
        end
    end
end)

------------------------------------------------------------
-- ВКЛАДКА 4: MOVEMENT
------------------------------------------------------------
local MovementTab = Window:Tab({
    Title = "Movement",
    Icon = "footprints",
})

-- === SPEED ===
MovementTab:Toggle({
    Title = "Speed Hack",
    Description = "Изменение скорости передвижения",
    Default = false,
    Callback = function(value)
        State.SpeedEnabled = value
    end,
})

MovementTab:Slider({
    Title = "Walk Speed",
    Value = {
        Min = 16,
        Max = 150,
        Default = 16,
    },
    Callback = function(value)
        State.SpeedValue = value
    end,
})

-- Speed в RenderStepped для обхода проверок
AddConnection(RunService.RenderStepped:Connect(function()
    if State.SpeedEnabled then
        pcall(function()
            local humanoid = GetHumanoid()
            if humanoid then
                humanoid.WalkSpeed = State.SpeedValue
            end
        end)
    end
end))

-- === JUMP POWER ===
MovementTab:Toggle({
    Title = "Jump Power",
    Description = "Изменение силы прыжка",
    Default = false,
    Callback = function(value)
        State.JumpEnabled = value
    end,
})

MovementTab:Slider({
    Title = "Jump Height",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        State.JumpValue = value
    end,
})

AddConnection(RunService.RenderStepped:Connect(function()
    if State.JumpEnabled then
        pcall(function()
            local humanoid = GetHumanoid()
            if humanoid then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = State.JumpValue
            end
        end)
    end
end))

-- === INFINITE JUMP ===
MovementTab:Toggle({
    Title = "Infinite Jump",
    Description = "Бесконечные прыжки в воздухе",
    Default = false,
    Callback = function(value)
        State.InfiniteJump = value
    end,
})

AddConnection(UserInputService.JumpRequest:Connect(function()
    if State.InfiniteJump then
        pcall(function()
            local humanoid = GetHumanoid()
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end))

-- === NOCLIP ===
MovementTab:Toggle({
    Title = "Noclip",
    Description = "Проход сквозь стены",
    Default = false,
    Callback = function(value)
        State.Noclip = value
    end,
})

AddConnection(RunService.Stepped:Connect(function()
    if State.Noclip then
        pcall(function()
            local char = GetCharacter()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end))

-- === FLY ===
local FlyBodyVelocity = nil
local FlyBodyGyro = nil
local FlyMobileGui = nil

local function StartFly()
    local root = GetRootPart()
    local humanoid = GetHumanoid()
    if not root or not humanoid then return end
    
    -- Создаём BodyVelocity для полёта
    FlyBodyVelocity = Instance.new("BodyVelocity")
    FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    FlyBodyVelocity.Parent = root
    
    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyGyro.D = 200
    FlyBodyGyro.P = 10000
    FlyBodyGyro.Parent = root
    
    -- Мобильный джойстик для полёта
    if IsMobile() then
        FlyMobileGui = Instance.new("ScreenGui")
        FlyMobileGui.Name = "FlyJoystick"
        FlyMobileGui.ResetOnSpawn = false
        FlyMobileGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        
        -- Кнопка ВВЕРХ
        local upBtn = Instance.new("TextButton")
        upBtn.Name = "FlyUp"
        upBtn.Size = UDim2.fromOffset(70, 70)
        upBtn.Position = UDim2.new(1, -90, 0.5, -100)
        upBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        upBtn.BackgroundTransparency = 0.3
        upBtn.Text = "▲"
        upBtn.TextColor3 = Color3.new(1, 1, 1)
        upBtn.TextSize = 28
        upBtn.Font = Enum.Font.GothamBold
        upBtn.Parent = FlyMobileGui
        
        local upCorner = Instance.new("UICorner")
        upCorner.CornerRadius = UDim.new(0, 35)
        upCorner.Parent = upBtn
        
        local flyUpHeld = false
        upBtn.MouseButton1Down:Connect(function() flyUpHeld = true end)
        upBtn.MouseButton1Up:Connect(function() flyUpHeld = false end)
        upBtn.TouchLongPress:Connect(function() flyUpHeld = true end)
        
        -- Кнопка ВНИЗ
        local downBtn = Instance.new("TextButton")
        downBtn.Name = "FlyDown"
        downBtn.Size = UDim2.fromOffset(70, 70)
        downBtn.Position = UDim2.new(1, -90, 0.5, 10)
        downBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        downBtn.BackgroundTransparency = 0.3
        downBtn.Text = "▼"
        downBtn.TextColor3 = Color3.new(1, 1, 1)
        downBtn.TextSize = 28
        downBtn.Font = Enum.Font.GothamBold
        downBtn.Parent = FlyMobileGui
        
        local downCorner = Instance.new("UICorner")
        downCorner.CornerRadius = UDim.new(0, 35)
        downCorner.Parent = downBtn
        
        local flyDownHeld = false
        downBtn.MouseButton1Down:Connect(function() flyDownHeld = true end)
        downBtn.MouseButton1Up:Connect(function() flyDownHeld = false end)
        
        -- Мобильный fly loop
        local flyConn
        flyConn = RunService.RenderStepped:Connect(function()
            if not State.Fly then
                flyConn:Disconnect()
                return
            end
            
            pcall(function()
                local r = GetRootPart()
                if not r or not FlyBodyVelocity or not FlyBodyVelocity.Parent then return end
                
                local camCF = Camera.CFrame
                local moveDir = humanoid.MoveDirection
                local vel = Vector3.new(0, 0, 0)
                
                if moveDir.Magnitude > 0 then
                    vel = vel + (camCF.LookVector * moveDir.Z + camCF.RightVector * moveDir.X).Unit * State.FlySpeed
                end
                
                if flyUpHeld then
                    vel = vel + Vector3.new(0, State.FlySpeed, 0)
                end
                if flyDownHeld then
                    vel = vel - Vector3.new(0, State.FlySpeed, 0)
                end
                
                FlyBodyVelocity.Velocity = vel
                FlyBodyGyro.CFrame = camCF
            end)
        end)
        
        AddConnection(flyConn)
    end
end

local function StopFly()
    if FlyBodyVelocity then
        FlyBodyVelocity:Destroy()
        FlyBodyVelocity = nil
    end
    if FlyBodyGyro then
        FlyBodyGyro:Destroy()
        FlyBodyGyro = nil
    end
    if FlyMobileGui then
        FlyMobileGui:Destroy()
        FlyMobileGui = nil
    end
end

MovementTab:Toggle({
    Title = "Fly",
    Description = "Полёт (ПК: WASD+E/Q | Мобильное: джойстик + кнопки)",
    Default = false,
    Callback = function(value)
        State.Fly = value
        if value then
            StartFly()
        else
            StopFly()
        end
    end,
})

MovementTab:Slider({
    Title = "Fly Speed",
    Value = {
        Min = 10,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        State.FlySpeed = value
    end,
})

-- ПК: Fly контроль (E вверх, Q вниз)
if not IsMobile() then
    local flyUpHeld = false
    local flyDownHeld = false
    
    AddConnection(UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.E then
            flyUpHeld = true
        elseif input.KeyCode == Enum.KeyCode.Q then
            flyDownHeld = true
        end
    end))
    
    AddConnection(UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.E then
            flyUpHeld = false
        elseif input.KeyCode == Enum.KeyCode.Q then
            flyDownHeld = false
        end
    end))
    
    AddConnection(RunService.RenderStepped:Connect(function()
        if State.Fly and FlyBodyVelocity and FlyBodyVelocity.Parent then
            pcall(function()
                local root = GetRootPart()
                local humanoid = GetHumanoid()
                if not root or not humanoid then return end
                
                local camCF = Camera.CFrame
                local moveDir = humanoid.MoveDirection
                local vel = Vector3.new(0, 0, 0)
                
                -- Горизонтальное движение по направлению камеры
                if moveDir.Magnitude > 0 then
                    vel = moveDir * State.FlySpeed
                end
                
                -- Вверх/Вниз
                if flyUpHeld then
                    vel = vel + Vector3.new(0, State.FlySpeed, 0)
                end
                if flyDownHeld then
                    vel = vel - Vector3.new(0, State.FlySpeed, 0)
                end
                
                FlyBodyVelocity.Velocity = vel
                FlyBodyGyro.CFrame = camCF
            end)
        end
    end))
end

-- === AUTO-EVADE MURDERER ===
MovementTab:Toggle({
    Title = "Auto-Evade Murderer",
    Description = "Автоматическое убегание от убийцы с обнажённым ножом",
    Default = false,
    Callback = function(value)
        State.AutoEvade = value
    end,
})

MovementTab:Slider({
    Title = "Evade Distance",
    Description = "Дистанция срабатывания",
    Value = {
        Min = 8,
        Max = 40,
        Default = 18,
    },
    Callback = function(value)
        State.AutoEvadeDistance = value
    end,
})

task.spawn(function()
    while task.wait(0.1) do
        if State.AutoEvade then
            pcall(function()
                local myRole = GetLocalRole()
                if myRole == "Murderer" then return end -- Не убегаем от себя
                
                local root = GetRootPart()
                if not root then return end
                
                local murderer = FindMurderer()
                if not murderer or not murderer.Character then return end
                
                local murdererRoot = murderer.Character:FindFirstChild("HumanoidRootPart")
                if not murdererRoot then return end
                
                -- Проверяем, обнажён ли нож у убийцы (в руках)
                local knifeInHand = false
                for _, tool in pairs(murderer.Character:GetChildren()) do
                    if tool:IsA("Tool") and (tool.Name == "Knife" or tool:FindFirstChild("Stab")) then
                        knifeInHand = true
                        break
                    end
                end
                
                if not knifeInHand then return end
                
                local distance = (root.Position - murdererRoot.Position).Magnitude
                
                if distance <= State.AutoEvadeDistance then
                    -- Направление ОТ убийцы
                    local direction = (root.Position - murdererRoot.Position).Unit
                    local escapeDistance = State.AutoEvadeDistance - distance + 10
                    
                    -- Плавный телепорт в противоположную сторону
                    local newPos = root.Position + direction * math.min(escapeDistance, 15)
                    
                    -- Проверяем что новая позиция не внутри стены
                    local rayResult = Workspace:Raycast(root.Position, direction * escapeDistance)
                    if rayResult then
                        newPos = rayResult.Position - direction * 3
                    end
                    
                    root.CFrame = CFrame.new(newPos.X, root.Position.Y, newPos.Z)
                end
            end)
        end
    end
end)

------------------------------------------------------------
-- ВКЛАДКА 5: MISC
------------------------------------------------------------
local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "puzzle",
})

-- === FAKE DEAD ===
MiscTab:Dropdown({
    Title = "Fake Dead Pose",
    Description = "Выбор позы притворной смерти",
    Values = {"На живот", "На спину / хребет"},
    Value = "На живот",
    Callback = function(value)
        State.FakeDeadPose = value
    end,
})

MiscTab:Toggle({
    Title = "Fake Dead",
    Description = "Притвориться мёртвым",
    Default = false,
    Callback = function(value)
        State.FakeDead = value
        
        pcall(function()
            local char = GetCharacter()
            local humanoid = GetHumanoid()
            local root = GetRootPart()
            
            if not char or not humanoid or not root then return end
            
            if value then
                humanoid.PlatformStand = true
                
                task.spawn(function()
                    while State.FakeDead do
                        pcall(function()
                            local r = GetRootPart()
                            local h = GetHumanoid()
                            if r and h then
                                h.PlatformStand = true
                                
                                if State.FakeDeadPose == "На живот" then
                                    -- Лицом вниз
                                    r.CFrame = CFrame.new(r.Position) * 
                                        CFrame.Angles(math.rad(90), 0, 0)
                                else
                                    -- На спину (лицом вверх)
                                    r.CFrame = CFrame.new(r.Position) * 
                                        CFrame.Angles(math.rad(-90), 0, 0)
                                end
                            end
                        end)
                        task.wait(0.05)
                    end
                end)
            else
                humanoid.PlatformStand = false
                -- Возвращаем нормальную ориентацию
                root.CFrame = CFrame.new(root.Position)
            end
        end)
    end,
})

-- === FE INVISIBILITY ===
MiscTab:Toggle({
    Title = "FE Invisibility",
    Description = "Локальная невидимость (смещение хитбокса)",
    Default = false,
    Callback = function(value)
        State.FEInvisible = value
        
        pcall(function()
            local char = GetCharacter()
            if not char then return end
            
            if value then
                -- Метод: Смещаем все визуальные части далеко, сохраняя хитбокс
                -- Создаём фейковый персонаж
                task.spawn(function()
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if not root then return end
                    
                    -- Сохраняем оригинальные свойства
                    local originalTransparencies = {}
                    
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            originalTransparencies[part] = part.LocalTransparencyModifier
                            part.LocalTransparencyModifier = 1
                        elseif part:IsA("Decal") or part:IsA("Texture") then
                            originalTransparencies[part] = part.Transparency
                            part.Transparency = 1
                        end
                    end
                    
                    -- Цикл поддержания невидимости
                    local invisConn
                    invisConn = RunService.RenderStepped:Connect(function()
                        if not State.FEInvisible then
                            -- Восстанавливаем
                            for part, val in pairs(originalTransparencies) do
                                if part and part.Parent then
                                    if part:IsA("BasePart") then
                                        part.LocalTransparencyModifier = val
                                    else
                                        part.Transparency = val
                                    end
                                end
                            end
                            invisConn:Disconnect()
                            return
                        end
                        
                        pcall(function()
                            local c = GetCharacter()
                            if c then
                                for _, part in pairs(c:GetDescendants()) do
                                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                        part.LocalTransparencyModifier = 1
                                    end
                                end
                            end
                        end)
                    end)
                    
                    AddConnection(invisConn)
                end)
            end
        end)
    end,
})

------------------------------------------------------------
-- ГЛОБАЛЬНЫЕ ОБРАБОТЧИКИ
------------------------------------------------------------

-- Восстановление при смерти/респавне
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    
    -- Сбрасываем состояния, требующие пересоздания
    if State.Fly then
        StopFly()
        task.wait(0.5)
        StartFly()
    end
    
    if State.FakeDead then
        State.FakeDead = false
    end
    
    if State.FEInvisible then
        -- Пересоздаём невидимость для нового персонажа
        State.FEInvisible = false
        task.wait(0.5)
        State.FEInvisible = true
    end
end)

------------------------------------------------------------
-- ФИНАЛЬНОЕ УВЕДОМЛЕНИЕ
------------------------------------------------------------
WindUI:Notify({
    Title = "🎮 Все модули загружены",
    Content = "5 вкладок активны. Удачной игры!",
    Duration = 3,
})

print("[MM2 Elite Hub] ✅ Скрипт полностью инициализирован")
