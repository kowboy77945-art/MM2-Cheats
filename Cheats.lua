--// WindUI Library Load
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist.lua'))()

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Local Player
local LocalPlayer = Players.LocalPlayer

--// State Variables
local States = {
    -- Movement
    WalkSpeedEnabled = true,
    WalkSpeedValue = 16,
    JumpPowerValue = 50,
    NoclipEnabled = false,
    FlyEnabled = false,
    FlySpeed = 60,
    
    -- Visuals
    ESPEnabled = false,
    ESPFillTransparency = 0.5,
    GunESPEnabled = false,
    
    -- Combat
    AutoKillEnabled = false,
    AutoGrabGunEnabled = false,
    
    -- Misc
    FakeDeadEnabled = false,
    FakeDeadPose = "На живот",
    FEInvisEnabled = false,
}

--// Connections Storage (для очистки)
local Connections = {}
local ESPHighlights = {}
local GunESPHighlights = {}

---------------------------------------------------------------
-- UTILITY FUNCTIONS
---------------------------------------------------------------

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

-- Определение роли игрока в MM2
local function GetPlayerRole(player)
    -- Проверяем Backpack и Character на наличие инструментов
    local function checkForTool(container)
        if not container then return nil end
        for _, item in pairs(container:GetChildren()) do
            if item:IsA("Tool") then
                local name = item.Name:lower()
                if name == "knife" or name == "murderer" then
                    return "Murderer"
                elseif name == "gun" or name == "revolver" or name == "sheriff" then
                    return "Sheriff"
                end
            end
        end
        return nil
    end
    
    local role = checkForTool(player:FindFirstChild("Backpack"))
    if role then return role end
    
    if player.Character then
        role = checkForTool(player.Character)
        if role then return role end
    end
    
    return "Innocent"
end

local function GetRoleColor(role)
    if role == "Murderer" then
        return Color3.fromRGB(255, 0, 0) -- Красный
    elseif role == "Sheriff" then
        return Color3.fromRGB(0, 100, 255) -- Синий
    else
        return Color3.fromRGB(0, 255, 0) -- Зеленый
    end
end

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

---------------------------------------------------------------
-- WINDOW CREATION
---------------------------------------------------------------

local Window = WindUI:CreateWindow({
    Title = "MM2 Hub",
    Icon = "sword",
    Author = "Advanced Script",
    Folder = "MM2Hub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

WindUI:Notify({
    Title = "MM2 Hub",
    Content = "Скрипт успешно загружен! Приятной игры.",
    Icon = "check-circle",
    Duration = 5,
})

---------------------------------------------------------------
-- TAB: MOVEMENT
---------------------------------------------------------------

local MovementTab = Window:Tab({
    Title = "Movement",
    Icon = "person-standing",
})

local MovementSection = MovementTab:Section({ Title = "Движение" })

-- WalkSpeed Slider
MovementSection:Slider({
    Title = "WalkSpeed",
    Icon = "gauge",
    Value = {
        Min = 16,
        Max = 150,
        Default = 16,
    },
    Callback = function(value)
        States.WalkSpeedValue = value
    end,
})

-- WalkSpeed enforcer loop (обход серверного сброса)
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        if States.WalkSpeedValue > 16 then
            local hum = GetHumanoid()
            if hum then
                hum.WalkSpeed = States.WalkSpeedValue
            end
        end
    end)
end)

-- JumpPower Slider
MovementSection:Slider({
    Title = "JumpPower",
    Icon = "arrow-big-up",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        States.JumpPowerValue = value
        local hum = GetHumanoid()
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = value
        end
    end,
})

-- JumpPower enforcer
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        if States.JumpPowerValue > 50 then
            local hum = GetHumanoid()
            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = States.JumpPowerValue
            end
        end
    end)
end)

-- Noclip Toggle
MovementSection:Toggle({
    Title = "Noclip",
    Icon = "ghost",
    Default = false,
    Callback = function(state)
        States.NoclipEnabled = state
    end,
})

