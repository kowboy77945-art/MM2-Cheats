-- ============================================
-- MM2 CHEAT HUB v4.0
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ============================================
-- 10 КЛЮЧЕЙ
-- ============================================
local ValidKeys = {
    "MM2-CHEATS-ALPHA",
    "MM2-CHEATS-BRAVO",
    "MM2-CHEATS-DELTA",
    "MM2-CHEATS-GHOST",
    "MM2-CHEATS-NINJA",
    "MM2-CHEATS-STORM",
    "MM2-CHEATS-BLADE",
    "MM2-CHEATS-FROST",
    "MM2-CHEATS-VENOM",
    "MM2-CHEATS-OMEGA"
}

-- ============================================
-- КАСТОМНАЯ СИСТЕМА КЛЮЧЕЙ (не WindUI!)
-- ============================================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "MM2_KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() KeyGui.Parent = game:GetService("CoreGui") end)
if not KeyGui.Parent then
    KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Затемнение фона
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
Overlay.BackgroundTransparency = 0.4
Overlay.BorderSizePixel = 0
Overlay.ZIndex = 10
Overlay.Parent = KeyGui

-- Главный контейнер
local Container = Instance.new("Frame")
Container.Size = UDim2.new(0, 400, 0, 320)
Container.Position = UDim2.new(0.5, -200, 0.5, -160)
Container.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
Container.BorderSizePixel = 0
Container.ZIndex = 11
Container.Parent = KeyGui

local cCorner = Instance.new("UICorner", Container)
cCorner.CornerRadius = UDim.new(0, 14)

local cStroke = Instance.new("UIStroke", Container)
cStroke.Color = Color3.fromRGB(120, 60, 255)
cStroke.Thickness = 2.5
cStroke.Transparency = 0

-- Иконка + Заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.Position = UDim2.new(0, 0, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔒 MM2 Cheats — Авторизация"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.ZIndex = 12
TitleLabel.Parent = Container

-- Подзаголовок
local SubLabel = Instance.new("TextLabel")
SubLabel.Size = UDim2.new(1, -30, 0, 18)
SubLabel.Position = UDim2.new(0, 15, 0, 52)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Введите ключ: MM2-CHEATS-XXXXX"
SubLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextSize = 13
SubLabel.ZIndex = 12
SubLabel.Parent = Container

-- Поле ввода
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -50, 0, 45)
InputBox.Position = UDim2.new(0, 25, 0, 85)
InputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
InputBox.BorderSizePixel = 0
InputBox.Text = ""
InputBox.PlaceholderText = "MM2-CHEATS-XXXXX"
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
InputBox.Font = Enum.Font.GothamBold
InputBox.TextSize = 17
InputBox.ClearTextOnFocus = false
InputBox.ZIndex = 12
InputBox.Parent = Container

local iCorner = Instance.new("UICorner", InputBox)
iCorner.CornerRadius = UDim.new(0, 10)

local iStroke = Instance.new("UIStroke", InputBox)
iStroke.Color = Color3.fromRGB(70, 70, 100)
iStroke.Thickness = 1.5

-- Кнопка активации
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(1, -50, 0, 42)
SubmitBtn.Position = UDim2.new(0, 25, 0, 145)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(90, 45, 220)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "✅ Активировать ключ"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 16
SubmitBtn.ZIndex = 12
SubmitBtn.AutoButtonColor = true
SubmitBtn.Parent = Container

local sCorner = Instance.new("UICorner", SubmitBtn)
sCorner.CornerRadius = UDim.new(0, 10)

-- Кнопка показать ключи
local ShowBtn = Instance.new("TextButton")
ShowBtn.Size = UDim2.new(1, -50, 0, 34)
ShowBtn.Position = UDim2.new(0, 25, 0, 198)
ShowBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
ShowBtn.BorderSizePixel = 0
ShowBtn.Text = "📋 Показать все ключи"
ShowBtn.TextColor3 = Color3.fromRGB(170, 170, 200)
ShowBtn.Font = Enum.Font.Gotham
ShowBtn.TextSize = 13
ShowBtn.ZIndex = 12
ShowBtn.AutoButtonColor = true
ShowBtn.Parent = Container

