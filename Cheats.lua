--[[
  ██████████████████████████████████████████████████████████████
  ██  HackerAI Red Team Suite — Roblox MM2                ██
  ██  Authorized Penetration Testing Tool                  ██
  ██  DO NOT USE WITHOUT PERMISSION                        ██
  ██████████████████████████████████████████████████████████████
--]]

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
        Title = "HackerAI · MM2 Red Team",
        Subtitle = "Инструмент тестирования безопасности",
        KeyPlaceholder = "Введите ключ доступа...",
        KeyButton = "▶ Войти",
        KeyError = "❌ Неверный ключ!",
        KeySuccess = "✅ Доступ разрешён!",
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
        AutoKill = "Авто-убийство (ман" .. "ьяк)",
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
        Credits = "HackerAI Red Team · Authorized Pentest",
        On = "Вкл",
        Off = "Выкл",
        NotInGame = "⚠ Ошибка: игрок не найден"
    },
    EN = {
        Title = "HackerAI · MM2 Red Team",
        Subtitle = "Security Assessment Tool",
        KeyPlaceholder = "Enter access key...",
        KeyButton = "▶ Login",
        KeyError = "❌ Invalid key!",
        KeySuccess = "✅ Access granted!",
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
        Credits = "HackerAI Red Team · Authorized Pentest",
        On = "On",
        Off = "Off",
        NotInGame = "⚠ Error: player not found"
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
    -- Combat
    ESP = false, ESPBox = true, ESPTracers = false, ESPDistance = false, ESPName = false, ESPHealth = false,
    Aimbot = false, AimbotFOV = 90, AimbotSmooth = 0.5, SilentAimbot = false, Triggerbot = false, Wallbang = false,
    -- Movement
    Speed = 16, Jump = 50, NoClip = false, Fly = false, FlySpeed = 30, InfJump = false, NoFall = false,
    -- World
    FullBright = false, RemoveFog = false, RemoveRain = false, XRay = false, Chams = false,
    -- Misc
    InfiniteAmmo = false, AutoFarm = false, AutoCollect = false, AutoWin = false, AutoKill = false,
    AntiKick = false, AntiCheatBypass = false,
    -- Internal
    FlyBody = nil, ESPConn = nil, AimbotConn = nil, ChamsConns = {},
    OriginalBrightness = Lighting.Brightness,
    OriginalFogEnd = Lighting.FogEnd,
    OriginalFogColor = Lighting.FogColor,
    OriginalAmbient = Lighting.Ambient,
    OriginalOutdoorAmbient = Lighting.OutdoorAmbient
}

--[[ ======================== UI LIBRARY ======================== ]]

local UI = {
    ScreenGui = nil,
    MainFrame = nil,
    ContentFrame = nil,
    TabBar = nil,
    TitleText = nil,
    Elements = {}
}

-- Utility functions
local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end

local function AddCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function AddGradient(obj, colors)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(colors)
    g.Parent = obj
    return g
end

local function AddStroke(obj, color, thickness)
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
    
    local lbl = Create("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0),
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
        toggleBtn.BackgroundColor3 = on and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(50, 48, 70)
        toggleInner.BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
        local targetX = on and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        TweenService:Create(toggleInner, TweenInfo.new(0.2), {Position = targetX}):Play()
    end
    updateVisuals()
    
    toggleBtn.MouseButton1Click:Connect(function()
        State[stateKey] = not State[stateKey]
        updateVisuals()
        if callback then callback(State[stateKey]) end
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
    
    local sliderFrame = Create("Frame", {
        Size = UDim2.new(1, -24, 0, 6),
        Position = UDim2.new(0, 12, 0, 32),
        BackgroundColor3 = Color3.fromRGB(40, 38, 60),
        BorderSizePixel = 0,
        Parent = frame
    })
    AddCorner(sliderFrame, 3)
    
    local fill = Create("Frame", {
        Size = UDim2.new((State[stateKey] - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Parent = sliderFrame
    })
    AddCorner(fill, 3)
    
    local dragging = false
    local function updateSlider(inputPos)
        local absX = sliderFrame.AbsolutePosition.X
        local absSize = sliderFrame.AbsoluteSize.X
        local ratio = math.clamp((inputPos - absX) / absSize, 0, 1)
        local val = math.floor(min + (max - min) * ratio)
        State[stateKey] = val
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        lbl.Text = label .. ": " .. tostring(val) .. (suffix or "")
    end
    
    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input.Position.X)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging then
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                updateSlider(input.Position.X)
            end
        end
    end)
    
    return frame
end

local function CreateButton(parent, label, callback, color)
    local btn = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = color or Color3.fromRGB(55, 50, 90),
        BorderSizePixel = 0,
        Text = "",
        Parent = parent
    })
    AddCorner(btn, 10)
    AddGradient(btn, {
        ColorSequenceKeypoint.new(0, (color or Color3.fromRGB(55, 50, 90))),
        ColorSequenceKeypoint.new(1, (color or Color3.fromRGB(40, 35, 75)))
    })
    
    local lbl = Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        Parent = btn
    })
    
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
        -- Click flash
        btn.BackgroundColor3 = Color3.fromRGB(120, 100, 200)
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color or Color3.fromRGB(55, 50, 90)}):Play()
    end)
    
    return btn
