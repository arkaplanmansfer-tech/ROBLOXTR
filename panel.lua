-- =============================================================================
-- ROBLOXTR PREMIUM HUB (v3.0 FINAL EDITION)
-- Kurucu: Mansfer | Tasarım: v2.2 Pro | Gelişmiş Combat & Görsel Güncellemesi
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
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
mf.Position = UDim2.new(0.5, -240, 0.5, -160); mf.Size = UDim2.new(0, 480, 0, 320); mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 12)

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"; sidebar.Parent = mf; sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); sidebar.Size = UDim2.new(0, 140, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

-- AVATAR VE STATS (HOME)
local avatar = Instance.new("ImageLabel")
avatar.Parent = sidebar; avatar.Position = UDim2.new(0, 45, 0, 15); avatar.Size = UDim2.new(0, 50, 0, 50); avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

local t = Instance.new("TextLabel")
t.Parent = sidebar; t.BackgroundTransparency = 1; t.Position = UDim2.new(0, 0, 0, 70); t.Size = UDim2.new(1, 0, 0, 20)
t.Font = Enum.Font.SourceSansBold; t.Text = "RobloxTR v3.0 Pro"; t.TextColor3 = Color3.fromRGB(255, 190, 0); t.TextSize = 16

local cb = Instance.new("TextButton")
cb.Parent = mf; cb.BackgroundTransparency = 1; cb.Position = UDim2.new(0, 450, 0, 8); cb.Size = UDim2.new(0, 25, 0, 25)
cb.Font = Enum.Font.SourceSansBold; cb.Text = "X"; cb.TextColor3 = Color3.fromRGB(255, 70, 70); cb.TextSize = 18

-- SCROLLING CONTENT AREA (Otomatik Yükseklik Ayarlı)
local function CreateScroll(name)
    local sf = Instance.new("ScrollingFrame")
    sf.Name = name; sf.Parent = mf; sf.BackgroundTransparency = 1; sf.Position = UDim2.new(0, 150, 0, 35); sf.Size = UDim2.new(0, 315, 0, 270)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.ScrollBarThickness = 3; sf.Visible = false; sf.BorderSizePixel = 0
    local padding = Instance.new("UIListLayout", sf)
    padding.Padding = UDim.new(0, 6)
    padding.SortOrder = Enum.SortOrder.LayoutOrder
    return sf
end

local homeC = CreateScroll("Home"); homeC.Visible = true
local mainC = CreateScroll("Main")
local espC = CreateScroll("ESP")
local musicC = CreateScroll("Music")
local setC = CreateScroll("Settings")

-- [HOME] STATS PANELİ
local function addStat(pnt, txt)
    local l = Instance.new("TextLabel"); l.Parent = pnt; l.Size = UDim2.new(1, -10, 0, 32); l.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    l.Font = Enum.Font.SourceSansBold; l.TextColor3 = Color3.fromRGB(220, 220, 220); l.TextSize = 13; Instance.new("UICorner", l).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", l); stroke.Color = Color3.fromRGB(40, 40, 50); stroke.Thickness = 1
    return l
end
local fpsL = addStat(homeC, "🚀 FPS: Hesaplıyor..."); local pingL = addStat(homeC, "📡 Ping: Hesaplıyor...")

local lastTime = os.clock()
local frameCount = 0
local currentFPS = 60

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = os.clock()
    if now - lastTime >= 0.5 then
        currentFPS = math.floor(frameCount / (now - lastTime))
        frameCount = 0
        lastTime = now
    end
    fpsL.Text = "🚀 Sunucu FPS: " .. currentFPS
    local ping = "N/A"
    pcall(function() ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    pingL.Text = "📡 Anlık Ping: " .. ping .. " ms"
end)

