-- =============================================================================
-- 🔱 ROBLOXTR PREMIUM HUB v6.0 - TITAN EDITION
-- 🚀 Kurucu: Mansfer | 500+ Satır | Ultra Gelişmiş Hileler & 3D Lobi
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- [BİLDİRİM SİSTEMİ]
local function Notify(title, text, duration)
    local notif = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    local frame = Instance.new("Frame", notif)
    frame.Size = UDim2.new(0, 220, 0, 60); frame.Position = UDim2.new(1, 0, 0.8, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30); Instance.new("UICorner", frame)
    local stroke = Instance.new("UIStroke", frame); stroke.Color = Color3.fromRGB(80, 40, 150)
    
    local t = Instance.new("TextLabel", frame)
    t.Size = UDim2.new(1, 0, 0, 25); t.Text = title; t.TextColor3 = Color3.fromRGB(255, 190, 0)
    t.Font = Enum.Font.SourceSansBold; t.BackgroundTransparency = 1; t.TextSize = 16
    
    local d = Instance.new("TextLabel", frame)
    d.Size = UDim2.new(1, 0, 0, 35); d.Position = UDim2.new(0, 0, 0, 25); d.Text = text
    d.TextColor3 = Color3.fromRGB(255, 255, 255); d.Font = Enum.Font.SourceSans; d.BackgroundTransparency = 1; d.TextSize = 14
    
    frame:TweenPosition(UDim2.new(0.8, 0, 0.8, 0), "Out", "Quad", 0.5, true)
    task.wait(duration or 3)
    frame:TweenPosition(UDim2.new(1, 0, 0.8, 0), "In", "Quad", 0.5, true)
    task.wait(0.5); notif:Destroy()
end

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

-- LOGO & AVATAR
local logo = Instance.new("TextLabel", sidebar)
logo.Size = UDim2.new(1, 0, 0, 50); logo.Text = "ROBLOXTR TITAN"; logo.TextColor3 = Color3.fromRGB(255, 190, 0)
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

-- [HOME - 3D LOBİ & STATS]
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

-- [HELPERS - PRO SLIDER & BUTTON]
local function CreateSlider(pnt, label, min, max, def, cb)
    local f = Instance.new("Frame", pnt); f.Size = UDim2.new(1, -20, 0, 55); f.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", f); local stroke = Instance.new("UIStroke", f); stroke.Color = Color3.fromRGB(45, 45, 60)
    local lbl = Instance.new("TextLabel", f); lbl.Position = UDim2.new(0, 12, 0, 5); lbl.Size = UDim2.new(1, -24, 0, 20)
    lbl.Text = label .. ": " .. def; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.BackgroundTransparency = 1; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame", f); bar.Position = UDim2.new(0, 12, 0, 32); bar.Size = UDim2.new(1, -24, 0, 8); bar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(80, 40, 150)
    local btn = Instance.new("TextButton", bar); btn.Size = UDim2.new(0, 16, 0, 16); btn.Position = UDim2.new((def-min)/(max-min), -8, 0.5, -8); btn.Text = ""
    btn.BackgroundColor3 = Color3.fromRGB(255, 190, 0); Instance.new("UICorner", btn)
    local active = false
    local function update(input)
        local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(p, 0, 1, 0); btn.Position = UDim2.new(p, -8, 0.5, -8)
        local val = min + p * (max - min); if max <= 10 then val = math.round(val * 10) / 10 else val = math.floor(val) end
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

-- [CONFIG]
local Config = { Speed = 16, Jump = 50, Fly = 50, Hitbox = 2, FOV = 100, Smooth = 5, TPDelay = 0.5 }
local State = { Flying = false, InfJump = false, NoClip = false, ESP = false, Tracers = false, Hitbox = false, Aimbot = false, AutoTP = false }
local SavedPos = nil

-- [TABS]
local function addTab(name, pos, content)
    local b = CreateBtn(sidebar, name, function() for _, c in pairs(mf:GetChildren()) do if c:IsA("ScrollingFrame") then c.Visible = false end end; content.Visible = true end)
    b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 130, 0, 35)
end
addTab("🏠 Home", 60, homeC); addTab("⚡ Veledrom", 105, mainC); addTab("🎯 ESP", 150, espC)
addTab("🔫 Combat", 195, combatC); addTab("🌌 Teleport", 240, tpC); addTab("⚙️ Ayarlar", 285, setC)

-- [VELEDROM FEATURES]
CreateSlider(mainC, "Hız (Speed)", 16, 500, 16, function(v) Config.Speed = v end)
CreateSlider(mainC, "Zıplama (Jump)", 50, 500, 50, function(v) Config.Jump = v end)
CreateSlider(mainC, "Uçma Hızı (Fly)", 10, 500, 50, function(v) Config.Fly = v end)

RunService.RenderStepped:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum and not State.Flying then hum.WalkSpeed = Config.Speed; hum.JumpPower = Config.JumpPower end
    if State.NoClip then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
end)

CreateBtn(mainC, "👻 NoClip (Duvar Geçme)", function(b) State.NoClip = not State.NoClip; Notify("NoClip", State.NoClip and "Aktif" or "Pasif") end)
CreateBtn(mainC, "🚀 Infinite Jump (Sınırsız Zıplama)", function(b) State.InfJump = not State.InfJump; Notify("InfJump", State.InfJump and "Aktif" or "Pasif") end)
UserInputService.JumpRequest:Connect(function() if State.InfJump then LocalPlayer.Character.Humanoid:ChangeState("Jumping") end end)

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
CreateSlider(combatC, "Aimbot FOV", 50, 800, 100, function(v) Config.FOV = v end)
CreateSlider(combatC, "Aimbot Smoothness", 1, 20, 5, function(v) Config.Smooth = v end)
CreateBtn(combatC, "🔫 Aimbot (Sağ Tık)", function() State.Aimbot = not State.Aimbot end)
CreateSlider(combatC, "Hitbox Boyutu", 2, 50, 2, function(v) Config.Hitbox = v end)
CreateBtn(combatC, "🎯 Hitbox Aktif Et", function() State.Hitbox = not State.Hitbox end)

-- [TELEPORT FEATURES]
CreateSlider(tpC, "⏱️ TP Gecikmesi", 0.1, 5, 0.5, function(v) Config.TPDelay = v end)
CreateBtn(tpC, "📍 Konum Kaydet", function() SavedPos = LocalPlayer.Character.HumanoidRootPart.CFrame; Notify("TP", "Konum Kaydedildi") end)
CreateBtn(tpC, "🔄 Auto-Farm (Sonsuz TP)", function(b)
    State.AutoTP = not State.AutoTP; task.spawn(function() while State.AutoTP and SavedPos do LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos; task.wait(Config.TPDelay) end end)
end)

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

Notify("RobloxTR TITAN", "Hoş geldin Mansfer! Panel Hazır.", 5)
