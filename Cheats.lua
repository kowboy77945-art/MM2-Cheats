--[[
    ╔══════════════════════════════════════════════╗
    ║       MM2 ELITE HUB — WindUI Edition         ║
    ║  Совместимость: Solara, Wave, Hydrogen, Delta ║
    ╚══════════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 1: ЗАГРУЗКА БИБЛИОТЕКИ И СЕРВИСЫ
-- ═══════════════════════════════════════════════

local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 2: ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ СОСТОЯНИЯ
-- ═══════════════════════════════════════════════

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
    AutoEvadeDistance = 20,

    -- Misc
    FakeDead = false,
    FakeDeadPose = "На живот",
    FEInvisible = false,
}

-- Хранилища
local ESPHighlights = {}      -- [Player] = Highlight
local GunESPHighlight = nil
local Connections = {}         -- Все RBXScriptConnections для очистки
local FlyBodyVelocity = nil
local FlyBodyGyro = nil

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 3: УТИЛИТЫ (ОПРЕДЕЛЕНИЕ РОЛЕЙ, RAYCAST)
-- ═══════════════════════════════════════════════

-- Определяет роль игрока: "Murderer", "Sheriff", "Innocent"
local function GetRole(player)
    if not player then return "Innocent" end

    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character

    local function checkForTool(container, toolName)
        if not container then return false end
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") then
                local nameL = item.Name:lower()
                if toolName == "knife" and (nameL == "knife" or nameL:find("knife")) then
                    return true
                end
                if toolName == "gun" and (nameL == "gun" or nameL:find("gun") or nameL:find("revolver")) then
                    return true
                end
            end
        end
        return false
    end

    local hasKnife = checkForTool(backpack, "knife") or checkForTool(character, "knife")
    local hasGun = checkForTool(backpack, "gun") or checkForTool(character, "gun")

    if hasKnife then return "Murderer" end
    if hasGun then return "Sheriff" end
    return "Innocent"
end

-- Возвращает роль LocalPlayer
local function GetMyRole()
    return GetRole(LocalPlayer)
end

-- Находит игрока-убийцу
local function FindMurderer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and GetRole(player) == "Murderer" then
            return player
        end
    end
    return nil
end

-- Находит всех живых игроков (кроме local)
local function GetAlivePlayers()
    local alive = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                table.insert(alive, player)
            end
        end
    end
    return alive
end

-- Проверка линии видимости (Raycast wall check)
local function HasLineOfSight(fromPos, toPos)
    local direction = toPos - fromPos
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    -- Исключаем персонажей из рейкаста
    local filterList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            table.insert(filterList, player.Character)
        end
    end
    rayParams.FilterDescendantsInstances = filterList

    local result = Workspace:Raycast(fromPos, direction, rayParams)
    -- Если ничего не задело — прямая линия чистая
    return result == nil
end

-- Получить тул (оружие) из инвентаря или рук
local function GetToolFromPlayer(player, toolType)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character

    local function findTool(container)
        if not container then return nil end
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") then
                local nameL = item.Name:lower()
                if toolType == "gun" and (nameL == "gun" or nameL:find("gun") or nameL:find("revolver")) then
                    return item
                end
                if toolType == "knife" and (nameL == "knife" or nameL:find("knife")) then
                    return item
                end
            end
        end
        return nil
    end

    return findTool(character) or findTool(backpack)
end

-- Экипировать тул
local function EquipTool(tool)
    if tool and tool.Parent ~= LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(tool)
    end
end

-- Безопасный HumanoidRootPart
local function GetHRP(player)
    if player and player.Character then
        return player.Character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function GetPartFromChar(player, partName)
    if player and player.Character then
        return player.Character:FindFirstChild(partName)
    end
    return nil
end

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 4: СОЗДАНИЕ UI — WINDUI
-- ═══════════════════════════════════════════════

local Window = Wind:CreateWindow({
    Title = "MM2 Elite Hub",
    Icon = "rbxassetid://18220853337",
    Author = "Elite Dev",
    Folder = "MM2EliteHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

-- Стартовое уведомление
Wind:Notify({
    Title = "MM2 Elite Hub",
    Content = "Скрипт успешно загружен!\nВсе модули активированы.\nУдачной игры!",
    Duration = 5,
    Icon = "rbxassetid://18220853337",
})

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 5: ВКЛАДКА "COMBAT (MAIN)"
-- ═══════════════════════════════════════════════

local CombatMainTab = Window:Tab({
    Title = "Combat (Main)",
    Icon = "sword",
})

-- ── Auto-Kill Murderer ──
CombatMainTab:Toggle({
    Title = "Full Auto-Kill Murderer",
    Description = "Автоматический выстрел в Убийцу при прямой видимости",
    Default = false,
    Callback = function(val)
        State.AutoKillMurderer = val
    end,
})

task.spawn(function()
    while task.wait(0.1) do
        if State.AutoKillMurderer then
            local myRole = GetMyRole()
            if myRole == "Sheriff" or GetToolFromPlayer(LocalPlayer, "gun") then
                local murderer = FindMurderer()
                if murderer then
                    local myHRP = GetHRP(LocalPlayer)
                    local targetPart = GetPartFromChar(murderer, State.TargetPart) or GetHRP(murderer)

                    if myHRP and targetPart then
                        local canSee = true
                        if State.WallCheck then
                            canSee = HasLineOfSight(myHRP.Position, targetPart.Position)
                        end

                        if canSee then
                            -- Экипировать пистолет
                            local gun = GetToolFromPlayer(LocalPlayer, "gun")
                            if gun then
                                EquipTool(gun)
                                task.wait(0.05)

                                -- Имитация выстрела через Remote
                                -- MM2 использует RemoteEvent для стрельбы
                                -- Метод: направление камеры + FireServer
                                pcall(function()
                                    -- Попытка найти Remote для стрельбы
                                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                                    if remotes then
                                        local shootRemote = remotes:FindFirstChild("Shoot") or remotes:FindFirstChild("Fire")
                                        if shootRemote then
                                            shootRemote:FireServer(targetPart.Position)
                                        end
                                    end

                                    -- Альтернативный метод — активация тула с позицией
                                    if gun:FindFirstChild("Fire") then
                                        gun.Fire:FireServer(targetPart.Position)
                                    elseif gun:FindFirstChild("RemoteFunction") then
                                        gun.RemoteFunction:InvokeServer(targetPart.Position)
                                    end

                                    -- Универсальный метод: Mouse1Click с подменой
                                    local mouseObj = LocalPlayer:GetMouse()
                                    if mouseObj then
                                        gun:Activate()
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ── Auto-Grab Gun ──
CombatMainTab:Toggle({
    Title = "Auto-Grab Gun",
    Description = "Мгновенный подбор пистолета при смерти Шерифа",
    Default = false,
    Callback = function(val)
        State.AutoGrabGun = val
    end,
})

task.spawn(function()
    while task.wait(0.15) do
        if State.AutoGrabGun then
            pcall(function()
                local myHRP = GetHRP(LocalPlayer)
                if not myHRP then return end

                for _, obj in ipairs(Workspace:GetChildren()) do
                    if obj.Name == "GunDrop" or (obj:IsA("Tool") and obj.Name:lower():find("gun")) then
                        local handle = obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")
                        if handle then
                            -- Телепорт к пистолету
                            myHRP.CFrame = handle.CFrame * CFrame.new(0, 3, 0)
                            task.wait(0.1)
                            -- Попытка подобрать
                            if obj:IsA("Tool") then
                                pcall(function()
                                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                    if humanoid then
                                        humanoid:EquipTool(obj)
                                    end
                                end)
                            end
                        end
                    end
                end

                -- Также проверяем модели с GunDrop
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                        myHRP.CFrame = obj.CFrame * CFrame.new(0, 3, 0)
                        task.wait(0.15)
                    end
                end
            end)
        end
    end
end)

-- ── Kill Aura (для Маньяка) ──
CombatMainTab:Toggle({
    Title = "Kill Aura (Murderer Only)",
    Description = "Автоатака ножом по ближайшим игрокам",
    Default = false,
    Callback = function(val)
        State.KillAura = val
    end,
})

CombatMainTab:Slider({
    Title = "Kill Aura Radius",
    Description = "Радиус действия Kill Aura (стадс)",
    Value = {
        Min = 5,
        Max = 50,
        Default = 15,
    },
    Callback = function(val)
        State.KillAuraRadius = val
    end,
})

task.spawn(function()
    while task.wait(0.05) do
        if State.KillAura and GetMyRole() == "Murderer" then
            pcall(function()
                local knife = GetToolFromPlayer(LocalPlayer, "knife")
                if not knife then return end

                EquipTool(knife)
                local myHRP = GetHRP(LocalPlayer)
                if not myHRP then return end

                for _, player in ipairs(GetAlivePlayers()) do
                    local theirHRP = GetHRP(player)
                    if theirHRP then
                        local dist = (myHRP.Position - theirHRP.Position).Magnitude
                        if dist <= State.KillAuraRadius then
                            -- Активация ножа (удар)
                            pcall(function()
                                knife:Activate()

                                -- Метод через Remote
                                if knife:FindFirstChild("Stab") then
                                    knife.Stab:FireServer(theirHRP.Position)
                                end

                                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                                if remotes then
                                    local killRemote = remotes:FindFirstChild("Stab") or remotes:FindFirstChild("Kill")
                                    if killRemote then
                                        killRemote:FireServer(player)
                                    end
                                end
                            end)
                        end
                    end
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 6: ВКЛАДКА "COMBAT (SETTINGS)"
-- ═══════════════════════════════════════════════

local CombatSettingsTab = Window:Tab({
    Title = "Combat (Settings)",
    Icon = "settings",
})

-- ── Silent Aim Toggle ──
CombatSettingsTab:Toggle({
    Title = "Silent Aim",
    Description = "Пуля автоматически летит в цель при ручной стрельбе",
    Default = false,
    Callback = function(val)
        State.SilentAim = val
    end,
})

-- ── Target Part Dropdown ──
CombatSettingsTab:Dropdown({
    Title = "Target Part",
    Description = "Часть тела для наведения",
    Values = {"HumanoidRootPart", "Head"},
    Value = "HumanoidRootPart",
    Callback = function(val)
        State.TargetPart = val
    end,
})

-- ── Wall Check Toggle ──
CombatSettingsTab:Toggle({
    Title = "Wall Check",
    Description = "Проверка стен перед выстрелом",
    Default = true,
    Callback = function(val)
        State.WallCheck = val
    end,
})

-- ── Silent Aim Hook ──
-- Хукаем Namecall/NewIndex для перенаправления пуль
task.spawn(function()
    -- Метод через подмену Mouse.Hit
    local mt = getrawmetatable(game)
    if mt and setreadonly then
        local oldNamecall = mt.__namecall
        local oldIndex = mt.__index

        setreadonly(mt, false)

        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()

            if State.SilentAim then
                -- Перехват FireServer для стрельбы
                if method == "FireServer" then
                    local selfName = tostring(self)
                    if selfName:lower():find("shoot") or selfName:lower():find("fire") or selfName:lower():find("remote") then
                        local murderer = FindMurderer()
                        if murderer then
                            local targetPart = GetPartFromChar(murderer, State.TargetPart) or GetHRP(murderer)
                            if targetPart then
                                local canShoot = true
                                if State.WallCheck then
                                    local myHRP = GetHRP(LocalPlayer)
                                    if myHRP then
                                        canShoot = HasLineOfSight(myHRP.Position, targetPart.Position)
                                    end
                                end

                                if canShoot then
                                    -- Подменяем первый аргумент (позицию) на позицию цели
                                    if typeof(args[1]) == "Vector3" then
                                        args[1] = targetPart.Position
                                    elseif typeof(args[1]) == "CFrame" then
                                        args[1] = targetPart.CFrame
                                    end
                                    return oldNamecall(self, unpack(args))
                                end
                            end
                        end
                    end
                end
            end

            return oldNamecall(self, ...)
        end)

        mt.__index = newcclosure(function(self, key)
            if State.SilentAim then
                -- Подмена Mouse.Hit для тулов использующих Mouse
                if tostring(self) == "Instance" or (typeof(self) == "Instance" and self:IsA("Mouse")) then
                    if key == "Hit" then
                        local murderer = FindMurderer()
                        if murderer then
                            local targetPart = GetPartFromChar(murderer, State.TargetPart) or GetHRP(murderer)
                            if targetPart then
                                local canShoot = true
                                if State.WallCheck then
                                    local myHRP = GetHRP(LocalPlayer)
                                    if myHRP then
                                        canShoot = HasLineOfSight(myHRP.Position, targetPart.Position)
                                    end
                                end
                                if canShoot then
                                    return targetPart.CFrame
                                end
                            end
                        end
                    elseif key == "Target" then
                        local murderer = FindMurderer()
                        if murderer then
                            local targetPart = GetPartFromChar(murderer, State.TargetPart) or GetHRP(murderer)
                            if targetPart then
                                return targetPart
                            end
                        end
                    end
                end
            end

            return oldIndex(self, key)
        end)

        setreadonly(mt, true)
    end
end)

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 7: ВКЛАДКА "VISUALS"
-- ═══════════════════════════════════════════════

local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye",
})

-- ── Player ESP ──
VisualsTab:Toggle({
    Title = "Player ESP (Role Chams)",
    Description = "Подсветка игроков по ролям сквозь стены",
    Default = false,
    Callback = function(val)
        State.PlayerESP = val
        if not val then
            -- Удалить все ESP
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
    Description = "Прозрачность заливки подсветки",
    Value = {
        Min = 0,
        Max = 1,
        Default = 0.5,
    },
    Callback = function(val)
        State.ESPFillTransparency = val
        -- Обновить существующие
        for _, highlight in pairs(ESPHighlights) do
            if highlight and highlight.Parent then
                highlight.FillTransparency = val
            end
        end
    end,
})

-- Цвета ролей
local RoleColors = {
    Murderer = Color3.fromRGB(255, 0, 0),
    Sheriff = Color3.fromRGB(0, 100, 255),
    Innocent = Color3.fromRGB(0, 255, 0),
}

local function UpdateESP(player)
    if not State.PlayerESP then return end
    if player == LocalPlayer then return end

    local character = player.Character
    if not character then
        -- Удалить ESP если нет персонажа
        if ESPHighlights[player] then
            ESPHighlights[player]:Destroy()
            ESPHighlights[player] = nil
        end
        return
    end

    local role = GetRole(player)
    local color = RoleColors[role] or RoleColors.Innocent

    -- Создать или обновить Highlight
    local highlight = ESPHighlights[player]
    if not highlight or not highlight.Parent then
        highlight = Instance.new("Highlight")
        highlight.Name = "MM2_ESP"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = character
        highlight.Parent = character
        ESPHighlights[player] = highlight
    end

    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = State.ESPFillTransparency
    highlight.OutlineTransparency = 0
    highlight.Adornee = character
end

-- ESP Loop — непрерывный цикл обновления
task.spawn(function()
    while task.wait(0.5) do
        if State.PlayerESP then
            for _, player in ipairs(Players:GetPlayers()) do
                pcall(function()
                    UpdateESP(player)
                end)
            end
        end
    end
end)

-- Подписка на новых игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if State.PlayerESP then
            UpdateESP(player)
        end
    end)
end)

-- Подписка на существующих игроков (CharacterAdded)
for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if State.PlayerESP then
            UpdateESP(player)
        end
    end)
end

-- Очистка ESP при выходе игрока
Players.PlayerRemoving:Connect(function(player)
    if ESPHighlights[player] then
        ESPHighlights[player]:Destroy()
        ESPHighlights[player] = nil
    end
end)

-- ── Gun ESP ──
VisualsTab:Toggle({
    Title = "Gun ESP",
    Description = "Подсветка выпавшего пистолета золотым цветом",
    Default = false,
    Callback = function(val)
        State.GunESP = val
        if not val and GunESPHighlight then
            GunESPHighlight:Destroy()
            GunESPHighlight = nil
        end
    end,
})

task.spawn(function()
    while task.wait(0.3) do
        if State.GunESP then
            pcall(function()
                local gunDrop = nil

                for _, obj in ipairs(Workspace:GetChildren()) do
                    if obj.Name == "GunDrop" then
                        gunDrop = obj
                        break
                    end
                end

                if not gunDrop then
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj.Name == "GunDrop" then
                            if obj:IsA("BasePart") then
                                gunDrop = obj
                            elseif obj:IsA("Model") then
                                gunDrop = obj
                            end
                            break
                        end
                    end
                end

                if gunDrop then
                    if not GunESPHighlight or not GunESPHighlight.Parent then
                        GunESPHighlight = Instance.new("Highlight")
                        GunESPHighlight.Name = "MM2_GunESP"
                        GunESPHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        GunESPHighlight.FillColor = Color3.fromRGB(255, 215, 0)
                        GunESPHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                        GunESPHighlight.FillTransparency = 0.3
                        GunESPHighlight.OutlineTransparency = 0
                    end

                    GunESPHighlight.Adornee = gunDrop
                    if GunESPHighlight.Parent ~= gunDrop then
                        GunESPHighlight.Parent = gunDrop
                    end
                else
                    if GunESPHighlight and GunESPHighlight.Parent then
                        GunESPHighlight:Destroy()
                        GunESPHighlight = nil
                    end
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 8: ВКЛАДКА "MOVEMENT"
-- ═══════════════════════════════════════════════

local MovementTab = Window:Tab({
    Title = "Movement",
    Icon = "zap",
})

-- ── Speed ──
MovementTab:Toggle({
    Title = "Speed Hack",
    Description = "Увеличение скорости передвижения",
    Default = false,
    Callback = function(val)
        State.SpeedEnabled = val
        if not val then
            pcall(function()
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.WalkSpeed = 16 end
            end)
        end
    end,
})

MovementTab:Slider({
    Title = "Walk Speed",
    Value = {
        Min = 16,
        Max = 150,
        Default = 16,
    },
    Callback = function(val)
        State.SpeedValue = val
    end,
})

-- Speed Loop через RenderStepped для обхода проверок
RunService.RenderStepped:Connect(function()
    if State.SpeedEnabled then
        pcall(function()
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = State.SpeedValue
            end
        end)
    end
end)

-- ── Jump Power ──
MovementTab:Toggle({
    Title = "Jump Power",
    Description = "Увеличение высоты прыжка",
    Default = false,
    Callback = function(val)
        State.JumpEnabled = val
        if not val then
            pcall(function()
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.JumpPower = 50
                    humanoid.UseJumpPower = true
                end
            end)
        end
    end,
})

MovementTab:Slider({
    Title = "Jump Power Value",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(val)
        State.JumpValue = val
    end,
})

RunService.RenderStepped:Connect(function()
    if State.JumpEnabled then
        pcall(function()
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = State.JumpValue
            end
        end)
    end
end)

-- ── Infinite Jump ──
MovementTab:Toggle({
    Title = "Infinite Jump",
    Description = "Прыжки в воздухе без ограничений",
    Default = false,
    Callback = function(val)
        State.InfiniteJump = val
    end,
})

UserInputService.JumpRequest:Connect(function()
    if State.InfiniteJump then
        pcall(function()
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- ── Noclip ──
MovementTab:Toggle({
    Title = "Noclip",
    Description = "Проход сквозь стены и объекты",
    Default = false,
    Callback = function(val)
        State.Noclip = val
    end,
})

RunService.Stepped:Connect(function()
    if State.Noclip then
        pcall(function()
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- ── Fly ──
MovementTab:Toggle({
    Title = "Fly",
    Description = "Полёт (ПК: WASD+Space/Ctrl, Мобильный: джойстик)",
    Default = false,
    Callback = function(val)
        State.Fly = val

        pcall(function()
            local character = LocalPlayer.Character
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")

            if val then
                -- Создаём BodyVelocity и BodyGyro
                FlyBodyVelocity = Instance.new("BodyVelocity")
                FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                FlyBodyVelocity.Velocity = Vector3.zero
                FlyBodyVelocity.Parent = hrp

                FlyBodyGyro = Instance.new("BodyGyro")
                FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                FlyBodyGyro.P = 9e4
                FlyBodyGyro.Parent = hrp
            else
                if FlyBodyVelocity then
                    FlyBodyVelocity:Destroy()
                    FlyBodyVelocity = nil
                end
                if FlyBodyGyro then
                    FlyBodyGyro:Destroy()
                    FlyBodyGyro = nil
                end
            end
        end)
    end,
})

MovementTab:Slider({
    Title = "Fly Speed",
    Value = {
        Min = 10,
        Max = 200,
        Default = 50,
    },
    Callback = function(val)
        State.FlySpeed = val
    end,
})

-- Fly Movement Loop
RunService.RenderStepped:Connect(function()
    if State.Fly and FlyBodyVelocity and FlyBodyGyro then
        pcall(function()
            local hrp = GetHRP(LocalPlayer)
            if not hrp then return end

            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            local moveDir = humanoid.MoveDirection -- Работает и с джойстиком на мобильном
            local camCF = Camera.CFrame

            FlyBodyGyro.CFrame = camCF

            local velocity = Vector3.zero

            -- Движение вперед/назад/влево/вправо (джойстик на мобильном тоже задаёт MoveDirection)
            if moveDir.Magnitude > 0 then
                velocity = velocity + (camCF.LookVector * moveDir.Z + camCF.RightVector * moveDir.X).Unit * State.FlySpeed
            end

            -- Подъём/спуск — ПК
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                velocity = velocity + Vector3.new(0, State.FlySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                velocity = velocity + Vector3.new(0, -State.FlySpeed, 0)
            end

            -- Мобильный: если джойстик + Jump кнопка
            if humanoid.Jump then
                velocity = velocity + Vector3.new(0, State.FlySpeed * 0.5, 0)
            end

            -- Если нет ввода с джойстика, используем камеру для направления
            if moveDir.Magnitude > 0 then
                local lookDir = camCF.LookVector
                local rightDir = camCF.RightVector
                velocity = (lookDir * moveDir.Z + rightDir * moveDir.X) * State.FlySpeed

                -- Добавляем вертикаль
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    velocity = velocity + Vector3.new(0, State.FlySpeed, 0)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    velocity = velocity + Vector3.new(0, -State.FlySpeed, 0)
                end
            end

            FlyBodyVelocity.Velocity = velocity

            -- Отключить падение
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        end)
    end
end)

-- ── Auto-Evade Murderer ──
MovementTab:Toggle({
    Title = "Auto-Evade Murderer",
    Description = "Автоматическое уклонение от Убийцы при сближении",
    Default = false,
    Callback = function(val)
        State.AutoEvade = val
    end,
})

MovementTab:Slider({
    Title = "Evade Distance",
    Description = "Дистанция срабатывания (стадс)",
    Value = {
        Min = 10,
        Max = 50,
        Default = 20,
    },
    Callback = function(val)
        State.AutoEvadeDistance = val
    end,
})

task.spawn(function()
    while task.wait(0.1) do
        if State.AutoEvade then
            pcall(function()
                local myRole = GetMyRole()
                if myRole == "Murderer" then return end -- Маньяк не убегает от себя

                local murderer = FindMurderer()
                if not murderer then return end

                local myHRP = GetHRP(LocalPlayer)
                local murderHRP = GetHRP(murderer)

                if not myHRP or not murderHRP then return end

                -- Проверяем, держит ли убийца нож в руках
                local murdererHasKnifeEquipped = false
                if murderer.Character then
                    for _, item in ipairs(murderer.Character:GetChildren()) do
                        if item:IsA("Tool") and item.Name:lower():find("knife") then
                            murdererHasKnifeEquipped = true
                            break
                        end
                    end
                end

                if not murdererHasKnifeEquipped then return end

                local dist = (myHRP.Position - murderHRP.Position).Magnitude

                if dist <= State.AutoEvadeDistance then
                    -- Направление ОТ убийцы
                    local awayDir = (myHRP.Position - murderHRP.Position).Unit
                    -- Телепорт на 10 стадов в противоположную сторону
                    local newPos = myHRP.Position + awayDir * 12
                    myHRP.CFrame = CFrame.new(newPos)

                    -- Также увеличиваем скорость временно
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        local origSpeed = humanoid.WalkSpeed
                        humanoid.WalkSpeed = math.max(origSpeed, 32)
                        task.delay(1, function()
                            if humanoid and humanoid.Parent and not State.SpeedEnabled then
                                humanoid.WalkSpeed = 16
                            end
                        end)
                    end
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 9: ВКЛАДКА "MISC"
-- ═══════════════════════════════════════════════

local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "puzzle",
})

-- ── Fake Dead ──
MiscTab:Dropdown({
    Title = "Fake Dead Pose",
    Description = "Выбор позы при притворстве",
    Values = {"На живот", "На спину"},
    Value = "На живот",
    Callback = function(val)
        State.FakeDeadPose = val
    end,
})

MiscTab:Toggle({
    Title = "Fake Dead",
    Description = "Притвориться мертвым (смена позы персонажа)",
    Default = false,
    Callback = function(val)
        State.FakeDead = val

        pcall(function()
            local character = LocalPlayer.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local hrp = character:FindFirstChild("HumanoidRootPart")

            if val then
                humanoid.PlatformStand = true

                if State.FakeDeadPose == "На живот" then
                    -- Поворот лицом вниз
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(math.rad(90), 0, 0)
                else
                    -- Поворот лицом вверх (на спину)
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(math.rad(-90), 0, 0)
                end
            else
                humanoid.PlatformStand = false
                -- Возврат нормальной ориентации
                local pos = hrp.Position
                hrp.CFrame = CFrame.new(pos)
            end
        end)
    end,
})

-- Поддержание позы Fake Dead
RunService.RenderStepped:Connect(function()
    if State.FakeDead then
        pcall(function()
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = true
            end
        end)
    end
end)

-- ── FE Invisibility ──
MiscTab:Toggle({
    Title = "FE Invisibility",
    Description = "Локальная невидимость персонажа (смещение хитбокса)",
    Default = false,
    Callback = function(val)
        State.FEInvisible = val

        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end

            if val then
                -- Метод: смещение HRP далеко + перемещение визуальных частей
                -- Альтернатива: скрытие всех частей локально
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.LocalTransparencyModifier = 1
                    end
                    if part:IsA("Decal") or part:IsA("Texture") then
                        part.Transparency = 1
                    end
                end

                -- Скрытие аксессуаров
                for _, acc in ipairs(character:GetChildren()) do
                    if acc:IsA("Accessory") then
                        local handle = acc:FindFirstChild("Handle")
                        if handle then
                            handle.LocalTransparencyModifier = 1
                        end
                    end
                end

                -- Скрытие головы (face)
                local head = character:FindFirstChild("Head")
                if head then
                    for _, face in ipairs(head:GetChildren()) do
                        if face:IsA("Decal") then
                            face.Transparency = 1
                        end
                    end
                end
            else
                -- Восстановление видимости
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.LocalTransparencyModifier = 0
                    end
                    if part:IsA("Decal") or part:IsA("Texture") then
                        if part.Parent and part.Parent.Name == "Head" then
                            part.Transparency = 0
                        end
                    end
                end

                for _, acc in ipairs(character:GetChildren()) do
                    if acc:IsA("Accessory") then
                        local handle = acc:FindFirstChild("Handle")
                        if handle then
                            handle.LocalTransparencyModifier = 0
                        end
                    end
                end
            end
        end)
    end,
})

-- FE Invis поддержание в цикле
RunService.RenderStepped:Connect(function()
    if State.FEInvisible then
        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end

            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.LocalTransparencyModifier = 1
                end
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 10: ВОССТАНОВЛЕНИЕ ПОСЛЕ РЕСПАУНА
-- ═══════════════════════════════════════════════

LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1)

    -- Восстановить ESP
    if State.PlayerESP then
        for _, player in ipairs(Players:GetPlayers()) do
            pcall(function() UpdateESP(player) end)
        end
    end

    -- Сброс Fly при респауне
    if State.Fly then
        pcall(function()
            local hrp = character:WaitForChild("HumanoidRootPart", 5)
            if hrp then
                FlyBodyVelocity = Instance.new("BodyVelocity")
                FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                FlyBodyVelocity.Velocity = Vector3.zero
                FlyBodyVelocity.Parent = hrp

                FlyBodyGyro = Instance.new("BodyGyro")
                FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                FlyBodyGyro.P = 9e4
                FlyBodyGyro.Parent = hrp
            end
        end)
    end

    -- Сброс FakeDead
    if State.FakeDead then
        pcall(function()
            local humanoid = character:WaitForChild("Humanoid", 5)
            local hrp = character:WaitForChild("HumanoidRootPart", 5)
            if humanoid and hrp then
                humanoid.PlatformStand = true
                if State.FakeDeadPose == "На живот" then
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(math.rad(90), 0, 0)
                else
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(math.rad(-90), 0, 0)
                end
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════
-- СЕКЦИЯ 11: ФИНАЛЬНОЕ УВЕДОМЛЕНИЕ
-- ═══════════════════════════════════════════════

Wind:Notify({
    Title = "✅ Все модули загружены",
    Content = "Combat • Visuals • Movement • Misc\nВсе системы готовы к работе!",
    Duration = 4,
    Icon = "check-circle",
})

print("[MM2 Elite Hub] Скрипт полностью загружен и работает.")
