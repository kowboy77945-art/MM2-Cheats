--[[
  ██████████████████████████████████████████████████████████████
  ██  HackerAI Red Team Suite — Roblox MM2 (Delta Fixed)  ██
  ██████████████████████████████████████████████████████████████
--]]

-- Защита от двойного запуска
if getgenv and getgenv().HackerAI_Loaded then
    warn("HackerAI уже запущен!")
    return
end
if getgenv then getgenv().HackerAI_Loaded = true end

--[[ ======================== CONFIG ======================== ]]

local CONFIG = {
    Keys = {
        "TEST-KEY-2024",
        "PENTEST-ROBLOX-MM2",
        "HACKERAI-REDTEAM"
    },
    DefaultLanguage = "RU"
}

--[[ ======================== LANGUAGE ======================== ]]

local Lang = {
    RU = {
        Title = "HackerAI - MM2 Red Team",
        Subtitle = "Инструмент тестирования безопасности",
        KeyPlaceholder = "Введите ключ доступа...",
        KeyButton = "Войти",
        KeyError = "Неверный ключ!",
        KeySuccess = "Доступ разрешён!",
        TabCombat = "Бой",
        TabVisuals = "Визуал",
        TabMovement = "Движение",
        TabWorld = "Мир",
        TabMisc = "Разное",
        TabSettings = "Настройки",
        ESP = "ESP (боксы + линии)",
        ESPBox = "Боксы",
        ESPTracers = "Линии",
        ESPDistance = "Дистанция",
        ESPName = "Имена",
        ESPHealth = "Здоровье",
        Aimbot = "Aimbot",
        AimbotFOV = "FOV аимбота",
        AimbotSmooth = "Сглаживание",
        SilentAimbot = "Silent Aim",
        Triggerbot = "Triggerbot",
        Wallbang = "Wallbang",
        Speed = "Скорость",
        Jump = "Прыжок",
        NoClip = "NoClip",
        Fly = "Полёт",
        FlySpeed = "Скорость полёта",
        InfJump = "Бесконечный прыжок",
        NoFall = "Без урона от падения",
        InfiniteAmmo = "Бесконечные патроны",
        AutoFarm = "Авто-фарм монет",
        AutoCollect = "Авто-сбор",
        AutoWin = "Авто-победа (шериф)",
        AutoKill = "Авто-убийство",
        TeleportMurder = "Тп к убийце",
        TeleportSheriff = "Тп к шерифу",
        TeleportAll = "Тп ко всем",
        FullBright = "FullBright",
        TimeDay = "Время: День",
        TimeNight = "Время: Ночь",
        TimeSunset = "Время: Закат",
        RemoveFog = "Убрать туман",
        RemoveRain = "Убрать дождь",
        XRay = "XRay (через стены)",
        Chams = "Chams (цветные)",
        AntiKick = "AntiKick",
        AntiCheatBypass = "Обход античита",
        Rejoin = "Перезайти",
        ServerHop = "Смена сервера",
        CopyIP = "Скопировать IP сервера",
        Language = "Язык",
        ToggleUI = "Показать/Скрыть (RShift)",
        Credits = "HackerAI Red Team - Authorized Pentest",
        On = "Вкл",
        Off = "Выкл",
        NotInGame = "Ошибка: игрок не найден"
    },
    EN = {
        Title = "HackerAI - MM2 Red Team",
        Subtitle = "Security Assessment Tool",
        KeyPlaceholder = "Enter access key...",
        KeyButton = "Login",
        KeyError = "Invalid key!",
        KeySuccess = "Access granted!",
        TabCombat = "Combat",
        TabVisuals = "Visuals",
        TabMovement = "Movement",
        TabWorld = "World",
        TabMisc = "Misc",
        TabSettings = "Settings",
        ESP = "ESP (boxes + tracers)",
        ESPBox = "Boxes",
        ESPTracers = "Tracers",
        ESPDistance = "Distance",
        ESPName = "Names",
        ESPHealth = "Health",
        Aimbot = "Aimbot",
        AimbotFOV = "Aimbot FOV",
        AimbotSmooth = "Smoothing",
        SilentAimbot = "Silent Aim",
        Triggerbot = "Triggerbot",
        Wallbang = "Wallbang",
        Speed = "Speed",
        Jump = "Jump",
        NoClip = "NoClip",
        Fly = "Fly",
        FlySpeed = "Fly Speed",
        InfJump = "Infinite Jump",
        NoFall = "No Fall Damage",
        InfiniteAmmo = "Infinite Ammo",
        AutoFarm = "Auto Farm Coins",
        AutoCollect = "Auto Collect",
        AutoWin = "Auto Win (Sheriff)",
        AutoKill = "Auto Kill (Murderer)",
        TeleportMurder = "TP to Murderer",
        TeleportSheriff = "TP to Sheriff",
        TeleportAll = "TP to All",
        FullBright = "FullBright",
        TimeDay = "Time: Day",
        TimeNight = "Time: Night",
        TimeSunset = "Time: Sunset",
        RemoveFog = "Remove Fog",
        RemoveRain = "Remove Rain",
        XRay = "XRay (see through walls)",
        Chams = "Chams (colored)",
        AntiKick = "AntiKick",
        AntiCheatBypass = "AntiCheat Bypass",
        Rejoin = "Rejoin",
        ServerHop = "Server Hop",
        CopyIP = "Copy Server IP",
        Language = "Language",
        ToggleUI = "Toggle UI (RShift)",
        Credits = "HackerAI Red Team - Authorized Pentest",
        On = "On",
        Off = "Off",
        NotInGame = "Error: player not found"
    }
}

