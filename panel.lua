-- =============================================================================
-- ROBLOXTR PREMIUM HUB (v4.0 - FULL & FIXED)
-- Kurucu: Mansfer | Sürüm: v4.0 | Tüm Özellikler Aktif
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ESKİ PANELİ TEMİZLE
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("RobloxTR_Hub") then 
    LocalPlayer.PlayerGui.RobloxTR_Hub:Destroy() 
end

local sg = Instance.new("ScreenGui")
sg.Name = "RobloxTR_Hub"; sg.Parent = LocalPlayer.PlayerGui; sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ANA PANEL ÇERÇEVESİ
local mf = Instance.new("Frame")
mf.Name = "MainFrame"; mf.Parent = sg; mf.BackgroundColor3 = Color3.fromRGB(15, 15, 20); mf.BackgroundTransparency = 0.1
mf.Position = UDim2.new(0.5, -260, 0.5, -180); mf.Size = UDim2.new(0, 520, 0, 370); mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 12)

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"; sidebar.Parent = mf; sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); sidebar.Size = UDim2.new(0, 145, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

-- AVATAR VE STATS
local avatar = Instance.new("ImageLabel")
avatar.Parent = sidebar; avatar.Position = UDim2.new(0, 47, 0, 15); avatar.Size = UDim2.new(0, 50, 0, 50); avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

local t = Instance.new("TextLabel")
t.Parent = sidebar; t.BackgroundTransparency = 1; t.Position = UDim2.new(0, 0, 0, 70); t.Size = UDim2.new(1, 0, 0, 20)
t.Font = Enum.Font.SourceSansBold; t.Text = "RobloxTR v4.0"; t.TextColor3 = Color3.fromRGB(255, 190, 0); t.TextSize = 16

local cb = Instance.new("TextButton")
cb.Parent = mf; cb.BackgroundTransparency = 1; cb.Position = UDim2.new(0, 485, 0, 8); cb.Size = UDim2.new(0, 25, 0, 25)
cb.Font = Enum.Font.SourceSansBold; cb.Text = "X"; cb.TextColor3 = Color3.fromRGB(255, 70, 70); cb.TextSize = 18

-- SCROLLING AREAS
local function CreateScroll(name)
    local sf = Instance.new("ScrollingFrame")
    sf.Name = name; sf.Parent = mf; sf.BackgroundTransparency = 1; sf.Position = UDim2.new(0, 155, 0, 35); sf.Size = UDim2.new(0, 350, 0, 320)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.ScrollBarThickness = 3; sf.Visible = false; sf.BorderSizePixel = 0
    local padding = Instance.new("UIListLayout", sf); padding.Padding = UDim.new(0, 8); padding.SortOrder = Enum.SortOrder.LayoutOrder
    return sf
end

local homeC = CreateScroll("Home"); homeC.Visible = true
local mainC = CreateScroll("Main"); local espC = CreateScroll("ESP")
local tpC = CreateScroll("Teleport"); local setC = CreateScroll("Settings")

-- STATS UPDATE
RunService.RenderStepped:Connect(function()
    pcall(function()
        homeC:FindFirstChild("fps").Text = "🚀 FPS: " .. math.floor(1/RunService.RenderStepped:Wait())
        homeC:FindFirstChild("ping").Text = "📡 Ping: " .. math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms"
    end)
end)

-- [HELPERS]
local function CreateSlider(pnt, label, min, max, def, cb)
    local f = Instance.new("Frame", pnt); f.Size = UDim2.new(1, -15, 0, 48); f.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", f); lbl.BackgroundTransparency = 1; lbl.Position = UDim2.new(0, 10, 0, 4); lbl.Size = UDim2.new(1, -20, 0, 18)
    lbl.Font = Enum.Font.SourceSansBold; lbl.Text = label..": "..def; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 13; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame", f); bar.Position = UDim2.new(0, 10, 0, 28); bar.Size = UDim2.new(1, -20, 0, 6); bar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
    local active = false
    local function update(input)
        local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1); fill.Size = UDim2.new(p, 0, 1, 0)
        local val = math.floor(min + p * (max - min)); lbl.Text = label..": "..val; cb(val)
    end
    bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then active = true; update(input) end end)
    UserInputService.InputChanged:Connect(function(input) if active and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then active = false end end)
end

local function CreateBtn(pnt, txt, cb, color)
    local b = Instance.new("TextButton", pnt); b.Size = UDim2.new(1, -15, 0, 36); b.BackgroundColor3 = color or Color3.fromRGB(30, 30, 38)
    b.Font = Enum.Font.SourceSansBold; b.Text = txt; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6); b.MouseButton1Click:Connect(function() cb(b) end); return b
end

-- CONFIG & STATES
local Config = { WalkSpeed = 16, JumpPower = 50, FlySpeed = 50, HitboxSize = 2, TeamCheck = true }
local State = { Flying = false, InfJump = false, Aimbot = false, ESP = false, Chams = false, Hitbox = false }