-- [TAB BUTTONS]
local tabButtons = {}
local function addTab(name, pos, content)
    local b = Instance.new("TextButton"); b.Parent = sidebar; b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 120, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.Font = Enum.Font.SourceSansBold; b.Text = name; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", b); stroke.Color = Color3.fromRGB(40, 40, 50); stroke.Thickness = 1
    
    b.MouseButton1Click:Connect(function()
        for _, v in pairs(mf:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
        for _, btn in pairs(tabButtons) do btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30); btn.TextColor3 = Color3.fromRGB(200, 200, 200) end
        content.Visible = true
        b.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
        b.TextColor3 = Color3.fromRGB(15, 15, 20)
    end)
    table.insert(tabButtons, b)
end
addTab("🏠 Home / Main", 100, homeC); addTab("⚡ Veledrom", 145, mainC); addTab("🎯 Combat & ESP", 190, espC); addTab("🎵 Music Hub", 235, musicC); addTab("⚙️ Ayarlar", 280, setC)
if tabButtons[1] then tabButtons[1].BackgroundColor3 = Color3.fromRGB(255, 190, 0); tabButtons[1].TextColor3 = Color3.fromRGB(15, 15, 20) end

-- [V2.2 Gelişmiş Slider Modülü]
local function CreateSlider(pnt, label, min, max, def, cb)
    local f = Instance.new("Frame"); f.Parent = pnt; f.Size = UDim2.new(1, -10, 0, 48); f.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", f); stroke.Color = Color3.fromRGB(35, 35, 45); stroke.Thickness = 1
    
    local lbl = Instance.new("TextLabel"); lbl.Parent = f; lbl.BackgroundTransparency = 1; lbl.Position = UDim2.new(0, 10, 0, 4); lbl.Size = UDim2.new(1, -20, 0, 18)
    lbl.Font = Enum.Font.SourceSansBold; lbl.Text = label..": "..def; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 13; lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local bar = Instance.new("Frame"); bar.Parent = f; bar.Position = UDim2.new(0, 10, 0, 28); bar.Size = UDim2.new(1, -20, 0, 6); bar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 3)
    
    local fill = Instance.new("Frame"); fill.Parent = bar; fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)
    
    local active = false
    local function updateSlider(input)
        local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(p, 0, 1, 0)
        local val = math.floor(min + p * (max - min))
        lbl.Text = label..": "..val
        cb(val)
    end
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then active = true; updateSlider(input) end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then active = false end
    end)
end

-- [BUTON OLUŞTURUCU]
local function CreateBtn(pnt, txt, cb, color)
    local b = Instance.new("TextButton"); b.Parent = pnt; b.Size = UDim2.new(1, -10, 0, 36); b.BackgroundColor3 = color or Color3.fromRGB(30, 30, 38)
    b.Font = Enum.Font.SourceSansBold; b.Text = txt; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextSize = 14; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", b); stroke.Color = color and color:Lerp(Color3.fromRGB(255,255,255), 0.2) or Color3.fromRGB(45, 45, 55); stroke.Thickness = 1
    b.MouseButton1Click:Connect(function() cb(b) end); return b
end

-- GLOBAL DEĞİŞKENLER & DÖNGÜ YÖNETİCİLERİ
local Config = { WalkSpeed = 16, JumpPower = 50, FlySpeed = 50, HitboxSize = 2 }
local State = { Flying = false, InfJump = false, Hitbox = false, ESP = false, Chams = false }

-- [SLIDERS INTEGRATION]
CreateSlider(mainC, "Yürüme Hızı (Speed)", 16, 300, 16, function(v) Config.WalkSpeed = v end)
CreateSlider(mainC, "Zıplama Gücü (Jump)", 50, 300, 50, function(v) Config.JumpPower = v end)
CreateSlider(mainC, "Uçma Hızı (Fly Speed)", 10, 200, 50, function(v) Config.FlySpeed = v end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = Config.WalkSpeed
        if not char.Humanoid.UseJumpPower then char.Humanoid.UseJumpPower = true end
        char.Humanoid.JumpPower = Config.JumpPower
    end
end)