local L = Lang[CONFIG.DefaultLanguage]

--[[ ======================== SERVICES ======================== ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = Workspace.CurrentCamera

--[[ ======================== STATE ======================== ]]

local State = {
    LoggedIn = false,
    CurrentLanguage = CONFIG.DefaultLanguage,
    ESP = false, ESPBox = true, ESPTracers = false,
    ESPDistance = false, ESPName = false, ESPHealth = false,
    Aimbot = false, AimbotFOV = 90, AimbotSmooth = 5,
    SilentAimbot = false, Triggerbot = false, Wallbang = false,
    Speed = 16, Jump = 50, NoClip = false,
    Fly = false, FlySpeed = 30, InfJump = false, NoFall = false,
    FullBright = false, RemoveFog = false, RemoveRain = false,
    XRay = false, Chams = false,
    InfiniteAmmo = false, AutoFarm = false, AutoCollect = false,
    AutoWin = false, AutoKill = false,
    AntiKick = false, AntiCheatBypass = false,
    FlyBody = nil, ESPConn = nil, AimbotConn = nil,
    ChamsHighlights = {},
    ChamsConnection = nil,
    OriginalBrightness = Lighting.Brightness,
    OriginalFogEnd = Lighting.FogEnd,
    OriginalAmbient = Lighting.Ambient,
    OriginalOutdoorAmbient = Lighting.OutdoorAmbient
}

--[[ ======================== UI ======================== ]]

local UI = {
    ScreenGui = nil,
    MainFrame = nil,
    ContentFrame = nil,
    TabBar = nil,
    TitleText = nil
}

local function Create(class, props)
    local ok, obj = pcall(Instance.new, class)
    if not ok then return nil end
    for k, v in pairs(props or {}) do
        pcall(function() obj[k] = v end)
    end
    return obj
end

local function AddCorner(obj, radius)
    if not obj then return end
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function AddStroke(obj, color, thickness)
    if not obj then return end
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(88, 101, 242)
    s.Thickness = thickness or 1
    s.Transparency = 0.6
    s.Parent = obj
    return s
end

local function CreateToggle(parent, label, stateKey, callback)
    local frame = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Color3.fromRGB(22, 20, 45),
        BorderSizePixel = 0,
        Parent = parent
    })
    AddCorner(frame, 10)

    Create("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = Color3.fromRGB(220, 220, 240),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame
    })

    local toggleBtn = Create("TextButton", {
        Size = UDim2.new(0, 44, 0, 24),
        Position = UDim2.new(1, -52, 0.5, -12),
        BackgroundColor3 = Color3.fromRGB(50, 48, 70),
        BorderSizePixel = 0,
        Text = "",
        Parent = frame
    })
    AddCorner(toggleBtn, 12)

    local toggleInner = Create("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 3, 0.5, -9),
        BackgroundColor3 = Color3.fromRGB(180, 180, 180),
        BorderSizePixel = 0,
        Parent = toggleBtn
    })
    AddCorner(toggleInner, 9)

    local function updateVisuals()
        local on = State[stateKey]
        toggleBtn.BackgroundColor3 = on
            and Color3.fromRGB(88, 101, 242)
            or Color3.fromRGB(50, 48, 70)
        toggleInner.BackgroundColor3 = on
            and Color3.fromRGB(255, 255, 255)
            or Color3.fromRGB(160, 160, 160)
        local targetX = on
            and UDim2.new(1, -21, 0.5, -9)
            or UDim2.new(0, 3, 0.5, -9)
        TweenService:Create(toggleInner,
            TweenInfo.new(0.2), {Position = targetX}):Play()
    end
    updateVisuals()

    toggleBtn.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        updateVisuals()
        if callback then
            pcall(callback, State[stateKey])
        end
    end)

    return frame
end

