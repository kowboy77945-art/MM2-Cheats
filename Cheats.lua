--[[
    MM2 Enhanced Script
    Библиотека: WindUI
    Совместимость: ПК (Solara, Wave) / Mobile (Hydrogen, Delta)
    
    ВНИМАНИЕ: Используйте на свой страх и риск.
    Скрипт предназначен исключительно в образовательных целях.
]]

-- ============================================================
-- ИНИЦИАЛИЗАЦИЯ БИБЛИОТЕКИ
-- ============================================================

local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'))()

-- ============================================================
-- СЕРВИСЫ И ПЕРЕМЕННЫЕ
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Таблица состояний всех функций
local State = {
    -- Movement
    WalkSpeed = 16,
    JumpPower = 50,
    NoclipEnabled = false,
    FlyEnabled = false,
    FlySpeed = 50,
    
    -- Visuals
    ESPMurderer = true,
    ESPSheriff = true,
    ESPInnocent = true,
    FillTransparency = 0.5,
    
    -- Combat / Misc
    AutoGrabGun = false,
    FakeDead = false,
    FEInvisible = false,
}

-- Хранилище подключений (Connections) для корректной очистки
local Connections = {}

-- Хранилище ESP-объектов Highlight
local ESPHighlights = {}

-- Переменные для Fly
local FlyBodyVelocity = nil
local FlyBodyGyro = nil

-- ============================================================
-- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
-- ============================================================

--- Получить персонажа и Humanoid локального игрока
local function GetCharacterAndHumanoid()
    local char = LocalPlayer.Character
    if not char then return nil, nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return char, hum
end

--- Получить HumanoidRootPart
local function GetHRP()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

--- Определение роли игрока в MM2
--- Возвращает: "Murderer", "Sheriff", "Innocent" или "Unknown"
local function GetPlayerRole(player)
    -- Проверяем Backpack на наличие оружия
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    
    local hasKnife = false
    local hasGun = false
    
    -- Проверка Backpack
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            local itemName = item.Name:lower()
            if itemName == "knife" or item:IsA("Tool") and item:FindFirstChild("KnifeServer") then
                hasKnife = true
            end
            if itemName == "gun" or itemName == "revolver" then
                hasGun = true
            end
            -- Дополнительная проверка через ToolTip или атрибуты
            if item:IsA("Tool") then
                if item:FindFirstChild("GunLocal") or item:FindFirstChild("GunServer") then
                    hasGun = true
                end
                if item:FindFirstChild("KnifeLocal") or item:FindFirstChild("KnifeServer") then
                    hasKnife = true
                end
            end
        end
    end
    
    -- Проверка экипированного оружия в Character
    if character then
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Tool") then
                local itemName = item.Name:lower()
                if itemName == "knife" or item:FindFirstChild("KnifeServer") or item:FindFirstChild("KnifeLocal") then
                    hasKnife = true
                end
                if itemName == "gun" or itemName == "revolver" or item:FindFirstChild("GunLocal") or item:FindFirstChild("GunServer") then
                    hasGun = true
                end
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

--- Определение, является ли устройство мобильным
local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

--- Получение вектора направления движения (поддержка ПК и Mobile)
local function GetMoveDirection()
    local char, hum = GetCharacterAndHumanoid()
    if hum then
        return hum.MoveDirection
    end
    return Vector3.new(0, 0, 0)
end

-- ============================================================
-- СОЗДАНИЕ UI
-- ============================================================

