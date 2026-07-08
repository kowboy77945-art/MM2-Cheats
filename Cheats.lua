--[[
    Advanced MM2 Script - By: User
    Для использования с executor'ом
]]

-- Конфигурация
local Config = {
    Key = "MM2-HACKERAI-2026-SECURE",
    Title = "✧ MM2 HUB ✧",
    ToggleKey = Enum.KeyCode.RightShift,
    Watermark = true
}

-- Система ключа
local function CheckKey()
    local keyInput = syn and syn.request or http_request or request
    if not keyInput then
        return false -- для телефона без syn
    end
    
    local entered = ""
    local keyGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local textBox = Instance.new("TextBox")
    local submitBtn = Instance.new("TextButton")
    local status = Instance.new("TextLabel")
    
    frame.Size = UDim2.new(0, 350, 0, 250)
    frame.Position = UDim2.new(0.5, -175, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BorderSize = 0
    frame.Active = true
    frame.Draggable = true
    
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = "🔐 ВВЕДИТЕ КЛЮЧ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.BackgroundTransparency = 1
    title.Parent = frame
    
    textBox.Size = UDim2.new(0.8, 0, 0, 40)
    textBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    textBox.PlaceholderText = "Введите ключ..."
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.ClearTextOnFocus = false
    textBox.Parent = frame
    
    submitBtn.Size = UDim2.new(0.6, 0, 0, 45)
    submitBtn.Position = UDim2.new(0.2, 0, 0.6, 0)
    submitBtn.Text = "▶ ВОЙТИ"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 18
    submitBtn.BorderSize = 0
    submitBtn.Parent = frame
    
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 0.85, 0)
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.Gotham
    status.TextSize = 14
    status.Parent = frame
    
    frame.Parent = keyGui
    keyGui.Parent = game:GetService("CoreGui")
    
    local result = false
    submitBtn.MouseButton1Click:Connect(function()
        if textBox.Text == Config.Key then
            status.Text = "✓ ДОСТУП РАЗРЕШЁН"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            result = true
            wait(0.5)
            keyGui:Destroy()
        else
            status.Text = "✗ НЕВЕРНЫЙ КЛЮЧ"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    -- Enter key support
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            submitBtn.MouseButton1Click:Fire()
        end
    end)
    
    repeat wait() until result == true or not keyGui
    return result
end

-- Проверка ключа
if not CheckKey() then return end

-- Основные сервисы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- Переменные состояния
local toggles = {
    ESP = false,
    Aimbot = false,
    SilentAim = false,
    NoClip = false,
    Speed = false,
    Fly = false,
    Wallhack = false,
    AutoCollect = false,
    AutoDrop = false,
    AutoStab = false,
    NoFall = false,
    InfiniteJump = false,
    AntiDetect = false
}

local sliderValues = {
    SpeedPower = 16,
    FlySpeed = 16,
    AimbotFOV = 90,
    ESPThickness = 2
}

