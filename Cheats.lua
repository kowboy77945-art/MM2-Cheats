-- MM2 Ultimate Cheat Script с WindUI
-- Загрузка WindUI
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

-- Сервисы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera

-- ============================================
-- СИСТЕМА КЛЮЧЕЙ
-- ============================================
local ValidKeys = {
    "MM2-CHEAT-KEY01",
    "MM2-CHEAT-KEY02",
    "MM2-CHEAT-KEY03",
    "MM2-CHEAT-KEY04",
    "MM2-CHEAT-KEY05",
    "MM2-CHEAT-KEY06",
    "MM2-CHEAT-KEY07",
    "MM2-CHEAT-KEY08",
    "MM2-CHEAT-KEY09",
    "MM2-CHEAT-KEY10"
}

local KeyVerified = false

-- Создаём окно ключа
local KeyWindow = WindUI:CreateWindow({
    Title = "🔑 Система Ключей - MM2 Cheat",
    Icon = "key-round",
    Author = "MM2 Script",
    Folder = "MM2CheatHub",
    Size = UDim2.fromOffset(400, 220),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 0,
    HasOutline = true,
})

local KeyTab = KeyWindow:Tab({
    Title = "Введите ключ",
    Icon = "lock",
})

local KeyInput = ""

KeyTab:Input({
    Title = "🔐 Ключ доступа",
    Desc = "Введите ключ для доступа к скрипту",
    Value = "",
    Placeholder = "MM2-CHEAT-KEYXX",
    Callback = function(value)
        KeyInput = value
    end,
})

KeyTab:Button({
    Title = "✅ Подтвердить ключ",
    Desc = "Нажмите для проверки ключа",
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
                Title = "✅ Успех!",
                Content = "Ключ принят! Загрузка чита...",
                Duration = 3,
            })
            wait(1)
            KeyWindow:Destroy()
            wait(0.5)
            LoadMainScript()
        else
            WindUI:Notify({
                Title = "❌ Ошибка!",
                Content = "Неверный ключ! Попробуйте снова.",
                Duration = 3,
            })
        end
    end,
})

KeyTab:Button({
    Title = "📋 Получить ключ",
    Desc = "Список доступных ключей (для теста)",
    Callback = function()
        WindUI:Notify({
            Title = "🔑 Ключи",
            Content = "MM2-CHEAT-KEY01 до MM2-CHEAT-KEY10",
            Duration = 8,
        })
    end,
})