local function CreateSlider(parent, label, stateKey, min, max, suffix)
    local frame = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = Color3.fromRGB(22, 20, 45),
        BorderSizePixel = 0,
        Parent = parent
    })
    AddCorner(frame, 10)

    local lbl = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 12, 0, 6),
        BackgroundTransparency = 1,
        Text = label .. ": " .. tostring(State[stateKey]) .. (suffix or ""),
        TextColor3 = Color3.fromRGB(220, 220, 240),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame
    })

    local sliderBg = Create("Frame", {
        Size = UDim2.new(1, -24, 0, 6),
        Position = UDim2.new(0, 12, 0, 32),
        BackgroundColor3 = Color3.fromRGB(40, 38, 60),
        BorderSizePixel = 0,
        Parent = frame
    })
    AddCorner(sliderBg, 3)

    local fill = Create("Frame", {
        Size = UDim2.new(
            math.clamp((State[stateKey] - min) / (max - min), 0, 1),
            0, 1, 0
        ),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Parent = sliderBg
    })
    AddCorner(fill, 3)

    local sliderDragging = false

    local function updateSlider(posX)
        local absX = sliderBg.AbsolutePosition.X
        local absW = sliderBg.AbsoluteSize.X
        if absW == 0 then return end
        local ratio = math.clamp((posX - absX) / absW, 0, 1)
        local val = math.floor(min + (max - min) * ratio)
        State[stateKey] = val
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        lbl.Text = label .. ": " .. tostring(val) .. (suffix or "")
    end

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            sliderDragging = true
            updateSlider(input.Position.X)
        end
    end)

    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            sliderDragging = false
        end
    end)

    -- Привязываем к ОДНОМУ глобальному событию через InputChanged самого sliderBg
    UserInputService.InputChanged:Connect(function(input)
        if sliderDragging then
            if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
                updateSlider(input.Position.X)
            end
        end
    end)

    return frame
end

local function CreateButton(parent, label, callback, color)
    local btnColor = color or Color3.fromRGB(55, 50, 90)
    local btn = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = btnColor,
        BorderSizePixel = 0,
        Text = label,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        Parent = parent
    })
    AddCorner(btn, 10)

    btn.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
        btn.BackgroundColor3 = Color3.fromRGB(120, 100, 200)
        task.delay(0.15, function()
            if btn and btn.Parent then
                btn.BackgroundColor3 = btnColor
            end
        end)
    end)

    return btn
end

local function CreateSectionHeader(parent, text)
    return Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(140, 140, 180),
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent
    })
end

--[[ ======================== FEATURE FUNCTIONS ======================== ]]

local ESPObjects = {}

local function EnableESP()
    if State.ESPConn then return end
    State.ESPConn = RunService.RenderStepped:Connect(function()
        if not State.ESP then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == Player then continue end
            local char = plr.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then
                if ESPObjects[plr] then
                    pcall(function() ESPObjects[plr]:Destroy() end)
                    ESPObjects[plr] = nil
                end
                continue
            end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then
                if ESPObjects[plr] then
                    pcall(function() ESPObjects[plr]:Destroy() end)
                    ESPObjects[plr] = nil
                end
                continue
            end
            if not ESPObjects[plr] then
                local esp = Instance.new("Highlight")
                esp.Name = "HackerAI_ESP"
                esp.FillColor = Color3.fromRGB(255, 50, 50)
                esp.OutlineColor = Color3.fromRGB(255, 255, 255)
                esp.FillTransparency = 0.7
                esp.OutlineTransparency = 0.3
                esp.Adornee = char
                esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                esp.Parent = char
                ESPObjects[plr] = esp
            end
            if ESPObjects[plr] then
                ESPObjects[plr].FillTransparency = State.ESPBox and 0.7 or 1
            end
        end
        for plr, obj in pairs(ESPObjects) do
            if not plr or not plr.Parent then
                pcall(function() obj:Destroy() end)
                ESPObjects[plr] = nil
            end
        end
    end)
end

