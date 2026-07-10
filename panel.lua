-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - TAM DONANIMLI SÜRÜM
-- Kurucu: Mansfer | Temel: v2.2 Sağlam Altyapı | Yeni: v3.0 Logo & Pro Özellikler
-- =============================================================================

local sg = Instance.new("ScreenGui")
sg.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Name = "RobloxTR_v3"
sg.ResetOnSpawn = false

local mf = Instance.new("Frame")
mf.Name = "MainFrame"
mf.Parent = sg
mf.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mf.BackgroundTransparency = 0.15
mf.Position = UDim2.new(0.5, -240, 0.5, -160)
mf.Size = UDim2.new(0, 480, 0, 320)
mf.Visible = false
local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 10)
mc.Parent = mf

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Parent = mf
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.BackgroundTransparency = 0.3
sidebar.Size = UDim2.new(0, 140, 1, 0)
local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(0, 10)
sc.Parent = sidebar

local t = Instance.new("TextLabel")
t.Parent = sidebar
t.BackgroundTransparency = 1
t.Position = UDim2.new(0, 12, 0, 15)
t.Size = UDim2.new(0, 120, 0, 25)
t.Font = Enum.Font.SourceSansBold
t.Text = "RobloxTR v3.0"
t.TextColor3 = Color3.fromRGB(255, 190, 0)
t.TextSize = 18
t.TextXAlignment = Enum.TextXAlignment.Left

local st = Instance.new("TextLabel")
st.Parent = sidebar
st.BackgroundTransparency = 1
st.Position = UDim2.new(0, 12, 0, 35)
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

-- İÇERİK ALANLARI
local mainContent = Instance.new("ScrollingFrame")
mainContent.Name = "MainContent"
mainContent.Parent = mf
mainContent.BackgroundTransparency = 1
mainContent.Position = UDim2.new(0, 150, 0, 45)
mainContent.Size = UDim2.new(0, 315, 0, 260)
mainContent.CanvasSize = UDim2.new(0, 0, 1.5, 0)
mainContent.ScrollBarThickness = 2
mainContent.Visible = true

local aimContent = Instance.new("ScrollingFrame")
aimContent.Name = "AimContent"
aimContent.Parent = mf
aimContent.BackgroundTransparency = 1
aimContent.Position = UDim2.new(0, 150, 0, 45)
aimContent.Size = UDim2.new(0, 315, 0, 260)
aimContent.CanvasSize = UDim2.new(0, 0, 1.5, 0)
aimContent.ScrollBarThickness = 2
aimContent.Visible = false

local settingsContent = Instance.new("ScrollingFrame")
settingsContent.Name = "SettingsContent"
settingsContent.Parent = mf
settingsContent.BackgroundTransparency = 1
settingsContent.Position = UDim2.new(0, 150, 0, 45)
settingsContent.Size = UDim2.new(0, 315, 0, 260)
settingsContent.CanvasSize = UDim2.new(0, 0, 1.5, 0)
settingsContent.ScrollBarThickness = 2
settingsContent.Visible = false

local l1 = Instance.new("UIListLayout")
l1.Parent = mainContent; l1.Padding = UDim.new(0, 6)
local l2 = Instance.new("UIListLayout")
l2.Parent = aimContent; l2.Padding = UDim.new(0, 8)
local l3 = Instance.new("UIListLayout")
l3.Parent = settingsContent; l3.Padding = UDim.new(0, 6)

-- SEKME BUTONLARI
local function createSideBtn(name, pos)
    local b = Instance.new("TextButton")
    b.Parent = sidebar
    b.Position = UDim2.new(0, 10, 0, pos)
    b.Size = UDim2.new(0, 120, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Font = Enum.Font.SourceSansBold
    b.Text = name
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    return b
end

local mBtn = createSideBtn("🏠 Main", 75)
local aBtn = createSideBtn("🎯 Aim & ESP", 115)
local sBtn = createSideBtn("⚙️ Settings", 155)

mBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local function switch(activeBtn, activeContent)
    mainContent.Visible = false; aimContent.Visible = false; settingsContent.Visible = false
    mBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); aBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); sBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    activeContent.Visible = true
    activeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end

mBtn.MouseButton1Click:Connect(function() switch(mBtn, mainContent) end)
aBtn.MouseButton1Click:Connect(function() switch(aBtn, aimContent) end)
sBtn.MouseButton1Click:Connect(function() switch(sBtn, settingsContent) end)