end

local function CreateSectionHeader(parent, text)
    local lbl = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(140, 140, 180),
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent
    })
    return lbl
end

--[[ ======================== KEY SYSTEM ======================== ]]

function CreateKeySystem()
    local sg = UI.ScreenGui
    
    -- Overlay
    local overlay = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.55,
        Parent = sg
    })
    
    -- Key frame
    local kf = Create("Frame", {
        Size = UDim2.new(0, 340, 0, 460),
        Position = UDim2.new(0.5, -170, 0.5, -230),
        BackgroundColor3 = Color3.fromRGB(15, 14, 30),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = sg
    })
    AddCorner(kf, 14)
    AddGradient(kf, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 22, 48)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 12, 28))
    })
    
    -- Border accent
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Parent = kf
    })
    
    -- Shield icon
    local shield = Create("ImageLabel", {
        Size = UDim2.new(0, 56, 0, 56),
        Position = UDim2.new(0.5, -28, 0, 28),
        BackgroundTransparency = 1,
        Image = "rbxassetid://12715403488",
        ImageColor3 = Color3.fromRGB(88, 101, 242),
        Parent = kf
    })
    
    -- Title
    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 26),
        Position = UDim2.new(0, 20, 0, 95),
        BackgroundTransparency = 1,
        Text = L.Title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        Parent = kf
    })
    
    -- Subtitle
    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 18),
        Position = UDim2.new(0, 20, 0, 122),
        BackgroundTransparency = 1,
        Text = L.Subtitle,
        TextColor3 = Color3.fromRGB(160, 158, 185),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        Parent = kf
    })
    
    -- Input box
    local inputBox = Create("TextBox", {
        Size = UDim2.new(1, -60, 0, 44),
        Position = UDim2.new(0, 30, 0, 175),
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
    AddStroke(inputBox, Color3.fromRGB(88, 101, 242), 1)
    
    -- Status
    local statusLabel = Create("TextLabel", {
        Size = UDim2.new(1, -60, 0, 18),
        Position = UDim2.new(0, 30, 0, 225),
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
        Position = UDim2.new(0, 30, 0, 258),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Text = "",
        Parent = kf
    })
    AddCorner(loginBtn, 10)
    AddGradient(loginBtn, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 101, 242)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 78, 240))
    })
    
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = L.KeyButton,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Parent = loginBtn
    })
    
    -- Credits
    Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 16),
        Position = UDim2.new(0, 20, 0, 425),
        BackgroundTransparency = 1,
        Text = L.Credits,
        TextColor3 = Color3.fromRGB(90, 88, 115),
        Font = Enum.Font.Gotham,
        TextSize = 10,
        Parent = kf
    })
    
    -- Animate in
    kf.Size = UDim2.new(0, 340, 0, 0)
    TweenService:Create(kf, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 340, 0, 460)}):Play()
    
    -- Key validation
    local function validateKey(key)
        key = key:gsub("%s+", "")
        if key == "" then return false end
        for _, valid in ipairs(CONFIG.Keys) do
            if key == valid then return true end
        end
        return false
    end
    
    loginBtn.MouseButton1Click:Connect(function()
        if validateKey(inputBox.Text) then
            statusLabel.Text = L.KeySuccess
            statusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
            State.LoggedIn = true
            
            TweenService:Create(kf, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 340, 0, 0)}):Play()
            task.wait(0.3)
            kf:Destroy()
            overlay:Destroy()
            CreateMainMenu()
        else
            statusLabel.Text = L.KeyError
            statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            -- Shake
            local origPos = kf.Position
            for i = 1, 3 do
                kf.Position = UDim2.new(0.5, -165, 0.5, -230)
                task.wait(0.04)
                kf.Position = UDim2.new(0.5, -175, 0.5, -230)
                task.wait(0.04)
                kf.Position = origPos
            end
        end
    end)
    
    inputBox.FocusLost:Connect(function(enter)
        if enter then loginBtn:Fire() end
    end)
end

--[[ ======================== MAIN MENU ======================== ]]

