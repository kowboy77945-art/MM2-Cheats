--[[
    MM2 Professional Cheat HUD
    Built on WindUI Library
    Compatible: Solara, Wave, Hydrogen, Delta
    
    DISCLAIMER: For educational purposes only.
]]

-- ============================================
-- INITIALIZATION & SERVICES
-- ============================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ============================================
-- STATE MANAGEMENT
-- ============================================

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
    ESPTransparency = 0.5,
    GunESP = false,
    
    -- Movement
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    JumpPowerEnabled = false,
    JumpPowerValue = 50,
    InfiniteJump = false,
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    AutoEvade = false,
    AutoEvadeDistance = 20,
    
    -- Misc
    FakeDead = false,
    FakeDeadMode = "На живот",
    FEInvisibility = false,
}

-- Connection storage for cleanup
local Connections = {}
local ESPObjects = {}
local GunESPObjects = {}
local FlyBodyVelocity = nil
local FlyBodyGyro = nil

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================

--- Clean up a specific connection by key
local function CleanConnection(key)
    if Connections[key] then
        if typeof(Connections[key]) == "RBXScriptConnection" then
            Connections[key]:Disconnect()
        end
        Connections[key] = nil
    end
end

--- Get the local player's character and humanoid safely
local function GetCharacter()
    local char = LocalPlayer.Character
    if not char then return nil, nil, nil end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    return char, humanoid, rootPart
end

--- Determine a player's role based on their tools
local function GetPlayerRole(player)
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    
    local hasKnife = false
    local hasGun = false
    
    -- Check character (equipped tools)
    if char then
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") then
                if item.Name == "Knife" or item.Name == "knife" then
                    hasKnife = true
                elseif item.Name == "Gun" or item.Name == "gun" or item.Name == "Revolver" then
                    hasGun = true
                end
            end
        end
    end
    
    -- Check backpack
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                if item.Name == "Knife" or item.Name == "knife" then
                    hasKnife = true
                elseif item.Name == "Gun" or item.Name == "gun" or item.Name == "Revolver" then
                    hasGun = true
                end
            end
        end
    end
    
    if hasKnife then return "Murderer" end
    if hasGun then return "Sheriff" end
    return "Innocent"
end

--- Find the murderer player
local function FindMurderer()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and GetPlayerRole(player) == "Murderer" then
            return player
        end
    end
    return nil
end

--- Find the local player's gun tool
local function FindGunTool()
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    
    if char then
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") and (item.Name == "Gun" or item.Name == "gun" or item.Name == "Revolver") then
                return item
            end
        end
    end
    
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") and (item.Name == "Gun" or item.Name == "gun" or item.Name == "Revolver") then
                return item
            end
        end
    end
    
    return nil
end

--- Find the local player's knife tool
local function FindKnifeTool()
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    
    if char then
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") and (item.Name == "Knife" or item.Name == "knife") then
                return item
            end
        end
    end
    
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") and (item.Name == "Knife" or item.Name == "knife") then
                return item
            end
        end
    end
    
    return nil
end

--- Raycast wall check between two positions (excluding a character)
local function IsVisible(fromPos, toPos, excludeChar)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local excludeList = {}
    if excludeChar then
        table.insert(excludeList, excludeChar)
    end
    
    -- Also exclude target character if needed
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            table.insert(excludeList, player.Character)
        end
    end
    
    -- We only want to check for walls, so exclude all characters
    -- Then re-add them except our own to check against geometry only
    rayParams.FilterDescendantsInstances = excludeList
    rayParams.CollisionGroup = "Default"
    
    local direction = (toPos - fromPos)
    local result = Workspace:Raycast(fromPos, direction, rayParams)
    
    -- If raycast hit nothing, target is visible
    if not result then return true end
    
    -- If it hit something before reaching the target, not visible
    local distToTarget = direction.Magnitude
    local distToHit = (result.Position - fromPos).Magnitude
    
    return distToHit >= distToTarget * 0.95
end

