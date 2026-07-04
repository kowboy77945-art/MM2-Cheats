-- MM2 Ultimate Cheat Script v3.0
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

-- Сервисы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera

-- ============================================
-- КЛЮЧИ (формат MM2-CHEATS-XXXXX)
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

local KeyVerified = false

-- ============================================
-- ОКНО КЛЮЧА
-- ============================================
local KeyWindow = WindUI:CreateWindow({
    Title = "🔑 MM2 Cheats - Авторизация",
    Icon = "key-round",
    Author = "MM2 Cheats v3.0",
    Folder = "MM2KeySystem",
    Size = UDim2.fromOffset(460, 360),
    Transparent = true,
    Theme = "Dark",
    HasOutline = true,
})

local KeyTab = KeyWindow:Tab({
    Title = "Ключ доступа",
    Icon = "lock",
})

local KeyInput = ""

KeyTab:Paragraph({
    Title = "🔐 Введите ключ доступа",
    Desc = "Формат: MM2-CHEATS-XXXXX\nПример: MM2-CHEATS-ALPHA\n\nНажмите 'Показать ключи' для списка.",
})

KeyTab:Input({
    Title = "Ваш ключ",
    Desc = "Введите ключ сюда",
    Value = "",
    Placeholder = "MM2-CHEATS-XXXXX",
    Callback = function(value)
        KeyInput = value
    end,
})

KeyTab:Button({
    Title = "✅ Активировать",
    Desc = "Проверить ключ и запустить чит",
    Callback = function()
        local found = false
        for _, key in ipairs(ValidKeys) do
            if KeyInput == key then
                found = true
                break
            end
        end

        if found then
            KeyVerified = true
            WindUI:Notify({
                Title = "✅ Ключ принят!",
                Content = "Добро пожаловать! Загрузка...",
                Duration = 3,
            })
            task.wait(1.5)
            KeyWindow:Destroy()
            task.wait(0.5)
            LoadMainScript()
        else
            WindUI:Notify({
                Title = "❌ Неверный ключ!",
                Content = "Проверьте правильность ключа и попробуйте снова.",
                Duration = 4,
            })
        end
    end,
})

KeyTab:Button({
    Title = "📋 Показать ключи",
    Desc = "Список всех доступных ключей",
    Callback = function()
        WindUI:Notify({
            Title = "🔑 Ключи (1-5)",
            Content = "MM2-CHEATS-ALPHA\nMM2-CHEATS-BRAVO\nMM2-CHEATS-DELTA\nMM2-CHEATS-GHOST\nMM2-CHEATS-NINJA",
            Duration = 12,
        })
        task.wait(0.3)
        WindUI:Notify({
            Title = "🔑 Ключи (6-10)",
            Content = "MM2-CHEATS-STORM\nMM2-CHEATS-BLADE\nMM2-CHEATS-FROST\nMM2-CHEATS-VENOM\nMM2-CHEATS-OMEGA",
            Duration = 12,
        })
    end,
})