-- Noclip loop
task.spawn(function()
    RunService.Stepped:Connect(function()
        if States.NoclipEnabled then
            local char = GetCharacter()
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- Fly Toggle
local FlySection = MovementTab:Section({ Title = "Полёт" })

FlySection:Toggle({
    Title = "Fly",
    Icon = "plane",
    Default = false,
    Callback = function(state)
        States.FlyEnabled = state
        
        local char = GetCharacter()
        local hrp = GetRootPart()
        local hum = GetHumanoid()
        
        if not hrp or not hum then return end
        
        if state then
            -- Создаём BodyGyro и BodyVelocity
            local bg = Instance.new("BodyGyro")
            bg.Name = "FlyGyro"
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.D = 300
            bg.P = 9e4
            bg.Parent = hrp
            
            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlyVelocity"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.zero
            bv.Parent = hrp
            
            hum.PlatformStand = true
            
            -- Fly control loop
            Connections["FlyLoop"] = RunService.RenderStepped:Connect(function()
                if not States.FlyEnabled then return end
                
                local bvInst = hrp:FindFirstChild("FlyVelocity")
                local bgInst = hrp:FindFirstChild("FlyGyro")
                if not bvInst or not bgInst then return end
                
                local camera = Workspace.CurrentCamera
                local moveDirection = Vector3.zero
                
                if IsMobile() then
                    -- Мобильное управление: используем MoveDirection гуманоида
                    if hum.MoveDirection.Magnitude > 0 then
                        moveDirection = hum.MoveDirection
                    end
                    -- Для подъёма/спуска на мобильном используем кнопку прыжка
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) or hum.Jump then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    end
                else
                    -- ПК управление
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        moveDirection = moveDirection - Vector3.new(0, 1, 0)
                    end
                end
                
                if moveDirection.Magnitude > 0 then
                    bvInst.Velocity = moveDirection.Unit * States.FlySpeed
                else
                    bvInst.Velocity = Vector3.zero
                end
                
                bgInst.CFrame = camera.CFrame
            end)
        else
            -- Отключение полёта
            if Connections["FlyLoop"] then
                Connections["FlyLoop"]:Disconnect()
                Connections["FlyLoop"] = nil
            end
            
            local bg = hrp:FindFirstChild("FlyGyro")
            local bv = hrp:FindFirstChild("FlyVelocity")
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
            
            hum.PlatformStand = false
        end
    end,
})

FlySection:Slider({
    Title = "Fly Speed",
    Icon = "gauge",
    Value = {
        Min = 10,
        Max = 200,
        Default = 60,
    },
    Callback = function(value)
        States.FlySpeed = value
    end,
})

---------------------------------------------------------------
-- TAB: VISUALS
---------------------------------------------------------------

local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye",
})

local ESPSection = VisualsTab:Section({ Title = "ESP Игроков" })

-- ESP Functions
local function ClearAllESP()
    for _, highlight in pairs(ESPHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    ESPHighlights = {}
end

local function ApplyESP(player)
    if not States.ESPEnabled then return end
    if player == LocalPlayer then return end
    
    local character = player.Character
    if not character then return end
    
    -- Удаляем старый highlight
    local oldKey = player.Name
    if ESPHighlights[oldKey] and ESPHighlights[oldKey].Parent then
        ESPHighlights[oldKey]:Destroy()
    end
    
    local role = GetPlayerRole(player)
    local color = GetRoleColor(role)
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "MM2ESP_" .. player.Name
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = States.ESPFillTransparency
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = character
    highlight.Parent = character
    
    ESPHighlights[oldKey] = highlight
end

local function RefreshAllESP()
    ClearAllESP()
    if not States.ESPEnabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            ApplyESP(player)
        end
    end
end

-- ESP Toggle
ESPSection:Toggle({
    Title = "Player ESP",
    Icon = "scan-eye",
    Default = false,
    Callback = function(state)
        States.ESPEnabled = state
        if state then
            RefreshAllESP()
        else
            ClearAllESP()
        end
    end,
})

-- ESP Fill Transparency Slider
ESPSection:Slider({
    Title = "Fill Transparency",
    Icon = "blend",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value)
        States.ESPFillTransparency = value / 100
        -- Обновляем существующие highlights
        for _, highlight in pairs(ESPHighlights) do
            if highlight and highlight.Parent then
                highlight.FillTransparency = States.ESPFillTransparency
            end
        end
    end,
})