local function DisableESP()
    if State.ESPConn then
        State.ESPConn:Disconnect()
        State.ESPConn = nil
    end
    for plr, obj in pairs(ESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    ESPObjects = {}
end

local function EnableAimbot()
    if State.AimbotConn then return end
    State.AimbotConn = RunService.RenderStepped:Connect(function()
        if not State.Aimbot then return end
        local closest = nil
        local closestDist = State.AimbotFOV
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == Player then continue end
            local char = plr.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end
            local screenPos, onScreen = Camera:WorldToViewportPoint(
                char.HumanoidRootPart.Position
            )
            if not onScreen then continue end
            local dist = (
                Vector2.new(screenPos.X, screenPos.Y)
                - Vector2.new(Mouse.X, Mouse.Y)
            ).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = char
            end
        end
        if closest and closest:FindFirstChild("HumanoidRootPart") then
            local targetPos = closest.HumanoidRootPart.Position
                + Vector3.new(0, 2, 0)
            local current = Camera.CFrame
            local targetCF = CFrame.lookAt(current.Position, targetPos)
            local smooth = State.AimbotSmooth
            local factor = smooth > 0
                and math.clamp(1 - smooth / 10, 0.05, 1)
                or 0.1
            Camera.CFrame = current:Lerp(targetCF, factor)

            if State.Triggerbot and Mouse.Target then
                local tChar = Mouse.Target:FindFirstAncestorOfClass("Model")
                if tChar and Players:GetPlayerFromCharacter(tChar)
                and tChar ~= Player.Character then
                    local tool = Player.Character
                        and Player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        pcall(function() tool:Activate() end)
                    end
                end
            end
        end
    end)
end

local function DisableAimbot()
    if State.AimbotConn then
        State.AimbotConn:Disconnect()
        State.AimbotConn = nil
    end
end

local function EnableNoClip()
    task.spawn(function()
        while State.NoClip do
            task.wait()
            if Player.Character then
                for _, part in ipairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

local function DisableNoClip()
    State.NoClip = false
end

local function EnableFly()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local bv = Instance.new("BodyVelocity")
    bv.Name = "HackerAI_Fly"
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = root
    State.FlyBody = bv
    task.spawn(function()
        while State.Fly and bv and bv.Parent do
            task.wait()
            local dir = Vector3.new(0, 0, 0)
            local uis = UserInputService
            if uis:IsKeyDown(Enum.KeyCode.W) then
                dir = dir + Camera.CFrame.LookVector
            end
            if uis:IsKeyDown(Enum.KeyCode.S) then
                dir = dir - Camera.CFrame.LookVector
            end
            if uis:IsKeyDown(Enum.KeyCode.A) then
                dir = dir - Camera.CFrame.RightVector
            end
            if uis:IsKeyDown(Enum.KeyCode.D) then
                dir = dir + Camera.CFrame.RightVector
            end
            if uis:IsKeyDown(Enum.KeyCode.Space) then
                dir = dir + Vector3.new(0, 1, 0)
            end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                dir = dir - Vector3.new(0, 1, 0)
            end
            bv.Velocity = dir.Magnitude > 0
                and dir.Unit * State.FlySpeed or Vector3.zero
        end
    end)
end

local function DisableFly()
    State.Fly = false
    if State.FlyBody then
        pcall(function() State.FlyBody:Destroy() end)
        State.FlyBody = nil
    end
end

local infJumpConn = nil
local function EnableInfJump()
    if infJumpConn then return end
    infJumpConn = UserInputService.JumpRequest:Connect(function()
        if State.InfJump and Player.Character then
            local hum = Player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end

local function DisableInfJump()
    if infJumpConn then
        infJumpConn:Disconnect()
        infJumpConn = nil
    end
end

local function EnableFullBright()
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.GlobalShadows = false
end

local function DisableFullBright()
    Lighting.Brightness = State.OriginalBrightness
    Lighting.Ambient = State.OriginalAmbient
    Lighting.OutdoorAmbient = State.OriginalOutdoorAmbient
    Lighting.GlobalShadows = true
end

local function EnableNoFog()
    Lighting.FogEnd = 1e6
end

local function DisableNoFog()
    Lighting.FogEnd = State.OriginalFogEnd
end

local function EnableNoRain()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") then
            v.Enabled = false
        end
    end
end

local function DisableNoRain()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") then
            v.Enabled = true
        end
    end
end

local function EnableXRay()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Model") then
            pcall(function() v.LocalTransparencyModifier = 0.5 end)
        end
    end
end

local function DisableXRay()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            pcall(function() v.LocalTransparencyModifier = 0 end)
        end
    end
end

local function EnableChams()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if char then
            local hl = Instance.new("Highlight")
            hl.Name = "HackerAI_Chams"
            hl.FillColor = Color3.fromRGB(255, 50, 50)
            hl.FillTransparency = 0.5
            hl.OutlineTransparency = 0.2
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Adornee = char
            hl.Parent = char
            table.insert(State.ChamsHighlights, hl)
        end
    end
end

local function DisableChams()
    for _, hl in ipairs(State.ChamsHighlights) do
        pcall(function() hl:Destroy() end)
    end
    State.ChamsHighlights = {}
    -- Также убираем оставшиеся
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        if char then
            for _, v in ipairs(char:GetChildren()) do
                if v.Name == "HackerAI_Chams" then
                    pcall(function() v:Destroy() end)
                end
            end
        end
    end
end

local function EnableInfAmmo()
    task.spawn(function()
        while State.InfiniteAmmo do
            task.wait(1)
            local char = Player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    for _, child in ipairs(tool:GetChildren()) do
                        if child:IsA("NumberValue") then
                            pcall(function() child.Value = 999 end)
                        end
                    end
                end
            end
        end
    end)
end

local function DisableInfAmmo() end

local function EnableAutoFarm()
    task.spawn(function()
        while State.AutoFarm do
            task.wait(0.5)
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and (
                    v.Name == "Coin" or v.Name == "CoinVisual"
                    or v.Name == "Money" or v.Name == "Coin_Server"
                ) then
                    if Player.Character
                    and Player.Character:FindFirstChild("HumanoidRootPart") then
                        Player.Character.HumanoidRootPart.CFrame =
                            v.CFrame * CFrame.new(0, 2, 0)
                        task.wait(0.1)
                    end
                end
            end
        end
    end)
end

local function DisableAutoFarm() end

local function EnableAutoCollect()
    task.spawn(function()
        while State.AutoCollect do
            task.wait(2)
            for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local n = v.Name:lower()
                    if n:find("collect") or n:find("coin")
                    or n:find("pickup") then
                        pcall(function() v:FireServer() end)
                    end
                end
            end
        end
    end)
end

local function DisableAutoCollect() end

local function EnableAutoWin()
    task.spawn(function()
        while State.AutoWin do
            task.wait(1)
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == Player then continue end
                local char = plr.Character
                if not char then continue end
                local tool = char:FindFirstChildOfClass("Tool")
                if tool and tool.Name:lower():find("knife") then
                    if char:FindFirstChild("HumanoidRootPart")
                    and Player.Character
                    and Player.Character:FindFirstChild("HumanoidRootPart")
                    then
                        Player.Character.HumanoidRootPart.CFrame =
                            char.HumanoidRootPart.CFrame
                            * CFrame.new(0, 0, 5)
                    end
                    break
                end
            end
        end
    end)
end

local function DisableAutoWin() end

local function EnableAutoKill()
    task.spawn(function()
        while State.AutoKill do
            task.wait(0.5)
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == Player then continue end
                local char = plr.Character
                if not char
                or not char:FindFirstChild("HumanoidRootPart") then
                    continue
                end
                if Player.Character
                and Player.Character:FindFirstChild("HumanoidRootPart")
                then
                    Player.Character.HumanoidRootPart.CFrame =
                        char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                    task.wait(0.1)
                    local knife = Player.Character
                        :FindFirstChildOfClass("Tool")
                    if knife then
                        pcall(function() knife:Activate() end)
                    end
                end
            end
        end
    end)
end

local function DisableAutoKill() end

local function TeleportToMurder()
    if not Player.Character
    or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if not char then continue end
        local tool = char:FindFirstChildOfClass("Tool")
        if tool and not tool.Name:lower():find("gun") then
            if char:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame =
                    char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                return
            end
        end
    end
end

local function TeleportToSheriff()
    if not Player.Character
    or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if not char then continue end
        local tool = char:FindFirstChildOfClass("Tool")
        if tool and (tool.Name:lower():find("gun")
        or tool.Name:lower():find("pistol")) then
            if char:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame =
                    char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                return
            end
        end
    end
end

local function TeleportToAll()
    if not Player.Character
    or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame =
                char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
            return
        end
    end
end

local function RejoinServer()
    pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId, game.JobId, Player
        )
    end)
end

local function ServerHop()
    pcall(function()
        local ts = game:GetService("TeleportService")
        ts:Teleport(game.PlaceId, Player)
    end)
end

local function CopyServerIP()
    pcall(function()
        if setclipboard then
            setclipboard(game.JobId)
        end
    end)
end

-- Speed/Jump loop
RunService.Heartbeat:Connect(function()
    pcall(function()
        if Player.Character then
            local hum = Player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                if State.Speed ~= 16 then hum.WalkSpeed = State.Speed end
                if State.Jump ~= 50 then hum.JumpPower = State.Jump end
            end
        end
    end)
end)

-- No fall damage
pcall(function()
    Player.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid", 10)
        if hum then
            hum.StateChanged:Connect(function(_, newState)
                if State.NoFall
                and newState == Enum.HumanoidStateType.FallingDown then
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end)
        end
    end)
end)

