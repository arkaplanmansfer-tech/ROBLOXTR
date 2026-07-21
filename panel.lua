-- =============================================================================
-- 🔱 ROBLOXTR PREMIUM HUB v4.8 - TITAN PRO UPDATE
-- 🚀 Kurucu: Mansfer | 200+ Satır | Ultra Gelişmiş Mobil Hileler
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- [TEMALAR]
local Themes = {
    Sari = {Main = Color3.fromRGB(15, 15, 20), Accent = Color3.fromRGB(255, 190, 0)},
    Siyah = {Main = Color3.fromRGB(5, 5, 5), Accent = Color3.fromRGB(200, 200, 200)},
    Kirmizi = {Main = Color3.fromRGB(20, 5, 5), Accent = Color3.fromRGB(255, 50, 50)},
    Beyaz = {Main = Color3.fromRGB(245, 245, 245), Accent = Color3.fromRGB(40, 40, 40)}
}
local CurrentTheme = Themes.Sari

-- [BİLDİRİM SİSTEMİ]
local function Notify(title, text, duration)
    local notif = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    local frame = Instance.new("Frame", notif)
    frame.Size = UDim2.new(0, 200, 0, 60); frame.Position = UDim2.new(0.78, 0, 0.75, 0)
    frame.BackgroundColor3 = CurrentTheme.Main; Instance.new("UICorner", frame)
    local stroke = Instance.new("UIStroke", frame); stroke.Color = CurrentTheme.Accent
    
    local t = Instance.new("TextLabel", frame)
    t.Size = UDim2.new(1, 0, 0, 25); t.Text = title; t.TextColor3 = CurrentTheme.Accent
    t.Font = Enum.Font.SourceSansBold; t.BackgroundTransparency = 1; t.TextSize = 16
    
    local d = Instance.new("TextLabel", frame)
    d.Size = UDim2.new(1, 0, 0, 35); d.Position = UDim2.new(0, 0, 0, 25); d.Text = text
    d.TextColor3 = Color3.fromRGB(255, 255, 255); d.Font = Enum.Font.SourceSans; d.BackgroundTransparency = 1; d.TextSize = 14
    
    frame.Position = UDim2.new(1, 0, 0.75, 0)
    frame:TweenPosition(UDim2.new(0.78, 0, 0.75, 0), "Out", "Quad", 0.5, true)
    task.wait(duration or 3)
    frame:TweenPosition(UDim2.new(1, 0, 0.75, 0), "In", "Quad", 0.5, true)
    task.wait(0.5); notif:Destroy()
end

-- ESKİ PANELİ TEMİZLE
if LocalPlayer.PlayerGui:FindFirstChild("RobloxTR_Hub") then LocalPlayer.PlayerGui.RobloxTR_Hub:Destroy() end

local sg = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
sg.Name = "RobloxTR_Hub"; sg.ResetOnSpawn = false

-- ANA PANEL
local mf = Instance.new("Frame", sg)
mf.Name = "MainFrame"; mf.BackgroundColor3 = CurrentTheme.Main; mf.BackgroundTransparency = 0.05
mf.Position = UDim2.new(0.5, -280, 0.5, -200); mf.Size = UDim2.new(0, 560, 0, 400); mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mf); mainStroke.Color = CurrentTheme.Accent; mainStroke.Thickness = 2.5

-- SIDEBAR
local sidebar = Instance.new("Frame", mf)
sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 12); sidebar.Size = UDim2.new(0, 150, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 15)

-- LOGO
local logo = Instance.new("TextLabel", sidebar)
logo.Size = UDim2.new(1, 0, 0, 50); logo.Text = "ROBLOXTR v4.8"; logo.TextColor3 = CurrentTheme.Accent
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

-- [HOME - 3D LOBİ - DEV KARAKTER]
local viewFrame = Instance.new("ViewportFrame", homeC)
viewFrame.Size = UDim2.new(1, -20, 0, 250); viewFrame.BackgroundTransparency = 1; viewFrame.Position = UDim2.new(0, 10, 0, 0)

local function update3D()
    viewFrame:ClearAllChildren()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    char.Archivable = true; local model = char:Clone(); model.Parent = viewFrame
    local cam = Instance.new("Camera", viewFrame); cam.FieldOfView = 30; viewFrame.CurrentCamera = cam
    cam.CFrame = CFrame.new(Vector3.new(0, 2, 4.5), model.PrimaryPart.Position + Vector3.new(0, 0.5, 0))
    task.spawn(function() while viewFrame.Parent do model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0)); task.wait() end end)