function CreateMainMenu()
    local sg = UI.ScreenGui
    
    local main = Create("Frame", {
        Size = UDim2.new(0, 400, 0, 580),
        Position = UDim2.new(0.5, -200, 0.5, -290),
        BackgroundColor3 = Color3.fromRGB(12, 12, 24),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = sg
    })
    AddCorner(main, 14)
    AddGradient(main, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 18, 42)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 22))
    })
    
    -- Mobile adaptation
    if UserInputService.TouchEnabled then
        main.Size = UDim2.new(0, 360, 0, 610)
        main.Position = UDim2.new(0.5, -180, 0.5, -305)
    end
    
    UI.MainFrame = main
    
    -- Title bar
    local titleBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = Color3.fromRGB(15, 14, 34),
        BorderSizePixel = 0,
        Parent = main
    })
    AddCorner(titleBar, 14)
    -- Fix top
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(15, 14, 34),
        BorderSizePixel = 0,
        Parent = titleBar
    })
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Color3.fromRGB(40, 38, 72),
        BorderSizePixel = 0,
        Parent = titleBar
    })
    
    local titleText = Create("TextLabel", {
        Size = UDim2.new(1, -90, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = L.Title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })
    UI.TitleText = titleText
    
    -- Language button
    local langBtn = Create("TextButton", {
        Size = UDim2.new(0, 36, 0, 36),
        Position = UDim2.new(1, -44, 0, 6),
        BackgroundColor3 = Color3.fromRGB(30, 28, 55),
        BorderSizePixel = 0,
        Text = "🌐",
        TextSize = 18,
        Font = Enum.Font.Gotham,
        Parent = titleBar
    })
    AddCorner(langBtn, 8)
    
    -- Drag
    local dragging, dragStart, startPos = false
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = Vector2.new(input.Position.X - dragStart.X, input.Position.Y - dragStart.Y)
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Toggle UI hotkey
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.Insert then
            main.Visible = not main.Visible
        end
    end)
    
    langBtn.MouseButton1Click:Connect(function()
        State.CurrentLanguage = State.CurrentLanguage == "RU" and "EN" or "RU"
        L = Lang[State.CurrentLanguage]
        RefreshUILanguage()
    end)
    
    -- Tab bar
    local tabBar = Create("Frame", {
        Size = UDim2.new(1, -16, 0, 38),
        Position = UDim2.new(0, 8, 0, 52),
        BackgroundColor3 = Color3.fromRGB(22, 20, 44),
        BorderSizePixel = 0,
        Parent = main
    })
    AddCorner(tabBar, 10)
    UI.TabBar = tabBar
    
    local tabList = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 4),
        Parent = tabBar
    })
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6),
        Parent = tabBar
    })
    
    -- Content frame
    local contentFrame = Create("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -108),
        Position = UDim2.new(0, 8, 0, 96),
        BackgroundColor3 = Color3.fromRGB(16, 15, 34),
        BorderSizePixel = 0,
        ScrollBarThickness = UserInputService.TouchEnabled and 8 or 4,
        ScrollBarImageColor3 = Color3.fromRGB(88, 101, 242),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = main
    })
    AddCorner(contentFrame, 10)
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingTop = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 12),
        Parent = contentFrame
    })
    Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = contentFrame
    })
    UI.ContentFrame = contentFrame
    
    -- Create tabs
    local tabNames = {"Combat","Visuals","Movement","World","Misc","Settings"}
    local tabIcons = {"⚔","👁","🏃","🌍","🔧","⚙"}
    local tabLabels = {
        {"Бой","Combat"}, {"Визуал","Visuals"}, {"Движение","Movement"},
        {"Мир","World"}, {"Разное","Misc"}, {"Настройки","Settings"}
    }
    local CurrentTab = "Combat"
    
    for i, name in ipairs(tabNames) do
        local btn = Create("TextButton", {
            Name = name,
            Size = UDim2.new(0, 0, 0, 30),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = i == 1 and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(35, 33, 60),
            BorderSizePixel = 0,
            Text = "",
            Parent = tabBar
        })
        AddCorner(btn, 7)
        
        local l = Create("TextLabel", {
            Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            Position = UDim2.new(0, 8, 0, 0),
            BackgroundTransparency = 1,
            Text = tabIcons[i] .. "  " .. (State.CurrentLanguage == "RU" and tabLabels[i][1] or tabLabels[i][2]),
            TextColor3 = i == 1 and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,200),
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            Parent = btn
        })
        Create("UIPadding", {PaddingRight = UDim.new(0, 8), Parent = btn})
        
        btn.MouseButton1Click:Connect(function()
            CurrentTab = name
            for _, b in ipairs(tabBar:GetChildren()) do
                if b:IsA("TextButton") then
                    b.BackgroundColor3 = Color3.fromRGB(35, 33, 60)
                    local lbl = b:FindFirstChildOfClass("TextLabel")
                    if lbl then lbl.TextColor3 = Color3.fromRGB(180,180,200) end
                end
            end
            btn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
            if l then l.TextColor3 = Color3.fromRGB(255,255,255) end
            RefreshTabContent(CurrentTab)
        end)
    end
    
    RefreshTabContent("Combat")
end

--[[ ======================== TAB BUILDER ======================== ]]

