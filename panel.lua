local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Arayüz Oluşturma
local sg = Instance.new("ScreenGui")
sg.Name = "PremiumHubV3"
sg.Parent = LocalPlayer:WaitForChild("PlayerGui")
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mf = Instance.new("Frame")
mf.Name = "MainFrame"
mf.Parent = sg
mf.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mf.BackgroundTransparency = 0.15
mf.Position = UDim2.new(0.25, 0, 0.2, 0)
mf.Size = UDim2.new(0, 480, 0, 320)
mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 10)

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Parent = mf
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.BackgroundTransparency = 0.3
sidebar.Size = UDim2.new(0, 140, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

-- Logo (Üst Kısım)
local logo = Instance.new("ImageLabel")
logo.Parent = sidebar
logo.BackgroundTransparency = 1
logo.Position = UDim2.new(0, 45, 0, 15)
logo.Size = UDim2.new(0, 50, 0, 50)
logo.Image = "rbxassetid://10723345437"

local t = Instance.new("TextLabel")
t.Parent = sidebar
t.BackgroundTransparency = 1
t.Position = UDim2.new(0, 12, 0, 70)
t.Size = UDim2.new(0, 120, 0, 25)
t.Font = Enum.Font.SourceSansBold
t.Text = "Premium Hub v3"
t.TextColor3 = Color3.fromRGB(255, 190, 0)
t.TextSize = 17
t.TextXAlignment = Enum.TextXAlignment.Left

local st = Instance.new("TextLabel")
st.Parent = sidebar
st.BackgroundTransparency = 1
st.Position = UDim2.new(0, 12, 0, 90)
st.Size = UDim2.new(0, 120, 0, 15)
st.Font = Enum.Font.SourceSans
st.Text = "Kurucu: Mansfer"
st.TextColor3 = Color3.fromRGB(150, 150, 150)
st.TextSize = 12
st.TextXAlignment = Enum.TextXAlignment.Left

local cb = Instance.new("TextButton")
cb.Parent = mf
cb.BackgroundTransparency = 1
cb.Position = UDim2.new(0, 445, 0, 10)
cb.Size = UDim2.new(0, 25, 0, 25)
cb.Font = Enum.Font.SourceSansBold
cb.Text = "X"
cb.TextColor3 = Color3.fromRGB(255, 50, 50)
cb.TextSize = 18

-- ScrollFrame Fonksiyonu (Taşmaları Engeller)
local function CreateScrollFrame(name)
    local sf = Instance.new("ScrollingFrame")
    sf.Name = name
    sf.Parent = mf
    sf.BackgroundTransparency = 1
    sf.Position = UDim2.new(0, 150, 0, 45)
    sf.Size = UDim2.new(0, 315, 0, 260)
    sf.CanvasSize = UDim2.new(0, 0, 0, 0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.ScrollBarThickness = 4
    sf.BorderSizePixel = 0
    sf.Visible = false
    local layout = Instance.new("UIListLayout")
    layout.Parent = sf
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    return sf
end

local mainContent = CreateScrollFrame("MainContent")
mainContent.Visible = true
local aimContent = CreateScrollFrame("AimContent")
local settingsContent = CreateScrollFrame("SettingsContent")

-- Sidebar Butonları
local mBtn = Instance.new("TextButton")
mBtn.Parent = sidebar; mBtn.Position = UDim2.new(0, 10, 0, 120); mBtn.Size = UDim2.new(0, 120, 0, 30); mBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); mBtn.Font = Enum.Font.SourceSansBold; mBtn.Text = "🏠 Main"; mBtn.TextColor3 = Color3.fromRGB(255, 255, 255); mBtn.TextSize = 13; Instance.new("UICorner", mBtn).CornerRadius = UDim.new(0, 5)

local aBtn = Instance.new("TextButton")
aBtn.Parent = sidebar; aBtn.Position = UDim2.new(0, 10, 0, 160); aBtn.Size = UDim2.new(0, 120, 0, 30); aBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); aBtn.Font = Enum.Font.SourceSansBold; aBtn.Text = "🎯 Aim & ESP"; aBtn.TextColor3 = Color3.fromRGB(200, 200, 200); aBtn.TextSize = 13; Instance.new("UICorner", aBtn).CornerRadius = UDim.new(0, 5)

local sBtn = Instance.new("TextButton")
sBtn.Parent = sidebar; sBtn.Position = UDim2.new(0, 10, 0, 200); sBtn.Size = UDim2.new(0, 120, 0, 30); sBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); sBtn.Font = Enum.Font.SourceSansBold; sBtn.Text = "⚙️ Settings"; sBtn.TextColor3 = Color3.fromRGB(200, 200, 200); sBtn.TextSize = 13; Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 5)