-- ============================================
-- ОСНОВНОЙ СКРИПТ
-- ============================================
function LoadMainScript()
    if not KeyVerified then return end

    -- Настройки
    local Settings = {
        WalkSpeed = 16,
        JumpPower = 50,
        WalkSpeedEnabled = false,
        JumpPowerEnabled = false,
        NoclipEnabled = false,
        FlyEnabled = false,
        FlySpeed = 50,
        ESPEnabled = false,
        ESPMurderer = true,
        ESPSheriff = true,
        ESPInnocent = true,
        ESPTransparency = 0.5,
        AutoPickupGun = false,
        FakeDeathEnabled = false,
    }

    local ESPObjects = {}
    local FlyBody = nil
    local FlyGyro = nil
    local FakeDeathActive = false
    local SavedMotors = {}

    -- ============================================
    -- ГЛАВНОЕ ОКНО
    -- ============================================
    local Window = WindUI:CreateWindow({
        Title = "🔪 MM2 Cheat Hub v3.0",
        Icon = "swords",
        Author = "MM2 Cheats | Добро пожаловать!",
        Folder = "MM2CheatMain",
        Size = UDim2.fromOffset(560, 460),
        Transparent = true,
        Theme = "Dark",
        HasOutline = true,
    })

    -- ============================================
    -- TAB: ДВИЖЕНИЕ
    -- ============================================
    local MovementTab = Window:Tab({
        Title = "Движение",
        Icon = "person-standing",
    })

    MovementTab:Section({ Title = "⚡ Скорость ходьбы" })

    MovementTab:Toggle({
        Title = "🏃 Включить скорость",
        Desc = "Изменить скорость ходьбы персонажа",
        Value = false,
        Callback = function(value)
            Settings.WalkSpeedEnabled = value
            if not value then
                pcall(function()
                    LocalPlayer.Character.Humanoid.WalkSpeed = 16
                end)
            end
        end,
    })

    MovementTab:Slider({
        Title = "Значение скорости",
        Desc = "От 16 до 200",
        Value = 16,
        Min = 16,
        Max = 200,
        Callback = function(value)
            Settings.WalkSpeed = value
        end,
    })

    MovementTab:Section({ Title = "🦘 Высота прыжка" })

    MovementTab:Toggle({
        Title = "🦘 Включить прыжок",
        Desc = "Изменить высоту прыжка персонажа",
        Value = false,
        Callback = function(value)
            Settings.JumpPowerEnabled = value
            if not value then
                pcall(function()
                    LocalPlayer.Character.Humanoid.JumpPower = 50
                end)
            end
        end,
    })

    MovementTab:Slider({
        Title = "Значение прыжка",
        Desc = "От 50 до 500",
        Value = 50,
        Min = 50,
        Max = 500,
        Callback = function(value)
            Settings.JumpPower = value
        end,
    })

    MovementTab:Section({ Title = "👻 Ноклип" })

    MovementTab:Toggle({
        Title = "👻 Ноклип",
        Desc = "Проходить сквозь стены и объекты",
        Value = false,
        Callback = function(value)
            Settings.NoclipEnabled = value
        end,
    })

    -- ============================================
    -- TAB: ПОЛЁТ
    -- ============================================
    local FlyTab = Window:Tab({
        Title = "Полёт",
        Icon = "plane",
    })

    FlyTab:Section({ Title = "✈️ Настройки полёта" })

    FlyTab:Toggle({
        Title = "✈️ Включить полёт",
        Desc = "Летать по карте свободно",
        Value = false,
        Callback = function(value)
            Settings.FlyEnabled = value
            if value then
                StartFly()
            else
                StopFly()
            end
        end,
    })

    FlyTab:Slider({
        Title = "Скорость полёта",
        Desc = "От 10 до 300",
        Value = 50,
        Min = 10,
        Max = 300,
        Callback = function(value)
            Settings.FlySpeed = value
        end,
    })

    FlyTab:Paragraph({
        Title = "📖 Управление полётом",
        Desc = "🖥️ ПК:\nW/A/S/D - направление\nSpace - вверх\nLeftCtrl - вниз\n\n📱 Телефон:\nДжойстик - направление\nКнопка прыжка - вверх",
    })

    -- ============================================
    -- TAB: ЕСП
    -- ============================================
    local ESPTab = Window:Tab({
        Title = "ЕСП",
        Icon = "eye",
    })

    ESPTab:Section({ Title = "👁️ Чамсы (ESP)" })

    ESPTab:Toggle({
        Title = "👁️ Включить ЕСП",
        Desc = "Видеть игроков сквозь стены",
        Value = false,
        Callback = function(value)
            Settings.ESPEnabled = value
            if not value then
                ClearAllESP()
            else
                RefreshESP()
            end
        end,
    })

    ESPTab:Section({ Title = "🎯 Фильтр по ролям" })

    ESPTab:Toggle({
        Title = "🔴 Убийца (Красный)",
        Desc = "Показывать убийцу красным цветом",
        Value = true,
        Callback = function(value)
            Settings.ESPMurderer = value
            if Settings.ESPEnabled then RefreshESP() end
        end,
    })

    ESPTab:Toggle({
        Title = "🔵 Шериф (Синий)",
        Desc = "Показывать шерифа синим цветом",
        Value = true,
        Callback = function(value)
            Settings.ESPSheriff = value
            if Settings.ESPEnabled then RefreshESP() end
        end,
    })

    ESPTab:Toggle({
        Title = "🟢 Невинные (Зелёный)",
        Desc = "Показывать невинных зелёным цветом",
        Value = true,
        Callback = function(value)
            Settings.ESPInnocent = value
            if Settings.ESPEnabled then RefreshESP() end
        end,
    })

    ESPTab:Section({ Title = "🎨 Настройка вида" })

    ESPTab:Slider({
        Title = "Прозрачность чамсов",
        Desc = "0 = яркие, 90 = почти невидимые",
        Value = 50,
        Min = 0,
        Max = 90,
        Callback = function(value)
            Settings.ESPTransparency = value / 100
            if Settings.ESPEnabled then RefreshESP() end
        end,
    })

    -- ============================================
    -- TAB: АВТО + ТРЮКИ
    -- ============================================
    local TricksTab = Window:Tab({
        Title = "Трюки",
        Icon = "wand",
    })

    TricksTab:Section({ Title = "🔫 Авто подбор пистолета" })

    TricksTab:Toggle({
        Title = "🔫 Авто подбор пистолета",
        Desc = "Телепорт к пистолету шерифа при его смерти",
        Value = false,
        Callback = function(value)
            Settings.AutoPickupGun = value
        end,
    })

    TricksTab:Paragraph({
        Title = "📖 Как работает",
        Desc = "Когда шериф умирает, пистолет падает на пол.\nСкрипт мгновенно телепортирует вас к пистолету!",
    })

    -- ============================================
    -- ФЕЙК СМЕРТЬ (ПРИТВОРИТЬСЯ МЁРТВЫМ)
    -- ============================================
    TricksTab:Section({ Title = "💀 Притвориться мёртвым" })

    TricksTab:Toggle({
        Title = "💀 Фейк смерть",
        Desc = "Персонаж падает как будто мёртвый (рэгдолл)",
        Value = false,
        Callback = function(value)
            Settings.FakeDeathEnabled = value
            if value then
                ActivateFakeDeath()
            else
                DeactivateFakeDeath()
            end
        end,
    })

    TricksTab:Paragraph({
        Title = "📖 Фейк смерть",
        Desc = "Ваш персонаж упадёт как тряпичная кукла.\nДругие игроки подумают что вы мертвы!\nВы всё ещё можете двигать камеру.\n\nВыключите чтобы встать обратно.",
    })

    -- ============================================
    -- TAB: ИНФО
    -- ============================================
    local InfoTab = Window:Tab({
        Title = "Инфо",
        Icon = "info",
    })

    InfoTab:Paragraph({
        Title = "🔪 MM2 Cheat Hub v3.0",
        Desc = "Все функции:\n\n🏃 Скорость ходьбы (16-200)\n🦘 Высота прыжка (50-500)\n👻 Ноклип (сквозь стены)\n✈️ Полёт (ПК + Телефон)\n👁️ ЕСП чамсы по ролям\n🔫 Авто подбор пистолета\n💀 Фейк смерть (рэгдолл)\n\n⚠️ Используйте на свой страх и риск!",
    })

    -- ============================================
    -- ФУНКЦИЯ ФЕЙК СМЕРТЬ (РЭГДОЛЛ)
    -- ============================================
    function ActivateFakeDeath()
        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end
            local humanoid = character:FindFirstChild("Humanoid")
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not hrp then return end

            FakeDeathActive = true
            SavedMotors = {}

            -- Отключаем управление
            humanoid.PlatformStand = true

            -- Сохраняем и отключаем все Motor6D (суставы)
            for _, joint in pairs(character:GetDescendants()) do
                if joint:IsA("Motor6D") then
                    table.insert(SavedMotors, {
                        Joint = joint,
                        Enabled = joint.Enabled,
                        Parent = joint.Parent,
                        Part0 = joint.Part0,
                        Part1 = joint.Part1,
                    })

                    -- Создаём BallSocketConstraint для рэгдолла
                    if joint.Part0 and joint.Part1 then
                        -- Attachment на Part0
                        local att0 = Instance.new("Attachment")
                        att0.Name = "FakeDeath_Att0"
                        att0.CFrame = joint.C0
                        att0.Parent = joint.Part0

                        -- Attachment на Part1
                        local att1 = Instance.new("Attachment")
                        att1.Name = "FakeDeath_Att1"
                        att1.CFrame = joint.C1
                        att1.Parent = joint.Part1

                        -- BallSocket соединение
                        local socket = Instance.new("BallSocketConstraint")
                        socket.Name = "FakeDeath_Socket"
                        socket.Attachment0 = att0
                        socket.Attachment1 = att1
                        socket.LimitsEnabled = true
                        socket.TwistLimitsEnabled = true
                        socket.UpperAngle = 45
                        socket.TwistLowerAngle = -45
                        socket.TwistUpperAngle = 45
                        socket.Parent = joint.Part0

                        -- Включаем физику на частях тела
                        if joint.Part1.Name ~= "HumanoidRootPart" then
                            joint.Part1.CanCollide = true
                        end
                    end

                    -- Отключаем Motor6D
                    joint.Enabled = false
                end
            end

            -- Включаем коллизию частей тела для реалистичности
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end

            -- Небольшой толчок для падения
            if hrp then
                local pushForce = Instance.new("BodyVelocity")
                pushForce.MaxForce = Vector3.new(5000, 5000, 5000)
                pushForce.Velocity = Vector3.new(
                    math.random(-5, 5),
                    2,
                    math.random(-5, 5)
                )
                pushForce.Parent = hrp

                -- Убираем силу через 0.2 секунды
                task.spawn(function()
                    task.wait(0.2)
                    if pushForce and pushForce.Parent then
                        pushForce:Destroy()
                    end
                end)
            end

            -- Убираем инструмент из рук (выглядит реалистичнее)
            pcall(function()
                humanoid:UnequipTools()
            end)
        end)
    end

    function DeactivateFakeDeath()
        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end
            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid then return end

            FakeDeathActive = false

            -- Удаляем все рэгдолл объекты
            for _, obj in pairs(character:GetDescendants()) do
                if obj.Name == "FakeDeath_Socket" or
                   obj.Name == "FakeDeath_Att0" or
                   obj.Name == "FakeDeath_Att1" then
                    obj:Destroy()
                end
            end

            -- Восстанавливаем Motor6D
            for _, data in pairs(SavedMotors) do
                pcall(function()
                    if data.Joint and data.Joint.Parent then
                        data.Joint.Enabled = true
                    end
                end)
            end
            SavedMotors = {}

            -- Возвращаем управление
            humanoid.PlatformStand = false

            -- Сбрасываем коллизии
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    if part.Name == "Head" then
                        part.CanCollide = true
                    elseif part.Name == "HumanoidRootPart" then
                        part.CanCollide = true
                    else
                        part.CanCollide = false
                    end
                end
            end
        end)
    end

    -- ============================================
    -- ОПРЕДЕЛЕНИЕ РОЛЕЙ MM2
    -- ============================================
    function GetPlayerRole(player)
        local result = "Innocent"
        pcall(function()
            if not player or not player.Character then return end
            local backpack = player:FindFirstChild("Backpack")
            local character = player.Character
            local hasKnife = false
            local hasGun = false

            -- Рюкзак
            if backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        local n = tool.Name:lower()
                        if n == "knife" or n:find("knife") then hasKnife = true end
                        if n == "gun" or n == "revolver" or n:find("gun") then hasGun = true end
                    end
                end
            end

            -- В руках
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    local n = tool.Name:lower()
                    if n == "knife" or n:find("knife") then hasKnife = true end
                    if n == "gun" or n == "revolver" or n:find("gun") then hasGun = true end
                end
            end

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

    function GetRoleText(role)
        if role == "Murderer" then return "🔪 УБИЙЦА" end
        if role == "Sheriff" then return "🔫 ШЕРИФ" end
        return "👤 НЕВИННЫЙ"
    end

    function ShouldShowRole(role)
        if role == "Murderer" then return Settings.ESPMurderer end
        if role == "Sheriff" then return Settings.ESPSheriff end
        return Settings.ESPInnocent
    end

    -- ============================================
    -- ЕСП ФУНКЦИИ
    -- ============================================
    function CreateESP(player)
        if player == LocalPlayer then return end
        if not player.Character then return end
        if not player.Character:FindFirstChild("HumanoidRootPart") then return end
        if not player.Character:FindFirstChild("Humanoid") then return end
        if player.Character.Humanoid.Health <= 0 then return end

        RemoveESP(player)

        local role = GetPlayerRole(player)
        if not ShouldShowRole(role) then return end

        local character = player.Character
        local color = GetRoleColor(role)

        -- Чамсы (Highlight)
        local highlight = Instance.new("Highlight")
        highlight.Name = "MM2_ESP"
        highlight.FillColor = color
        highlight.OutlineColor = color
        highlight.FillTransparency = Settings.ESPTransparency
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = character
        highlight.Parent = character

        -- Информация над головой
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "MM2_ESP_Info"
        billboard.Adornee = character:FindFirstChild("Head") or character.HumanoidRootPart
        billboard.Size = UDim2.new(0, 220, 0, 65)
        billboard.StudsOffset = Vector3.new(0, 3.5, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = character

        -- Фон
        local bg = Instance.new("Frame")
        bg.Name = "BG"
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bg.BackgroundTransparency = 0.7
        bg.BorderSizePixel = 0
        bg.Parent = billboard

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = bg

        local stroke = Instance.new("UIStroke")
        stroke.Color = color
        stroke.Thickness = 1.5
        stroke.Transparency = 0.3
        stroke.Parent = bg

        -- Имя
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "Name"
        nameLabel.Size = UDim2.new(1, -10, 0.33, 0)
        nameLabel.Position = UDim2.new(0, 5, 0, 2)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.DisplayName
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 13
        nameLabel.TextXAlignment = Enum.TextXAlignment.Center
        nameLabel.Parent = bg

        -- Роль
        local roleLabel = Instance.new("TextLabel")
        roleLabel.Name = "Role"
        roleLabel.Size = UDim2.new(1, -10, 0.33, 0)
        roleLabel.Position = UDim2.new(0, 5, 0.33, 0)
        roleLabel.BackgroundTransparency = 1
        roleLabel.Text = GetRoleText(role)
        roleLabel.TextColor3 = color
        roleLabel.TextStrokeTransparency = 0.5
        roleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        roleLabel.Font = Enum.Font.GothamBold
        roleLabel.TextSize = 12
        roleLabel.TextXAlignment = Enum.TextXAlignment.Center
        roleLabel.Parent = bg

        -- Дистанция
        local distLabel = Instance.new("TextLabel")
        distLabel.Name = "Dist"
        distLabel.Size = UDim2.new(1, -10, 0.33, 0)
        distLabel.Position = UDim2.new(0, 5, 0.66, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "📏 0m"
        distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distLabel.TextStrokeTransparency = 0.5
        distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextSize = 11
        distLabel.TextXAlignment = Enum.TextXAlignment.Center
        distLabel.Parent = bg

        ESPObjects[player.UserId] = {
            Highlight = highlight,
            Billboard = billboard,
            Player = player
        }
    end

    function RemoveESP(player)
        if ESPObjects[player.UserId] then
            local data = ESPObjects[player.UserId]
            pcall(function() if data.Highlight then data.Highlight:Destroy() end end)
            pcall(function() if data.Billboard then data.Billboard:Destroy() end end)
            ESPObjects[player.UserId] = nil
        end
        pcall(function()
            if player.Character then
                local h = player.Character:FindFirstChild("MM2_ESP")
                if h then h:Destroy() end
                local b = player.Character:FindFirstChild("MM2_ESP_Info")
                if b then b:Destroy() end
            end
        end)
    end

    function ClearAllESP()
        for _, player in pairs(Players:GetPlayers()) do
            RemoveESP(player)
        end
        ESPObjects = {}
    end

    function RefreshESP()
        ClearAllESP()
        if not Settings.ESPEnabled then return end
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(function() CreateESP(player) end)
            end
        end
    end

    -- ============================================
    -- ПОЛЁТ
    -- ============================================
    function StartFly()
        pcall(function()
            local character = LocalPlayer.Character
            if not character then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            if not hrp or not humanoid then return end

            StopFly()

            FlyBody = Instance.new("BodyVelocity")
            FlyBody.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            FlyBody.Velocity = Vector3.new(0, 0, 0)
            FlyBody.Parent = hrp

            FlyGyro = Instance.new("BodyGyro")
            FlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            FlyGyro.P = 9e4
            FlyGyro.Parent = hrp

            humanoid.PlatformStand = true
        end)
    end

    function StopFly()
        pcall(function()
            if LocalPlayer.Character then
                local h = LocalPlayer.Character:FindFirstChild("Humanoid")
                if h then h.PlatformStand = false end
            end
        end)
        pcall(function() if FlyBody then FlyBody:Destroy() FlyBody = nil end end)
        pcall(function() if FlyGyro then FlyGyro:Destroy() FlyGyro = nil end end)
    end

    -- ============================================
    -- ПОИСК ПИСТОЛЕТА
    -- ============================================
    function FindGunOnGround()
        for _, obj in pairs(game.Workspace:GetChildren()) do
            if obj:IsA("Tool") then
                local n = obj.Name:lower()
                if n == "gun" or n == "revolver" or n:find("gun") then
                    if obj:FindFirstChild("Handle") then
                        return obj
                    end
                end
            end
        end

        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj:IsA("Tool") then
                local n = obj.Name:lower()
                if n == "gun" or n == "revolver" or n:find("gun") then
                    local parent = obj.Parent
                    if parent and not parent:IsA("Backpack") and not parent:FindFirstChild("Humanoid") then
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
            local character = LocalPlayer.Character
            if not character then return end
            local humanoid = character:FindFirstChild("Humanoid")
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not hrp then return end
            if humanoid.Health <= 0 then return end

            -- Скорость
            if Settings.WalkSpeedEnabled and not FakeDeathActive then
                humanoid.WalkSpeed = Settings.WalkSpeed
            end

            -- Прыжок
            if Settings.JumpPowerEnabled and not FakeDeathActive then
                humanoid.JumpPower = Settings.JumpPower
                humanoid.UseJumpPower = true
            end

            -- Ноклип
            if Settings.NoclipEnabled then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end

            -- Полёт
            if Settings.FlyEnabled and FlyBody and FlyGyro and not FakeDeathActive then
                FlyGyro.CFrame = Camera.CFrame
                humanoid.PlatformStand = true

                local dir = Vector3.new(0, 0, 0)
                local cf = Camera.CFrame

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    dir = dir + cf.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    dir = dir - cf.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    dir = dir - cf.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    dir = dir + cf.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    dir = dir + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    dir = dir - Vector3.new(0, 1, 0)
                end

                -- Мобильное
                local moveDir = humanoid.MoveDirection
                if moveDir.Magnitude > 0.1 then
                    dir = dir + (cf.LookVector * moveDir.Z + cf.RightVector * moveDir.X)
                end
                if humanoid.Jump then
                    dir = dir + Vector3.new(0, 0.5, 0)
                end

                if dir.Magnitude > 0 then
                    FlyBody.Velocity = dir.Unit * Settings.FlySpeed
                else
                    FlyBody.Velocity = Vector3.new(0, 0, 0)
                end
            end

            -- Фейк смерть - держим PlatformStand
            if FakeDeathActive then
                humanoid.PlatformStand = true
            end

            -- ЕСП обновление (каждые 3 сек)
            espTimer = espTimer + dt
            if espTimer >= 3 then
                espTimer = 0
                if Settings.ESPEnabled then
                    RefreshESP()
                end
            end

            -- Дистанция ЕСП
            if Settings.ESPEnabled then
                for userId, data in pairs(ESPObjects) do
                    pcall(function()
                        if data.Billboard and data.Billboard.Parent and data.Player.Character then
                            local targetHRP = data.Player.Character:FindFirstChild("HumanoidRootPart")
                            if targetHRP then
                                local dist = math.floor((hrp.Position - targetHRP.Position).Magnitude)
                                local bg = data.Billboard:FindFirstChild("BG")
                                if bg then
                                    local distLabel = bg:FindFirstChild("Dist")
                                    if distLabel then
                                        distLabel.Text = "📏 " .. dist .. "m"
                                    end
                                end
                            end
                        end
                    end)
                end
            end

            -- Авто подбор пистолета
            if Settings.AutoPickupGun and not FakeDeathActive then
                local gun = FindGunOnGround()
                if gun and gun:FindFirstChild("Handle") then
                    local gunPos = gun.Handle.Position
                    local dist = (hrp.Position - gunPos).Magnitude

                    if dist > 15 then
                        hrp.CFrame = CFrame.new(gunPos + Vector3.new(0, 3, 0))
                    end

                    pcall(function() humanoid:MoveTo(gunPos) end)
                    pcall(function()
                        local prompt = gun:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt then fireproximityprompt(prompt) end
                    end)
                end
            end
        end)
    end)

    -- Респавн
    LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(1)
        FakeDeathActive = false
        SavedMotors = {}
        if Settings.FlyEnabled then task.wait(0.5) StartFly() end
        if Settings.ESPEnabled then task.wait(1) RefreshESP() end
    end)

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(1)
            if Settings.ESPEnabled then pcall(function() CreateESP(player) end) end
        end)
    end)

    Players.PlayerRemoving:Connect(function(player)
        RemoveESP(player)
    end)

    -- Готово!
    WindUI:Notify({
        Title = "🔪 MM2 Cheat Hub v3.0",
        Content = "Все функции загружены! Удачной игры!",
        Duration = 5,
    })
end