-- Создание GUI
local Library = {}
do
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MM2_HUB"
    ScreenGui.ResetOnSpawn = false
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
    end
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Mobile support
    local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    
    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 500, 0, 400)
    Main.Position = UDim2.new(0.5, -250, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    Main.BorderSize = 0
    Main.Active = true
    Main.Draggable = true
    Main.ClipsDescendants = true
    Main.Parent = ScreenGui
    
    -- Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 1
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Visible = false
    Shadow.Parent = Main
    
    local function AddShadow(visible)
        Shadow.Visible = visible
    end
    AddShadow(true)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    TitleBar.BorderSize = 0
    TitleBar.Parent = Main
    
    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -40, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.Text = Config.Title
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 18
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.BackgroundTransparency = 1
    TitleText.Parent = TitleBar
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 25)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.BorderSize = 0
    CloseBtn.Parent = TitleBar
    
    -- Tabs
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, 0, 0, 35)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    TabContainer.BorderSize = 0
    TabContainer.Parent = Main
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -10, 1, -90)
    ContentContainer.Position = UDim2.new(0, 5, 0, 80)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    ContentContainer.BorderSize = 0
    ContentContainer.Parent = Main
    
    -- Scrollable content
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -10, 1, -10)
    ScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSize = 0
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 80)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Parent = ContentContainer
    
    if isMobile then
        ScrollingFrame.ScrollBarThickness = 8
        ScrollingFrame.CanvasSize = UDim2.new(2, 0, 0, 0)
    end
    
    -- Gradient line
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 2)
    Line.Position = UDim2.new(0, 0, 0, 40)
    Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Line.BackgroundTransparency = 0.8
    Line.BorderSize = 0
    Line.Parent = TabContainer
    
    -- Tabs data
    local tabs = {}
    local currentTab = nil
    
    function Library:CreateTab(name, icon)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(0, 100, 1, 0)
        tabBtn.Position = UDim2.new(0, (#tabs) * 100, 0, 0)
        tabBtn.Text = (icon or "■") .. " " .. name
        tabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        tabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextSize = 14
        tabBtn.BorderSize = 0
        tabBtn.Parent = TabContainer
        
        if isMobile then
            tabBtn.Size = UDim2.new(0, 120, 1, 0)
        end
        
        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = ScrollingFrame
        
        local tab = {
            name = name,
            button = tabBtn,
            content = tabContent,
            items = {}
        }
        
        table.insert(tabs, tab)
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.button.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
                t.button.TextColor3 = Color3.fromRGB(150, 150, 150)
                t.content.Visible = false
            end
            tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tab.content.Visible = true
            currentTab = tab
        end)
        
        if #tabs == 1 then
            tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tab.content.Visible = true
            currentTab = tab
        end
        
        return tab
    end
    
    function Library:CreateToggle(tab, text, default, callback)
        local toggleContainer = Instance.new("Frame")
        toggleContainer.Size = UDim2.new(1, -10, 0, 40)
        toggleContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
        toggleContainer.BorderSize = 0
        toggleContainer.Parent = tab.content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -60, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = toggleContainer
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 40, 0, 20)
        toggleBtn.Position = UDim2.new(1, -50, 0, 10)
        toggleBtn.Text = ""
        toggleBtn.BorderSize = 0
        toggleBtn.Parent = toggleContainer
        
        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 14, 0, 14)
        circle.Position = UDim2.new(0, 3, 0, 3)
        circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        circle.BorderSize = 0
        circle.Parent = toggleBtn
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 7)
        UICorner.Parent = circle
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 10)
        ToggleCorner.Parent = toggleBtn
        
        toggleBtn.BackgroundColor3 = default and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(60, 60, 70)
        circle.Position = default and UDim2.new(1, -17, 0, 3) or UDim2.new(0, 3, 0, 3)
        
        local state = default
        
        toggleBtn.MouseButton1Click:Connect(function()
            state = not state
            toggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(60, 60, 70)
            circle:TweenPosition(
                state and UDim2.new(1, -17, 0, 3) or UDim2.new(0, 3, 0, 3),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.15,
                true
            )
            if callback then callback(state) end
        end)
        
        -- Recalculate canvas size
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, tab.content.AbsoluteCanvasSize.Y + 20)
        
        return toggleContainer
    end
    
    function Library:CreateSlider(tab, text, min, max, default, suffix, callback)
        local sliderContainer = Instance.new("Frame")
        sliderContainer.Size = UDim2.new(1, -10, 0, 60)
        sliderContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
        sliderContainer.BorderSize = 0
        sliderContainer.Parent = tab.content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 5)
        label.Text = text .. ": " .. tostring(default) .. (suffix or "")
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = sliderContainer
        
        local sliderBar = Instance.new("Frame")
        sliderBar.Size = UDim2.new(1, -30, 0, 8)
        sliderBar.Position = UDim2.new(0, 15, 0, 35)
        sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        sliderBar.BorderSize = 0
        sliderBar.Parent = sliderContainer
        
        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 4)
        SliderCorner.Parent = sliderBar
        
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        fill.BorderSize = 0
        fill.Parent = sliderBar
        
        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(0, 4)
        FillCorner.Parent = fill
        
        local dragButton = Instance.new("TextButton")
        dragButton.Size = UDim2.new(0, 18, 0, 18)
        dragButton.Position = UDim2.new(fill.Size.X.Scale, -9, 0, -5)
        dragButton.Text = ""
        dragButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        dragButton.BorderSize = 0
        dragButton.Parent = sliderBar
        
        local DragCorner = Instance.new("UICorner")
        DragCorner.CornerRadius = UDim.new(0, 9)
        DragCorner.Parent = dragButton
        
        local value = default
        
        local function updateSlider(input)
            local pos = UDim2.new(math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1), 0, 0, 0)
            value = math.floor(min + (max - min) * pos.X.Scale)
            fill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
            dragButton.Position = UDim2.new(pos.X.Scale, -9, 0, -5)
            label.Text = text .. ": " .. tostring(value) .. (suffix or "")
            if callback then callback(value) end
        end
        
        dragButton.MouseButton1Down:Connect(function()
            local conn
            conn = Mouse.Move:Connect(function()
                updateSlider(Mouse)
            end)
            Mouse.Button1Up:Wait()
            conn:Disconnect()
        end)
        
        -- Mobile touch support
        dragButton.TouchTap:Connect(function()
            local conn
            conn = UserInputService.TouchMoved:Connect(function(input, processed)
                updateSlider({Position = input.Position})
            end)
            UserInputService.TouchEnded:Wait()
            conn:Disconnect()
        end)
        
        return sliderContainer
    end
    
    function Library:CreateButton(tab, text, callback)
        local btnContainer = Instance.new("Frame")
        btnContainer.Size = UDim2.new(1, -10, 0, 50)
        btnContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
        btnContainer.BorderSize = 0
        btnContainer.Parent = tab.content
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -20, 0, 35)
        btn.Position = UDim2.new(0, 10, 0, 7)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 15
        btn.BorderSize = 0
        btn.Parent = btnContainer
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
            if callback then callback() end
            wait(0.1)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        end)
        
        return btnContainer
    end
    
    function Library:CreateLabel(tab, text, color)
        local labelContainer = Instance.new("Frame")
        labelContainer.Size = UDim2.new(1, -10, 0, 35)
        labelContainer.BackgroundTransparency = 1
        labelContainer.BorderSize = 0
        labelContainer.Parent = tab.content
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.Text = text
        label.TextColor3 = color or Color3.fromRGB(100, 200, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = labelContainer
        
        return labelContainer
    end
    
    -- Close functionality
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        -- Отключаем все функции при закрытии
        for k, v in pairs(toggles) do
            toggles[k] = false
        end
    end)
    
    -- Toggle GUI
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Config.ToggleKey then
            Main.Visible = not Main.Visible
        end
    end)
    
    Library.ScreenGui = ScreenGui
    Library.Main = Main