mBtn.MouseButton1Click:Connect(function() mainContent.Visible = true; aimContent.Visible = false; settingsContent.Visible = false; mBtn.BackgroundColor3 = Color3.fromRGB(45,45,45); aBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); sBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) end)
aBtn.MouseButton1Click:Connect(function() mainContent.Visible = false; aimContent.Visible = true; settingsContent.Visible = false; mBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); aBtn.BackgroundColor3 = Color3.fromRGB(45,45,45); sBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) end)
sBtn.MouseButton1Click:Connect(function() mainContent.Visible = false; aimContent.Visible = false; settingsContent.Visible = true; mBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); aBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); sBtn.BackgroundColor3 = Color3.fromRGB(45,45,45) end)

-- İstatistik Paneli (Avatar, Ping, FPS)
local statsFrame = Instance.new("Frame", mainContent)
statsFrame.Size = UDim2.new(0, 295, 0, 65)
statsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 6)

local avatarImg = Instance.new("ImageLabel", statsFrame)
avatarImg.Size = UDim2.new(0, 50, 0, 50)
avatarImg.Position = UDim2.new(0, 10, 0, 7)
avatarImg.BackgroundTransparency = 1
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)

local nameLbl = Instance.new("TextLabel", statsFrame)
nameLbl.BackgroundTransparency = 1; nameLbl.Position = UDim2.new(0, 70, 0, 5); nameLbl.Size = UDim2.new(0, 200, 0, 15); nameLbl.Font = Enum.Font.SourceSansBold; nameLbl.Text = LocalPlayer.Name; nameLbl.TextColor3 = Color3.fromRGB(255, 190, 0); nameLbl.TextSize = 15; nameLbl.TextXAlignment = Enum.TextXAlignment.Left

local statsLbl = Instance.new("TextLabel", statsFrame)
statsLbl.BackgroundTransparency = 1; statsLbl.Position = UDim2.new(0, 70, 0, 25); statsLbl.Size = UDim2.new(0, 200, 0, 30); statsLbl.Font = Enum.Font.SourceSans; statsLbl.Text = "FPS: -- | Ping: --\nSüre: --"; statsLbl.TextColor3 = Color3.fromRGB(200, 200, 200); statsLbl.TextSize = 13; statsLbl.TextXAlignment = Enum.TextXAlignment.Left; statsLbl.TextYAlignment = Enum.TextYAlignment.Top

local lastUpdate = tick()
local frames = 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - lastUpdate >= 1 then
        local ping = "N/A"
        pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        local timeSec = math.floor(workspace.DistributedGameTime)
        local mins = math.floor(timeSec / 60)
        local secs = timeSec % 60
        statsLbl.Text = string.format("FPS: %d | Ping: %s ms\nSunucu Süresi: %02d:%02d", frames, tostring(ping), mins, secs)
        frames = 0
        lastUpdate = tick()
    end
end)

-- Bileşen Oluşturma Fonksiyonları
local function CreateBtn(pnt, txt, bg)
    local b = Instance.new("TextButton", pnt)
    b.Size = UDim2.new(0, 295, 0, 38)
    b.BackgroundColor3 = bg
    b.Font = Enum.Font.SourceSansBold
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local function CreateSlider(pnt, labelTxt, min, max, default, callback)
    local f = Instance.new("Frame", pnt)
    f.Size = UDim2.new(0, 295, 0, 45)
    f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", f)
    lbl.BackgroundTransparency = 1; lbl.Position = UDim2.new(0, 10, 0, 2); lbl.Size = UDim2.new(0, 200, 0, 20); lbl.Font = Enum.Font.SourceSansBold; lbl.Text = labelTxt .. ": " .. default; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 13; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local box = Instance.new("TextBox", f)
    box.Position = UDim2.new(0, 240, 0, 4); box.Size = UDim2.new(0, 45, 0, 18); box.BackgroundColor3 = Color3.fromRGB(20, 20, 20); box.Font = Enum.Font.SourceSansBold; box.Text = tostring(default); box.TextColor3 = Color3.fromRGB(255, 190, 0); box.TextSize = 12; Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    local bar = Instance.new("Frame", f)
    bar.Position = UDim2.new(0, 10, 0, 28); bar.Size = UDim2.new(0, 275, 0, 6); bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50); Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 3)
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 190, 0); Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)
    
    local function update(val)
        val = math.clamp(val, min, max)
        lbl.Text = labelTxt .. ": " .. math.floor(val)
        box.Text = tostring(math.floor(val))
        fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
        callback(val)
    end
    box.FocusLost:Connect(function() local num = tonumber(box.Text); if num then update(num) else update(min) end end)
    local active = false
    bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then active = true; local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1); update(min + p * (max - min)) end end)
    UserInputService.InputChanged:Connect(function(input) if active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1); update(min + p * (max - min)) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then active = false end end)