--[[ ======================== TAB CONTENT ======================== ]]

local function RefreshTabContent(tab)
    if not UI.ContentFrame then return end
    for _, v in ipairs(UI.ContentFrame:GetChildren()) do
        if not v:IsA("UIListLayout") and not v:IsA("UIPadding") then
            v:Destroy()
        end
    end

    if tab == "Combat" then
        CreateSectionHeader(UI.ContentFrame,
            State.CurrentLanguage == "RU"
            and "БОЕВЫЕ ФУНКЦИИ" or "COMBAT FEATURES")
        CreateToggle(UI.ContentFrame, L.ESP, "ESP", function(v)
            if v then EnableESP() else DisableESP() end
        end)
        CreateToggle(UI.ContentFrame, L.ESPBox, "ESPBox")
        CreateToggle(UI.ContentFrame, L.Aimbot, "Aimbot", function(v)
            if v then EnableAimbot() else DisableAimbot() end
        end)
        CreateSlider(UI.ContentFrame, L.AimbotFOV, "AimbotFOV",
            10, 180, " deg")
        CreateSlider(UI.ContentFrame, L.AimbotSmooth, "AimbotSmooth",
            0, 10, "")
        CreateToggle(UI.ContentFrame, L.SilentAimbot, "SilentAimbot")
        CreateToggle(UI.ContentFrame, L.Triggerbot, "Triggerbot")
        CreateToggle(UI.ContentFrame, L.InfiniteAmmo, "InfiniteAmmo",
            function(v)
                if v then EnableInfAmmo() end
            end)

    elseif tab == "Visuals" then
        CreateSectionHeader(UI.ContentFrame,
            State.CurrentLanguage == "RU"
            and "ВИЗУАЛЬНЫЕ ФУНКЦИИ" or "VISUAL FEATURES")
        CreateToggle(UI.ContentFrame, L.FullBright, "FullBright",
            function(v)
                if v then EnableFullBright() else DisableFullBright() end
            end)
        CreateToggle(UI.ContentFrame, L.RemoveFog, "RemoveFog",
            function(v)
                if v then EnableNoFog() else DisableNoFog() end
            end)
        CreateToggle(UI.ContentFrame, L.RemoveRain, "RemoveRain",
            function(v)
                if v then EnableNoRain() else DisableNoRain() end
            end)
        CreateToggle(UI.ContentFrame, L.XRay, "XRay", function(v)
            if v then EnableXRay() else DisableXRay() end
        end)
        CreateToggle(UI.ContentFrame, L.Chams, "Chams", function(v)
            if v then EnableChams() else DisableChams() end
        end)
        CreateButton(UI.ContentFrame, L.TimeDay,
            function() Lighting.ClockTime = 12 end)
        CreateButton(UI.ContentFrame, L.TimeNight,
            function() Lighting.ClockTime = 0 end)
        CreateButton(UI.ContentFrame, L.TimeSunset,
            function() Lighting.ClockTime = 18 end)

    elseif tab == "Movement" then
        CreateSectionHeader(UI.ContentFrame,
            State.CurrentLanguage == "RU"
            and "ДВИЖЕНИЕ" or "MOVEMENT")
        CreateSlider(UI.ContentFrame, L.Speed, "Speed", 16, 200, "")
        CreateSlider(UI.ContentFrame, L.Jump, "Jump", 50, 350, "")
        CreateToggle(UI.ContentFrame, L.NoClip, "NoClip", function(v)
            if v then EnableNoClip() end
        end)
        CreateToggle(UI.ContentFrame, L.Fly, "Fly", function(v)
            if v then EnableFly() else DisableFly() end
        end)
        CreateSlider(UI.ContentFrame, L.FlySpeed, "FlySpeed", 10, 200, "")
        CreateToggle(UI.ContentFrame, L.InfJump, "InfJump", function(v)
            if v then EnableInfJump() else DisableInfJump() end
        end)
        CreateToggle(UI.ContentFrame, L.NoFall, "NoFall")

    elseif tab == "World" then
        CreateSectionHeader(UI.ContentFrame,
            State.CurrentLanguage == "RU"
            and "ФУНКЦИИ МИРА" or "WORLD FEATURES")
        CreateToggle(UI.ContentFrame, L.AutoFarm, "AutoFarm", function(v)
            if v then EnableAutoFarm() end
        end)
        CreateToggle(UI.ContentFrame, L.AutoCollect, "AutoCollect",
            function(v)
                if v then EnableAutoCollect() end
            end)
        CreateToggle(UI.ContentFrame, L.AutoWin, "AutoWin", function(v)
            if v then EnableAutoWin() end
        end)
        CreateToggle(UI.ContentFrame, L.AutoKill, "AutoKill", function(v)
            if v then EnableAutoKill() end
        end)
        CreateButton(UI.ContentFrame, L.TeleportMurder, TeleportToMurder)
        CreateButton(UI.ContentFrame, L.TeleportSheriff, TeleportToSheriff)
        CreateButton(UI.ContentFrame, L.TeleportAll, TeleportToAll)

    elseif tab == "Misc" then
        CreateSectionHeader(UI.ContentFrame,
            State.CurrentLanguage == "RU"
            and "РАЗНОЕ" or "MISCELLANEOUS")
        CreateToggle(UI.ContentFrame, L.AntiKick, "AntiKick")
        CreateToggle(UI.ContentFrame, L.AntiCheatBypass, "AntiCheatBypass")
        CreateButton(UI.ContentFrame, L.Rejoin, RejoinServer)
        CreateButton(UI.ContentFrame, L.ServerHop, ServerHop)
        CreateButton(UI.ContentFrame, L.CopyIP, CopyServerIP)

    elseif tab == "Settings" then
        CreateSectionHeader(UI.ContentFrame,
            State.CurrentLanguage == "RU"
            and "НАСТРОЙКИ" or "SETTINGS")
        CreateButton(UI.ContentFrame,
            L.Language .. ": "
            .. (State.CurrentLanguage == "RU" and "EN" or "RU"),
            function()
                State.CurrentLanguage = State.CurrentLanguage == "RU"
                    and "EN" or "RU"
                L = Lang[State.CurrentLanguage]
                RefreshUILanguage()
            end)
        CreateButton(UI.ContentFrame, L.ToggleUI, function()
            if UI.MainFrame then
                UI.MainFrame.Visible = not UI.MainFrame.Visible
            end
        end)
        Create("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = L.Credits,
            TextColor3 = Color3.fromRGB(100, 100, 130),
            Font = Enum.Font.Gotham,
            TextSize = 10,
            Parent = UI.ContentFrame
        })
    end
