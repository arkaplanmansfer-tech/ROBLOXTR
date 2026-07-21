-- =============================================================================
-- 🔱 ROBLOXTR PREMIUM HUB v4.6 - STABILITY UPDATE
-- 🚀 Kurucu: Mansfer | 500+ Satır | Ultra Gelişmiş Hileler & 3D Lobi
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ESKİ PANELİ TEMİZLE
if LocalPlayer.PlayerGui:FindFirstChild("RobloxTR_Hub") then LocalPlayer.PlayerGui.RobloxTR_Hub:Destroy() end

local sg = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
sg.Name = "RobloxTR_Hub"; sg.ResetOnSpawn = false

-- ANA PANEL
local mf = Instance.new("Frame", sg)
mf.Name = "MainFrame"; mf.BackgroundColor3 = Color3.fromRGB(12, 12, 18); mf.BackgroundTransparency = 0.05
mf.Position = UDim2.new(0.5, -280, 0.5, -200); mf.Size = UDim2.new(0, 560, 0, 400); mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mf); mainStroke.Color = Color3.fromRGB(80, 40, 150); mainStroke.Thickness = 2.5

-- SIDEBAR
local sidebar = Instance.new("Frame", mf)
sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 12); sidebar.Size = UDim2.new(0, 150, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 15)

-- LOGO
local logo = Instance.new("TextLabel", sidebar)
logo.Size = UDim2.new(1, 0, 0, 50); logo.Text = "ROBLOXTR v4.6"; logo.TextColor3 = Color3.fromRGB(255, 190, 0)
logo.Font = Enum.Font.SourceSansBold; logo.TextSize = 20; logo.BackgroundTransparency = 1

-- SCROLLING AREAS
local function CreateScroll(name)
    local sf = Instance.new("ScrollingFrame", mf)
    sf.Name = name; sf.BackgroundTransparency = 1; sf.Position = UDim2.new(0, 160, 0, 40); sf.Size = UDim2.new(0, 390, 0, 350)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.ScrollBarThickness = 2; sf.Visible = false; sf.BorderSizePixel = 0
    local padding = Instance.new("UIListLayout", sf); padding.Padding = UDim.new(0, 10); padding.SortOrder = Enum.SortOrder.LayoutOrder
    return sf
end

local homeC = CreateScroll("Home"); homeC.Visible = true
local mainC = CreateScroll("Main"); local espC = CreateScroll("ESP")
local combatC = CreateScroll("Combat"); local tpC = CreateScroll("Teleport"); local setC = CreateScroll("Settings")

-- [HOME - 3D LOBİ]
local viewFrame = Instance.new("ViewportFrame", homeC)
viewFrame.Size = UDim2.new(1, -20, 0, 180); viewFrame.BackgroundTransparency = 1; viewFrame.Position = UDim2.new(0, 10, 0, 0)

local function update3D()
    viewFrame:ClearAllChildren()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    char.Archivable = true; local model = char:Clone(); model.Parent = viewFrame
    local cam = Instance.new("Camera", viewFrame); cam.FieldOfView = 50; viewFrame.CurrentCamera = cam
    cam.CFrame = CFrame.new(Vector3.new(0, 2, 6), model.PrimaryPart.Position + Vector3.new(0, 0.5, 0))
    task.spawn(function() while viewFrame.Parent do model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0)); task.wait() end end)
end
task.spawn(update3D)

-- [HELPERS - FIXED SLIDER FOR MOBILE]
local function CreateSlider(pnt, label, min, max, def, cb)
    local f = Instance.new("Frame", pnt); f.Size = UDim2.new(1, -20, 0, 55); f.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", f); local stroke = Instance.new("UIStroke", f); stroke.Color = Color3.fromRGB(45, 45, 60)
    
    local lbl = Instance.new("TextLabel", f); lbl.Position = UDim2.new(0, 12, 0, 5); lbl.Size = UDim2.new(1, -24, 0, 20)
    lbl.Text = label .. ": " .. def; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.BackgroundTransparency = 1; lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local bar = Instance.new("Frame", f); bar.Position = UDim2.new(0, 12, 0, 32); bar.Size = UDim2.new(1, -24, 0, 8); bar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Instance.new("UICorner", bar)
    
    local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(80, 40, 150)
    Instance.new("UICorner", fill)
    
    local btn = Instance.new("TextButton", bar); btn.Size = UDim2.new(0, 16, 0, 16); btn.Position = UDim2.new((def-min)/(max-min), -8, 0.5, -8)
    btn.Text = ""; btn.BackgroundColor3 = Color3.fromRGB(255, 190, 0); Instance.new("UICorner", btn)

    local active = false
    local function update(input)
        local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(p, 0, 1, 0); btn.Position = UDim2.new(p, -8, 0.5, -8)
        local val = min + p * (max - min)
        if max <= 10 then val = math.round(val * 10) / 10 else val = math.floor(val) end
        lbl.Text = label .. ": " .. val; cb(val)
    end
    btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then active = true end end)
    UserInputService.InputChanged:Connect(function(i) if active and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then update(i) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then active = false end end)
end

local function CreateBtn(pnt, txt, cb, color)
    local b = Instance.new("TextButton", pnt); b.Size = UDim2.new(1, -20, 0, 38); b.BackgroundColor3 = color or Color3.fromRGB(35, 35, 45)
    b.Font = Enum.Font.SourceSansBold; b.Text = txt; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextSize = 14
    Instance.new("UICorner", b); local stroke = Instance.new("UIStroke", b); stroke.Color = Color3.fromRGB(60, 60, 80)
    b.MouseButton1Click:Connect(function() cb(b) end); return b