end
task.spawn(update3D)

-- [HELPERS]
local function CreateSlider(pnt, label, min, max, def, cb)
    local f = Instance.new("Frame", pnt); f.Size = UDim2.new(1, -20, 0, 55); f.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", f); local stroke = Instance.new("UIStroke", f); stroke.Color = Color3.fromRGB(45, 45, 60)
    local lbl = Instance.new("TextLabel", f); lbl.Position = UDim2.new(0, 12, 0, 5); lbl.Size = UDim2.new(1, -24, 0, 20)
    lbl.Text = label .. ": " .. def; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.BackgroundTransparency = 1; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame", f); bar.Position = UDim2.new(0, 12, 0, 32); bar.Size = UDim2.new(1, -24, 0, 8); bar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = CurrentTheme.Accent
    local btn = Instance.new("TextButton", bar); btn.Size = UDim2.new(0, 20, 0, 20); btn.Position = UDim2.new((def-min)/(max-min), -10, 0.5, -10); btn.Text = ""
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", btn)
    local active = false
    local function update(input)
        local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(p, 0, 1, 0); btn.Position = UDim2.new(p, -10, 0.5, -10)
        local val = min + p * (max - min); val = max <= 10 and math.round(val*10)/10 or math.floor(val)
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
    local active = false
    b.MouseButton1Click:Connect(function()
        if txt:find("🏠") or txt:find("⚡") or txt:find("🎯") or txt:find("🔫") or txt:find("🌌") or txt:find("⚙️") then
            cb()
        else
            active = not active
            b.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or (color or Color3.fromRGB(35, 35, 45))
            b.Text = active and txt .. " ✅" or txt
            cb(active)
        end
    end)
    return b
end

-- [TAB NAVIGATION - SIDEBAR FIX]
local function addTab(name, pos, icon, content)
    local b = CreateBtn(sidebar, icon .. " " .. name, function()
        for _, c in pairs(mf:GetChildren()) do if c:IsA("ScrollingFrame") then c.Visible = false end end
        content.Visible = true
    end, Color3.fromRGB(20, 20, 30))
    b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 130, 0, 35)
end
addTab("Home", 60, "🏠", homeC); addTab("Veledrom", 105, "⚡", mainC); addTab("ESP", 150, "🎯", espC)
addTab("Combat", 195, "🔫", combatC); addTab("Teleport", 240, "🌌", tpC); addTab("Ayarlar", 285, "⚙️", setC)

-- [VELEDROM]
local Config = { Speed = 16, Jump = 50, Fly = 50, Hitbox = 2, TPDelay = 0.5, FOV = 100, Smooth = 5, TogSize = 60 }
local State = { Flying = false, NoClip = false, ESP = false, Box = false, Tracers = false, Hitbox = false, Aimbot = false, AutoTP = false }

CreateSlider(mainC, "Hız (Speed)", 16, 500, 16, function(v) Config.Speed = v end)
CreateBtn(mainC, "🔄 Hızı Sıfırla", function() Config.Speed = 16; Notify("Veledrom", "Hız Sıfırlandı") end)
CreateSlider(mainC, "Zıplama (Jump)", 50, 500, 50, function(v) Config.Jump = v end)
CreateBtn(mainC, "🔄 Zıplamayı Sıfırla", function() Config.Jump = 50; Notify("Veledrom", "Zıplama Sıfırlandı") end)
CreateSlider(mainC, "Uçma Hızı (Fly)", 10, 500, 50, function(v) Config.Fly = v end)
CreateBtn(mainC, "✈️ Uçma (Fly) Aktif Et", function(a) State.Flying = a end)
CreateBtn(mainC, "👻 NoClip (Duvar Geçme)", function(a) State.NoClip = a end)

RunService.RenderStepped:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum and not State.Flying then hum.WalkSpeed = Config.Speed; hum.JumpPower = Config.Jump end
    if State.NoClip then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
end)

-- [ESP - ALL SYSTEMS]
CreateBtn(espC, "👁️ Highlight ESP (Röntgen)", function(a)
    State.ESP = a
    task.spawn(function()
        while State.ESP do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    if not p.Character:FindFirstChild("TR_ESP") then
                        local h = Instance.new("Highlight", p.Character); h.Name = "TR_ESP"
                        h.FillColor = CurrentTheme.Accent; h.OutlineColor = Color3.fromRGB(255,255,255)
                    end
                end
            end
            task.wait(1)
        end
        for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("TR_ESP") then p.Character.TR_ESP:Destroy() end end
    end)
end)
CreateBtn(espC, "📏 Box ESP (Kutu)", function(a) State.Box = a end)
CreateBtn(espC, "🔗 Tracer ESP (Çizgi)", function(a) State.Tracers = a end)