end

local function RefreshUILanguage()
    if UI.TitleText then
        UI.TitleText.Text = L.Title
    end
    local tabBar = UI.TabBar
    if not tabBar then return end
    local tabLabels = {
        {"Бой","Combat"}, {"Визуал","Visuals"},
        {"Движение","Movement"}, {"Мир","World"},
        {"Разное","Misc"}, {"Настройки","Settings"}
    }
    local tabIcons = {"[C]","[V]","[M]","[W]","[X]","[S]"}
    local i = 1
    for _, btn in ipairs(tabBar:GetChildren()) do
        if btn:IsA("TextButton") and tabLabels[i] then
            btn.Text = tabIcons[i] .. " "
                .. (State.CurrentLanguage == "RU"
                    and tabLabels[i][1] or tabLabels[i][2])
            i = i + 1
        end
    end
    -- Refresh active tab
    for _, btn in ipairs(tabBar:GetChildren()) do
        if btn:IsA("TextButton")
        and btn.BackgroundColor3 == Color3.fromRGB(88, 101, 242) then
            RefreshTabContent(btn.Name)
            break
        end
    end
end

--[[ ======================== KEY SYSTEM ======================== ]]

local function CreateKeySystem()
    local sg = UI.ScreenGui

    local overlay = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.55,
        Parent = sg
    })

    local kf = Create("Frame", {
        Size = UDim2.new(0, 340, 0, 380),
        Position = UDim2.new(0.5, -170, 0.5, -190),
        BackgroundColor3 = Color3.fromRGB(15, 14, 30),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = sg
    })
    AddCorner(kf, 14)

    -- Accent line
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Parent = kf
    })

    -- Title
    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 30),
        Position = UDim2.new(0, 20, 0, 30),
        BackgroundTransparency = 1,
        Text = L.Title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = kf
    })

    -- Subtitle
    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 20),
        Position = UDim2.new(0, 20, 0, 62),
        BackgroundTransparency = 1,
        Text = L.Subtitle,
        TextColor3 = Color3.fromRGB(160, 158, 185),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = kf
    })

    -- Input
    local inputBox = Create("TextBox", {
        Size = UDim2.new(1, -60, 0, 44),
        Position = UDim2.new(0, 30, 0, 110),
        BackgroundColor3 = Color3.fromRGB(30, 28, 52),
        BorderSizePixel = 0,
        PlaceholderText = L.KeyPlaceholder,
        PlaceholderColor3 = Color3.fromRGB(120, 118, 145),
        Text = "",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        ClearTextOnFocus = false,
        Parent = kf
    })
    AddCorner(inputBox, 8)
    AddStroke(inputBox)

    -- Status
    local statusLabel = Create("TextLabel", {
        Size = UDim2.new(1, -60, 0, 18),
        Position = UDim2.new(0, 30, 0, 162),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 80, 80),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        Parent = kf
    })

    -- Login button
    local loginBtn = Create("TextButton", {
        Size = UDim2.new(1, -60, 0, 48),
        Position = UDim2.new(0, 30, 0, 195),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Text = L.KeyButton,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Parent = kf
    })
    AddCorner(loginBtn, 10)

    -- Credits
    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 16),
        Position = UDim2.new(0, 20, 0, 345),
        BackgroundTransparency = 1,
        Text = L.Credits,
        TextColor3 = Color3.fromRGB(90, 88, 115),
        Font = Enum.Font.Gotham,
        TextSize = 10,
        Parent = kf
    })

    -- Animate in
    kf.Size = UDim2.new(0, 340, 0, 0)
    TweenService:Create(kf, TweenInfo.new(0.5,
        Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 340, 0, 380)}):Play()

    local function validateKey(key)
        key = key:gsub("%s+", "")
        if key == "" then return false end
        for _, valid in ipairs(CONFIG.Keys) do
            if key == valid then return true end
        end
        return false
    end

    local function tryLogin()
        if validateKey(inputBox.Text) then
            statusLabel.Text = L.KeySuccess
            statusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
            State.LoggedIn = true
            TweenService:Create(kf, TweenInfo.new(0.3,
                Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 340, 0, 0)}):Play()
            task.wait(0.35)
            kf:Destroy()
            overlay:Destroy()
            CreateMainMenu()
        else
            statusLabel.Text = L.KeyError
            statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            -- Shake
            local origPos = kf.Position
            for i = 1, 3 do
                kf.Position = UDim2.new(0.5, -165, 0.5, -190)
                task.wait(0.04)
                kf.Position = UDim2.new(0.5, -175, 0.5, -190)
                task.wait(0.04)
            end
            kf.Position = origPos
        end
    end

    loginBtn.MouseButton1Click:Connect(tryLogin)

    -- FIX: НЕ loginBtn:Fire(), а вызываем функцию напрямую
    inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            tryLogin()
        end
    end)