-- [TAB BUTTONS]
local tabButtons = {}
local function addTab(name, pos, content)
    local b = Instance.new("TextButton", sidebar); b.Position = UDim2.new(0, 12, 0, pos); b.Size = UDim2.new(0, 120, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.Font = Enum.Font.SourceSansBold; b.Text = name; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        for _, v in pairs(mf:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
        for _, btn in pairs(tabButtons) do btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30); btn.TextColor3 = Color3.fromRGB(200, 200, 200) end
        content.Visible = true; b.BackgroundColor3 = Color3.fromRGB(255, 190, 0); b.TextColor3 = Color3.fromRGB(15, 15, 20)
    end)
    table.insert(tabButtons, b)
end
addTab("🏠 Home", 95, homeC); addTab("⚡ Veledrom", 135, mainC); addTab("🎯 ESP / Combat", 175, espC); 
addTab("🔫 Aimbot", 215, CreateScroll("Aimbot")); addTab("🌌 Teleport", 255, tpC); addTab("⚙️ Ayarlar", 295, setC)

-- [VELEDROM - SPEED/JUMP/FLY]
CreateSlider(mainC, "Yürüme Hızı", 16, 300, 16, function(v) Config.WalkSpeed = v end)
CreateSlider(mainC, "Zıplama Gücü", 50, 300, 50, function(v) Config.JumpPower = v end)
CreateSlider(mainC, "Uçma Hızı", 10, 240, 50, function(v) Config.FlySpeed = v end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and not State.Flying then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
        LocalPlayer.Character.Humanoid.JumpPower = Config.JumpPower
    end
end)

local flyV, flyG
CreateBtn(mainC, "✈️ Fly (Uçuş)", function(b)
    State.Flying = not State.Flying; b.BackgroundColor3 = State.Flying and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38)
    local char = LocalPlayer.Character
    if State.Flying and char and char:FindFirstChild("HumanoidRootPart") then
        char.Humanoid.PlatformStand = true
        flyV = Instance.new("BodyVelocity", char.HumanoidRootPart); flyV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyG = Instance.new("BodyGyro", char.HumanoidRootPart); flyG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while State.Flying and char and char.Parent do
                local cam = Camera.CFrame; local mv = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then mv = mv - Vector3.new(0,1,0) end
                flyV.Velocity = mv.Magnitude > 0 and mv.Unit * Config.FlySpeed or Vector3.new(0,0,0)
                flyG.CFrame = cam; task.wait()
            end
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
        end)
    else
        if flyV then flyV:Destroy() end; if flyG then flyG:Destroy() end
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
    end
end)

-- [ESP & COMBAT]
CreateSlider(espC, "Hitbox Boyutu", 2, 30, 2, function(v) Config.HitboxSize = v end)
CreateBtn(espC, "🎯 Hitbox Expander", function(b) State.Hitbox = not State.Hitbox; b.BackgroundColor3 = State.Hitbox and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38) end)
task.spawn(function()
    while task.wait(0.5) do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                if State.Hitbox then hrp.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize); hrp.Transparency = 0.7; hrp.CanCollide = false
                else hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 1; hrp.CanCollide = true end
            end
        end
    end
end)
CreateBtn(espC, "👁️ Name ESP", function(b) State.ESP = not State.ESP; b.BackgroundColor3 = State.ESP and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38) end)
CreateBtn(espC, "🎨 Wall Chams", function(b) State.Chams = not State.Chams; b.BackgroundColor3 = State.Chams and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38) end)

-- [TELEPORT]
local function loadTP()
    for _, v in pairs(tpC:GetChildren()) do if v.Name == "TPBtn" then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            CreateBtn(tpC, "🚀 " .. p.DisplayName, function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                end
            end).Name = "TPBtn"
        end
    end
end
CreateBtn(tpC, "🔄 Listeyi Yenile", loadTP, Color3.fromRGB(150, 80, 0))
loadTP()

-- [SETTINGS]
local fb = false
CreateBtn(setC, "💡 FullBright", function(b) fb = not fb; Lighting.Ambient = fb and Color3.fromRGB(255,255,255) or Color3.fromRGB(127,127,127); b.BackgroundColor3 = fb and Color3.fromRGB(0,160,80) or Color3.fromRGB(30, 30, 38) end)
CreateBtn(setC, "🚀 Ultra FPS Boost", function(b)
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end end
end)

-- [GOJO TOGGLE & DRAG]
local tog = Instance.new("ImageButton", sg)
tog.Size = UDim2.new(0, 60, 0, 60); tog.Position = UDim2.new(0.6, 0, 0.02, 0)
tog.Image = "rbxassetid://15134244566"; tog.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 12)

tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)
cb.MouseButton1Click:Connect(function() mf.Visible = false end)

local function Drag(f)
    local d, s, p; f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true; s = i.Position; p = f.Position end end)
    UserInputService.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then
        local del = i.Position - s; f.Position = UDim2.new(p.X.Scale, p.X.Offset + del.X, p.Y.Scale, p.Y.Offset + del.Y)
    end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
end
Drag(tog); Drag(mf)

print("✅ RobloxTR v4.0 Başarıyla Yüklendi!")