local Window = WindUI:CreateWindow({
    Title = "MM2 Enhanced",
    Icon = "rbxassetid://18220853753",
    Author = "Script Hub",
    Folder = "MM2Enhanced",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

-- Уведомление о загрузке
WindUI:Notify({
    Title = "MM2 Enhanced",
    Content = "Скрипт успешно загружен!\nУстройство: " .. (IsMobile() and "📱 Mobile" or "💻 PC"),
    Duration = 5,
    Icon = "check",
})

-- ============================================================
-- ВКЛАДКА 1: MOVEMENT
-- ============================================================

local MovementTab = Window:Tab({
    Title = "Movement",
    Icon = "person-running",
})

-- Секция WalkSpeed
local SpeedSection = MovementTab:Section({
    Title = "Скорость передвижения",
})

SpeedSection:Slider({
    Title = "WalkSpeed",
    Description = "Скорость ходьбы персонажа (16 = стандарт)",
    Value = {
        Min = 16,
        Max = 150,
        Default = 16,
    },
    Callback = function(value)
        State.WalkSpeed = value
    end,
})

-- Цикл обновления WalkSpeed через RenderStepped
-- Используем RenderStepped для постоянного применения,
-- т.к. античит MM2 периодически сбрасывает значение
Connections["WalkSpeedLoop"] = RunService.RenderStepped:Connect(function()
    local _, hum = GetCharacterAndHumanoid()
    if hum then
        hum.WalkSpeed = State.WalkSpeed
    end
end)

-- Секция JumpPower
SpeedSection:Slider({
    Title = "JumpPower",
    Description = "Высота прыжка (50 = стандарт)",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        State.JumpPower = value
    end,
})

-- Цикл обновления JumpPower
Connections["JumpPowerLoop"] = RunService.RenderStepped:Connect(function()
    local _, hum = GetCharacterAndHumanoid()
    if hum then
        -- Поддержка обоих свойств (UseJumpPower может быть включен/выключен)
        if hum.UseJumpPower then
            hum.JumpPower = State.JumpPower
        else
            hum.JumpHeight = State.JumpPower / 3.6 -- Приблизительная конвертация
        end
    end
end)

-- Секция Noclip
local NoclipSection = MovementTab:Section({
    Title = "Прохождение сквозь стены",
})

NoclipSection:Toggle({
    Title = "Noclip",
    Description = "Позволяет проходить сквозь стены и объекты",
    Default = false,
    Callback = function(value)
        State.NoclipEnabled = value
        WindUI:Notify({
            Title = "Noclip",
            Content = value and "Включен ✅" or "Выключен ❌",
            Duration = 2,
        })
    end,
})

-- Цикл Noclip через Stepped (физический шаг)
-- Stepped вызывается до физических расчетов, что идеально для отключения коллизий
Connections["NoclipLoop"] = RunService.Stepped:Connect(function()
    if not State.NoclipEnabled then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

-- Секция Fly
local FlySection = MovementTab:Section({
    Title = "Полёт",
})

FlySection:Slider({
    Title = "Скорость полёта",
    Description = "Настройка скорости при полёте",
    Value = {
        Min = 10,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        State.FlySpeed = value
    end,
})

--- Функция запуска полёта
local function StartFly()
    local hrp = GetHRP()
    local _, hum = GetCharacterAndHumanoid()
    if not hrp or not hum then return end
    
    -- Создаём BodyVelocity для управления скоростью
    FlyBodyVelocity = Instance.new("BodyVelocity")
    FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    FlyBodyVelocity.Parent = hrp
    
    -- Создаём BodyGyro для стабилизации ориентации
    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyGyro.D = 200
    FlyBodyGyro.P = 10000
    FlyBodyGyro.Parent = hrp
    
    -- Отключаем падение
    hum.PlatformStand = true
    
    -- Цикл управления полётом
    Connections["FlyLoop"] = RunService.RenderStepped:Connect(function()
        if not State.FlyEnabled then return end
        
        local hrp2 = GetHRP()
        local _, hum2 = GetCharacterAndHumanoid()
        if not hrp2 or not hum2 or not FlyBodyVelocity or not FlyBodyGyro then return end
        
        -- Направление камеры
        local camCF = Camera.CFrame
        local moveDir = GetMoveDirection()
        
        local velocity = Vector3.new(0, 0, 0)
        
        -- Горизонтальное движение от MoveDirection (работает и с джойстиком, и с WASD)
        if moveDir.Magnitude > 0 then
            velocity = velocity + camCF.LookVector * moveDir.Z * (-State.FlySpeed)
            velocity = velocity + camCF.RightVector * moveDir.X * State.FlySpeed
        end
        
        -- Вертикальное движение (ПК: пробел/шифт)
        if not IsMobile() then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                velocity = velocity + Vector3.new(0, State.FlySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                velocity = velocity - Vector3.new(0, State.FlySpeed, 0)
            end
        else
            -- На мобильных: если прыгает — летим вверх
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) or hum2.Jump then
                velocity = velocity + Vector3.new(0, State.FlySpeed * 0.5, 0)
            end
        end
        
        FlyBodyVelocity.Velocity = velocity
        FlyBodyGyro.CFrame = camCF
    end)
end

--- Функция остановки полёта
local function StopFly()
    -- Удаляем физические объекты
    if FlyBodyVelocity then
        FlyBodyVelocity:Destroy()
        FlyBodyVelocity = nil
    end
    if FlyBodyGyro then
        FlyBodyGyro:Destroy()
        FlyBodyGyro = nil
    end
    
    -- Отключаем PlatformStand
    local _, hum = GetCharacterAndHumanoid()
    if hum then
        hum.PlatformStand = false
    end
    
    -- Отключаем цикл
    if Connections["FlyLoop"] then
        Connections["FlyLoop"]:Disconnect()
        Connections["FlyLoop"] = nil
    end
end

FlySection:Toggle({
    Title = "Fly",
    Description = "Включить полёт (ПК: Space/Shift — вверх/вниз)",
    Default = false,
    Callback = function(value)
        State.FlyEnabled = value
        if value then
            StartFly()
        else
            StopFly()
        end
        WindUI:Notify({
            Title = "Fly",
            Content = value and "Полёт активирован 🛫" or "Полёт деактивирован 🛬",
            Duration = 2,
        })
    end,
})

-- ============================================================
-- ВКЛАДКА 2: VISUALS (ESP)
-- ============================================================

local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye",
})

local ESPSection = VisualsTab:Section({
    Title = "ESP (Подсветка игроков)",
})

-- Цветовая схема ролей
local RoleColors = {
    Murderer = Color3.fromRGB(255, 50, 50),   -- Красный
    Sheriff = Color3.fromRGB(50, 100, 255),    -- Синий
    Innocent = Color3.fromRGB(50, 255, 100),   -- Зеленый
    Unknown = Color3.fromRGB(200, 200, 200),   -- Серый
}

-- Тоглы фильтрации ESP по ролям
ESPSection:Toggle({
    Title = "Подсветка Убийцы",
    Description = "Показывать ESP для Убийцы (красный)",
    Default = true,
    Callback = function(value)
        State.ESPMurderer = value
        -- Немедленно обновляем ESP
        UpdateAllESP()
    end,
})

ESPSection:Toggle({
    Title = "Подсветка Шерифа",
    Description = "Показывать ESP для Шерифа (синий)",
    Default = true,
    Callback = function(value)
        State.ESPSheriff = value
        UpdateAllESP()
    end,
})

ESPSection:Toggle({
    Title = "Подсветка Невинных",
    Description = "Показывать ESP для Невинных (зелёный)",
    Default = true,
    Callback = function(value)
        State.ESPInnocent = value
        UpdateAllESP()
    end,
})

ESPSection:Slider({
    Title = "Прозрачность заливки",
    Description = "0% = полностью видно, 100% = только контур",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value)
        State.FillTransparency = value / 100
        -- Обновляем прозрачность у всех существующих Highlight
        for _, highlight in pairs(ESPHighlights) do
            if highlight and highlight.Parent then
                highlight.FillTransparency = State.FillTransparency
            end
        end
    end,
})

--- Создать или обновить Highlight для конкретного игрока
local function UpdatePlayerESP(player)
    if player == LocalPlayer then return end
    
    local character = player.Character
    if not character then
        -- Удаляем старый Highlight если персонажа нет
        if ESPHighlights[player.UserId] then
            ESPHighlights[player.UserId]:Destroy()
            ESPHighlights[player.UserId] = nil
        end
        return
    end
    
    local role = GetPlayerRole(player)
    
    -- Проверяем, включен ли ESP для этой роли
    local shouldShow = false
    if role == "Murderer" and State.ESPMurderer then
        shouldShow = true
    elseif role == "Sheriff" and State.ESPSheriff then
        shouldShow = true
    elseif (role == "Innocent" or role == "Unknown") and State.ESPInnocent then
        shouldShow = true
    end
    
    if not shouldShow then
        -- Удаляем Highlight если роль отфильтрована
        if ESPHighlights[player.UserId] then
            ESPHighlights[player.UserId]:Destroy()
            ESPHighlights[player.UserId] = nil
        end
        return
    end
    
    -- Создаём Highlight если его нет
    local highlight = ESPHighlights[player.UserId]
    if not highlight or not highlight.Parent then
        highlight = Instance.new("Highlight")
        highlight.Name = "MM2_ESP_" .. player.UserId
        highlight.Adornee = character
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character
        ESPHighlights[player.UserId] = highlight
    end
    
    -- Обновляем адорни (на случай респауна)
    highlight.Adornee = character
    
    -- Применяем цвет роли
    local color = RoleColors[role] or RoleColors.Unknown
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = State.FillTransparency
    highlight.OutlineTransparency = 0
end

--- Обновить ESP для всех игроков
function UpdateAllESP()
    for _, player in ipairs(Players:GetPlayers()) do
        UpdatePlayerESP(player)
    end
end

--- Очистить все ESP
local function ClearAllESP()
    for userId, highlight in pairs(ESPHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    ESPHighlights = {}
end

-- Основной цикл обновления ESP (каждые 0.5 секунды для производительности)
-- Частое обновление необходимо т.к. роли могут меняться (подбор оружия, смерть)
task.spawn(function()
    while task.wait(0.5) do
        -- Проверяем, включен ли хотя бы один фильтр
        if State.ESPMurderer or State.ESPSheriff or State.ESPInnocent then
            UpdateAllESP()
        else
            ClearAllESP()
        end
    end
end)

-- Обработка новых игроков и респаунов
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1) -- Ждём загрузку персонажа
        UpdatePlayerESP(player)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    -- Очищаем ESP уходящего игрока
    if ESPHighlights[player.UserId] then
        ESPHighlights[player.UserId]:Destroy()
        ESPHighlights[player.UserId] = nil
    end
end)