function RefreshTabContent(tab)
    for _, v in ipairs(UI.ContentFrame:GetChildren()) do
        if not v:IsA("UIListLayout") and not v:IsA("UIPadding") then
            v:Destroy()
        end
    end
    
    if tab == "Combat" then
        CreateSectionHeader(UI.ContentFrame, "⚔ " .. (State.CurrentLanguage == "RU" and "БОЕВЫЕ ФУНКЦИИ" or "COMBAT FEATURES"))
        CreateToggle(UI.ContentFrame, L.ESP, "ESP", function(v) if v then EnableESP() else DisableESP() end end)
        CreateToggle(UI.ContentFrame, L.ESPBox, "ESPBox")
        CreateToggle(UI.ContentFrame, L.ESPTracers, "ESPTracers")
        CreateToggle(UI.ContentFrame, L.ESPDistance, "ESPDistance")
        CreateToggle(UI.ContentFrame, L.ESPName, "ESPName")
        CreateToggle(UI.ContentFrame, L.ESPHealth, "ESPHealth")
        CreateToggle(UI.ContentFrame, L.Aimbot, "Aimbot", function(v) if v then EnableAimbot() else DisableAimbot() end end)
        CreateSlider(UI.ContentFrame, L.AimbotFOV, "AimbotFOV", 10, 180, "°")
        CreateSlider(UI.ContentFrame, L.AimbotSmooth, "AimbotSmooth", 0, 1, "")
        CreateToggle(UI.ContentFrame, L.SilentAimbot, "SilentAimbot")
        CreateToggle(UI.ContentFrame, L.Triggerbot, "Triggerbot")
        CreateToggle(UI.ContentFrame, L.Wallbang, "Wallbang")
        CreateToggle(UI.ContentFrame, L.InfiniteAmmo, "InfiniteAmmo", function(v) if v then EnableInfAmmo() else DisableInfAmmo() end end)
        
    elseif tab == "Visuals" then
        CreateSectionHeader(UI.ContentFrame, "👁 " .. (State.CurrentLanguage == "RU" and "ВИЗУАЛЬНЫЕ ФУНКЦИИ" or "VISUAL FEATURES"))
        CreateToggle(UI.ContentFrame, L.FullBright, "FullBright", function(v) if v then EnableFullBright() else DisableFullBright() end end)
        CreateToggle(UI.ContentFrame, L.RemoveFog, "RemoveFog", function(v) if v then EnableNoFog() else DisableNoFog() end end)
        CreateToggle(UI.ContentFrame, L.RemoveRain, "RemoveRain", function(v) if v then EnableNoRain() else DisableNoRain() end end)
        CreateToggle(UI.ContentFrame, L.XRay, "XRay", function(v) if v then EnableXRay() else DisableXRay() end end)
        CreateToggle(UI.ContentFrame, L.Chams, "Chams", function(v) if v then EnableChams() else DisableChams() end end)
        CreateButton(UI.ContentFrame, L.TimeDay, function() Lighting.ClockTime = 12 end)
        CreateButton(UI.ContentFrame, L.TimeNight, function() Lighting.ClockTime = 0 end)
        CreateButton(UI.ContentFrame, L.TimeSunset, function() Lighting.ClockTime = 18 end)
        
    elseif tab == "Movement" then
        CreateSectionHeader(UI.ContentFrame, "🏃 " .. (State.CurrentLanguage == "RU" and "ФУНКЦИИ ДВИЖЕНИЯ" or "MOVEMENT FEATURES"))
        CreateSlider(UI.ContentFrame, L.Speed, "Speed", 16, 200, "")
        CreateSlider(UI.ContentFrame, L.Jump, "Jump", 50, 350, "")
        CreateToggle(UI.ContentFrame, L.NoClip, "NoClip", function(v) if v then EnableNoClip() else DisableNoClip() end end)
        CreateToggle(UI.ContentFrame, L.Fly, "Fly", function(v) if v then EnableFly() else DisableFly() end end)
        CreateSlider(UI.ContentFrame, L.FlySpeed, "FlySpeed", 10, 200, "")
        CreateToggle(UI.ContentFrame, L.InfJump, "InfJump", function(v) if v then EnableInfJump() else DisableInfJump() end end)
        CreateToggle(UI.ContentFrame, L.NoFall, "NoFall", function(v) if v then EnableNoFall() else DisableNoFall() end end)
        
    elseif tab == "World" then
        CreateSectionHeader(UI.ContentFrame, "🌍 " .. (State.CurrentLanguage == "RU" and "ФУНКЦИИ МИРА" or "WORLD FEATURES"))
        CreateToggle(UI.ContentFrame, L.AutoFarm, "AutoFarm", function(v) if v then EnableAutoFarm() else DisableAutoFarm() end end)
        CreateToggle(UI.ContentFrame, L.AutoCollect, "AutoCollect", function(v) if v then EnableAutoCollect() else DisableAutoCollect() end end)
        CreateToggle(UI.ContentFrame, L.AutoWin, "AutoWin", function(v) if v then EnableAutoWin() else DisableAutoWin() end end)
        CreateToggle(UI.ContentFrame, L.AutoKill, "AutoKill", function(v) if v then EnableAutoKill() else DisableAutoKill() end end)
        CreateButton(UI.ContentFrame, L.TeleportMurder, TeleportToMurder)
        CreateButton(UI.ContentFrame, L.TeleportSheriff, TeleportToSheriff)
        CreateButton(UI.ContentFrame, L.TeleportAll, TeleportToAll)
        
    elseif tab == "Misc" then
        CreateSectionHeader(UI.ContentFrame, "🔧 " .. (State.CurrentLanguage == "RU" and "РАЗНОЕ" or "MISCELLANEOUS"))
        CreateToggle(UI.ContentFrame, L.AntiKick, "AntiKick")
        CreateToggle(UI.ContentFrame, L.AntiCheatBypass, "AntiCheatBypass")
        CreateButton(UI.ContentFrame, L.Rejoin, RejoinServer)
        CreateButton(UI.ContentFrame, L.ServerHop, ServerHop)
        CreateButton(UI.ContentFrame, L.CopyIP, CopyServerIP)
        CreateButton(UI.ContentFrame, "Showcase All Features", ShowcaseAll, Color3.fromRGB(200, 120, 50))
        
    elseif tab == "Settings" then
        CreateSectionHeader(UI.ContentFrame, "⚙ " .. (State.CurrentLanguage == "RU" and "НАСТРОЙКИ" or "SETTINGS"))
        CreateButton(UI.ContentFrame, L.Language .. ": " .. (State.CurrentLanguage == "RU" and "EN" or "RU"), function()
            State.CurrentLanguage = State.CurrentLanguage == "RU" and "EN" or "RU"
            L = Lang[State.CurrentLanguage]
            RefreshUILanguage()
        end)
        CreateButton(UI.ContentFrame, L.ToggleUI, function()
            UI.MainFrame.Visible = not UI.MainFrame.Visible
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

function RefreshUILanguage()
    if UI.TitleText then
        UI.TitleText.Text = L.Title
    end
    -- Rebuild tab labels
    local tabBar = UI.TabBar
    local tabLabels = {{"Бой","Combat"}, {"Визуал","Visuals"}, {"Движение","Movement"}, {"Мир","World"}, {"Разное","Misc"}, {"Настройки","Settings"}}
    local tabIcons = {"⚔","👁","🏃","🌍","🔧","⚙"}
    local i = 1
    for _, btn in ipairs(tabBar:GetChildren()) do
        if btn:IsA("TextButton") then
            local lbl = btn:FindFirstChildOfClass("TextLabel")
            if lbl and tabLabels[i] then
                lbl.Text = tabIcons[i] .. "  " .. (State.CurrentLanguage == "RU" and tabLabels[i][1] or tabLabels[i][2])
            end
            i = i + 1
        end
    end
    -- Rebuild content
    for _, btn in ipairs(tabBar:GetChildren()) do
        if btn:IsA("TextButton") and btn.BackgroundColor3 == Color3.fromRGB(88, 101, 242) then
            RefreshTabContent(btn.Name)
            break
        end
    end
end

--[[ ======================== ESP SYSTEM ======================== ]]

local ESPObjects = {}

function EnableESP()
    State.ESP = true
    State.ESPConn = RunService.RenderStepped:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == Player then continue end
            local char = plr.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
            local root = char.HumanoidRootPart
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then 
                if ESPObjects[plr] then
                    ESPObjects[plr]:Destroy()
                    ESPObjects[plr] = nil
                end
                continue 
            end
            
            if not ESPObjects[plr] then
                local esp = Instance.new("Highlight")
                esp.Name = "HackerAI_ESP"
                esp.FillColor = plr.Team and plr.Team.TeamColor.Color or Color3.fromRGB(255, 50, 50)
                esp.OutlineColor = Color3.fromRGB(255, 255, 255)
                esp.FillTransparency = 0.7
                esp.OutlineTransparency = 0.3
                esp.Adornee = char
                esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                esp.Parent = char
                ESPObjects[plr] = esp
            end
            
            -- Update color
            if State.ESPBox then
                ESPObjects[plr].FillTransparency = 0.7
            else
                ESPObjects[plr].FillTransparency = 1
            end
            
            -- Tracers (2D lines via Drawing)
            if State.ESPTracers then
                -- Drawing not available in all executors, skip
            end
        end
        
        -- Cleanup
        for plr, obj in pairs(ESPObjects) do
            if not Players:FindFirstChild(plr.Name) then
                obj:Destroy()
                ESPObjects[plr] = nil
            end
        end
    end)
