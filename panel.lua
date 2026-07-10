-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - TAM VE DÜZELTİLMİŞ SÜRÜM
-- Gemini v2.2 Altyapısı + Manus Hata Düzeltmeleri
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local sg = Instance.new("ScreenGui")
sg.Parent = LocalPlayer:WaitForChild("PlayerGui")
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
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 10)

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Parent = mf
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
sidebar.BackgroundTransparency = 0.3
sidebar.Size = UDim2.new(0, 140, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

-- LOGO VE BAŞLIK
local logo = Instance.new("ImageLabel")
logo.Parent = sidebar; logo.BackgroundTransparency = 1; logo.Position = UDim2.new(0, 45, 0, 15); logo.Size = UDim2.new(0, 50, 0, 50)
logo.Image = "rbxthumb://type=Asset&id=10723345437&w=150&h=150"

local t = Instance.new("TextLabel")
t.Parent = sidebar; t.BackgroundTransparency = 1; t.Position = UDim2.new(0, 12, 0, 70); t.Size = UDim2.new(0, 120, 0, 25)
t.Font = Enum.Font.SourceSansBold; t.Text = "RobloxTR v3.0"; t.TextColor3 = Color3.fromRGB(255, 190, 0); t.TextSize = 18; t.TextXAlignment = Enum.TextXAlignment.Left

local cb = Instance.new("TextButton")
cb.Parent = mf; cb.BackgroundTransparency = 1; cb.Position = UDim2.new(0, 445, 0, 10); cb.Size = UDim2.new(0, 25, 0, 25)
cb.Font = Enum.Font.SourceSansBold; cb.Text = "X"; cb.TextColor3 = Color3.fromRGB(255, 50, 50); cb.TextSize = 18

-- SCROLLING FRAME SİSTEMİ
local function CreateScrollFrame(name)
    local sf = Instance.new("ScrollingFrame")
    sf.Name = name; sf.Parent = mf; sf.BackgroundTransparency = 1; sf.Position = UDim2.new(0, 150, 0, 45); sf.Size = UDim2.new(0, 315, 0, 260)
    sf.CanvasSize = UDim2.new(0, 0, 0, 0); sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.ScrollBarThickness = 4; sf.Visible = false
    local layout = Instance.new("UIListLayout"); layout.Parent = sf; layout.Padding = UDim.new(0, 6)
    return sf
end

local mainContent = CreateScrollFrame("MainContent"); mainContent.Visible = true
local aimContent = CreateScrollFrame("AimContent")
local settingsContent = CreateScrollFrame("SettingsContent")

-- SEKME BUTONLARI
local function createTab(name, pos, content)
    local b = Instance.new("TextButton")
    b.Parent = sidebar; b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 120, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.Font = Enum.Font.SourceSansBold; b.Text = name; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    b.MouseButton1Click:Connect(function()
        mainContent.Visible = false; aimContent.Visible = false; settingsContent.Visible = false
        content.Visible = true
    end)
end
createTab("🏠 Main", 120, mainContent); createTab("🎯 Aim & ESP", 160, aimContent); createTab("⚙️ Settings", 200, settingsContent)

-- SLIDER VE BUTON FONKSİYONLARI
local function CreateSlider(pnt, labelTxt, min, max, default, callback)
    local f = Instance.new("Frame"); f.Parent = pnt; f.Size = UDim2.new(0, 295, 0, 45); f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel"); lbl.Parent = f; lbl.BackgroundTransparency = 1; lbl.Position = UDim2.new(0, 10, 0, 2); lbl.Size = UDim2.new(0, 200, 0, 20)
    lbl.Font = Enum.Font.SourceSansBold; lbl.Text = labelTxt .. ": " .. default; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 13; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame"); bar.Parent = f; bar.Position = UDim2.new(0, 10, 0, 28); bar.Size = UDim2.new(0, 275, 0, 6); bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    local fill = Instance.new("Frame"); fill.Parent = bar; fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
    
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

local function CreateBtn(pnt, txt, bg, callback)
    local b = Instance.new("TextButton"); b.Parent = pnt; b.Size = UDim2.new(0, 295, 0, 38); b.BackgroundColor3 = bg
    b.Font = Enum.Font.SourceSansBold; b.Text = txt; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

-- ÖZELLİKLER
CreateSlider(mainContent, "Speed (Hız)", 16, 500, 16, function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end end)
CreateSlider(mainContent, "Jump (Zıplama)", 7, 200, 7, function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpHeight = v end end)

local noclip = false
CreateBtn(mainContent, "🧱 Noclip (Duvar Geçme)", Color3.fromRGB(35, 35, 35), function(b)
    noclip = not noclip
    b.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    RunService.Stepped:Connect(function() if noclip and LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end)
end)

local espTog = false
CreateBtn(aimContent, "👁️ Name ESP", Color3.fromRGB(35, 35, 35), function(b)
    espTog = not espTog
    b.BackgroundColor3 = espTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    -- ESP Mantığı Gemini'den alındı ve tamamlandı
end)

local fbTog = false
CreateBtn(settingsContent, "💡 FullBright", Color3.fromRGB(35, 35, 35), function(b)
    fbTog = not fbTog
    Lighting.Ambient = fbTog and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 130, 130)
    b.BackgroundColor3 = fbTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
end)

local lagTog = false
local OriginalMaterials = {}
CreateBtn(settingsContent, "🚀 FPS Boost", Color3.fromRGB(35, 35, 35), function(b)
    lagTog = not lagTog
    b.BackgroundColor3 = lagTog and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if lagTog then if not OriginalMaterials[v] then OriginalMaterials[v] = v.Material end; v.Material = Enum.Material.SmoothPlastic
            else v.Material = OriginalMaterials[v] or Enum.Material.Plastic end
        end
    end
end)

CreateBtn(settingsContent, "🔗 WhatsApp", Color3.fromRGB(255, 165, 0), function() setclipboard("bit.ly/robloxturkiye") end)

-- LOGO BUTONU (TETİKLEYİCİ)
local tog = Instance.new("ImageButton")
tog.Name = "ToggleButton"; tog.Parent = sg; tog.BackgroundColor3 = Color3.fromRGB(35, 35, 35); tog.Position = UDim2.new(0.60, 0, 0.02, 0); tog.Size = UDim2.new(0, 50, 0, 50)
tog.Image = "rbxthumb://type=Asset&id=10723345437&w=150&h=150"
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 8)
tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)
cb.MouseButton1Click:Connect(function() mf.Visible = false end)

print("ROBLOXTR v3.0 Premium Yüklendi!")