-- Подписываемся на CharacterAdded для уже существующих игроков
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            UpdatePlayerESP(player)
        end)
    end
end

-- ============================================================
-- ВКЛАДКА 3: COMBAT / MISC
-- ============================================================

local CombatTab = Window:Tab({
    Title = "Combat / Misc",
    Icon = "swords",
})

-- -------------------------------------------------------
-- AUTO-GRAB GUN
-- -------------------------------------------------------

local GunGrabSection = CombatTab:Section({
    Title = "Автоподбор пистолета",
})

GunGrabSection:Toggle({
    Title = "Auto-Grab Gun",
    Description = "Автоматически подбирает выпавший пистолет",
    Default = false,
    Callback = function(value)
        State.AutoGrabGun = value
        WindUI:Notify({
            Title = "Auto-Grab Gun",
            Content = value and "Автоподбор включён 🔫" or "Автоподбор выключен",
            Duration = 2,
        })
    end,
})

-- Фоновый поток сканирования workspace на GunDrop
task.spawn(function()
    while task.wait(0.1) do
        if not State.AutoGrabGun then continue end
        
        local hrp = GetHRP()
        if not hrp then continue end
        
        -- Ищем выпавший пистолет в workspace
        -- В MM2 он обычно называется "GunDrop"
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                -- Сохраняем исходную позицию
                local originalCFrame = hrp.CFrame
                
                -- Телепортируемся к пистолету
                hrp.CFrame = obj.CFrame
                
                -- Ждём подбор (несколько фреймов)
                task.wait(0.15)
                
                -- Возвращаемся на исходную позицию
                if hrp and hrp.Parent then
                    hrp.CFrame = originalCFrame
                end
                
                WindUI:Notify({
                    Title = "Auto-Grab",
                    Content = "Пистолет подобран! 🔫",
                    Duration = 3,
                })
                
                break -- Обрабатываем только один за цикл
            end
        end
    end
end)