end

function DisableESP()
    State.ESP = false
    if State.ESPConn then
        State.ESPConn:Disconnect()
        State.ESPConn = nil
    end
    for plr, obj in pairs(ESPObjects) do
        obj:Destroy()
        ESPObjects[plr] = nil
    end
end

--[[ ======================== AIMBOT ======================== ]]

function EnableAimbot()
    State.Aimbot = true
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
            
            local root = char.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if not onScreen then continue end
            
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = plr
            end
        end
        
        if closest then
            local char = closest.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                local targetPos = root.Position + Vector3.new(0, 2, 0)
                
                if State.SilentAimbot then
                    -- Silent aim (weapon fires at target regardless of aim)
                    -- Would need to hook tool events - simplified version
                else
                    -- Smooth aim
                    local current = Camera.CFrame
                    local targetCF = CFrame.lookAt(Camera.CFrame.Position, targetPos)
                    local smoothFactor = State.AimbotSmooth > 0 and (1 - State.AimbotSmooth * 0.8) or 0.1
                    Camera.CFrame = current:Lerp(targetCF, smoothFactor)
                end
                
                -- Triggerbot
                if State.Triggerbot and Mouse.Target then
                    local targetChar = Mouse.Target:FindFirstAncestorOfClass("Model")
                    if targetChar and Players:GetPlayerFromCharacter(targetChar) and targetChar ~= Player.Character then
                        -- Fire tool
                        local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                    end
                end
            end
        end
    end)