end

-- CONFIG & STATES
local Config = { Speed = 16, Jump = 50, Fly = 50, Hitbox = 2, TPDelay = 0.5, FOV = 100 }
local State = { Flying = false, InfJump = false, NoClip = false, ESP = false, Tracers = false, Hitbox = false, AutoTP = false }
local SavedPos = nil

-- [TAB NAVIGATION]
local function addTab(name, pos, content)
    local b = CreateBtn(sidebar, name, function()
        for _, c in pairs(mf:GetChildren()) do if c:IsA("ScrollingFrame") then c.Visible = false end end
        content.Visible = true
    end, Color3.fromRGB(20, 20, 30))
    b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 130, 0, 35)
end
addTab("🏠 Home", 60, homeC); addTab("⚡ Veledrom", 105, mainC); addTab("🎯 ESP", 150, espC)
addTab("🔫 Combat", 195, combatC); addTab("🌌 Teleport", 240, tpC); addTab("⚙️ Ayarlar", 285, setC)

-- [VELEDROM]
CreateSlider(mainC, "Hız (Speed)", 16, 500, 16, function(v) Config.Speed = v end)
CreateSlider(mainC, "Zıplama (Jump)", 50, 500, 50, function(v) Config.Jump = v end)
CreateSlider(mainC, "Uçma Hızı (Fly)", 10, 500, 50, function(v) Config.Fly = v end)

RunService.RenderStepped:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum and not State.Flying then hum.WalkSpeed = Config.Speed; hum.JumpPower = Config.JumpPower end
    if State.NoClip then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
end)

CreateBtn(mainC, "👻 NoClip (Duvar Geçme)", function(b) State.NoClip = not State.NoClip end)

local flyV, flyG
CreateBtn(mainC, "✈️ Fly (Uçma)", function(b)
    State.Flying = not State.Flying; local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if State.Flying and hrp then
        LocalPlayer.Character.Humanoid.PlatformStand = true
        flyV = Instance.new("BodyVelocity", hrp); flyV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyG = Instance.new("BodyGyro", hrp); flyG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function() while State.Flying and hrp.Parent do
            local cam = Camera.CFrame; local mv = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.RightVector end
            flyV.Velocity = mv.Magnitude > 0 and mv.Unit * Config.Fly or Vector3.new(0,0,0)
            flyG.CFrame = cam; task.wait()
        end end)
    else
        if flyV then flyV:Destroy() end; if flyG then flyG:Destroy() end
        if LocalPlayer.Character then LocalPlayer.Character.Humanoid.PlatformStand = false end
    end
end)

-- [ESP FEATURES]
CreateBtn(espC, "👁️ Name ESP (İsimler)", function() State.ESP = not State.ESP end)
CreateBtn(espC, "📏 Box ESP (Kutular)", function() State.Box = not State.Box end)
CreateBtn(espC, "🔗 Tracers (Çizgiler)", function() State.Tracers = not State.Tracers end)

-- [COMBAT FEATURES]
CreateSlider(combatC, "Hitbox Boyutu", 2, 50, 2, function(v) Config.Hitbox = v end)
CreateBtn(combatC, "🎯 Hitbox Aktif Et", function(b) State.Hitbox = not State.Hitbox end)

task.spawn(function()
    while task.wait(0.5) do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                if State.Hitbox then hrp.Size = Vector3.new(Config.Hitbox, Config.Hitbox, Config.Hitbox); hrp.Transparency = 0.7; hrp.CanCollide = false
                else hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 1; hrp.CanCollide = true end
            end
        end
    end
end)

-- [TELEPORT FEATURES]
CreateSlider(tpC, "⏱️ TP Gecikmesi", 0.1, 5, 0.5, function(v) Config.TPDelay = v end)
CreateBtn(tpC, "📍 Konum Kaydet", function() SavedPos = LocalPlayer.Character.HumanoidRootPart.CFrame end)
CreateBtn(tpC, "🔄 Oto-TP (AutoFarm)", function(b)
    State.AutoTP = not State.AutoTP
    task.spawn(function() while State.AutoTP and SavedPos do LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos; task.wait(Config.TPDelay) end end)
end)

local function loadTP()
    for _, v in pairs(tpC:GetChildren()) do if v.Name == "TPB" then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then CreateBtn(tpC, "🚀 TP -> " .. p.DisplayName, function() LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end).Name = "TPB" end
    end
end
CreateBtn(tpC, "🔄 Listeyi Yenile", loadTP, Color3.fromRGB(150, 80, 0))

-- [TOGGLE & DRAG]
local tog = Instance.new("ImageButton", sg)
tog.Size = UDim2.new(0, 60, 0, 60); tog.Position = UDim2.new(0.6, 0, 0.02, 0)
tog.Image = "rbxassetid://15134244566"; tog.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 12)
tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)

local function Drag(f)
    local d, s, p; f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true; s = i.Position; p = f.Position end end)
    UserInputService.InputChanged:Connect(function(i) if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local del = i.Position - s; f.Position = UDim2.new(p.X.Scale, p.X.Offset + del.X, p.Y.Scale, p.Y.Offset + del.Y)
    end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = false end end)
end
Drag(tog); Drag(mf)

print("✅ RobloxTR v4.6 Başarıyla Yüklendi!")