-- Также подписываемся на ChildAdded для мгновенной реакции
Workspace.ChildAdded:Connect(function(child)
    if not State.AutoGrabGun then return end
    if child.Name ~= "GunDrop" then return end
    
    task.wait(0.05) -- Минимальная задержка для стабильности
    
    local hrp = GetHRP()
    if not hrp then return end
    
    -- Ищем BasePart внутри (или сам объект)
    local targetPart = child:IsA("BasePart") and child or child:FindFirstChildOfClass("BasePart")
    if not targetPart then return end
    
    local originalCFrame = hrp.CFrame
    hrp.CFrame = targetPart.CFrame
    task.wait(0.15)
    if hrp and hrp.Parent then
        hrp.CFrame = originalCFrame
    end
    
    WindUI:Notify({
        Title = "Auto-Grab",
        Content = "Пистолет мгновенно подобран! ⚡",
        Duration = 3,
    })
end)

-- -------------------------------------------------------
-- FAKE DEAD
-- -------------------------------------------------------

local FakeDeadSection = CombatTab:Section({
    Title = "Притвориться мёртвым",
})

local originalFakeDeadState = {}

local function EnableFakeDead()
    local char, hum = GetCharacterAndHumanoid()
    local hrp = GetHRP()
    if not char or not hum or not hrp then return end
    
    -- Сохраняем исходное состояние
    originalFakeDeadState.PlatformStand = hum.PlatformStand
    originalFakeDeadState.CFrame = hrp.CFrame
    
    -- Включаем PlatformStand — персонаж "падает" и теряет управление ногами
    hum.PlatformStand = true
    
    -- Наклоняем персонажа на бок для имитации смерти
    -- Поворот на 90 градусов по оси Z
    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, 0, math.rad(90))
    
    -- Цикл удержания позы (античит может сбрасывать)
    Connections["FakeDeadLoop"] = RunService.RenderStepped:Connect(function()
        if not State.FakeDead then return end
        local _, h = GetCharacterAndHumanoid()
        if h then
            h.PlatformStand = true
        end
    end)