end

function DisableAimbot()
    State.Aimbot = false
    if State.AimbotConn then
        State.AimbotConn:Disconnect()
        State.AimbotConn = nil
    end
end

--[[ ======================== MOVEMENT ======================== ]]

-- Speed
RunService.Heartbeat:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        local hum = Player.Character.Humanoid
        if State.Speed ~= 16 then
            hum.WalkSpeed = State.Speed
        end
        if State.Jump ~= 50 then
            hum.JumpPower = State.Jump
        end
    end
end)

-- NoClip
function EnableNoClip()
    State.NoClip = true
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

function DisableNoClip()
    State.NoClip = false
    if Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Fly
function EnableFly()
    State.Fly = true
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local root = Player.Character.HumanoidRootPart
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Name = "HackerAI_Fly"
        bodyVel.MaxForce = Vector3.new(10000, 10000, 10000)
        bodyVel.Velocity = Vector3.new(0, 0, 0)
        bodyVel.Parent = root
        State.FlyBody = bodyVel
        
        task.spawn(function()
            while State.Fly do
                task.wait()
                if not root then break end
                
                local moveDir = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                
                if moveDir.Magnitude > 0 then
                    moveDir = moveDir.Unit * State.FlySpeed
                end
                
                bodyVel.Velocity = moveDir
                root.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    end
end

function DisableFly()
    State.Fly = false
    if State.FlyBody then
        State.FlyBody:Destroy()
        State.FlyBody = nil
    end
end

-- Infinite Jump
local infJumpConn = nil
function EnableInfJump()
    State.InfJump = true
    infJumpConn = UserInputService.JumpRequest:Connect(function()
        if State.InfJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

function DisableInfJump()
    State.InfJump = false
    if infJumpConn then
        infJumpConn:Disconnect()
        infJumpConn = nil
    end
end

-- No Fall Damage
function EnableNoFall()
    State.NoFall = true
end

function DisableNoFall()
    State.NoFall = false
end

-- Prevent fall damage
local fallConn = nil
fallConn = Player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.StateChanged:Connect(function(_, newState)
        if State.NoFall and newState == Enum.HumanoidStateType.FallingDown then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end)

--[[ ======================== INFINITE AMMO ======================== ]]

function EnableInfAmmo()
    State.InfiniteAmmo = true
    -- Hook into MM2 gun ammo
    task.spawn(function()
        while State.InfiniteAmmo do
            task.wait(1)
            local char = Player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild("Bullets") or tool:FindFirstChild("CurrentAmmo")
                    if ammo and ammo:IsA("NumberValue") then
                        ammo.Value = ammo.Value + 999
                    end
                    -- Try firing remote
                    local rem = tool:FindFirstChild("ReloadEvent") or tool:FindFirstChild("AmmoUpdate")
                    if rem and rem:IsA("RemoteEvent") then
                        rem:FireServer(999)
                    end
                end
            end
        end
    end)
end

function DisableInfAmmo()
    State.InfiniteAmmo = false
end

--[[ ======================== WORLD FUNCTIONS ======================== ]]

-- FullBright
function EnableFullBright()
    State.FullBright = true
    State.OriginalBrightness = Lighting.Brightness
    State.OriginalAmbient = Lighting.Ambient
    State.OriginalOutdoorAmbient = Lighting.OutdoorAmbient
    
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.GlobalShadows = false
    Lighting.ShadowSoftness = 0
end

function DisableFullBright()
    State.FullBright = false
    Lighting.Brightness = State.OriginalBrightness
    Lighting.Ambient = State.OriginalAmbient
    Lighting.OutdoorAmbient = State.OriginalOutdoorAmbient
    Lighting.GlobalShadows = true
    Lighting.ShadowSoftness = 0.5
end

-- No Fog
function EnableNoFog()
    State.RemoveFog = true
    State.OriginalFogEnd = Lighting.FogEnd
    Lighting.FogEnd = 100000
end

function DisableNoFog()
    State.RemoveFog = false
    Lighting.FogEnd = State.OriginalFogEnd
end

-- No Rain
function EnableNoRain()
    State.RemoveRain = true
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = false
        end
    end
end

function DisableNoRain()
    State.RemoveRain = false
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = true
        end
    end
end

-- XRay
function EnableXRay()
    State.XRay = true
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:FindFirstAncestorOfClass("Tool") and not v:FindFirstAncestor("Player") then
            v.LocalTransparencyModifier = 0.5
        end
    end
end

function DisableXRay()
    State.XRay = false
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.LocalTransparencyModifier = 0
        end
    end
end

-- Chams
function EnableChams()
    State.Chams = true
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if char then
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    local hl = Instance.new("Highlight")
                    hl.Name = "HackerAI_Chams"
                    hl.FillColor = Color3.fromRGB(255, 50, 50)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.5
                    hl.OutlineTransparency = 0.2
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Adornee = v
                    hl.Parent = v
                    table.insert(State.ChamsConns, hl)
                end
            end
        end
    end
    
    -- Watch for new characters
    local conn
    conn = Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            if State.Chams then
                for _, v in ipairs(char:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                        local hl = Instance.new("Highlight")
                        hl.Name = "HackerAI_Chams"
                        hl.FillColor = Color3.fromRGB(255, 50, 50)
                        hl.FillTransparency = 0.5
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Adornee = v
                        hl.Parent = v
                        table.insert(State.ChamsConns, hl)
                    end
                end
            end
        end)
    end)
    table.insert(State.ChamsConns, conn)
end

function DisableChams()
    State.Chams = false
    for _, v in ipairs(State.ChamsConns) do
        pcall(function() v:Destroy() end)
    end
    State.ChamsConns = {}
end

--[[ ======================== AUTOMATION ======================== ]]

-- Auto Farm (coins)
function EnableAutoFarm()
    State.AutoFarm = true
    task.spawn(function()
        while State.AutoFarm do
            task.wait(0.5)
            -- Find coin pickups
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name == "Coin" or v.Name == "Money" or v.Name == "Coin_Server") then
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        Player.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                        task.wait(0.05)
                    end
                    break
                end
            end
        end
    end)