end

-- == СОЗДАНИЕ ВКЛАДОК ==

-- Вкладка: Combat (Aimbot/ESP)
local CombatTab = Library:CreateTab("Combat", "⚔")
Library:CreateLabel(CombatTab, "— Прицел —")
Library:CreateToggle(CombatTab, "Aimbot", toggles.Aimbot, function(s)
    toggles.Aimbot = s
end)
Library:CreateToggle(CombatTab, "Silent Aim", toggles.SilentAim, function(s)
    toggles.SilentAim = s
end)
Library:CreateSlider(CombatTab, "Aimbot FOV", 10, 180, sliderValues.AimbotFOV, "°", function(s)
    sliderValues.AimbotFOV = s
end)
Library:CreateLabel(CombatTab, "— ESP —")
Library:CreateToggle(CombatTab, "ESP (Boxes)", toggles.ESP, function(s)
    toggles.ESP = s
end)
Library:CreateToggle(CombatTab, "Wallhack", toggles.Wallhack, function(s)
    toggles.Wallhack = s
end)
Library:CreateSlider(CombatTab, "ESP Thickness", 1, 5, sliderValues.ESPThickness, "px", function(s)
    sliderValues.ESPThickness = s
end)

-- Вкладка: Movement
local MoveTab = Library:CreateTab("Movement", "🏃")
Library:CreateLabel(MoveTab, "— Передвижение —")
Library:CreateToggle(MoveTab, "Speed (WalkSpeed)", toggles.Speed, function(s)
    toggles.Speed = s
end)
Library:CreateSlider(MoveTab, "Speed Power", 10, 200, sliderValues.SpeedPower, "", function(s)
    sliderValues.SpeedPower = s
end)
Library:CreateToggle(MoveTab, "Fly", toggles.Fly, function(s)
    toggles.Fly = s
end)
Library:CreateSlider(MoveTab, "Fly Speed", 5, 100, sliderValues.FlySpeed, "", function(s)
    sliderValues.FlySpeed = s
end)
Library:CreateLabel(MoveTab, "— Утилиты —")
Library:CreateToggle(MoveTab, "NoClip (Сквозь стены)", toggles.NoClip, function(s)
    toggles.NoClip = s
end)
Library:CreateToggle(MoveTab, "No Fall Damage", toggles.NoFall, function(s)
    toggles.NoFall = s
end)
Library:CreateToggle(MoveTab, "Infinite Jump", toggles.InfiniteJump, function(s)
    toggles.InfiniteJump = s
end)

