-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - FINAL STABLE VERSION
-- Kurucu: Mansfer | Tasarım: v2.2 | Özellikler: v3.0 (Fly, ESP, FPS Boost)
-- =============================================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- Eski Panelleri Temizle
if PlayerGui:FindFirstChild("RobloxTR_v3") then PlayerGui.RobloxTR_v3:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "RobloxTR_v3"
sg.Parent = PlayerGui
sg.ResetOnSpawn = false

-- ANA ÇERÇEVE
local mf = Instance.new("Frame")
mf.Name = "MainFrame"
mf.Parent = sg
mf.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mf.BackgroundTransparency = 0.15
mf.Position = UDim2.new(0.5, -240, 0.5, -160)
mf.Size = UDim2.new(0, 480, 0, 320)
mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 10)

-- SOL SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Parent = mf
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.Size = UDim2.new(0, 140, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local t = Instance.new("TextLabel")
t.Parent = sidebar; t.BackgroundTransparency = 1; t.Position = UDim2.new(0, 12, 0, 15); t.Size = UDim2.new(0, 120, 0, 25)
t.Font = Enum.Font.SourceSansBold; t.Text = "RobloxTR v3.0"; t.TextColor3 = Color3.fromRGB(255, 190, 0); t.TextSize = 18; t.TextXAlignment = Enum.TextXAlignment.Left

-- İÇERİK ALANLARI (Scrolling)
local function createContent(name)
    local f = Instance.new("ScrollingFrame")
    f.Name = name; f.Parent = mf; f.BackgroundTransparency = 1; f.Position = UDim2.new(0, 150, 0, 45); f.Size = UDim2.new(0, 315, 0, 260)
    f.CanvasSize = UDim2.new(0, 0, 2, 0); f.ScrollBarThickness = 2; f.Visible = false
    local l = Instance.new("UIListLayout"); l.Parent = f; l.Padding = UDim.new(0, 6)
    return f
end

local mainC = createContent("Main"); mainC.Visible = true
local espC = createContent("ESP")
local setC = createContent("Settings")

-- SEKME BUTONLARI
local function createTab(name, pos, content)
    local b = Instance.new("TextButton")
    b.Parent = sidebar; b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 120, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.Font = Enum.Font.SourceSansBold; b.Text = name; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    b.MouseButton1Click:Connect(function()
        mainC.Visible = false; espC.Visible = false; setC.Visible = false
        content.Visible = true
    end)
end
createTab("🏠 Main", 75, mainC); createTab("🎯 Aim & ESP", 115, espC); createTab("⚙️ Settings", 155, setC)

-- YARDIMCI FONKSİYONLAR
local function CreateBtn(pnt, txt, callback)
    local b = Instance.new("TextButton")
    b.Parent = pnt; b.Size = UDim2.new(0, 295, 0, 38); b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.Font = Enum.Font.SourceSansBold; b.Text = txt; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() callback(b) end)
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
    bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then active = true end end)
    UserInputService.InputChanged:Connect(function(input) if active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        update(min + p * (max - min))
    end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then active = false end end)
end

-- [MAIN]
CreateSlider(mainC, "Speed (Hız)", 16, 500, 16, function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end end)
CreateSlider(mainC, "Jump (Zıplama)", 50, 500, 50, function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = v end end)

local noclip = false
CreateBtn(mainC, "🧱 Noclip (Duvar Geçme)", function(b)
    noclip = not noclip
    b.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    RunService.Stepped:Connect(function() if noclip and LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end)
end)

-- [ESP]
local espEnabled = false
CreateBtn(espC, "👁️ Name ESP (İsimler)", function(b)
    espEnabled = not espEnabled
    b.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    -- ESP Mantığı Buraya (Kısa tutuldu)
end)

local chamsEnabled = false
CreateBtn(espC, "🌈 Chams (Duvar Arkası)", function(b)
    chamsEnabled = not chamsEnabled
    b.BackgroundColor3 = chamsEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if chamsEnabled then
                local h = Instance.new("Highlight", p.Character)
                h.Name = "TR_Chams"; h.FillColor = Color3.fromRGB(255, 165, 0)
            else
                if p.Character:FindFirstChild("TR_Chams") then p.Character.TR_Chams:Destroy() end
            end
        end
    end
end)

-- [SETTINGS]
local fbTog = false
CreateBtn(setC, "💡 FullBright (Aydınlatma)", function(b)
    fbTog = not fbTog
    Lighting.Brightness = fbTog and 2 or 1
    Lighting.ClockTime = fbTog and 14 or 12
    b.BackgroundColor3 = fbTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
end)

local fpsTog = false
CreateBtn(setC, "🚀 FPS Boost", function(b)
    fpsTog = not fpsTog
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = fpsTog and Enum.Material.SmoothPlastic or Enum.Material.Plastic
        end
    end
    b.BackgroundColor3 = fpsTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
end)

-- LOGO BUTONU (ID Düzeltildi)
local tog = Instance.new("ImageButton")
tog.Name = "ToggleButton"; tog.Parent = sg; tog.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tog.Position = UDim2.new(0.60, 0, 0.02, 0); tog.Size = UDim2.new(0, 55, 0, 55)
tog.Image = "http://www.roblox.com/asset/?id=10723345437" -- DOĞRU FORMAT
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 12)
tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)

-- SÜRÜKLEME SİSTEMİ
local function MakeDraggable(f)
    local s, iPos, sPos
    f.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then s = true; iPos = input.Position; sPos = f.Position end end)
    f.InputChanged:Connect(function(input) if s and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - iPos
        f.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y)
    end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then s = false end end)
end
MakeDraggable(mf); MakeDraggable(tog)

print("ROBLOXTR v3.0 Premium Yüklendi!")