-- ============================================
-- ОСНОВНОЙ СКРИПТ
-- ============================================
function LoadMainScript()
    if not KeyVerified then return end

    -- Переменные состояний
    local Settings = {
        -- Скорость и прыжок
        WalkSpeed = 16,
        JumpPower = 50,
        WalkSpeedEnabled = false,
        JumpPowerEnabled = false,

        -- Ноклип
        NoclipEnabled = false,

        -- Полёт
        FlyEnabled = false,
        FlySpeed = 50,

        -- ЕСП
        ESPEnabled = false,
        ESPMurderer = true,
        ESPSheriff = true,
        ESPInnocent = true,
        ESPTransparency = 0.5,

        -- Авто подбор пистолета
        AutoPickupGun = false,
    }

    -- Хранилище ЕСП
    local ESPObjects = {}
    local FlyBody = nil
    local FlyGyro = nil

    -- ============================================
    -- ГЛАВНОЕ ОКНО
    -- ============================================
    local Window = WindUI:CreateWindow({
        Title = "🔪 MM2 Cheat Hub",
        Icon = "swords",
        Author = "MM2 Script v2.0",
        Folder = "MM2CheatMain",
        Size = UDim2.fromOffset(580, 460),
        Transparent = true,
        Theme = "Dark",
        SideBarWidth = 200,
        HasOutline = true,
    })

    -- ============================================
    -- TAB: ДВИЖЕНИЕ
    -- ============================================
    local MovementTab = Window:Tab({
        Title = "🏃 Движение",
        Icon = "person-standing",
    })

    MovementTab:Section({ Title = "⚡ Скорость и Прыжок" })

    MovementTab:Toggle({
        Title = "🏃 Скорость ходьбы",
        Desc = "Включить изменение скорости",
        Value = false,
        Callback = function(value)
            Settings.WalkSpeedEnabled = value
            if not value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end,
    })

    MovementTab:Slider({
        Title = "📊 Значение скорости",
        Desc = "Настройте скорость ходьбы (16-200)",
        Value = 16,
        Min = 16,
        Max = 200,
        Callback = function(value)
            Settings.WalkSpeed = value
        end,
    })

    MovementTab:Toggle({
        Title = "🦘 Высота прыжка",
        Desc = "Включить изменение прыжка",
        Value = false,
        Callback = function(value)
            Settings.JumpPowerEnabled = value
            if not value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = 50
            end
        end,
    })

    MovementTab:Slider({
        Title = "📊 Значение прыжка",
        Desc = "Настройте высоту прыжка (50-500)",
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
        Desc = "Проходить сквозь стены",
        Value = false,
        Callback = function(value)
            Settings.NoclipEnabled = value
        end,
    })

    -- ============================================
    -- TAB: ПОЛЁТ
    -- ============================================
    local FlyTab = Window:Tab({
        Title = "✈️ Полёт",
        Icon = "plane",
    })

    FlyTab:Section({ Title = "✈️ Настройки полёта" })

    FlyTab:Toggle({
        Title = "✈️ Полёт (ПК: WASD + Space/Ctrl)",
        Desc = "Телефон: Джойстик + Кнопка прыжка вверх",
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
        Title = "📊 Скорость полёта",
        Desc = "Настройте скорость полёта (10-300)",
        Value = 50,
        Min = 10,
        Max = 300,
        Callback = function(value)
            Settings.FlySpeed = value
        end,
    })

    FlyTab:Paragraph({
        Title = "📖 Управление полётом",
        Desc = "ПК: W/A/S/D - направление, Space - вверх, LeftCtrl - вниз\nТелефон: Джойстик для направления, Прыжок - вверх",
    })

    -- ============================================
    -- TAB: ЕСП
    -- ============================================
    local ESPTab = Window:Tab({
        Title = "👁️ ЕСП",
        Icon = "eye",
    })

    ESPTab:Section({ Title = "👁️ Настройки ЕСП (Чамсы)" })

    ESPTab:Toggle({
        Title = "👁️ Включить ЕСП",
        Desc = "Показывать игроков сквозь стены",
        Value = false,
        Callback = function(value)
            Settings.ESPEnabled = value
            if not value then
                ClearAllESP()
            end
        end,
    })

    ESPTab:Section({ Title = "🎯 Выбор ролей" })

    ESPTab:Toggle({
        Title = "🔴 Убийца (Красный)",
        Desc = "Показывать убийцу",
        Value = true,
        Callback = function(value)
            Settings.ESPMurderer = value
            RefreshESP()
        end,
    })

    ESPTab:Toggle({
        Title = "🔵 Шериф (Синий)",
        Desc = "Показывать шерифа",
        Value = true,
        Callback = function(value)
            Settings.ESPSheriff = value
            RefreshESP()
        end,
    })

    ESPTab:Toggle({
        Title = "🟢 Невинные (Зелёный)",
        Desc = "Показывать невинных",
        Value = true,
        Callback = function(value)
            Settings.ESPInnocent = value
            RefreshESP()
        end,
    })

    ESPTab:Section({ Title = "🎨 Настройки отображения" })

    ESPTab:Slider({
        Title = "🔍 Прозрачность ЕСП",
        Desc = "0 = Полностью видно, 1 = Невидимо (0.0-0.9)",
        Value = 50,
        Min = 0,
        Max = 90,
        Callback = function(value)
            Settings.ESPTransparency = value / 100
            RefreshESP()
        end,
    })

    -- ============================================
    -- TAB: АВТО
    -- ============================================
    local AutoTab = Window:Tab({
        Title = "🔫 Авто",
        Icon = "crosshair",
    })

    AutoTab:Section({ Title = "🔫 Авто-функции" })

    AutoTab:Toggle({
        Title = "🔫 Авто подбор пистолета",
        Desc = "Автоматически подбирает пистолет шерифа",
        Value = false,
        Callback = function(value)
            Settings.AutoPickupGun = value
        end,
    })

    AutoTab:Paragraph({
        Title = "📖 Информация",
        Desc = "Когда шериф умирает и роняет пистолет, скрипт автоматически телепортирует вас к пистолету для подбора.",
    })

    -- ============================================
    -- TAB: ИНФО
    -- ============================================
    local InfoTab = Window:Tab({
        Title = "ℹ️ Инфо",
        Icon = "info",
    })

    InfoTab:Section({ Title = "📋 Информация о скрипте" })

    InfoTab:Paragraph({
        Title = "🔪 MM2 Cheat Hub v2.0",
        Desc = "Полнофункциональный чит для Murder Mystery 2\n\n✅ Скорость ходьбы\n✅ Высота прыжка\n✅ Ноклип\n✅ Полёт (ПК + Телефон)\n✅ ЕСП с цветами ролей\n✅ Авто подбор пистолета\n\n⚠️ Используйте на свой страх и риск!",
    })

    -- ============================================
    -- ФУНКЦИИ
    -- ============================================

    -- Получение роли игрока в MM2
    function GetPlayerRole(player)
        -- Метод через папку игры MM2
        local success, result = pcall(function()
            -- Проверяем через известные методы MM2
            if player and player.Character then
                local backpack = player:FindFirstChild("Backpack")
                local character = player.Character

                -- Проверяем наличие ножа
                local hasKnife = false
                local hasGun = false

                if backpack then
                    for _, tool in pairs(backpack:GetChildren()) do
                        local toolName = tool.Name:lower()
                        if toolName == "knife" or toolName:find("knife") then
                            hasKnife = true
                        end
                        if toolName == "gun" or toolName == "revolver" or toolName:find("gun") then
                            hasGun = true
                        end
                    end
                end

                -- Проверяем в руках
                for _, tool in pairs(character:GetChildren()) do
                    if tool:IsA("Tool") then
                        local toolName = tool.Name:lower()
                        if toolName == "knife" or toolName:find("knife") then
                            hasKnife = true
                        end
                        if toolName == "gun" or toolName == "revolver" or toolName:find("gun") then
                            hasGun = true
                        end
                    end
                end

                if hasKnife then
                    return "Murderer"
                elseif hasGun then
                    return "Sheriff"
                else
                    return "Innocent"
                end
            end
            return "Unknown"
        end)

        if success then
            return result
        end
        return "Unknown"
    end

    -- Получение цвета роли
    function GetRoleColor(role)
        if role == "Murderer" then
            return Color3.fromRGB(255, 0, 0) -- Красный
        elseif role == "Sheriff" then
            return Color3.fromRGB(0, 100, 255) -- Синий
        elseif role == "Innocent" then
            return Color3.fromRGB(0, 255, 0) -- Зелёный
        else
            return Color3.fromRGB(255, 255, 255) -- Белый
        end
    end

    -- Должен ли показывать ЕСП для этой роли
    function ShouldShowRole(role)
        if role == "Murderer" then return Settings.ESPMurderer end
        if role == "Sheriff" then return Settings.ESPSheriff end
        if role == "Innocent" then return Settings.ESPInnocent end
        return false
    end

    -- Создание ЕСП для игрока (Чамсы через Highlight)
    function CreateESP(player)
        if player == LocalPlayer then return end
        if not player.Character then return end

        RemoveESP(player)

        local role = GetPlayerRole(player)
        if not ShouldShowRole(role) then return end

        local character = player.Character
        if not character:FindFirstChild("HumanoidRootPart") then return end

        -- Highlight (Чамсы)
        local highlight = Instance.new("Highlight")
        highlight.Name = "MM2_ESP_Highlight"
        highlight.FillColor = GetRoleColor(role)
        highlight.OutlineColor = GetRoleColor(role)
        highlight.FillTransparency = Settings.ESPTransparency
        highlight.OutlineTransparency = 0
        highlight.Adornee = character
        highlight.Parent = character

        -- BillboardGui для имени и роли
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "MM2_ESP_Billboard"
        billboard.Adornee = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = character

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = GetRoleColor(role)
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 14
        nameLabel.Parent = billboard

        local roleLabel = Instance.new("TextLabel")
        roleLabel.Size = UDim2.new(1, 0, 0.5, 0)
        roleLabel.Position = UDim2.new(0, 0, 0.5, 0)
        roleLabel.BackgroundTransparency = 1

        local roleText = ""
        if role == "Murderer" then roleText = "🔪 УБИЙЦА"
        elseif role == "Sheriff" then roleText = "🔫 ШЕРИФ"
        elseif role == "Innocent" then roleText = "👤 НЕВИННЫЙ"
        else roleText = "❓ Неизвестно" end

        roleLabel.Text = roleText
        roleLabel.TextColor3 = GetRoleColor(role)
        roleLabel.TextStrokeTransparency = 0
        roleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        roleLabel.Font = Enum.Font.GothamBold
        roleLabel.TextSize = 12
        roleLabel.Parent = billboard

        -- Дистанция
        local distLabel = Instance.new("TextLabel")
        distLabel.Name = "DistLabel"
        distLabel.Size = UDim2.new(1, 0, 0.3, 0)
        distLabel.Position = UDim2.new(0, 0, 1, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "0m"
        distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distLabel.TextStrokeTransparency = 0
        distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextSize = 11
        distLabel.Parent = billboard

        ESPObjects[player.UserId] = {
            Highlight = highlight,
            Billboard = billboard,
            Player = player
        }
    end

    -- Удаление ЕСП для игрока
    function RemoveESP(player)
        if ESPObjects[player.UserId] then
            local data = ESPObjects[player.UserId]
            if data.Highlight and data.Highlight.Parent then
                data.Highlight:Destroy()
            end
            if data.Billboard and data.Billboard.Parent then
                data.Billboard:Destroy()
            end
            ESPObjects[player.UserId] = nil
        end

        -- Также очищаем из персонажа
        if player.Character then
            local h = player.Character:FindFirstChild("MM2_ESP_Highlight")
            if h then h:Destroy() end
            local b = player.Character:FindFirstChild("MM2_ESP_Billboard")
            if b then b:Destroy() end
        end
    end

    -- Очистка всех ЕСП
    function ClearAllESP()
        for _, player in pairs(Players:GetPlayers()) do
            RemoveESP(player)
        end
        ESPObjects = {}
    end

    -- Обновление всех ЕСП
    function RefreshESP()
        ClearAllESP()
        if Settings.ESPEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    CreateESP(player)
                end
            end
        end
    end

    -- ============================================
    -- ПОЛЁТ
    -- ============================================
    function StartFly()
        local character = LocalPlayer.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not hrp or not humanoid then return end

        -- Создаём BodyVelocity и BodyGyro
        FlyBody = Instance.new("BodyVelocity")
        FlyBody.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        FlyBody.Velocity = Vector3.new(0, 0, 0)
        FlyBody.Parent = hrp

        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        FlyGyro.P = 9e4
        FlyGyro.Parent = hrp

        -- Отключаем падение
        humanoid.PlatformStand = true
    end

    function StopFly()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end

        if FlyBody then
            FlyBody:Destroy()
            FlyBody = nil
        end
        if FlyGyro then
            FlyGyro:Destroy()
            FlyGyro = nil
        end
    end

    -- ============================================
    -- АВТО ПОДБОР ПИСТОЛЕТА
    -- ============================================
    function FindGunOnGround()
        -- Ищем пистолет на земле в Workspace
        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj:IsA("Tool") then
                local name = obj.Name:lower()
                if (name == "gun" or name == "revolver" or name:find("gun")) then
                    -- Проверяем что это не в руках/рюкзаке игрока
                    local isOnGround = true
                    local parent = obj.Parent
                    if parent then
                        if parent:IsA("Backpack") or parent:FindFirstChild("Humanoid") then
                            isOnGround = false
                        end
                    end
                    if isOnGround and obj:FindFirstChild("Handle") then
                        return obj
                    end
                end
            end
        end
        return nil
    end

    -- ============================================
    -- ГЛАВНЫЙ ЦИКЛ
    -- ============================================
    local espUpdateTimer = 0

    RunService.Heartbeat:Connect(function(dt)
        local character = LocalPlayer.Character
        if not character then return end
        local humanoid = character:FindFirstChild("Humanoid")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not humanoid or not hrp then return end

        -- Скорость ходьбы
        if Settings.WalkSpeedEnabled then
            humanoid.WalkSpeed = Settings.WalkSpeed
        end

        -- Высота прыжка
        if Settings.JumpPowerEnabled then
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
        if Settings.FlyEnabled and FlyBody and FlyGyro then
            FlyGyro.CFrame = Camera.CFrame
            humanoid.PlatformStand = true

            local moveDirection = Vector3.new(0, 0, 0)
            local camCF = Camera.CFrame

            -- Проверяем ввод с клавиатуры (ПК)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camCF.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camCF.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camCF.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camCF.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end

            -- Поддержка мобильного джойстика
            if humanoid.MoveDirection.Magnitude > 0 then
                local mobileMove = camCF.LookVector * humanoid.MoveDirection.Z + camCF.RightVector * humanoid.MoveDirection.X
                if mobileMove.Magnitude > 0 then
                    moveDirection = moveDirection + mobileMove.Unit
                end
            end

            -- Мобильный прыжок = вверх
            if humanoid.Jump then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end

            if moveDirection.Magnitude > 0 then
                FlyBody.Velocity = moveDirection.Unit * Settings.FlySpeed
            else
                FlyBody.Velocity = Vector3.new(0, 0, 0)
            end
        end

        -- Обновление ЕСП (каждые 2 секунды для производительности)
        espUpdateTimer = espUpdateTimer + dt
        if espUpdateTimer >= 2 then
            espUpdateTimer = 0
            if Settings.ESPEnabled then
                RefreshESP()
            end
        end

        -- Обновление дистанции ЕСП
        if Settings.ESPEnabled then
            for userId, data in pairs(ESPObjects) do
                if data.Billboard and data.Billboard.Parent then
                    local distLabel = data.Billboard:FindFirstChild("DistLabel", true)
                    if distLabel and data.Player and data.Player.Character then
                        local targetHRP = data.Player.Character:FindFirstChild("HumanoidRootPart")
                        if targetHRP and hrp then
                            local dist = math.floor((hrp.Position - targetHRP.Position).Magnitude)
                            distLabel.Text = tostring(dist) .. "m"
                        end
                    end
                end
            end
        end

        -- Авто подбор пистолета
        if Settings.AutoPickupGun then
            local gun = FindGunOnGround()
            if gun and gun:FindFirstChild("Handle") then
                local gunPos = gun.Handle.Position
                local distance = (hrp.Position - gunPos).Magnitude

                if distance <= 15 then
                    -- Близко - пробуем подобрать
                    humanoid:MoveTo(gunPos)
                elseif distance > 15 then
                    -- Далеко - телепортируем
                    hrp.CFrame = CFrame.new(gunPos + Vector3.new(0, 2, 0))
                end

                -- Пробуем подобрать через fireproximityprompt или касание
                pcall(function()
                    local prompt = gun:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then
                        fireproximityprompt(prompt)
                    end
                end)
            end
        end
    end)

    -- ============================================
    -- ОБРАБОТКА СПАВНА ПЕРСОНАЖА
    -- ============================================
    LocalPlayer.CharacterAdded:Connect(function(char)
        wait(1)
        -- Сбрасываем полёт при респавне
        if Settings.FlyEnabled then
            wait(0.5)
            StartFly()
        end
        -- Обновляем ЕСП
        if Settings.ESPEnabled then
            wait(1)
            RefreshESP()
        end
    end)

    -- Обработка новых игроков
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            wait(1)
            if Settings.ESPEnabled then
                CreateESP(player)
            end
        end)
    end)

    -- Обработка ухода игроков
    Players.PlayerRemoving:Connect(function(player)
        RemoveESP(player)
    end)

    -- ============================================
    -- УВЕДОМЛЕНИЕ ОБ УСПЕХЕ
    -- ============================================
    WindUI:Notify({
        Title = "🔪 MM2 Cheat Hub",
        Content = "Скрипт успешно загружен! Приятной игры!",
        Duration = 5,
    })
end