-- [FLY SYSTEM V3]
local flyV, flyG
CreateBtn(mainC, "✈️ Fly (Uçma Sistemi)", function(b)
    State.Flying = not State.Flying
    b.BackgroundColor3 = State.Flying and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38)
    local char = LocalPlayer.Character
    if State.Flying and char and char:FindFirstChild("HumanoidRootPart") then
        flyV = Instance.new("BodyVelocity"); flyV.MaxForce = Vector3.new(math.huge, math.huge, math.huge); flyV.Velocity = Vector3.new(0,0,0); flyV.Parent = char.HumanoidRootPart
        flyG = Instance.new("BodyGyro"); flyG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge); flyG.CFrame = char.HumanoidRootPart.CFrame; flyG.Parent = char.HumanoidRootPart
        task.spawn(function()
            while State.Flying and char and char.Parent and flyV.Parent do
                local dir = char.Humanoid.MoveDirection
                local camCFrame = Camera.CFrame
                local vel = Vector3.new(0,0,0)
                if dir.Magnitude > 0 then vel = camCFrame:VectorToWorldSpace(Vector3.new(dir.X, 0, dir.Z == 0 and 0 or dir.Z)) * Config.FlySpeed end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, Config.FlySpeed, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vel = vel + Vector3.new(0, -Config.FlySpeed, 0) end
                flyV.Velocity = vel
                flyG.CFrame = camCFrame
                task.wait()
            end
        end)
    else
        if flyV then flyV:Destroy() end
        if flyG then flyG:Destroy() end
    end
end)

-- [INFINITY JUMP]
UserInputService.JumpRequest:Connect(function()
    if State.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)
CreateBtn(mainC, "🦘 Infinity Jump (Sonsuz Zıplama)", function(b)
    State.InfJump = not State.InfJump
    b.BackgroundColor3 = State.InfJump and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38)
end)

-- [HITBOX EXPANDER]
CreateSlider(espC, "Hitbox Genişliği", 2, 30, 2, function(v) Config.HitboxSize = v end)
CreateBtn(espC, "🎯 Hitbox Expander", function(b)
    State.Hitbox = not State.Hitbox
    b.BackgroundColor3 = State.Hitbox and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38)
end)

task.spawn(function()
    while task.wait(0.5) do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                if State.Hitbox then
                    hrp.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                    hrp.Transparency = 0.65
                    hrp.Color = Color3.fromRGB(255, 190, 0)
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    hrp.CanCollide = true
                end
            end
        end
    end
end)

-- [ESP & CHAMS MODULE V3]
local function updateESP(p)
    if p == LocalPlayer then return end
    local function setup(char)
        local head = char:WaitForChild("Head", 6)
        if not head then return end
        
        -- Temizleme
        if head:FindFirstChild("TR_ESP") then head.TR_ESP:Destroy() end
        if char:FindFirstChild("TR_Chams") then char.TR_Chams:Destroy() end
        
        -- Name ESP
        local bg = Instance.new("BillboardGui", head); bg.Name = "TR_ESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 120, 0, 24); bg.StudsOffset = Vector3.new(0, 2.5, 0); bg.Enabled = State.ESP
        local tl = Instance.new("TextLabel", bg); tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1,0,1,0); tl.Font = Enum.Font.SourceSansBold; tl.TextColor3 = Color3.fromRGB(255, 255, 255); tl.TextSize = 11; tl.TextStrokeTransparency = 0.3
        
        -- Chams
        local highlight = Instance.new("Highlight", char); highlight.Name = "TR_Chams"; highlight.FillColor = Color3.fromRGB(255, 60, 60); highlight.FillTransparency = 0.4; highlight.OutlineColor = Color3.fromRGB(255, 190, 0); highlight.OutlineTransparency = 0.1; highlight.Enabled = State.Chams
        
        local renderConn
        renderConn = RunService.RenderStepped:Connect(function()
            if not char.Parent or not head.Parent or not bg.Parent then bg:Destroy(); if highlight then highlight:Destroy() end; renderConn:Disconnect(); return end
            bg.Enabled = State.ESP
            highlight.Enabled = State.Chams
            if State.ESP and char:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                tl.Text = string.format("%s [%dm]", p.Name, dist)
            end
        end)
    end
    if p.Character then setup(p.Character) end
    p.CharacterAdded:Connect(setup)
end