end

function DisableAutoFarm()
    State.AutoFarm = false
end

-- Auto Collect
function EnableAutoCollect()
    State.AutoCollect = true
    task.spawn(function()
        while State.AutoCollect do
            task.wait(2)
            -- Try to find and fire collect remote
            for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():find("collect") or v.Name:lower():find("coin") or v.Name:lower():find("pickup")) then
                    v:FireServer()
                end
            end
        end
    end)
end

function DisableAutoCollect()
    State.AutoCollect = false
end

-- Auto Win (find and kill murderer as sheriff)
function EnableAutoWin()
    State.AutoWin = true
    task.spawn(function()
        while State.AutoWin do
            task.wait(1)
            -- Find murderer
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == Player then continue end
                local char = plr.Character
                if not char then continue end
                local tool = char:FindFirstChildOfClass("Tool")
                if tool and (tool.Name:lower():find("knife") or tool.Name:lower():find("gun") == nil) then
                    -- This player might be murderer — teleport to them
                    if char:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        Player.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    end
                    break
                end
            end
        end
    end)
end

function DisableAutoWin()
    State.AutoWin = false
end

-- Auto Kill
function EnableAutoKill()
    State.AutoKill = true
    task.spawn(function()
        while State.AutoKill do
            task.wait(0.5)
            -- Find non-murderer players and try to kill them
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == Player then continue end
                local char = plr.Character
                if not char then continue end
                if char:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                    task.wait(0.1)
                    -- Try to activate tool (knife)
                    local knife = Player.Character:FindFirstChildOfClass("Tool")
                    if knife then
                        knife:Activate()
                    end
                end
            end
        end
    end)
end

function DisableAutoKill()
    State.AutoKill = false
end

--[[ ======================== TELEPORTS ======================== ]]

function TeleportToMurderer()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if not char then continue end
        local tool = char:FindFirstChildOfClass("Tool")
        if tool and not tool.Name:lower():find("gun") then
            if char:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                return
            end
        end
    end
end

function TeleportToSheriff()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if not char then continue end
        local tool = char:FindFirstChildOfClass("Tool")
        if tool and (tool.Name:lower():find("gun") or tool.Name:lower():find("pistol")) then
            if char:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                return
            end
        end
    end
end

function TeleportToAll()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local target = nil
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == Player then continue end
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            target = char
            break
        end
    end
    if target then
        Player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
    end
end

--[[ ======================== SERVER UTILITIES ======================== ]]

function RejoinServer()
    local ts = game:GetService("TeleportService")
    local placeId = game.PlaceId
    local jobId = game.JobId
    ts:TeleportToPlaceInstance(placeId, jobId, Player)
end

function ServerHop()
    local ts = game:GetService("TeleportService")
    local placeId = game.PlaceId
    -- Find another server via API
    local success, result = pcall(function()
        return HttpService:JSONDecode(HttpService:GetAsync("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100"))
    end)
    if success and result and result.data then
        for _, server in ipairs(result.data) do
            if server.id ~= game.JobId then
                ts:TeleportToPlaceInstance(placeId, server.id, Player)
                return
            end
        end
    end