-- Незатухающее ESP: постоянный сканирующий цикл
task.spawn(function()
    while true do
        task.wait(1.5) -- Сканируем каждые 1.5 секунды
        if States.ESPEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local existing = ESPHighlights[player.Name]
                    local role = GetPlayerRole(player)
                    local color = GetRoleColor(role)
                    
                    if existing and existing.Parent then
                        -- Обновляем цвет если роль изменилась
                        if existing.FillColor ~= color then
                            existing.FillColor = color
                            existing.OutlineColor = color
                        end
                        existing.FillTransparency = States.ESPFillTransparency
                    else
                        -- ESP пропал — переприменяем
                        ApplyESP(player)
                    end
                end
            end
        end
    end
end)

-- PlayerAdded listener
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(1) -- Ждём загрузки персонажа
        if States.ESPEnabled then
            ApplyESP(player)
        end
    end)
end)

-- Для уже существующих игроков
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            task.wait(1)
            if States.ESPEnabled then
                ApplyESP(player)
            end
        end)
    end
end

-- Обработка респавна LocalPlayer (роли могут смениться)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    if States.ESPEnabled then
        RefreshAllESP()
    end
end)

-- Gun ESP Section
local GunESPSection = VisualsTab:Section({ Title = "Gun ESP" })

local function ClearGunESP()
    for _, highlight in pairs(GunESPHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    GunESPHighlights = {}
end

local function ApplyGunESP()
    if not States.GunESPEnabled then return end
    ClearGunESP()
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" and (obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("Tool")) then
            local target = obj
            if obj:IsA("BasePart") then
                -- Ищем модель-родитель если есть
                if obj.Parent and obj.Parent:IsA("Model") then
                    target = obj.Parent
                end
            end
            
            local existing = target:FindFirstChild("GunDropESP")
            if not existing then
                local highlight = Instance.new("Highlight")
                highlight.Name = "GunDropESP"
                highlight.FillColor = Color3.fromRGB(255, 215, 0) -- Золотой
                highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                highlight.FillTransparency = 0.3
                highlight.OutlineTransparency = 0
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Parent = target
                
                table.insert(GunESPHighlights, highlight)
            end
        end
    end
end

GunESPSection:Toggle({
    Title = "Gun Drop ESP",
    Icon = "crosshair",
    Default = false,
    Callback = function(state)
        States.GunESPEnabled = state
        if state then
            ApplyGunESP()
        else
            ClearGunESP()
        end
    end,
})

-- Gun ESP scanning loop
task.spawn(function()
    while true do
        task.wait(1)
        if States.GunESPEnabled then
            ApplyGunESP()
        end
    end
end)

---------------------------------------------------------------
-- TAB: COMBAT
---------------------------------------------------------------

local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "swords",
})

local CombatSection = CombatTab:Section({ Title = "Автоматическое оружие" })

-- Функция поиска убийцы
local function FindMurderer()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                if GetPlayerRole(player) == "Murderer" then
                    return player
                end
            end
        end
    end
    return nil
end

-- Функция проверки Line of Sight с Raycasting
local function HasLineOfSight(fromPos, toPos)
    local direction = (toPos - fromPos)
    local distance = direction.Magnitude
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    
    -- Игнорируем своего персонажа и прозрачные части
    local ignoreList = {}
    local localChar = GetCharacter()
    if localChar then
        table.insert(ignoreList, localChar)
    end
    
    -- Добавляем прозрачные детали в игнор
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Transparency >= 0.5 then
            table.insert(ignoreList, part)
        end
    end
    
    raycastParams.FilterDescendantsInstances = ignoreList
    
    local result = Workspace:Raycast(fromPos, direction.Unit * distance, raycastParams)
    
    if result then
        -- Проверяем, попали ли мы в персонаж убийцы
        local hitPart = result.Instance
        local hitChar = hitPart:FindFirstAncestorOfClass("Model")
        if hitChar then
            local hitPlayer = Players:GetPlayerFromCharacter(hitChar)
            if hitPlayer and GetPlayerRole(hitPlayer) == "Murderer" then
                return true
            end
        end
        return false
    end
    
    -- Если ничего не попалось, значит прямая видимость есть
    return true
end

-- Поиск Remote для стрельбы
local function FindShootRemote()
    -- MM2 использует разные remote names, ищем подходящий
    local possibleNames = {"ShootPlayer", "Fire", "Shoot", "RemoteFunction", "KnifeRemote"}
    
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            for _, name in pairs(possibleNames) do
                if remote.Name:lower():find(name:lower()) then
                    return remote
                end
            end
        end
    end
    
    -- Fallback: ищем в определённых местах MM2
    local mainModule = ReplicatedStorage:FindFirstChild("Remotes")
    if mainModule then
        for _, remote in pairs(mainModule:GetChildren()) do
            if remote:IsA("RemoteEvent") then
                return remote
            end
        end
    end
    
    return nil