local skCorner = Instance.new("UICorner", ShowBtn)
skCorner.CornerRadius = UDim.new(0, 8)

-- Статус
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -30, 0, 20)
StatusLabel.Position = UDim2.new(0, 15, 0, 245)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 14
StatusLabel.ZIndex = 12
StatusLabel.Parent = Container

-- Список ключей (скрыт)
local KeyListLabel = Instance.new("TextLabel")
KeyListLabel.Size = UDim2.new(1, -30, 0, 40)
KeyListLabel.Position = UDim2.new(0, 15, 0, 270)
KeyListLabel.BackgroundTransparency = 1
KeyListLabel.Text = ""
KeyListLabel.TextColor3 = Color3.fromRGB(140, 140, 170)
KeyListLabel.Font = Enum.Font.Code
KeyListLabel.TextSize = 10
KeyListLabel.TextWrapped = true
KeyListLabel.ZIndex = 12
KeyListLabel.Parent = Container

-- Логика кнопок
local keysShown = false

ShowBtn.MouseButton1Click:Connect(function()
    keysShown = not keysShown
    if keysShown then
        Container.Size = UDim2.new(0, 400, 0, 380)
        Container.Position = UDim2.new(0.5, -200, 0.5, -190)
        KeyListLabel.Text = table.concat(ValidKeys, "  |  ")
        ShowBtn.Text = "🔽 Скрыть ключи"
    else
        Container.Size = UDim2.new(0, 400, 0, 320)
        Container.Position = UDim2.new(0.5, -200, 0.5, -160)
        KeyListLabel.Text = ""
        ShowBtn.Text = "📋 Показать все ключи"
    end
end)

SubmitBtn.MouseButton1Click:Connect(function()
    local input = InputBox.Text
    local found = false

    for _, key in ipairs(ValidKeys) do
        if input == key then
            found = true
            break
        end
    end

    if found then
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
        StatusLabel.Text = "✅ Ключ принят! Загрузка..."

        -- Анимация исчезновения
        local tween = TweenService:Create(Container, TweenInfo.new(0.5), {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, -200, 0.4, -160)
        })
        tween:Play()

        local tween2 = TweenService:Create(Overlay, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        })
        tween2:Play()

        task.wait(0.6)
        KeyGui:Destroy()
        task.wait(0.3)

        -- ЗАГРУЗКА ГЛАВНОГО МЕНЮ
        LoadMainMenu()
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "❌ Неверный ключ! Попробуйте снова."
        -- Встряска
        local orig = Container.Position
        for i = 1, 4 do
            Container.Position = orig + UDim2.new(0, 8, 0, 0)
            task.wait(0.04)
            Container.Position = orig - UDim2.new(0, 8, 0, 0)
            task.wait(0.04)
        end
        Container.Position = orig
    end
end)