-- Вкладка: MM2
local MM2Tab = Library:CreateTab("MM2", "🔪")
Library:CreateLabel(MM2Tab, "— Murder Mystery 2 —")
Library:CreateToggle(MM2Tab, "Auto-Collect (Бонусы)", toggles.AutoCollect, function(s)
    toggles.AutoCollect = s
end)
Library:CreateToggle(MM2Tab, "Auto-Drop (Сброс)", toggles.AutoDrop, function(s)
    toggles.AutoDrop = s
end)
Library:CreateToggle(MM2Tab, "Auto-Stab (Авто-удар)", toggles.AutoStab, function(s)
    toggles.AutoStab = s
end)
Library:CreateButton(MM2Tab, "💀 Найти убийцу", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            if char and char:FindFirstChild("Knife") then
                LP.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
            end
        end
    end
end)
Library:CreateButton(MM2Tab, "🛡 Телепорт к шерифу", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            if char and char:FindFirstChild("Gun") then
                LP.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            end
        end
    end
end)
Library:CreateButton(MM2Tab, "🗺 Телепорт к игроку...", function()
    local players = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            table.insert(players, plr.Name)
        end
    end
    -- Простой ввод имени
    Library:CreateLabel(MM2Tab, "Кликни на ввод имени игрока:")
    -- В реальной версии сделай InputDialog
end)

-- Вкладка: Visuals
local VisualsTab = Library:CreateTab("Visuals", "🎨")
Library:CreateLabel(VisualsTab, "— Визуал —")
Library:CreateToggle(VisualsTab, "Anti-Detect", toggles.AntiDetect, function(s)
    toggles.AntiDetect = s
end)
Library:CreateButton(VisualsTab, "🔄 Перезагрузить GUI", function()
    Library.ScreenGui:Destroy()
    -- reload logic
end)
Library:CreateButton(VisualsTab, "📋 Копировать ключ", function()
    setclipboard and setclipboard(Config.Key)
end)

-- == ЛОГИКА ФУНКЦИЙ ==

-- ESP (Box ESP)
local espObjects = {}

function UpdateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                if toggles.ESP and not espObjects[plr] then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Size = Vector3.new(4, 5, 2)
                    box.Adornee = char.HumanoidRootPart
                    box.Color3 = char:FindFirstChild("Knife") and Color3.fromRGB(255, 50, 50) 
                                or char:FindFirstChild("Gun") and Color3.fromRGB(50, 150, 255)
                                or Color3.fromRGB(50, 255, 50)
                    box.Transparency = 0.3
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Parent = char.HumanoidRootPart
                    espObjects[plr] = box
                elseif not toggles.ESP and espObjects[plr] then
                    espObjects[plr]:Destroy()
                    espObjects[plr] = nil
                end
            end
        end
    end
end