end

-- Функция стрельбы (симуляция выстрела из пистолета)
local function ShootAtPlayer(targetPlayer)
    local character = GetCharacter()
    if not character then return end
    
    -- Проверяем, есть ли у нас пистолет
    local gun = nil
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower() == "gun" or tool.Name:lower() == "revolver") then
            gun = tool
            break
        end
    end
    
    if not gun then
        -- Проверяем Backpack
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower() == "gun" or tool.Name:lower() == "revolver") then
                -- Экипируем пистолет
                local hum = GetHumanoid()
                if hum then
                    hum:EquipTool(tool)
                    gun = tool
                    task.wait(0.1)
                end
                break
            end
        end
    end
    
    if not gun then return end
    
    local targetChar = targetPlayer.Character
    if not targetChar then return end
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart") 
        or targetChar:FindFirstChild("Head")
    if not targetHRP then return end
    
    -- Метод 1: Активация Tool через Remote
    -- MM2 обычно использует RemoteEvent для стрельбы
    local shootRemote = FindShootRemote()
    
    if shootRemote then
        pcall(function()
            if shootRemote:IsA("RemoteEvent") then
                shootRemote:FireServer(targetPlayer.Character, targetHRP.Position)
            elseif shootRemote:IsA("RemoteFunction") then
                shootRemote:InvokeServer(targetPlayer.Character, targetHRP.Position)
            end
        end)
    end
    
    -- Метод 2: Симуляция клика мышью в направлении цели
    pcall(function()
        local camera = Workspace.CurrentCamera
        -- Временно направляем камеру на цель
        local originalCF = camera.CFrame
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetHRP.Position)
        
        -- Активируем инструмент
        if gun:FindFirstChild("Activate") then
            gun.Activate:Fire()
        end
        mouse1click()
        
        task.wait(0.05)
        camera.CFrame = originalCF
    end)
    
    -- Метод 3: Прямой Fire Remote из инструмента
    pcall(function()
        for _, descendant in pairs(gun:GetDescendants()) do
            if descendant:IsA("RemoteEvent") then
                descendant:FireServer(targetHRP.Position)
            end
        end
    end)
end

-- Auto-Kill Toggle
CombatSection:Toggle({
    Title = "Auto-Kill Murderer (Triggerbot)",
    Icon = "target",
    Default = false,
    Callback = function(state)
        States.AutoKillEnabled = state
        if state then
            WindUI:Notify({
                Title = "Auto-Kill",
                Content = "Автоматический убийца активирован. Нужен пистолет!",
                Icon = "alert-triangle",
                Duration = 3,
            })
        end
    end,
})

-- Auto-Kill Loop
task.spawn(function()
    while true do
        task.wait(0.15)
        if States.AutoKillEnabled then
            local myRole = GetPlayerRole(LocalPlayer)
            -- Работает только если мы Шериф или подобрали пистолет
            if myRole == "Sheriff" then
                local murderer = FindMurderer()
                if murderer and murderer.Character then
                    local myHRP = GetRootPart()
                    local targetHRP = murderer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if myHRP and targetHRP then
                        local distance = (myHRP.Position - targetHRP.Position).Magnitude
                        
                        -- Проверяем дистанцию (разумный предел)
                        if distance < 300 then
                            -- Проверяем прямую видимость
                            if HasLineOfSight(myHRP.Position, targetHRP.Position) then
                                ShootAtPlayer(murderer)
                                task.wait(0.5) -- Кулдаун после выстрела
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto-Grab Gun
local GrabSection = CombatTab:Section({ Title = "Авто-подбор" })

GrabSection:Toggle({
    Title = "Auto-Grab Gun",
    Icon = "hand",
    Default = false,
    Callback = function(state)
        States.AutoGrabGunEnabled = state
    end,
})

-- Auto-Grab Gun Loop
task.spawn(function()
    while true do
        task.wait(0.3)
        if States.AutoGrabGunEnabled then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name == "GunDrop" then
                    local hrp = GetRootPart()
                    if hrp then
                        local targetPart = nil
                        
                        if obj:IsA("BasePart") then
                            targetPart = obj
                        elseif obj:IsA("Model") then
                            targetPart = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
                        elseif obj:IsA("Tool") then
                            local handle = obj:FindFirstChild("Handle")
                            if handle then
                                targetPart = handle
                            end
                        end
                        
                        if targetPart then
                            -- CFrame телепорт к пистолету
                            local originalPos = hrp.CFrame
                            hrp.CFrame = targetPart.CFrame * CFrame.new(0, 2, 0)
                            task.wait(0.2)
                            
                            -- Касаемся пистолета
                            hrp.CFrame = targetPart.CFrame
                            task.wait(0.15)
                            
                            -- Возвращаемся обратно (опционально)
                            -- hrp.CFrame = originalPos
                            
                            WindUI:Notify({
                                Title = "Auto-Grab",
                                Content = "Пистолет подобран!",
                                Icon = "check",
                                Duration = 2,
                            })
                        end
                    end
                end
            end
        end
    end
end)

---------------------------------------------------------------
-- TAB: MISC
---------------------------------------------------------------

local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "settings",
})