end

-- Temel Özellikler
CreateSlider(mainContent, "Speed (Yurume Hizi)", 16, 500, 16, function(v) local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid"); if hum then hum.WalkSpeed = v end end)
CreateSlider(mainContent, "JumpHeight (Ziplama Yuksekligi)", 7, 200, 7, function(v) local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid"); if hum then if hum.UseJumpPower then hum.UseJumpPower = false end; hum.JumpHeight = v end end)

local flyBtn = CreateBtn(mainContent, "✈️ Fly (Uçma) [Kapali]", Color3.fromRGB(35, 35, 35))
local tb = CreateBtn(mainContent, "📍 Koordinat Kaydet / TP Yap", Color3.fromRGB(35, 35, 35))

local aimb = CreateBtn(aimContent, "🎯 Aim Bot (Otomatik Nisan) [Kapali]", Color3.fromRGB(35, 35, 35))
local espb = CreateBtn(aimContent, "👁️ Name ESP (Isimleri Goster) [Kapali]", Color3.fromRGB(35, 35, 35))

-- Müzik Sistemi (Settings)
local musicLbl = Instance.new("TextLabel", settingsContent)
musicLbl.Size = UDim2.new(0, 295, 0, 20); musicLbl.BackgroundTransparency = 1; musicLbl.Text = "🎵 Müzik Çalar"; musicLbl.TextColor3 = Color3.fromRGB(255, 190, 0); musicLbl.Font = Enum.Font.SourceSansBold; musicLbl.TextSize = 14

local mPlay = Instance.new("Sound", game:GetService("SoundService"))
mPlay.Volume = 1; mPlay.Looped = true

local phonkBtn = CreateBtn(settingsContent, "🔊 Çal: Phonk", Color3.fromRGB(35, 35, 35))
local chillBtn = CreateBtn(settingsContent, "🔊 Çal: Chill", Color3.fromRGB(35, 35, 35))
local tensionBtn = CreateBtn(settingsContent, "🔊 Çal: Tension", Color3.fromRGB(35, 35, 35))
local stopBtn = CreateBtn(settingsContent, "⏹️ Müziği Durdur", Color3.fromRGB(150, 50, 50))

phonkBtn.MouseButton1Click:Connect(function() mPlay.SoundId = "rbxassetid://6092040445"; mPlay:Play() end)
chillBtn.MouseButton1Click:Connect(function() mPlay.SoundId = "rbxassetid://1837879082"; mPlay:Play() end)
tensionBtn.MouseButton1Click:Connect(function() mPlay.SoundId = "rbxassetid://1843460628"; mPlay:Play() end)
stopBtn.MouseButton1Click:Connect(function() mPlay:Stop() end)

local fb = CreateBtn(settingsContent, "💡 FullBright (Haritayi Aydınlat)", Color3.fromRGB(35, 35, 35))
local noclipCamBtn = CreateBtn(settingsContent, "🎥 Camera X-Ray (Duvar İçi Görüş)", Color3.fromRGB(35, 35, 35))
local lb = CreateBtn(settingsContent, "📱 FPS Boost / Lag Fix", Color3.fromRGB(35, 35, 35))
local wpb = CreateBtn(settingsContent, "🔗 WhatsApp Grubunu Kopyala", Color3.fromRGB(255, 190, 0))
wpb.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Toggle ve Sürükleme Sistemi
local tog = Instance.new("TextButton", sg)
tog.BackgroundColor3 = Color3.fromRGB(35, 35, 35); tog.BackgroundTransparency = 0.2; tog.Position = UDim2.new(0.60, 0, 0.02, 0); tog.Size = UDim2.new(0, 100, 0, 35); tog.Font = Enum.Font.SourceSansBold; tog.Text = "Premium Hub"; tog.TextColor3 = Color3.fromRGB(255, 190, 0); tog.TextSize = 15; Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", tog); stroke.Color = Color3.fromRGB(255, 190, 0); stroke.Thickness = 1

tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)
cb.MouseButton1Click:Connect(function() mf.Visible = false end)

local function MakeDraggable(f)
    local s, iPos, sPos
    f.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then s = true; iPos = input.Position; sPos = f.Position; input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then s = false end end) end end)
    f.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then if s then local delta = input.Position - iPos; f.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y) end end end)
end
MakeDraggable(tog); MakeDraggable(mf)