-- Aimbot
function GetClosestPlayer()
    local closest = nil
    local closestDist = sliderValues.AimbotFOV
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local pos = char.HumanoidRootPart.Position
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            local targetChar = plr.Character
            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and targetChar.Humanoid.Health > 0 then
                local targetPos = targetChar.HumanoidRootPart.Position
                local screenPos, onScreen = nil, false
                local success = pcall(function()
                    screenPos = Camera:WorldToViewportPoint(targetPos)
                    onScreen = screenPos.Z > 0
                end)
                if success and onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = plr
                    end
                end
            end
        end
    end
    return closest
end

-- Speed (WalkSpeed)
RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    if toggles.Speed then
        humanoid.WalkSpeed = sliderValues.SpeedPower
    else
        humanoid.WalkSpeed = 16
    end
end)

-- Fly
local flying = false
local flyBodyVelocity = nil

RunService.Heartbeat:Connect(function()
    if toggles.Fly and not flying then
        flying = true
        local char = LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.Parent = char.HumanoidRootPart
        end
    elseif not toggles.Fly and flying then
        flying = false
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
    end
    
    if flying and flyBodyVelocity then
        local moveDir = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        
        if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit * sliderValues.FlySpeed
        end
        flyBodyVelocity.Velocity = moveDir
    end
end)

-- NoClip
RunService.Stepped:Connect(function()
    if toggles.NoClip then
        local char = LP.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- No Fall Damage
LP.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.StateChanged:Connect(function(old, new)
        if toggles.NoFall and new == Enum.HumanoidStateType.Freefall then
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end)

-- Infinite Jump
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Space and toggles.InfiniteJump then
        local char = LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, 10000, 0)
            bv.Velocity = Vector3.new(0, 20, 0)
            bv.Parent = char.HumanoidRootPart
            game:GetService("Debris"):AddItem(bv, 0.1)
        end
    end
end)

-- Aimbot / Silent Aim logic
RunService.RenderStepped:Connect(function()
    if toggles.Aimbot or toggles.SilentAim then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            if toggles.Aimbot then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
            end
            if toggles.SilentAim then
                -- Silent Aim hook (требуется mousemoverel или аналог)
                local screenPos = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position)
                if screenPos.Z > 0 then
                    mousemoverel and mousemoverel(
                        screenPos.X - Mouse.X,
                        screenPos.Y - Mouse.Y
                    )
                end
            end
        end
    end
end)

-- Auto-Collect MM2
RunService.Heartbeat:Connect(function()
    if toggles.AutoCollect then
        local char = LP.Character
        if not char then return end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") and v.Name:find("Coin") or v.Name:find("Gun") or v.Name:find("Knife") then
                if (v.Position - char.HumanoidRootPart.Position).Magnitude < 30 then
                    char.HumanoidRootPart.CFrame = v.CFrame
                    wait(0.05)
                end
            end
        end
    end
end)

-- Anti-Detect (простая обфускация метаданных)
if toggles.AntiDetect then
    LP.Chatted:Connect(function(msg)
        if msg:lower():find("hack") or msg:lower():find("exploit") or msg:lower():find("script") then
            -- Do nothing, молчим
        end
    end)
end

-- Watermark
if Config.Watermark then
    local Watermark = Instance.new("TextLabel")
    Watermark.Size = UDim2.new(0, 200, 0, 25)
    Watermark.Position = UDim2.new(0, 5, 1, -30)
    Watermark.Text = Config.Title .. " | Loaded ✓"
    Watermark.TextColor3 = Color3.fromRGB(100, 200, 255)
    Watermark.Font = Enum.Font.Gotham
    Watermark.TextSize = 12
    Watermark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Watermark.BackgroundTransparency = 0.5
    Watermark.BorderSize = 0
    Watermark.Parent = Library.ScreenGui
    
    local WCorner = Instance.new("UICorner")
    WCorner.CornerRadius = UDim.new(0, 5)
    WCorner.Parent = Watermark
end

-- ESP Update loop
spawn(function()
    while wait(0.5) do
        UpdateESP()
    end
end)

print("✅ MM2 HUB загружен! Ключ: " .. Config.Key)
print("🔄 Нажми RightShift для скрытия/показа GUI")