local FakeDeadSection = MiscTab:Section({ Title = "Fake Dead (Притвориться мертвым)" })

-- Dropdown для выбора позы
FakeDeadSection:Dropdown({
    Title = "Поза",
    Icon = "user-x",
    Multi = false,
    Items = {"На живот", "На спину"},
    Value = "На живот",
    Callback = function(value)
        States.FakeDeadPose = value
    end,
})

-- Fake Dead Toggle
FakeDeadSection:Toggle({
    Title = "Fake Dead",
    Icon = "skull",
    Default = false,
    Callback = function(state)
        States.FakeDeadEnabled = state
        
        local char = GetCharacter()
        local hum = GetHumanoid()
        local hrp = GetRootPart()
        
        if not char or not hum or not hrp then return end
        
        if state then
            -- Останавливаем все анимации
            hum.PlatformStand = true
            
            -- Применяем позу
            local function applyPose()
                if States.FakeDeadPose == "На живот" then
                    -- Лицом вниз
                    hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(math.rad(-90), 0, 0)
                elseif States.FakeDeadPose == "На спину" then
                    -- Лицом вверх
                    hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(math.rad(90), 0, 0)
                end
            end
            
            applyPose()
            
            -- Останавливаем анимации
            local animator = hum:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
            
            -- Поддерживаем позу в цикле
            Connections["FakeDead"] = RunService.RenderStepped:Connect(function()
                if States.FakeDeadEnabled then
                    hum.PlatformStand = true
                    applyPose()
                    
                    -- Блокируем анимации
                    local anim = hum:FindFirstChildOfClass("Animator")
                    if anim then
                        for _, track in pairs(anim:GetPlayingAnimationTracks()) do
                            track:Stop(0)
                        end
                    end
                end
            end)
        else
            -- Отключаем Fake Dead
            if Connections["FakeDead"] then
                Connections["FakeDead"]:Disconnect()
                Connections["FakeDead"] = nil
            end
            
            hum.PlatformStand = false
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, 0, 0)
        end
    end,
})

-- FE Invisibility
local InvisSection = MiscTab:Section({ Title = "Невидимость" })