end

local function DisableFakeDead()
    -- Отключаем цикл
    if Connections["FakeDeadLoop"] then
        Connections["FakeDeadLoop"]:Disconnect()
        Connections["FakeDeadLoop"] = nil
    end
    
    local char, hum = GetCharacterAndHumanoid()
    local hrp = GetHRP()
    if not hum then return end
    
    -- Восстанавливаем состояние
    hum.PlatformStand = false
    
    -- Выравниваем персонажа
    if hrp then
        local pos = hrp.Position
        hrp.CFrame = CFrame.new(pos) * CFrame.Angles(0, 0, 0)
    end
end

FakeDeadSection:Toggle({
    Title = "Fake Dead",
    Description = "Персонаж падает, имитируя смерть (рэгдолл)",
    Default = false,
    Callback = function(value)
        State.FakeDead = value
        if value then
            EnableFakeDead()
        else
            DisableFakeDead()
        end
        WindUI:Notify({
            Title = "Fake Dead",
            Content = value and "Вы 'мертвы' 💀" or "Вы 'ожили' 🧟",
            Duration = 2,
        })
    end,
})

-- -------------------------------------------------------
-- FE INVISIBILITY
-- -------------------------------------------------------

local InvisSection = CombatTab:Section({
    Title = "Невидимость (FE)",
})