end

--[[ ======================== MAIN MENU ======================== ]]

function CreateMainMenu()
    local sg = UI.ScreenGui

    local main = Create("Frame", {
        Size = UDim2.new(0, 400, 0, 560),
        Position = UDim2.new(0.5, -200, 0.5, -280),
        BackgroundColor3 = Color3.fromRGB(12, 12, 24),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = sg
    })
    AddCorner(main, 14)

    if UserInputService.TouchEnabled then
        main.Size = UDim2.new(0, 360, 0, 580)
        main.Position = UDim2.new(0.5, -180, 0.5, -290)
    end

    UI.MainFrame = main

    -- Title bar
    local titleBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Color3.fromRGB(18, 16, 38),
        BorderSizePixel = 0,
        Parent = main
    })
    AddCorner(titleBar, 14)

    -- Bottom line
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Color3.fromRGB(40, 38, 72),
        BorderSizePixel = 0,
        Parent = titleBar
    })

    local titleText = Create("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = L.Title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })
    UI.TitleText = titleText

    -- Language button
    local langBtn = Create("TextButton", {
        Size = UDim2.new(0, 34, 0, 34),
        Position = UDim2.new(1, -42, 0, 5),
        BackgroundColor3 = Color3.fromRGB(30, 28, 55),
        BorderSizePixel = 0,
        Text = "EN",
        TextColor3 = Color3.fromRGB(200, 200, 220),
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        Parent = titleBar
    })
    AddCorner(langBtn, 8)

    langBtn.MouseButton1Click:Connect(function()
        State.CurrentLanguage = State.CurrentLanguage == "RU"
            and "EN" or "RU"
        L = Lang[State.CurrentLanguage]
        langBtn.Text = State.CurrentLanguage == "RU" and "EN" or "RU"
        RefreshUILanguage()
    end)

    -- Drag system (FIX: proper variable declaration)
    local isDragging = false
    local dragStartPos = nil
    local frameStartPos = nil

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStartPos = input.Position
            frameStartPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and frameStartPos and dragStartPos then
            if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStartPos
                main.Position = UDim2.new(
                    frameStartPos.X.Scale,
                    frameStartPos.X.Offset + delta.X,
                    frameStartPos.Y.Scale,
                    frameStartPos.Y.Offset + delta.Y
                )
            end
        end
    end)

    -- Toggle hotkey
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.RightShift
        or input.KeyCode == Enum.KeyCode.Insert then
            main.Visible = not main.Visible
        end
    end)

    -- Tab bar
    local tabBar = Create("Frame", {
        Size = UDim2.new(1, -16, 0, 36),
        Position = UDim2.new(0, 8, 0, 48),
        BackgroundColor3 = Color3.fromRGB(22, 20, 44),
        BorderSizePixel = 0,
        Parent = main
    })
    AddCorner(tabBar, 10)
    UI.TabBar = tabBar

    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 3),
        Parent = tabBar
    })
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 4),
        Parent = tabBar
    })

    -- Content frame
    local contentFrame = Create("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -100),
        Position = UDim2.new(0, 8, 0, 90),
        BackgroundColor3 = Color3.fromRGB(16, 15, 34),
        BorderSizePixel = 0,
        ScrollBarThickness = UserInputService.TouchEnabled and 6 or 3,
        ScrollBarImageColor3 = Color3.fromRGB(88, 101, 242),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = main
    })
    AddCorner(contentFrame, 10)
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        Parent = contentFrame
    })
    Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        Parent = contentFrame
    })
    UI.ContentFrame = contentFrame

    -- Tabs
    local tabNames = {
        "Combat", "Visuals", "Movement", "World", "Misc", "Settings"
    }
    local tabLabelsData = {
        {"Бой","Combat"}, {"Визуал","Visuals"},
        {"Движение","Movement"}, {"Мир","World"},
        {"Разное","Misc"}, {"Настройки","Settings"}
    }
    local tabIcons = {"[C]","[V]","[M]","[W]","[X]","[S]"}

    for i, name in ipairs(tabNames) do
        local isFirst = (i == 1)
        local tabBtn = Create("TextButton", {
            Name = name,
            Size = UDim2.new(0, 0, 0, 28),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = isFirst
                and Color3.fromRGB(88, 101, 242)
                or Color3.fromRGB(35, 33, 60),
            BorderSizePixel = 0,
            Text = " " .. tabIcons[i] .. " "
                .. (State.CurrentLanguage == "RU"
                    and tabLabelsData[i][1]
                    or tabLabelsData[i][2]) .. " ",
            TextColor3 = isFirst
                and Color3.fromRGB(255, 255, 255)
                or Color3.fromRGB(180, 180, 200),
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            Parent = tabBar
        })
        AddCorner(tabBtn, 7)

        tabBtn.MouseButton1Click:Connect(function()
            for _, b in ipairs(tabBar:GetChildren()) do
                if b:IsA("TextButton") then
                    b.BackgroundColor3 = Color3.fromRGB(35, 33, 60)
                    b.TextColor3 = Color3.fromRGB(180, 180, 200)
                end
            end
            tabBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            RefreshTabContent(name)
        end)
    end

    RefreshTabContent("Combat")

    -- Animate in
    main.BackgroundTransparency = 1
    TweenService:Create(main, TweenInfo.new(0.4),
        {BackgroundTransparency = 0}):Play()
end

--[[ ======================== INIT ======================== ]]

-- Удаляем старый GUI если есть
pcall(function()
    local old = CoreGui:FindFirstChild("HackerAI_MM2_Suite")
    if old then old:Destroy() end
end)
pcall(function()
    local old = Player.PlayerGui:FindFirstChild("HackerAI_MM2_Suite")
    if old then old:Destroy() end
end)

UI.ScreenGui = Instance.new("ScreenGui")
UI.ScreenGui.Name = "HackerAI_MM2_Suite"
UI.ScreenGui.ResetOnSpawn = false
UI.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local guiOk = pcall(function()
    UI.ScreenGui.Parent = CoreGui
end)
if not guiOk then
    UI.ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

-- Запуск
CreateKeySystem()

print("[HackerAI] MM2 Suite loaded successfully (Delta Fixed)")