InvisSection:Toggle({
    Title = "FE Invisibility",
    Icon = "eye-off",
    Default = false,
    Callback = function(state)
        States.FEInvisEnabled = state
        
        local char = GetCharacter()
        if not char then return end
        
        if state then
            -- Метод 1: Локальная прозрачность всех частей
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 1
                elseif part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 1
                end
            end
            
            -- Скрываем аксессуары
            for _, accessory in pairs(char:GetChildren()) do
                if accessory:IsA("Accessory") then
                    local handle = accessory:FindFirstChild("Handle")
                    if handle then
                        handle.LocalTransparencyModifier = 1
                        -- Скрываем меш-детали аксессуаров
                        for _, child in pairs(handle:GetChildren()) do
                            if child:IsA("SpecialMesh") or child:IsA("Decal") then
                                if child:IsA("Decal") then
                                    child.Transparency = 1
                                end
                            end
                        end
                    end
                end
            end
            
            -- Скрываем лицо
            local head = char:FindFirstChild("Head")
            if head then
                for _, face in pairs(head:GetChildren()) do
                    if face:IsA("Decal") then
                        face.Transparency = 1
                    end
                end
            end
            
            -- Поддерживаем невидимость в цикле (на случай переодевания)
            Connections["FEInvis"] = RunService.RenderStepped:Connect(function()
                if States.FEInvisEnabled then
                    local c = GetCharacter()
                    if c then
                        for _, part in pairs(c:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end
            end)
            
            -- Метод 2: Сдвиг хитбокса (дополнительно)
            -- Смещаем HRP далеко вниз относительно остальных частей
            pcall(function()
                local hrp = GetRootPart()
                if hrp then
                    -- Сохраняем оригинальный offset
                    local rootJoint = hrp:FindFirstChild("RootJoint")
                    if rootJoint then
                        rootJoint.C0 = rootJoint.C0 * CFrame.new(0, 0, -100)
                    end
                end
            end)
            
            WindUI:Notify({
                Title = "FE Invisibility",
                Content = "Локальная невидимость активирована.",
                Icon = "eye-off",
                Duration = 3,
            })
        else
            -- Восстановление видимости
            if Connections["FEInvis"] then
                Connections["FEInvis"]:Disconnect()
                Connections["FEInvis"] = nil
            end
            
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0
                elseif part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 0
                end
            end
            
            -- Восстанавливаем аксессуары
            for _, accessory in pairs(char:GetChildren()) do
                if accessory:IsA("Accessory") then
                    local handle = accessory:FindFirstChild("Handle")
                    if handle then
                        handle.LocalTransparencyModifier = 0
                    end
                end
            end
            
            -- Восстанавливаем лицо
            local head = char:FindFirstChild("Head")
            if head then
                for _, face in pairs(head:GetChildren()) do
                    if face:IsA("Decal") then
                        face.Transparency = 0
                    end
                end
            end
            
            -- Восстанавливаем хитбокс
            pcall(function()
                local hrp = GetRootPart()
                if hrp then
                    local rootJoint = hrp:FindFirstChild("RootJoint")
                    if rootJoint then
                        rootJoint.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
                    end
                end
            end)
            
            WindUI:Notify({
                Title = "FE Invisibility",
                Content = "Видимость восстановлена.",
                Icon = "eye",
                Duration = 3,
            })
        end
    end,
})

---------------------------------------------------------------
-- ANTI-AFK (Бонус)
---------------------------------------------------------------

local AntiAFKSection = MiscTab:Section({ Title = "Утилиты" })

AntiAFKSection:Toggle({
    Title = "Anti-AFK",
    Icon = "timer-off",
    Default = true,
    Callback = function(state)
        if state then
            -- Удаляем AFK handler
            local VirtualUser = game:GetService("VirtualUser")
            Connections["AntiAFK"] = LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        else
            if Connections["AntiAFK"] then
                Connections["AntiAFK"]:Disconnect()
                Connections["AntiAFK"] = nil
            end
        end
    end,
})

---------------------------------------------------------------
-- CLEANUP ON CHARACTER RESPAWN
---------------------------------------------------------------

LocalPlayer.CharacterAdded:Connect(function(newChar)
    -- Сбрасываем Fly при респавне
    if States.FlyEnabled then
        States.FlyEnabled = false
        if Connections["FlyLoop"] then
            Connections["FlyLoop"]:Disconnect()
            Connections["FlyLoop"] = nil
        end
    end
    
    -- Сбрасываем Fake Dead при респавне
    if States.FakeDeadEnabled then
        States.FakeDeadEnabled = false
        if Connections["FakeDead"] then
            Connections["FakeDead"]:Disconnect()
            Connections["FakeDead"] = nil
        end
    end
    
    -- Сбрасываем FE Invis при респавне
    if States.FEInvisEnabled then
        States.FEInvisEnabled = false
        if Connections["FEInvis"] then
            Connections["FEInvis"]:Disconnect()
            Connections["FEInvis"] = nil
        end
    end
    
    -- Ждём загрузки и обновляем ESP
    task.wait(2)
    if States.ESPEnabled then
        RefreshAllESP()
    end
end)

---------------------------------------------------------------
-- FINAL NOTIFICATION
---------------------------------------------------------------

WindUI:Notify({
    Title = "MM2 Hub Loaded",
    Content = "4 вкладки: Movement, Visuals, Combat, Misc. Удачной игры!",
    Icon = "party-popper",
    Duration = 6,
})