--- Simple wall check (only checking against workspace geometry, not characters)
local function CanSeeTarget(fromPos, targetPos, myChar)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local excludeList = {}
    -- Exclude all player characters so we only hit walls/map
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            table.insert(excludeList, player.Character)
        end
    end
    rayParams.FilterDescendantsInstances = excludeList
    
    local direction = (targetPos - fromPos)
    local result = Workspace:Raycast(fromPos, direction, rayParams)
    
    if not result then return true end
    return (result.Position - fromPos).Magnitude >= direction.Magnitude * 0.9
end

-- ============================================
-- ESP SYSTEM
-- ============================================

local function ClearESP()
    for _, obj in pairs(ESPObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    ESPObjects = {}
end

local function ClearGunESP()
    for _, obj in pairs(GunESPObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    GunESPObjects = {}
end

local function ApplyESPToPlayer(player)
    if not State.PlayerESP then return end
    if player == LocalPlayer then return end
    
    local char = player.Character
    if not char then return end
    
    -- Remove existing highlight
    local existingKey = player.UserId .. "_esp"
    if ESPObjects[existingKey] and ESPObjects[existingKey].Parent then
        ESPObjects[existingKey]:Destroy()
    end
    
    local role = GetPlayerRole(player)
    local color
    if role == "Murderer" then
        color = Color3.fromRGB(255, 0, 0)
    elseif role == "Sheriff" then
        color = Color3.fromRGB(0, 100, 255)
    else
        color = Color3.fromRGB(0, 255, 0)
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "MM2_ESP"
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = State.ESPTransparency
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = char
    highlight.Parent = char
    
    ESPObjects[existingKey] = highlight
end

local function RefreshAllESP()
    ClearESP()
    if not State.PlayerESP then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        task.spawn(function()
            ApplyESPToPlayer(player)
        end)
    end
end

local function UpdateGunESP()
    ClearGunESP()
    if not State.GunESP then return end
    
    -- Search for GunDrop in workspace
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" and (obj:IsA("BasePart") or obj:IsA("Model")) then
            local highlight = Instance.new("Highlight")
            highlight.Name = "MM2_GunESP"
            highlight.FillColor = Color3.fromRGB(255, 215, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
            highlight.FillTransparency = 0.3
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Adornee = obj
            highlight.Parent = obj
            
            table.insert(GunESPObjects, highlight)
        end
    end
end

-- ============================================
-- COMBAT SYSTEMS
-- ============================================

--- Auto Kill Murderer Logic
local function StartAutoKill()
    CleanConnection("AutoKill")
    
    Connections["AutoKill"] = RunService.Heartbeat:Connect(function()
        if not State.AutoKillMurderer then return end
        
        local char, humanoid, rootPart = GetCharacter()
        if not char or not humanoid or not rootPart then return end
        if humanoid.Health <= 0 then return end
        
        -- Check if we have a gun
        local gunTool = FindGunTool()
        if not gunTool then return end
        
        -- Find murderer
        local murderer = FindMurderer()
        if not murderer then return end
        
        local murdererChar = murderer.Character
        if not murdererChar then return end
        
        local murdererHumanoid = murdererChar:FindFirstChildOfClass("Humanoid")
        if not murdererHumanoid or murdererHumanoid.Health <= 0 then return end
        
        local targetPart = murdererChar:FindFirstChild(State.TargetPart) or murdererChar:FindFirstChild("HumanoidRootPart")
        if not targetPart then return end
        
        -- Wall check
        if State.WallCheck then
            if not CanSeeTarget(rootPart.Position, targetPart.Position, char) then
                return
            end
        end
        
        -- Equip gun if not equipped
        if gunTool.Parent ~= char then
            humanoid:EquipTool(gunTool)
            task.wait(0.1)
        end
        
        -- Fire the gun at the murderer
        -- MM2 gun typically uses a RemoteEvent for shooting
        -- We simulate shooting by firing the remote
        local remotes = gunTool:FindFirstChild("Remote") or gunTool:FindFirstChild("ShootEvent")
        if not remotes then
            -- Try to find any remote event in the gun
            for _, child in pairs(gunTool:GetDescendants()) do
                if child:IsA("RemoteEvent") then
                    remotes = child
                    break
                end
            end
        end
        
        if remotes then
            remotes:FireServer(targetPart.Position)
        end
        
        -- Alternative: Look for the Shoot function pattern in ReplicatedStorage
        local shootRemote = ReplicatedStorage:FindFirstChild("ShootEvent") or ReplicatedStorage:FindFirstChild("Remote")
        if shootRemote and shootRemote:IsA("RemoteEvent") then
            shootRemote:FireServer(targetPart.Position)
        end
    end)
end

--- Auto Grab Gun Logic
local function StartAutoGrabGun()
    CleanConnection("AutoGrabGun")
    
    Connections["AutoGrabGun"] = RunService.Heartbeat:Connect(function()
        if not State.AutoGrabGun then return end
        
        local char, humanoid, rootPart = GetCharacter()
        if not char or not humanoid or not rootPart then return end
        if humanoid.Health <= 0 then return end
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" then
                local targetPos
                if obj:IsA("BasePart") then
                    targetPos = obj.CFrame
                elseif obj:IsA("Model") then
                    local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        targetPos = primary.CFrame
                    end
                end
                
                if targetPos then
                    local originalCFrame = rootPart.CFrame
                    rootPart.CFrame = targetPos
                    task.wait(0.15)
                    -- Touch the gun to pick it up
                    if obj and obj.Parent then
                        -- Firetouch if available
                        if firetouchinterest then
                            local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                            if part then
                                firetouchinterest(rootPart, part, 0)
                                task.wait(0.1)
                                firetouchinterest(rootPart, part, 1)
                            end
                        end
                    end
                    task.wait(0.1)
                    rootPart.CFrame = originalCFrame
                end
                break
            end
        end
    end)
end

--- Kill Aura Logic (for Murderer role)
local function StartKillAura()
    CleanConnection("KillAura")
    
    Connections["KillAura"] = RunService.Heartbeat:Connect(function()
        if not State.KillAura then return end
        
        local char, humanoid, rootPart = GetCharacter()
        if not char or not humanoid or not rootPart then return end
        if humanoid.Health <= 0 then return end
        
        -- Check if we're the murderer
        local knifeTool = FindKnifeTool()
        if not knifeTool then return end
        
        -- Equip knife
        if knifeTool.Parent ~= char then
            humanoid:EquipTool(knifeTool)
            task.wait(0.1)
        end
        
        -- Find nearby players
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetChar = player.Character
                local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
                local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                
                if targetHumanoid and targetRoot and targetHumanoid.Health > 0 then
                    local dist = (rootPart.Position - targetRoot.Position).Magnitude
                    
                    if dist <= State.KillAuraRadius then
                        -- Activate knife - simulate the knife's remote
                        local knifeRemote = knifeTool:FindFirstChild("Remote") or knifeTool:FindFirstChild("KillEvent")
                        if not knifeRemote then
                            for _, child in pairs(knifeTool:GetDescendants()) do
                                if child:IsA("RemoteEvent") then
                                    knifeRemote = child
                                    break
                                end
                            end
                        end
                        
                        if knifeRemote then
                            knifeRemote:FireServer(targetRoot.Position)
                        end
                        
                        -- Also try firetouchinterest for knife hit registration
                        if firetouchinterest then
                            local knifeHandle = knifeTool:FindFirstChild("Handle")
                            if knifeHandle and targetRoot then
                                firetouchinterest(knifeHandle, targetRoot, 0)
                                task.wait()
                                firetouchinterest(knifeHandle, targetRoot, 1)
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- ============================================
-- SILENT AIM HOOK
-- ============================================

local function SetupSilentAim()
    -- Hook the namecall to redirect gun shots to the murderer
    if not State._OldNamecall then
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if State.SilentAim and (method == "FireServer" or method == "InvokeServer") then
                -- Check if this is a gun-related remote
                local remoteName = self.Name:lower()
                if remoteName:find("shoot") or remoteName:find("gun") or remoteName:find("remote") then
                    local murderer = FindMurderer()
                    if murderer and murderer.Character then
                        local targetPart = murderer.Character:FindFirstChild(State.TargetPart) 
                            or murderer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if targetPart then
                            local myChar = LocalPlayer.Character
                            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                            
                            local shouldAim = true
                            if State.WallCheck and myRoot then
                                shouldAim = CanSeeTarget(myRoot.Position, targetPart.Position, myChar)
                            end
                            
                            if shouldAim then
                                -- Replace position arguments with murderer's position
                                for i, arg in pairs(args) do
                                    if typeof(arg) == "Vector3" then
                                        args[i] = targetPart.Position
                                    elseif typeof(arg) == "CFrame" then
                                        args[i] = targetPart.CFrame
                                    end
                                end
                                return oldNamecall(self, unpack(args))
                            end
                        end
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end))
        
        State._OldNamecall = oldNamecall
    end
end

-- Try to set up silent aim hook (may not be available on all executors)
task.spawn(function()
    pcall(SetupSilentAim)
end)

-- ============================================
-- MOVEMENT SYSTEMS
-- ============================================

--- WalkSpeed enforcement loop
local function StartWalkSpeedLoop()
    CleanConnection("WalkSpeed")
    
    Connections["WalkSpeed"] = RunService.RenderStepped:Connect(function()
        if not State.WalkSpeedEnabled then return end
        local _, humanoid = GetCharacter()
        if humanoid then
            humanoid.WalkSpeed = State.WalkSpeedValue
        end
    end)
end

--- JumpPower enforcement loop
local function StartJumpPowerLoop()
    CleanConnection("JumpPower")
    
    Connections["JumpPower"] = RunService.RenderStepped:Connect(function()
        if not State.JumpPowerEnabled then return end
        local _, humanoid = GetCharacter()
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = State.JumpPowerValue
        end
    end)
end

--- Infinite Jump
local function StartInfiniteJump()
    CleanConnection("InfiniteJump")
    
    Connections["InfiniteJump"] = UserInputService.JumpRequest:Connect(function()
        if not State.InfiniteJump then return end
        local _, humanoid = GetCharacter()
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

--- Noclip Loop
local function StartNoclip()
    CleanConnection("Noclip")
    
    Connections["Noclip"] = RunService.Stepped:Connect(function()
        if not State.Noclip then return end
        local char = LocalPlayer.Character
        if not char then return end
        
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

--- Fly System
local function StartFly()
    local char, humanoid, rootPart = GetCharacter()
    if not char or not humanoid or not rootPart then return end
    
    -- Create BodyVelocity and BodyGyro
    FlyBodyVelocity = Instance.new("BodyVelocity")
    FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyVelocity.Velocity = Vector3.zero
    FlyBodyVelocity.Parent = rootPart
    
    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyGyro.P = 9000
    FlyBodyGyro.D = 500
    FlyBodyGyro.Parent = rootPart
    
    CleanConnection("Fly")
    
    Connections["Fly"] = RunService.RenderStepped:Connect(function()
        if not State.Fly then return end
        if not FlyBodyVelocity or not FlyBodyVelocity.Parent then return end
        if not rootPart or not rootPart.Parent then return end
        
        local moveDirection = humanoid.MoveDirection
        local camCF = Camera.CFrame
        
        local velocity = Vector3.zero
        
        if moveDirection.Magnitude > 0 then
            velocity = camCF.LookVector * moveDirection.Z * -State.FlySpeed 
                + camCF.RightVector * moveDirection.X * State.FlySpeed
            
            -- Simplified: use camera look for forward movement
            local flatMove = Vector3.new(moveDirection.X, 0, moveDirection.Z)
            if flatMove.Magnitude > 0 then
                velocity = (camCF.LookVector * (-moveDirection.Z) + camCF.RightVector * moveDirection.X).Unit * State.FlySpeed
            end
        end
        
        -- Vertical movement (jump = up, on mobile use jump button)
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            velocity = velocity + Vector3.new(0, State.FlySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            velocity = velocity - Vector3.new(0, State.FlySpeed, 0)
        end
        
        FlyBodyVelocity.Velocity = velocity
        FlyBodyGyro.CFrame = camCF
    end)
end

local function StopFly()
    CleanConnection("Fly")
    
    if FlyBodyVelocity then
        FlyBodyVelocity:Destroy()
        FlyBodyVelocity = nil
    end
    if FlyBodyGyro then
        FlyBodyGyro:Destroy()
        FlyBodyGyro = nil
    end
end

--- Auto-Evade Murderer
local function StartAutoEvade()
    CleanConnection("AutoEvade")
    
    Connections["AutoEvade"] = RunService.Heartbeat:Connect(function()
        if not State.AutoEvade then return end
        
        local char, humanoid, rootPart = GetCharacter()
        if not char or not humanoid or not rootPart then return end
        if humanoid.Health <= 0 then return end
        
        local murderer = FindMurderer()
        if not murderer or not murderer.Character then return end
        
        local murdererRoot = murderer.Character:FindFirstChild("HumanoidRootPart")
        if not murdererRoot then return end
        
        -- Check if murderer has knife equipped (in character, not backpack)
        local knifeEquipped = false
        for _, item in pairs(murderer.Character:GetChildren()) do
            if item:IsA("Tool") and (item.Name == "Knife" or item.Name == "knife") then
                knifeEquipped = true
                break
            end
        end
        
        if not knifeEquipped then return end
        
        local dist = (rootPart.Position - murdererRoot.Position).Magnitude
        if dist < State.AutoEvadeDistance then
            -- Move in opposite direction
            local awayDirection = (rootPart.Position - murdererRoot.Position).Unit
            local teleportDist = State.AutoEvadeDistance + 10
            rootPart.CFrame = rootPart.CFrame + awayDirection * math.min(5, teleportDist - dist)
        end
    end)
end

-- ============================================
-- MISC SYSTEMS
-- ============================================

--- Fake Dead
local function ApplyFakeDead()
    local char, humanoid, rootPart = GetCharacter()
    if not char or not humanoid or not rootPart then return end
    
    if State.FakeDead then
        humanoid.PlatformStand = true
        
        if State.FakeDeadMode == "На живот" then
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(math.rad(-90), 0, 0)
        elseif State.FakeDeadMode == "На спину" then
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(math.rad(90), 0, 0)
        end
    else
        humanoid.PlatformStand = false
    end
end

--- FE Invisibility (Desync method)
local function ToggleFEInvisibility(enabled)
    local char, humanoid, rootPart = GetCharacter()
    if not char or not rootPart then return end
    
    if enabled then
        CleanConnection("FEInvis")
        
        -- Simple desync: offset the character's network position
        local offset = Vector3.new(0, -100, 0)
        
        Connections["FEInvis"] = RunService.Heartbeat:Connect(function()
            if not State.FEInvisibility then return end
            local c = LocalPlayer.Character
            if not c then return end
            local rp = c:FindFirstChild("HumanoidRootPart")
            if not rp then return end
            
            -- Rapid CFrame manipulation to cause desync
            rp.Velocity = Vector3.new(0, 0, 0)
        end)
        
        -- Alternative: hide all parts locally
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 1
            end
        end
    else
        CleanConnection("FEInvis")
        
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0
                end
            end
        end
    end
end

-- ============================================
-- CHARACTER RELOAD HANDLER
-- ============================================

local function OnCharacterAdded(char)
    -- Wait for character to fully load
    char:WaitForChild("HumanoidRootPart")
    char:WaitForChild("Humanoid")
    
    task.wait(0.5)
    
    -- Re-apply ESP
    if State.PlayerESP then
        task.spawn(RefreshAllESP)
    end
    
    -- Re-apply movement modifications
    if State.Fly then
        StopFly()
        task.defer(StartFly)
    end
    
    -- Re-apply fake dead if active
    if State.FakeDead then
        task.defer(ApplyFakeDead)
    end
    
    -- FE Invis re-apply
    if State.FEInvisibility then
        task.defer(function()
            ToggleFEInvisibility(true)
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

-- ============================================
-- ESP AUTO-REFRESH SYSTEM
-- ============================================

-- Refresh ESP when players join/leave or characters change
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if State.PlayerESP then
            task.spawn(function()
                ApplyESPToPlayer(player)
            end)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    local key = player.UserId .. "_esp"
    if ESPObjects[key] then
        if ESPObjects[key].Parent then
            ESPObjects[key]:Destroy()
        end
        ESPObjects[key] = nil
    end
end)

-- Connect existing players' CharacterAdded
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            if State.PlayerESP then
                task.spawn(function()
                    ApplyESPToPlayer(player)
                end)
            end
        end)
    end
end

-- Periodic ESP refresh (handles role changes mid-round)
task.spawn(function()
    while task.wait(3) do
        if State.PlayerESP then
            task.spawn(RefreshAllESP)
        end
        if State.GunESP then
            task.spawn(UpdateGunESP)
        end
    end
end)

-- ============================================
-- INITIALIZE ALL LOOPS
-- ============================================

task.spawn(StartAutoKill)
task.spawn(StartAutoGrabGun)
task.spawn(StartKillAura)
task.spawn(StartWalkSpeedLoop)
task.spawn(StartJumpPowerLoop)
task.spawn(StartInfiniteJump)
task.spawn(StartNoclip)
task.spawn(StartAutoEvade)

-- ============================================
-- UI CONSTRUCTION (WindUI)
-- ============================================

local Window = WindUI:CreateWindow({
    Title = "MM2 Professional HUD",
    Icon = "sword",
    Author = "MM2 Script",
    Folder = "MM2_HUD",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

-- ========================
-- TAB 1: COMBAT (MAIN)
-- ========================

local CombatMainTab = Window:Tab({
    Title = "Combat (Main)",
    Icon = "crosshair",
})

CombatMainTab:Toggle({
    Title = "Full Auto-Kill Murderer",
    Description = "Автоматическая стрельба по Убийце при прямой видимости",
    Default = false,
    Callback = function(value)
        State.AutoKillMurderer = value
    end,
})

CombatMainTab:Toggle({
    Title = "Auto-Grab Gun",
    Description = "Телепорт к выпавшему пистолету при его появлении",
    Default = false,
    Callback = function(value)
        State.AutoGrabGun = value
    end,
})

CombatMainTab:Toggle({
    Title = "Kill Aura",
    Description = "Автоатака ножом (для роли Убийцы)",
    Default = false,
    Callback = function(value)
        State.KillAura = value
    end,
})

CombatMainTab:Slider({
    Title = "Kill Aura Radius",
    Description = "Радиус действия Kill Aura (в стадах)",
    Value = {
        Min = 5,
        Max = 50,
        Default = 15,
    },
    Callback = function(value)
        State.KillAuraRadius = value
    end,
})

-- ============================
-- TAB 2: COMBAT (SETTINGS)
-- ============================

local CombatSettingsTab = Window:Tab({
    Title = "Combat (Settings)",
    Icon = "settings",
})

CombatSettingsTab:Toggle({
    Title = "Silent Aim",
    Description = "Перенаправление пуль в Убийцу при ручной стрельбе",
    Default = false,
    Callback = function(value)
        State.SilentAim = value
    end,
})

CombatSettingsTab:Dropdown({
    Title = "Target Part",
    Description = "Кость для наведения",
    Values = {"HumanoidRootPart", "Head"},
    Value = "HumanoidRootPart",
    Callback = function(value)
        State.TargetPart = value
    end,
})

CombatSettingsTab:Toggle({
    Title = "Wall Check",
    Description = "Проверка стен через Raycast для прицеливания",
    Default = true,
    Callback = function(value)
        State.WallCheck = value
    end,
})

-- ====================
-- TAB 3: VISUALS
-- ====================

local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye",
})

VisualsTab:Toggle({
    Title = "Player ESP",
    Description = "Подсветка игроков: Красный=Убийца, Синий=Шериф, Зелёный=Невинный",
    Default = false,
    Callback = function(value)
        State.PlayerESP = value
        if value then
            task.spawn(RefreshAllESP)
        else
            ClearESP()
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
        State.ESPTransparency = value
        -- Update existing ESP objects
        for _, obj in pairs(ESPObjects) do
            if obj and obj.Parent and obj:IsA("Highlight") then
                obj.FillTransparency = value
            end
        end
    end,
})

VisualsTab:Toggle({
    Title = "Gun ESP",
    Description = "Подсветка выпавшего пистолета золотым цветом",
    Default = false,
    Callback = function(value)
        State.GunESP = value
        if value then
            task.spawn(UpdateGunESP)
        else
            ClearGunESP()
        end
    end,
})

-- ====================
-- TAB 4: MOVEMENT
-- ====================

local MovementTab = Window:Tab({
    Title = "Movement",
    Icon = "zap",
})

MovementTab:Toggle({
    Title = "Custom WalkSpeed",
    Description = "Изменение скорости ходьбы",
    Default = false,
    Callback = function(value)
        State.WalkSpeedEnabled = value
        if not value then
            local _, humanoid = GetCharacter()
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end,
})

MovementTab:Slider({
    Title = "WalkSpeed Value",
    Description = "Скорость передвижения",
    Value = {
        Min = 16,
        Max = 150,
        Default = 16,
    },
    Callback = function(value)
        State.WalkSpeedValue = value
    end,
})

MovementTab:Toggle({
    Title = "Custom JumpPower",
    Description = "Изменение высоты прыжка",
    Default = false,
    Callback = function(value)
        State.JumpPowerEnabled = value
        if not value then
            local _, humanoid = GetCharacter()
            if humanoid then
                humanoid.JumpPower = 50
                humanoid.UseJumpPower = true
            end
        end
    end,
})

MovementTab:Slider({
    Title = "JumpPower Value",
    Description = "Высота прыжка",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        State.JumpPowerValue = value
    end,
})

MovementTab:Toggle({
    Title = "Infinite Jump",
    Description = "Прыжки в воздухе без ограничений",
    Default = false,
    Callback = function(value)
        State.InfiniteJump = value
    end,
})

MovementTab:Toggle({
    Title = "Noclip",
    Description = "Проход сквозь стены",
    Default = false,
    Callback = function(value)
        State.Noclip = value
    end,
})

MovementTab:Toggle({
    Title = "Fly",
    Description = "Полёт персонажа (WASD + Space/Shift)",
    Default = false,
    Callback = function(value)
        State.Fly = value
        if value then
            task.spawn(StartFly)
        else
            StopFly()
        end
    end,
})

MovementTab:Slider({
    Title = "Fly Speed",
    Description = "Скорость полёта",
    Value = {
        Min = 10,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        State.FlySpeed = value
    end,
})

MovementTab:Toggle({
    Title = "Auto-Evade Murderer",
    Description = "Автоматическое уклонение от Убийцы с ножом",
    Default = false,
    Callback = function(value)
        State.AutoEvade = value
    end,
})

MovementTab:Slider({
    Title = "Evade Distance",
    Description = "Дистанция срабатывания уклонения (стады)",
    Value = {
        Min = 5,
        Max = 50,
        Default = 20,
    },
    Callback = function(value)
        State.AutoEvadeDistance = value
    end,
})

-- ====================
-- TAB 5: MISC
-- ====================

local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "box",
})

MiscTab:Toggle({
    Title = "Fake Dead",
    Description = "Притворство мёртвым (PlatformStand)",
    Default = false,
    Callback = function(value)
        State.FakeDead = value
        ApplyFakeDead()
    end,
})

MiscTab:Dropdown({
    Title = "Fake Dead Mode",
    Description = "Поза при притворстве",
    Values = {"На живот", "На спину"},
    Value = "На живот",
    Callback = function(value)
        State.FakeDeadMode = value
        if State.FakeDead then
            ApplyFakeDead()
        end
    end,
})

MiscTab:Toggle({
    Title = "FE Invisibility",
    Description = "Локальная невидимость / десинк хитбокса",
    Default = false,
    Callback = function(value)
        State.FEInvisibility = value
        ToggleFEInvisibility(value)
    end,
})

-- ============================================
-- STARTUP NOTIFICATION
-- ============================================

WindUI:Notify({
    Title = "MM2 Professional HUD",
    Content = "Скрипт успешно загружен! Все модули активны и готовы к работе.",
    Icon = "check-circle",
    Duration = 5,
})

-- Select first tab
Window:SelectTab(1)