Players.PlayerAdded:Connect(updateESP)
for _, p in pairs(Players:GetPlayers()) do updateESP(p) end

CreateBtn(espC, "👁️ Mini Name ESP", function(b)
    State.ESP = not State.ESP
    b.BackgroundColor3 = State.ESP and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38)
end)

CreateBtn(espC, "🎨 Wall Chams (X-Ray Oyuncu)", function(b)
    State.Chams = not State.Chams
    b.BackgroundColor3 = State.Chams and Color3.fromRGB(0, 160, 80) or Color3.fromRGB(30, 30, 38)
end)

-- [GÜVENLİ MÜZİK ALTYAPISI]
local srv = SoundService:FindFirstChild("HubMusicPlayer")
if not srv then
    srv = Instance.new("Sound", SoundService)
    srv.Name = "HubMusicPlayer"
end
srv.Volume = 0.65; srv.Looped = true

CreateBtn(musicC, "🔥 Play Gym Phonk", function() srv.SoundId = "rbxassetid://9043887091"; srv:Play() end)
CreateBtn(musicC, "☕ Play Lofi Chill", function() srv.SoundId = "rbxassetid://9044431773"; srv:Play() end)
CreateBtn(musicC, "🛸 Play Cyber Tension", function() srv.SoundId = "rbxassetid://9047104975"; srv:Play() end)
CreateBtn(musicC, "🛑 Müziği Sustur", function() srv:Stop() end, Color3.fromRGB(150, 40, 40))

-- [SETTINGS / AJAN İŞLERİ]
local fb = false
CreateBtn(setC, "💡 FullBright (Geceyi Sil)", function(b)
    fb = not fb; Lighting.Ambient = fb and Color3.fromRGB(255,255,255) or Color3.fromRGB(127,127,127)
    b.BackgroundColor3 = fb and Color3.fromRGB(0,160,80) or Color3.fromRGB(30, 30, 38)
end)

local boost = false; local mats = {}
CreateBtn(setC, "🚀 Ultra FPS Boost", function(b)
    boost = not boost; b.BackgroundColor3 = boost and Color3.fromRGB(0,160,80) or Color3.fromRGB(30, 30, 38)
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then
        if boost then if not mats[v] then mats[v] = v.Material end; v.Material = Enum.Material.SmoothPlastic else v.Material = mats[v] or Enum.Material.Plastic end
    end end
end)

CreateBtn(setC, "🔗 WhatsApp Grubunu Al", function() if setclipboard then setclipboard("bit.ly/robloxturkiye") end end, Color3.fromRGB(255, 150, 0))

-- LOGO VE MENÜ AÇMA/KAPAMA SÜRÜKLEME ALTYAPISI
local tog = Instance.new("ImageButton", sg); tog.Size = UDim2.new(0, 52, 0, 52); tog.Position = UDim2.new(0.6, 0, 0.02, 0)
tog.Image = "rbxassetid://10723345437"; tog.BackgroundColor3 = Color3.fromRGB(20,20,25)
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 10)
local tStroke = Instance.new("UIStroke", tog); tStroke.Color = Color3.fromRGB(255, 190, 0); tStroke.Thickness = 1.5

tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)
cb.MouseButton1Click:Connect(function() mf.Visible = false end)

local function Drag(f)
    local s, i, sp
    f.InputBegan:Connect(function(inpt) if inpt.UserInputType == Enum.UserInputType.MouseButton1 or inpt.UserInputType == Enum.UserInputType.Touch then s = true; i = inpt.Position; sp = f.Position end end)
    UserInputService.InputChanged:Connect(function(inpt) if s and (inpt.UserInputType == Enum.UserInputType.MouseMovement or inpt.UserInputType == Enum.UserInputType.Touch) then
        local d = inpt.Position - i; f.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end end)
    UserInputService.InputEnded:Connect(function(inpt) if inpt.UserInputType == Enum.UserInputType.MouseButton1 or inpt.UserInputType == Enum.UserInputType.Touch then s = false end end)
end
Drag(mf); Drag(tog)

print("Premium Hub v3.0 Başarıyla Aktif Edildi!")