-- FONKSİYONLAR
local function CreateBtn(pnt, txt, bg)
    local b = Instance.new("TextButton")
    b.Parent = pnt; b.Size = UDim2.new(0, 295, 0, 38)
    b.BackgroundColor3 = bg; b.Font = Enum.Font.SourceSansBold
    b.Text = txt; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local function CreateSlider(pnt, labelTxt, min, max, default, callback)
    local f = Instance.new("Frame")
    f.Parent = pnt; f.Size = UDim2.new(0, 295, 0, 45); f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = f; lbl.BackgroundTransparency = 1; lbl.Position = UDim2.new(0, 10, 0, 2); lbl.Size = UDim2.new(0, 200, 0, 20)
    lbl.Font = Enum.Font.SourceSansBold; lbl.Text = labelTxt .. ": " .. default; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 13; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame")
    bar.Parent = f; bar.Position = UDim2.new(0, 10, 0, 28); bar.Size = UDim2.new(0, 275, 0, 6); bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    local fill = Instance.new("Frame")
    fill.Parent = bar; fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
    
    local function update(val)
        val = math.clamp(val, min, max)
        lbl.Text = labelTxt .. ": " .. math.floor(val)
        fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
        callback(val)
    end
    
    local active = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            active = true
            local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            update(min + p * (max - min))
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            update(min + p * (max - min))
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then active = false end
    end)
end

-- MAIN ÖZELLİKLERİ
CreateSlider(mainContent, "Speed (Yürüme Hızı)", 16, 500, 16, function(v)
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = v end
end)

CreateSlider(mainContent, "JumpHeight (Zıplama)", 7, 300, 7, function(v)
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.JumpHeight = v end
end)

local noclip = false
local nBtn = CreateBtn(mainContent, "🧱 Noclip (Duvar Geçme) [Kapalı]", Color3.fromRGB(35, 35, 35))
nBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    nBtn.Text = noclip and "🧱 Noclip [Aktif]" or "🧱 Noclip (Duvar Geçme) [Kapalı]"
    nBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    game:GetService("RunService").Stepped:Connect(function()
        if noclip and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- AIM & ESP ÖZELLİKLERİ
local espb = CreateBtn(aimContent, "👁️ Name ESP [Kapalı]", Color3.fromRGB(35, 35, 35))
local chamb = CreateBtn(aimContent, "🌈 Chams (Duvar Arkası) [Kapalı]", Color3.fromRGB(35, 35, 35))

-- SETTINGS ÖZELLİKLERİ
local fb = CreateBtn(settingsContent, "💡 FullBright (Aydınlatma)", Color3.fromRGB(35, 35, 35))
local lb = CreateBtn(settingsContent, "🚀 FPS Boost (Blokları Optimize Et)", Color3.fromRGB(35, 35, 35))

-- LOGO BUTONU (rbxassetid://10723345437)
local tog = Instance.new("ImageButton")
tog.Name = "ToggleButton"
tog.Parent = sg
tog.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tog.BackgroundTransparency = 0.2
tog.Position = UDim2.new(0.60, 0, 0.02, 0)
tog.Size = UDim2.new(0, 50, 0, 50)
tog.Image = "rbxassetid://10723345437"
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", tog)
stroke.Color = Color3.fromRGB(255, 190, 0); stroke.Thickness = 1

tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)
cb.MouseButton1Click:Connect(function() mf.Visible = false end)

-- SÜRÜKLEME SİSTEMİ
local function MakeDraggable(f)
    local s, iPos, sPos
    f.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            s = true; iPos = input.Position; sPos = f.Position
        end
    end)
    f.InputChanged:Connect(function(input)
        if s and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - iPos
            f.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y)
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then s = false end
    end)
end
MakeDraggable(tog); MakeDraggable(mf)

-- FULLBRIGHT & FPS BOOST KODLARI
local fTog = false
fb.MouseButton1Click:Connect(function()
    fTog = not fTog
    game:GetService("Lighting").Brightness = fTog and 2 or 1
    game:GetService("Lighting").ClockTime = fTog and 14 or 12
    fb.BackgroundColor3 = fTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
end)

lb.MouseButton1Click:Connect(function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic end
    end
    lb.Text = "Optimize Edildi!"
    lb.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
end)

print("ROBLOXTR v3.0 Premium Yüklendi!")