-- TP Sistemi
local sX, sY, sZ = 0, 0, 0; local saved = false
tb.MouseButton1Click:Connect(function()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        if not saved then
            local pos = root.Position; sX, sY, sZ = pos.X, pos.Y, pos.Z; saved = true
            tb.Text = "Konuma Isinlanmak Icin Bas"; tb.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        else
            task.wait(0.5); root.CFrame = CFrame.new(sX, sY, sZ); saved = false
            tb.Text = "Koordinat Kaydet / TP Yap"; tb.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end
    end
end)

-- Fly (Uçma) Sistemi
local flyTog = false; local flyBody = nil
flyBtn.MouseButton1Click:Connect(function()
    flyTog = not flyTog
    flyBtn.Text = flyTog and "✈️ Fly [Aktif]" or "✈️ Fly (Uçma) [Kapali]"
    flyBtn.BackgroundColor3 = flyTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    local char = LocalPlayer.Character
    if flyTog and char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        flyBody = Instance.new("BodyVelocity")
        flyBody.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyBody.Velocity = Vector3.new(0, 0, 0)
        flyBody.Parent = root
        
        spawn(function()
            while flyTog and char and char.Parent do
                if flyBody and flyBody.Parent then
                    local moveDir = char.Humanoid.MoveDirection
                    flyBody.Velocity = moveDir * 50
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then flyBody.Velocity = flyBody.Velocity + Vector3.new(0, 50, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then flyBody.Velocity = flyBody.Velocity + Vector3.new(0, -50, 0) end
                end
                task.wait()
            end
        end)
    else
        if flyBody then flyBody:Destroy(); flyBody = nil end
    end
end)

-- Fullbright & X-Ray Cam
local fTog = false
fb.MouseButton1Click:Connect(function()
    fTog = not fTog
    Lighting.Ambient = fTog and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 130, 130)
    fb.Text = fTog and "FullBright Aktif" or "💡 FullBright (Haritayi Aydinlat)"
    fb.BackgroundColor3 = fTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
end)

local camTog = false
noclipCamBtn.MouseButton1Click:Connect(function()
    camTog = not camTog
    LocalPlayer.DevCameraOcclusionMode = camTog and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom
    noclipCamBtn.Text = camTog and "🎥 Camera X-Ray [Aktif]" or "🎥 Camera X-Ray (Duvar İçi Görüş)"
    noclipCamBtn.BackgroundColor3 = camTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
end)

-- FPS Boost
local lagTog = false; local OriginalMaterials = {}
lb.MouseButton1Click:Connect(function()
    lagTog = not lagTog
    lb.Text = lagTog and "📱 FPS Boost [Aktif]" or "📱 FPS Boost / Lag Fix"
    lb.BackgroundColor3 = lagTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if lagTog then
                if not OriginalMaterials[v] then OriginalMaterials[v] = v.Material end
                v.Material = Enum.Material.SmoothPlastic
            else
                if OriginalMaterials[v] then v.Material = OriginalMaterials[v] else v.Material = Enum.Material.Plastic end
            end
        end
    end
end)

wpb.MouseButton1Click:Connect(function() if setclipboard then setclipboard("bit.ly/robloxturkiye") end end)

-- Aim Bot
local aimTog = false; local aimConn
aimb.MouseButton1Click:Connect(function()
    aimTog = not aimTog
    aimb.Text = aimTog and "🎯 Aim Bot [Aktif]" or "🎯 Aim Bot (Otomatik Nisan) [Kapali]"
    aimb.BackgroundColor3 = aimTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    if aimTog then
        aimConn = RunService.RenderStepped:Connect(function()
            local target = nil; local maxDist = math.huge
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    if dist < maxDist then maxDist = dist; target = plr.Character.HumanoidRootPart end
                end
            end
            if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
        end)
    else
        if aimConn then aimConn:Disconnect() end
    end
end)

-- Gelişmiş Güvenli ESP
local espTog = false; local espConns = {}
espb.MouseButton1Click:Connect(function()
    espTog = not espTog
    espb.Text = espTog and "👁️ Name ESP [Aktif]" or "👁️ Name ESP (Isimleri Goster) [Kapali]"
    espb.BackgroundColor3 = espTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    
    local function addEsp(plr)
        if plr == LocalPlayer then return end
        local function create(char)
            if not espTog then return end
            local head = char:WaitForChild("Head", 5)
            if not head then return end
            if head:FindFirstChild("TR_ESP") then head.TR_ESP:Destroy() end
            
            local bb = Instance.new("BillboardGui")
            bb.Name = "TR_ESP"; bb.AlwaysOnTop = true; bb.Size = UDim2.new(0, 200, 0, 50); bb.StudsOffset = Vector3.new(0, 3, 0); bb.Parent = head
            local tl = Instance.new("TextLabel", bb)
            tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.Font = Enum.Font.SourceSansBold; tl.TextColor3 = Color3.fromR