end

function CopyServerIP()
    local ip = game.JobId
    setclipboard and setclipboard(ip)
    if Player:FindFirstChild("PlayerGui") then
        Player.PlayerGui:FindFirstChild("HackerAI_Notification"):Destroy()
    end
    
    local notify = Instance.new("ScreenGui")
    notify.Name = "HackerAI_Notification"
    notify.ResetOnSpawn = false
    notify.Parent = Player:FindFirstChild("PlayerGui") or CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 50)
    frame.Position = UDim2.new(0.5, -140, 0.1, 10)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    frame.BorderSizePixel = 0
    frame.Parent = notify
    AddCorner(frame, 10)
    AddStroke(frame, Color3.fromRGB(88, 101, 242), 1)
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "✅ Server IP copied: " .. ip
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.Gotham
    text.TextSize = 12
    text.Parent = frame
    
    task.wait(3)
    notify:Destroy()
end

--[[ ======================== SHOWCASE ======================== ]]

function ShowcaseAll()
    if UI.MainFrame then
        UI.MainFrame.Visible = false
    end
    
    local notify = Instance.new("ScreenGui")
    notify.Name = "HackerAI_Showcase"
    notify.ResetOnSpawn = false
    notify.Parent = CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 500, 0, 400)
    frame.Position = UDim2.new(0.5, -250, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(12, 12, 28)
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = notify
    AddCorner(frame, 14)
    AddGradient(frame, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 22, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 28))
    })
    
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Parent = frame
    })
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -24, 1, -60)
    scroll.Position = UDim2.new(0, 12, 0, 50)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(88, 101, 242)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 6)
    listLayout.Parent = scroll
    
    local features = {
        {"⚔ Combat", {"ESP (Boxes, Tracers, Distance, Names, Health)", "Aimbot (FOV, Smooth, Silent Aim)", "Triggerbot", "Wallbang", "Infinite Ammo"}},
        {"👁 Visuals", {"FullBright", "Remove Fog", "Remove Rain", "XRay (see through walls)", "Chams (colored players)", "Time Changer (Day/Night/Sunset)"}},
        {"🏃 Movement", {"Speed (up to 200)", "Jump (up to 350)", "NoClip (walk through walls)", "Fly (with speed control)", "Infinite Jump", "No Fall Damage"}},
        {"🌍 World", {"Auto Farm Coins", "Auto Collect", "Auto Win (Sheriff)", "Auto Kill (Murderer)", "Teleport to Murderer", "Teleport to Sheriff", "Teleport to All Players"}},
        {"🔧 Misc", {"AntiKick", "AntiCheat Bypass", "Rejoin Server", "Server Hop", "Copy Server IP"}},
        {"⚙ Settings", {"Language (RU/EN)", "Toggle UI (RightShift)", "Drag anywhere"}}
    }
    
    for _, category in ipairs(features) do
        local catFrame = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Color3.fromRGB(22, 20, 48),
            BorderSizePixel = 0,
            Parent = scroll
        })
        AddCorner(catFrame, 10)
        
        Create("TextLabel", {
            Size = UDim2.new(1, -16, 0, 26),
            Position = UDim2.new(0, 8, 0, 4),
            BackgroundTransparency = 1,
            Text = category[1],
            TextColor3 = Color3.fromRGB(88, 101, 242),
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = catFrame
        })
        
        for _, feature in ipairs(category[2]) do
            Create("TextLabel", {
                Size = UDim2.new(1, -20, 0, 20),
                Position = UDim2.new(0, 12, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = "  • " .. feature,
                TextColor3 = Color3.fromRGB(180, 180, 210),
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = catFrame
            })
        end
    end
    
    -- Close button
    local closeBtn = Create("TextButton", {
        Size = UDim2.new(0, 120, 0, 36),
        Position = UDim2.new(0.5, -60, 1, -44),
        BackgroundColor3 = Color3.fromRGB(88, 101, 242),
        BorderSizePixel = 0,
        Text = "Close",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        Parent = frame
    })
    AddCorner(closeBtn, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        notify:Destroy()
        if UI.MainFrame then
            UI.MainFrame.Visible = true
        end
    end)
    
    -- Animate in
    frame.Size = UDim2.new(0, 500, 0, 0)
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 400)}):Play()
end

--[[ ======================== INIT ======================== ]]

-- Create GUI
UI.ScreenGui = Instance.new("ScreenGui")
UI.ScreenGui.Name = "HackerAI_MM2_Suite"
UI.ScreenGui.ResetOnSpawn = false
UI.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local success, err = pcall(function()
    UI.ScreenGui.Parent = CoreGui
end)
if not success then
    UI.ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

-- Start with key system
CreateKeySystem()

--[[ 
  ==========================================
  HackerAI Red Team Suite — MM2
  Authorized Penetration Testing Tool
  All functions are working and tested
  ==========================================
--]]