-- ============================================
-- ГЛАВНОЕ МЕНЮ (WindUI)
-- ============================================
function LoadMainMenu()
    -- Загрузка WindUI
    local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

    -- Настройки
    local S = {
        WalkSpeed = 16,
        JumpPower = 50,
        SpeedOn = false,
        JumpOn = false,
        NoclipOn = false,
        FlyOn = false,
        FlySpeed = 50,
        ESPOn = false,
        ESPMurderer = true,
        ESPSheriff = true,
        ESPInnocent = true,
        ESPTransparency = 0.5,
        AutoGun = false,
        FakeDeath = false,
        Invisible = false,
    }

    local ESPStore = {}
    local FlyBody = nil
    local FlyGyro = nil
    local FakeDeathActive = false
    local InvisibleActive = false
    local SavedMotors = {}

    -- ============================================
    -- СОЗДАНИЕ ОКНА
    -- ============================================
    local Window = WindUI:CreateWindow({
        Title = "🔪 MM2 Cheat Hub v4.0",
        Icon = "swords",
        Author = "MM2 Cheats",
        Folder = "MM2Cheat",
        Size = UDim2.fromOffset(560, 460),
        Transparent = true,
        Theme = "Dark",
        HasOutline = true,
    })

    -- ============================================
    -- TAB: ДВИЖЕНИЕ
    -- ============================================
    local MoveTab = Window:Tab({
        Title = "Движение",
        Icon = "person-standing",
    })

    MoveTab:Section({ Title = "⚡ Скорость" })

    MoveTab:Toggle({
        Title = "🏃 Скорость ходьбы",
        Desc = "Изменить скорость персонажа",
        Value = false,
        Callback = function(v)
            S.SpeedOn = v
            if not v then
                pcall(function()
                    LocalPlayer.Character.Humanoid.WalkSpeed = 16
                end)
            end
        end,
    })

    MoveTab:Slider({
        Title = "Значение скорости",
        Desc = "16 — 200",
        Value = 16,
        Min = 16,
        Max = 200,
        Callback = function(v) S.WalkSpeed = v end,
    })

    MoveTab:Section({ Title = "🦘 Прыжок" })

    MoveTab:Toggle({
        Title = "🦘 Высота прыжка",
        Desc = "Изменить высоту прыжка",
        Value = false,
        Callback = function(v)
            S.JumpOn = v
            if not v then
                pcall(function()
                    LocalPlayer.Character.Humanoid.JumpPower = 50
                end)
            end
        end,
    })

    MoveTab:Slider({
        Title = "Значение прыжка",
        Desc = "50 — 500",
        Value = 50,
        Min = 50,
        Max = 500,
        Callback = function(v) S.JumpPower = v end,
    })

    MoveTab:Section({ Title = "👻 Ноклип" })

    MoveTab:Toggle({
        Title = "👻 Ноклип",
        Desc = "Проход сквозь стены",
        Value = false,
        Callback = function(v) S.NoclipOn = v end,
    })

    -- ============================================
    -- TAB: ПОЛЁТ
    -- ============================================
    local FlyTab = Window:Tab({
        Title = "Полёт",
        Icon = "plane",
    })

    FlyTab:Section({ Title = "✈️ Полёт" })

    FlyTab:Toggle({
        Title = "✈️ Включить полёт",
        Desc = "Летать свободно по карте",
        Value = false,
        Callback = function(v)
            S.FlyOn = v
            if v then StartFly() else StopFly() end
        end,
    })

    FlyTab:Slider({
        Title = "Скорость полёта",
        Desc = "10 — 300",
        Value = 50,
        Min = 10,
        Max = 300,
        Callback = function(v) S.FlySpeed = v end,
    })

    FlyTab:Paragraph({
        Title = "📖 Управление",
        Desc = "🖥️ ПК: W/A/S/D + Space(вверх) + Ctrl(вниз)\n📱 Телефон: Джойстик + Прыжок(вверх)",
    })

    -- ============================================
    -- TAB: ЕСП
    -- ============================================
    local ESPTab = Window:Tab({
        Title = "ЕСП",
        Icon = "eye",
    })

    ESPTab:Section({ Title = "👁️ Чамсы" })

    ESPTab:Toggle({
        Title = "👁️ Включить ЕСП",
        Desc = "Подсветка игроков сквозь стены",
        Value = false,
        Callback = function(v)
            S.ESPOn = v
            if v then RefreshESP() else ClearAllESP() end
        end,
    })

    ESPTab:Section({ Title = "🎯 Фильтр ролей" })

    ESPTab:Toggle({
        Title = "🔴 Убийца (Красный)",
        Desc = "Показывать убийцу",
        Value = true,
        Callback = function(v) S.ESPMurderer = v; if S.ESPOn then RefreshESP() end end,
    })

    ESPTab:Toggle({
        Title = "🔵 Шериф (Синий)",
        Desc = "Показывать шерифа",
        Value = true,
        Callback = function(v) S.ESPSheriff = v; if S.ESPOn then RefreshESP() end end,
    })

    ESPTab:Toggle({
        Title = "🟢 Невинные (Зелёный)",
        Desc = "Показывать невинных",
        Value = true,
        Callback = function(v) S.ESPInnocent = v; if S.ESPOn then RefreshESP() end end,
    })

    ESPTab:Section({ Title = "🎨 Прозрачность" })

    ESPTab:Slider({
        Title = "Прозрачность чамсов",
        Desc = "0 = ярко, 90 = еле видно",
        Value = 50,
        Min = 0,
        Max = 90,
        Callback = function(v) S.ESPTransparency = v / 100; if S.ESPOn then RefreshESP() end end,
    })

    -- ============================================
    -- TAB: ТРЮКИ
    -- ============================================
    local TrickTab = Window:Tab({
        Title = "Трюки",
        Icon = "wand",
    })

    TrickTab:Section({ Title = "🔫 Авто подбор пистолета" })

    TrickTab:Toggle({
        Title = "🔫 Авто подбор пистолета",
        Desc = "Пистолет сразу попадает в руки (без телепорта!)",
        Value = false,
        Callback = function(v) S.AutoGun = v end,
    })

    TrickTab:Paragraph({
        Title = "📖 Как работает",
        Desc = "Когда шериф умирает и роняет пистолет,\nон мгновенно попадает к вам в инвентарь!",
    })

    TrickTab:Section({ Title = "💀 Фейк смерть" })

    TrickTab:Toggle({
        Title = "💀 Притвориться мёртвым",
        Desc = "Персонаж падает как тряпичная кукла (рэгдолл)",
        Value = false,
        Callback = function(v)
            S.FakeDeath = v
            if v then ActivateFakeDeath() else DeactivateFakeDeath() end
        end,
    })

    TrickTab:Section({ Title = "👻 FE Невидимость" })

    TrickTab:Toggle({
        Title = "👻 Невидимость (FE)",
        Desc = "Другие игроки вас НЕ видят! (Server-side)",
        Value = false,
        Callback = function(v)
            S.Invisible = v
            if v then ActivateInvisibility() else DeactivateInvisibility() end
        end,
    })

    TrickTab:Paragraph({
        Title = "⚠️ Важно про невидимость",
        Desc = "• Другие игроки вас не видят на сервере!\n• Вы видите себя прозрачным\n• Чтобы стать видимым — выключите тогл\n  (персонаж ресетнется)\n• Работает через FE (Filtering Enabled)",
    })

    -- ============================================
    -- TAB: ИНФО
    -- ============================================
    local InfoTab = Window:Tab({
        Title = "Инфо",
        Icon = "info",
    })

    InfoTab:Paragraph({
        Title = "🔪 MM2 Cheat Hub v4.0",
        Desc = "Все функции:\n\n🏃 Скорость ходьбы\n🦘 Высота прыжка\n👻 Ноклип\n✈️ Полёт (ПК+Телефон)\n👁️ ЕСП чамсы по ролям\n🔫 Авто подбор пистолета\n💀 Фейк смерть (рэгдолл)\n👻 FE Невидимость\n\n⚠️ Используйте на свой страх и риск!",
    })

    -- ============================================
    -- ФУНКЦИИ: РОЛИ MM2
    -- ============================================
    function GetPlayerRole(player)
        local result = "Innocent"
        pcall(function()
            if not player or not player.Character then return end
            local hasKnife, hasGun = false, false

            local function CheckTool(tool)
                if tool:IsA("Tool") then
                    local n = tool.Name:lower()
                    if n == "knife" or n:find("knife") then hasKnife = true end
                    if n == "gun" or n == "revolver" or n:find("gun") then hasGun = true end
                end
            end

            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                for _, t in pairs(backpack:GetChildren()) do CheckTool(t) end
            end
            for _, t in pairs(player.Character:GetChildren()) do CheckTool(t) end

            if hasKnife then result = "Murderer"
            elseif hasGun then result = "Sheriff" end
        end)
        return result
    end

    function GetRoleColor(role)
        if role == "Murderer" then return Color3.fromRGB(255, 25, 25) end
        if role == "Sheriff" then return Color3.fromRGB(30, 100, 255) end
        return Color3.fromRGB(25, 255, 25)
    end

    function GetRoleEmoji(role)
        if role == "Murderer" then return "🔪 УБИЙЦА" end
        if role == "Sheriff" then return "🔫 ШЕРИФ" end
        return "👤 НЕВИННЫЙ"
    end

    function ShouldShow(role)
        if role == "Murderer" then return S.ESPMurderer end
        if role == "Sheriff" then return S.ESPSheriff end
        return S.ESPInnocent
    end

    -- ============================================
    -- ФУНКЦИИ: ЕСП
    -- ============================================
    function CreateESP(player)
        if player == LocalPlayer then return end
        if not player.Character then return end
        local char = player.Character
        if not char:FindFirstChild("HumanoidRootPart") then return end
        if not char:FindFirstChild("Humanoid") then return end
        if char.Humanoid.Health <= 0 then return end

        RemoveESP(player)
        local role = GetPlayerRole(player)
        if not ShouldShow(role) then return end
        local color = GetRoleColor(role)

        -- Highlight
        local hl = Instance.new("Highlight")
        hl.Name = "MM2ESP"
        hl.FillColor = color
        hl.OutlineColor = color
        hl.FillTransparency = S.ESPTransparency
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Adornee = char
        hl.Parent = char

        -- Billboard
        local bb = Instance.new("BillboardGui")
        bb.Name = "MM2ESPInfo"
        bb.Adornee = char:FindFirstChild("Head") or char.HumanoidRootPart
        bb.Size = UDim2.new(0, 200, 0, 55)
        bb.StudsOffset = Vector3.new(0, 3.5, 0)
        bb.AlwaysOnTop = true
        bb.Parent = char

        -- Фон
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.new(0, 0, 0)
        bg.BackgroundTransparency = 0.65
        bg.BorderSizePixel = 0
        bg.Parent = bb
        Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
        local bgS = Instance.new("UIStroke", bg)
        bgS.Color = color
        bgS.Thickness = 1.5

        -- Имя
        local nm = Instance.new("TextLabel")
        nm.Size = UDim2.new(1, 0, 0.35, 0)
        nm.BackgroundTransparency = 1
        nm.Text = player.DisplayName
        nm.TextColor3 = Color3.new(1, 1, 1)
        nm.TextStrokeTransparency = 0.3
        nm.Font = Enum.Font.GothamBold
        nm.TextSize = 13
        nm.Parent = bg

        -- Роль
        local rl = Instance.new("TextLabel")
        rl.Size = UDim2.new(1, 0, 0.35, 0)
        rl.Position = UDim2.new(0, 0, 0.35, 0)
        rl.BackgroundTransparency = 1
        rl.Text = GetRoleEmoji(role)
        rl.TextColor3 = color
        rl.TextStrokeTransparency = 0.3
        rl.Font = Enum.Font.GothamBold
        rl.TextSize = 12
        rl.Parent = bg

        -- Дистанция
        local dl = Instance.new("TextLabel")
        dl.Name = "Dist"
        dl.Size = UDim2.new(1, 0, 0.3, 0)
        dl.Position = UDim2.new(0, 0, 0.7, 0)
        dl.BackgroundTransparency = 1
        dl.Text = "📏 0m"
        dl.TextColor3 = Color3.fromRGB(200, 200, 200)
        dl.TextStrokeTransparency = 0.3
        dl.Font = Enum.Font.Gotham
        dl.TextSize = 11
        dl.Parent = bg

        ESPStore[player.UserId] = {HL = hl, BB = bb, Player = player}
    end

    function RemoveESP(player)
        if ESPStore[player.UserId] then
            pcall(function() ESPStore[player.UserId].HL:Destroy() end)
            pcall(function() ESPStore[player.UserId].BB:Destroy() end)
            ESPStore[player.UserId] = nil
        end
        pcall(function()
            if player.Character then
                local a = player.Character:FindFirstChild("MM2ESP")
                if a then a:Destroy() end
                local b = player.Character:FindFirstChild("MM2ESPInfo")
                if b then b:Destroy() end
            end
        end)
    end

    function ClearAllESP()
        for _, p in pairs(Players:GetPlayers()) do RemoveESP(p) end
        ESPStore = {}
    end

    function RefreshESP()
        ClearAllESP()
        if not S.ESPOn then return end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                pcall(function() CreateESP(p) end)
            end
        end
    end

    -- ============================================
    -- ФУНКЦИИ: ПОЛЁТ
    -- ============================================
    function StartFly()
        pcall(function()
            StopFly()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if not hrp or not hum then return end

            FlyBody = Instance.new("BodyVelocity")
            FlyBody.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            FlyBody.Velocity = Vector3.new(0, 0, 0)
            FlyBody.Parent = hrp

            FlyGyro = Instance.new("BodyGyro")
            FlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            FlyGyro.P = 9e4
            FlyGyro.Parent = hrp

            hum.PlatformStand = true
        end)
    end

    function StopFly()
        pcall(function()
            if LocalPlayer.Character then
                local h = LocalPlayer.Character:FindFirstChild("Humanoid")
                if h then h.PlatformStand = false end
            end
        end)
        pcall(function() if FlyBody then FlyBody:Destroy(); FlyBody = nil end end)
        pcall(function() if FlyGyro then FlyGyro:Destroy(); FlyGyro = nil end end)
    end

    -- ============================================
    -- ФУНКЦИИ: ФЕЙК СМЕРТЬ (РЭГДОЛЛ)
    -- ============================================
    function ActivateFakeDeath()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChild("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp then return end

            FakeDeathActive = true
            SavedMotors = {}
            hum.PlatformStand = true

            pcall(function() hum:UnequipTools() end)

            for _, joint in pairs(char:GetDescendants()) do
                if joint:IsA("Motor6D") then
                    table.insert(SavedMotors, joint)

                    if joint.Part0 and joint.Part1 then
                        local a0 = Instance.new("Attachment")
                        a0.Name = "FD_A0"
                        a0.CFrame = joint.C0
                        a0.Parent = joint.Part0

                        local a1 = Instance.new("Attachment")
                        a1.Name = "FD_A1"
                        a1.CFrame = joint.C1
                        a1.Parent = joint.Part1

                        local bs = Instance.new("BallSocketConstraint")
                        bs.Name = "FD_Socket"
                        bs.Attachment0 = a0
                        bs.Attachment1 = a1
                        bs.LimitsEnabled = true
                        bs.TwistLimitsEnabled = true
                        bs.UpperAngle = 45
                        bs.TwistLowerAngle = -45
                        bs.TwistUpperAngle = 45
                        bs.Parent = joint.Part0

                        joint.Part1.CanCollide = true
                    end
                    joint.Enabled = false
                end
            end

            -- Толчок для падения
            local push = Instance.new("BodyVelocity")
            push.MaxForce = Vector3.new(5000, 5000, 5000)
            push.Velocity = Vector3.new(math.random(-3, 3), 2, math.random(-3, 3))
            push.Parent = hrp
            task.delay(0.2, function()
                pcall(function() push:Destroy() end)
            end)
        end)
    end

    function DeactivateFakeDeath()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChild("Humanoid")

            FakeDeathActive = false

            -- Удаляем рэгдолл объекты
            for _, obj in pairs(char:GetDescendants()) do
                if obj.Name == "FD_Socket" or obj.Name == "FD_A0" or obj.Name == "FD_A1" then
                    obj:Destroy()
                end
            end

            -- Восстанавливаем суставы
            for _, motor in pairs(SavedMotors) do
                pcall(function() motor.Enabled = true end)
            end
            SavedMotors = {}

            if hum then hum.PlatformStand = false end

            -- Сбрасываем коллизии
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Name ~= "Head" then
                    part.CanCollide = false
                end
            end
        end)
    end

    -- ============================================
    -- ФУНКЦИИ: FE НЕВИДИМОСТЬ
    -- ============================================
    function ActivateInvisibility()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            InvisibleActive = true
            local savedCF = hrp.CFrame

            -- Создаём фейковый персонаж
            local fakeChar = Instance.new("Model")
            fakeChar.Name = "InvisChar"

            local fakeHead = Instance.new("Part")
            fakeHead.Name = "Head"
            fakeHead.Size = Vector3.new(2, 1, 1)
            fakeHead.Transparency = 1
            fakeHead.CanCollide = false
            fakeHead.Anchored = true
            fakeHead.CFrame = CFrame.new(0, 10000, 0)
            fakeHead.Parent = fakeChar

            local fakeTorso = Instance.new("Part")
            fakeTorso.Name = "Torso"
            fakeTorso.Size = Vector3.new(2, 2, 1)
            fakeTorso.Transparency = 1
            fakeTorso.CanCollide = false
            fakeTorso.Anchored = true
            fakeTorso.CFrame = CFrame.new(0, 10000, 0)
            fakeTorso.Parent = fakeChar

            local fakeHRP = Instance.new("Part")
            fakeHRP.Name = "HumanoidRootPart"
            fakeHRP.Size = Vector3.new(2, 2, 1)
            fakeHRP.Transparency = 1
            fakeHRP.CanCollide = false
            fakeHRP.Anchored = true
            fakeHRP.CFrame = CFrame.new(0, 10000, 0)
            fakeHRP.Parent = fakeChar

            local fakeHum = Instance.new("Humanoid")
            fakeHum.Parent = fakeChar

            fakeChar.Parent = workspace

            -- Свап персонажа — сервер теряет отслеживание
            LocalPlayer.Character = fakeChar
            task.wait(0.3)
            LocalPlayer.Character = char
            task.wait(0.2)

            -- Возвращаем позицию
            if char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = savedCF
            end

            -- Убираем фейк
            fakeChar:Destroy()

            -- Делаем себя прозрачным ЛОКАЛЬНО (чтобы вы видели что невидимы)
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0.7
                end
                if part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 0.7
                end
                if part:IsA("Hat") or part:IsA("Accessory") then
                    pcall(function()
                        part.Handle.Transparency = 0.7
                    end)
                end
            end

            -- Уведомление
            WindUI:Notify({
                Title = "👻 Невидимость",
                Content = "Вы невидимы для других игроков!",
                Duration = 4,
            })
        end)
    end

    function DeactivateInvisibility()
        InvisibleActive = false
        WindUI:Notify({
            Title = "👻 Невидимость",
            Content = "Ресет персонажа для снятия невидимости...",
            Duration = 3,
        })
        task.wait(0.5)
        -- Ресет персонажа
        pcall(function()
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
        end)
    end

    -- ============================================
    -- ФУНКЦИЯ: ПОИСК ПИСТОЛЕТА НА ЗЕМЛЕ
    -- ============================================
    function FindGunOnGround()
        -- Ищем в workspace (не в руках/рюкзаке игрока)
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("Tool") then
                local n = obj.Name:lower()
                if n == "gun" or n == "revolver" or n:find("gun") then
                    if obj:FindFirstChild("Handle") then
                        return obj
                    end
                end
            end
        end

        -- Глубокий поиск
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") then
                local n = obj.Name:lower()
                if n == "gun" or n == "revolver" or n:find("gun") then
                    local parent = obj.Parent
                    if parent and parent == workspace or (parent and not parent:IsA("Backpack") and not parent:FindFirstChildOfClass("Humanoid")) then
                        if obj:FindFirstChild("Handle") then
                            return obj
                        end
                    end
                end
            end
        end
        return nil
    end

    -- ============================================
    -- ГЛАВНЫЙ ЦИКЛ
    -- ============================================
    local espTimer = 0

    RunService.Heartbeat:Connect(function(dt)
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChild("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp then return end
            if hum.Health <= 0 then return end

            -- Скорость
            if S.SpeedOn and not FakeDeathActive then
                hum.WalkSpeed = S.WalkSpeed
            end

            -- Прыжок
            if S.JumpOn and not FakeDeathActive then
                hum.JumpPower = S.JumpPower
                hum.UseJumpPower = true
            end

            -- Ноклип
            if S.NoclipOn then
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                    end
                end
            end

            -- Полёт
            if S.FlyOn and FlyBody and FlyGyro and not FakeDeathActive then
                FlyGyro.CFrame = Camera.CFrame
                hum.PlatformStand = true

                local dir = Vector3.new(0, 0, 0)
                local cf = Camera.CFrame

                -- ПК
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cf.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cf.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cf.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cf.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end

                -- Телефон
                local md = hum.MoveDirection
                if md.Magnitude > 0.1 then
                    dir = dir + (cf.LookVector * md.Z + cf.RightVector * md.X)
                end
                if hum.Jump then dir = dir + Vector3.new(0, 0.5, 0) end

                FlyBody.Velocity = dir.Magnitude > 0 and dir.Unit * S.FlySpeed or Vector3.new(0, 0, 0)
            end

            -- Фейк смерть
            if FakeDeathActive then
                hum.PlatformStand = true
            end

            -- ЕСП обновление ролей
            espTimer = espTimer + dt
            if espTimer >= 3 then
                espTimer = 0
                if S.ESPOn then RefreshESP() end
            end

            -- ЕСП дистанция
            if S.ESPOn then
                for _, data in pairs(ESPStore) do
                    pcall(function()
                        if data.BB and data.BB.Parent and data.Player.Character then
                            local tHRP = data.Player.Character:FindFirstChild("HumanoidRootPart")
                            if tHRP then
                                local dist = math.floor((hrp.Position - tHRP.Position).Magnitude)
                                local bg = data.BB:FindFirstChildWhichIsA("Frame")
                                if bg then
                                    local dl = bg:FindFirstChild("Dist")
                                    if dl then dl.Text = "📏 " .. dist .. "m" end
                                end
                            end
                        end
                    end)
                end
            end

            -- ============================================
            -- АВТО ПОДБОР ПИСТОЛЕТА (БЕЗ ТЕЛЕПОРТА!)
            -- ============================================
            if S.AutoGun and not FakeDeathActive then
                local gun = FindGunOnGround()
                if gun and gun:FindFirstChild("Handle") then
                    -- Метод 1: firetouchinterest (пистолет сразу в руки)
                    pcall(function()
                        firetouchinterest(hrp, gun.Handle, 0)
                        task.wait()
                        firetouchinterest(hrp, gun.Handle, 1)
                    end)

                    -- Метод 2: Перемещение в рюкзак напрямую
                    pcall(function()
                        if gun.Parent == workspace then
                            gun.Parent = LocalPlayer.Backpack
                        end
                    end)

                    -- Метод 3: ClickDetector
                    pcall(function()
                        local cd = gun:FindFirstChildWhichIsA("ClickDetector", true)
                        if cd then fireclickdetector(cd) end
                    end)

                    -- Метод 4: ProximityPrompt
                    pcall(function()
                        local pp = gun:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if pp then fireproximityprompt(pp) end
                    end)
                end
            end
        end)
    end)

    -- Респавн
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        FakeDeathActive = false
        InvisibleActive = false
        SavedMotors = {}
        if S.FlyOn then task.wait(0.5); StartFly() end
        if S.ESPOn then task.wait(1); RefreshESP() end
    end)

    -- Игроки
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function()
            task.wait(1)
            if S.ESPOn then pcall(function() CreateESP(p) end) end
        end)
    end)

    Players.PlayerRemoving:Connect(function(p) RemoveESP(p) end)

    -- Готово!
    WindUI:Notify({
        Title = "🔪 MM2 Cheat Hub v4.0",
        Content = "Все функции загружены! Удачной игры!",
        Duration = 5,
    })
end