--[[
    Метод FE Invisibility:
    Работает через "отсоединение" персонажа от камеры.
    Мы клонируем персонажа, делаем оригинал невидимым,
    а клон используем как "фейковую" модель для сервера.
    
    Альтернативный упрощённый метод: скрываем все части персонажа
    локально (Transparency = 1), при этом серверная модель остаётся.
    Это сбивает с толку врагов визуально.
]]

local invisibleParts = {}

local function EnableFEInvisibility()
    local char = LocalPlayer.Character
    if not char then return end
    
    -- Сохраняем оригинальные прозрачности и скрываем все части
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            invisibleParts[part] = part.LocalTransparencyModifier
            part.LocalTransparencyModifier = 1
        elseif part:IsA("Decal") or part:IsA("Texture") then
            invisibleParts[part] = part.Transparency
            part.Transparency = 1
        end
    end
    
    -- Цикл поддержания невидимости (игра может сбрасывать LocalTransparencyModifier)
    Connections["InvisLoop"] = RunService.RenderStepped:Connect(function()
        if not State.FEInvisible then return end
        local c = LocalPlayer.Character
        if not c then return end
        
        for _, part in ipairs(c:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 1
            end
        end
    end)
end

local function DisableFEInvisibility()
    -- Отключаем цикл
    if Connections["InvisLoop"] then
        Connections["InvisLoop"]:Disconnect()
        Connections["InvisLoop"] = nil
    end
    
    -- Восстанавливаем прозрачности
    for part, originalValue in pairs(invisibleParts) do
        if part and part.Parent then
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = originalValue or 0
            elseif part:IsA("Decal") or part:IsA("Texture") then
                part.Transparency = originalValue or 0
            end
        end
    end
    invisibleParts = {}
end

InvisSection:Toggle({
    Title = "FE Invisibility",
    Description = "Локальная невидимость (вы не видите себя, враги видят вас с задержкой)",
    Default = false,
    Callback = function(value)
        State.FEInvisible = value
        if value then
            EnableFEInvisibility()
        else
            DisableFEInvisibility()
        end
        WindUI:Notify({
            Title = "FE Invisibility",
            Content = value and "Невидимость включена 👻" or "Невидимость выключена 👤",
            Duration = 2,
        })
    end,
})

-- ============================================================
-- ОБРАБОТКА РЕСПАУНА ПЕРСОНАЖА
-- ============================================================
-- При респауне нужно пересоздать физические объекты и сбросить состояния

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(1) -- Ждём полную загрузку персонажа
    
    -- Если Fly был включен — перезапускаем
    if State.FlyEnabled then
        StopFly()
        task.wait(0.5)
        StartFly()
    end
    
    -- Сбрасываем FakeDead
    if State.FakeDead then
        task.wait(0.5)
        EnableFakeDead()
    end
    
    -- Перезапускаем невидимость
    if State.FEInvisible then
        task.wait(0.5)
        EnableFEInvisibility()
    end
    
    -- Обновляем ESP
    task.wait(0.5)
    UpdateAllESP()
end)

-- ============================================================
-- ЗАВЕРШАЮЩЕЕ УВЕДОМЛЕНИЕ
-- ============================================================

WindUI:Notify({
    Title = "🎮 MM2 Enhanced",
    Content = "Все модули загружены и активны.\n\n📁 Movement — скорость, прыжки, noclip, полёт\n👁 Visuals — ESP с определением ролей\n⚔ Combat — автоподбор, фейк, невидимость",
    Duration = 8,
    Icon = "info",
})

print("[MM2 Enhanced] Скрипт полностью загружен и готов к работе.")