-- [COMBAT]
CreateSlider(combatC, "Aimbot FOV", 50, 800, 100, function(v) Config.FOV = v end)
CreateBtn(combatC, "🔫 Mobil Aimbot (Kilitle)", function(a)
    State.Aimbot = a
    task.spawn(function()
        while State.Aimbot do
            local target = nil; local dist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head; local pos, on = Camera:WorldToViewportPoint(head.Position)
                    if on then
                        local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if mag < Config.FOV and mag < dist then dist = mag; target = head end
                    end
                end
            end
            if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
            task.wait()
        end
    end)
end)
CreateSlider(combatC, "Hitbox Boyutu", 2, 50, 2, function(v) Config.Hitbox = v end)
CreateBtn(combatC, "🎯 Hitbox Aktif Et", function(a) State.Hitbox = a end)

-- [TELEPORT]
local SavedPos = nil
CreateSlider(tpC, "⏱️ TP Gecikmesi", 0.1, 5, 0.5, function(v) Config.TPDelay = v end)
CreateBtn(tpC, "📍 Konum Kaydet", function() SavedPos = LocalPlayer.Character.HumanoidRootPart.CFrame; Notify("TP", "Konum Kaydedildi") end)
CreateBtn(tpC, "🔄 Oto-TP (AutoFarm)", function(a)
    State.AutoTP = a
    task.spawn(function() while State.AutoTP and SavedPos do LocalPlayer.Character.HumanoidRootPart.CFrame = SavedPos; task.wait(Config.TPDelay) end end)
end)

-- [SETTINGS]
CreateBtn(setC, "🔗 Grup Linki (Kopyala)", function() setclipboard("bit.ly/robloxturkiye"); Notify("Grup", "Link Kopyalandı!") end)
CreateSlider(setC, "Buton Boyutu (Aç/Kapa)", 40, 150, 60, function(v) tog.Size = UDim2.new(0, v, 0, v) end)
CreateBtn(setC, "🔄 Butonu Sıfırla", function() tog.Position = UDim2.new(0.6, 0, 0.02, 0) end)
CreateBtn(setC, "🎨 Tema: Sarı", function() CurrentTheme = Themes.Sari; mf.BackgroundColor3 = CurrentTheme.Main; mainStroke.Color = CurrentTheme.Accent end)
CreateBtn(setC, "🎨 Tema: Siyah", function() CurrentTheme = Themes.Siyah; mf.BackgroundColor3 = CurrentTheme.Main; mainStroke.Color = CurrentTheme.Accent end)
CreateBtn(setC, "🎨 Tema: Kırmızı", function() CurrentTheme = Themes.Kirmizi; mf.BackgroundColor3 = CurrentTheme.Main; mainStroke.Color = CurrentTheme.Accent end)
CreateBtn(setC, "🎨 Tema: Beyaz", function() CurrentTheme = Themes.Beyaz; mf.BackgroundColor3 = CurrentTheme.Main; mainStroke.Color = CurrentTheme.Accent end)

-- [TOGGLE & ANIMATION]
local tog = Instance.new("ImageButton", sg)
tog.Size = UDim2.new(0, 60, 0, 60); tog.Position = UDim2.new(0.6, 0, 0.02, 0)
tog.Image = "rbxassetid://15134244566"; tog.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 12)

tog.MouseButton1Click:Connect(function()
    if mf.Visible then
        mf:TweenSize(UDim2.new(0,0,0,0), "In", "Back", 0.3, true, function() mf.Visible = false end)
    else
        mf.Visible = true; mf.Size = UDim2.new(0,0,0,0)
        mf:TweenSize(UDim2.new(0, 560, 0, 400), "Out", "Back", 0.3, true)
    end
end)

local function Drag(f)
    local d, s, p; f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true; s = i.Position; p = f.Position end end)
    UserInputService.InputChanged:Connect(function(i) if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local del = i.Position - s; f.Position = UDim2.new(p.X.Scale, p.X.Offset + del.X, p.Y.Scale, p.Y.Offset + del.Y)
    end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = false end end)
end
Drag(tog); Drag(mf)

Notify("RobloxTR v4.8 Titan Pro", "Hoş geldin Mansfer! Panel Hazır.", 5)
