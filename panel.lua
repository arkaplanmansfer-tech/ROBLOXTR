-- =============================================================================
-- ROBLOXTR PREMIUM HUB (v3.4 - ADVANCED TP UPDATE)
-- Kurucu: Mansfer | Sürüm: v3.4 | Yeni: TP Modu (Anında/Süzülerek) Seçeneği
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

-- AVATAR VE STATS (HOME)
local avatar = Instance.new("ImageLabel")
avatar.Parent = sidebar; avatar.Position = UDim2.new(0, 47, 0, 15); avatar.Size = UDim2.new(0, 50, 0, 50); avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

local t = Instance.new("TextLabel")
t.Parent = sidebar; t.BackgroundTransparency = 1; t.Position = UDim2.new(0, 0, 0, 70); t.Size = UDim2.new(1, 0, 0, 20)
t.Font = Enum.Font.SourceSansBold; t.Text = "RobloxTR v3.4"; t.TextColor3 = Color3.fromRGB(255, 190, 0); t.TextSize = 16

local cb = Instance.new("TextButton")
cb.Parent = mf; cb.BackgroundTransparency = 1; cb.Position = UDim2.new(0, 485, 0, 8); cb.Size = UDim2.new(0, 25, 0, 25)
cb.Font = Enum.Font.SourceSansBold; cb.Text = "X"; cb.TextColor3 = Color3.fromRGB(255, 70, 70); cb.TextSize = 18

-- SCROLLING CONTENT AREA
local function CreateScroll(name)
    local sf = Instance.new("ScrollingFrame")
    sf.Name = name; sf.Parent = mf; sf.BackgroundTransparency = 1; sf.Position = UDim2.new(0, 155, 0, 35); sf.Size = UDim2.new(0, 350, 0, 320)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.ScrollBarThickness = 3; sf.Visible = false; sf.BorderSizePixel = 0
    local padding = Instance.new("UIListLayout", sf)
    padding.Padding = UDim.new(0, 8)
    padding.SortOrder = Enum.SortOrder.LayoutOrder
    return sf
end

local homeC = CreateScroll("Home"); homeC.Visible = true
local mainC = CreateScroll("Main"); local espC = CreateScroll("ESP")
local musicC = CreateScroll("Music"); local tpC = CreateScroll("Teleport"); local setC = CreateScroll("Settings")

-- [HOME] STATS
local function addStat(pnt, txt)
    local l = Instance.new("TextLabel"); l.Parent = pnt; l.Size = UDim2.new(1, -10, 0, 32); l.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    l.Font = Enum.Font.SourceSansBold; l.TextColor3 = Color3.fromRGB(220, 220, 220); l.TextSize = 13; Instance.new("UICorner", l).CornerRadius = UDim.new(0, 6)
    return l
end
local fpsL = addStat(homeC, "🚀 FPS: ..."); local pingL = addStat(homeC, "📡 Ping: ...")

RunService.RenderStepped:Connect(function()
    fpsL.Text = "🚀 Sunucu FPS: " .. math.floor(1/RunService.RenderStepped:Wait())
    local ping = "N/A"
    pcall(function() ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    pingL.Text = "📡 Anlık Ping: " .. ping .. " ms"
end)

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
addTab("🎵 Music Hub", 215, musicC); addTab("🌌 Teleport", 255, tpC); addTab("⚙️ Ayarlar", 295, setC)

-- [HELPERS]
local function CreateSlider(pnt, label, min, max, def, cb)
    local f = Instance.new("Frame", pnt); f.Size = UDim2.new(1, -15, 0, 48); f.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", f); lbl.BackgroundTransparency = 1; lbl.Position = UDim2.new(0, 10, 0, 4); lbl.Size = UDim2.new(1, -20, 0, 18)
    lbl.Font = Enum.Font.SourceSansBold; lbl.Text = label..": "..def; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 13
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

local Config = { WalkSpeed = 16, JumpPower = 50, FlySpeed = 50, HitboxSize = 2, TPDuration = 2 }
local State = { Flying = false, InfJump = false, Hitbox = false, ESP = false, Chams = false }

-- [VELEDROM]
CreateSlider(mainC, "Yürüme Hızı", 16, 300, 16, function(v) Config.WalkSpeed = v end)
CreateSlider(mainC, "Zıplama Gücü", 50, 300, 50, function(v) Config.JumpPower = v end)
CreateSlider(mainC, "Uçma Hızı", 10, 240, 50, function(v) Config.FlySpeed = v end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and not State.Flying then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
        LocalPlayer.Character.Humanoid.JumpPower = Config.JumpPower
    end
end)

-- [TOGGLE BUTONU VE SÜRÜKLEME]
local tog = Instance.new("ImageButton", sg)
tog.Size = UDim2.new(0, 52, 0, 52); tog.Position = UDim2.new(0.6, 0, 0.02, 0)
tog.Image = "rbxassetid://10723345437"; tog.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 10)
local tStroke = Instance.new("UIStroke", tog); tStroke.Color = Color3.fromRGB(255, 190, 0); tStroke.Thickness = 1.5

tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)
cb.MouseButton1Click:Connect(function() mf.Visible = false end)

local function Drag(f)
    local dragging, dragStart, startPos
    f.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = f.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

Drag(tog); Drag(mf)
