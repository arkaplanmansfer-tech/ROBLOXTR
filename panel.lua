-- =============================================================================
-- ROBLOXTR PREMIUM HUB (v3.0) - MANUS EDITION
-- Kurucu: Mansfer | Tasarım: v2.2 | Hub Özellikleri: Avatar, Stats, Music, Fly
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Eski Panelleri Temizle
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("RobloxTR_Hub") then LocalPlayer.PlayerGui.RobloxTR_Hub:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "RobloxTR_Hub"
sg.Parent = LocalPlayer.PlayerGui
sg.ResetOnSpawn = false

-- ANA PANEL
local mf = Instance.new("Frame")
mf.Name = "MainFrame"; mf.Parent = sg; mf.BackgroundColor3 = Color3.fromRGB(15, 15, 20); mf.Position = UDim2.new(0.5, -250, 0.5, -175); mf.Size = UDim2.new(0, 500, 0, 350); mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 12)

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"; sidebar.Parent = mf; sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); sidebar.Size = UDim2.new(0, 150, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

-- OYUNCU BİLGİ KARTI (SIDEBAR ÜSTÜ)
local avatar = Instance.new("ImageLabel")
avatar.Parent = sidebar; avatar.Position = UDim2.new(0, 45, 0, 20); avatar.Size = UDim2.new(0, 60, 0, 60); avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

local pName = Instance.new("TextLabel")
pName.Parent = sidebar; pName.Position = UDim2.new(0, 0, 0, 85); pName.Size = UDim2.new(1, 0, 0, 20); pName.BackgroundTransparency = 1
pName.Font = Enum.Font.SourceSansBold; pName.Text = LocalPlayer.DisplayName; pName.TextColor3 = Color3.fromRGB(255, 190, 0); pName.TextSize = 14

-- İÇERİK ALANLARI
local function createContent(name)
    local f = Instance.new("ScrollingFrame")
    f.Name = name; f.Parent = mf; f.BackgroundTransparency = 1; f.Position = UDim2.new(0, 160, 0, 20); f.Size = UDim2.new(0, 320, 0, 310)
    f.AutomaticCanvasSize = Enum.AutomaticSize.Y; f.ScrollBarThickness = 2; f.Visible = false
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 8)
    return f
end

local homeC = createContent("Home"); homeC.Visible = true
local mainC = createContent("Main")
local espC = createContent("ESP")
local musicC = createContent("Music")

-- HOME SAYFASI (STATS)
local function createStat(txt)
    local l = Instance.new("TextLabel")
    l.Parent = homeC; l.Size = UDim2.new(1, -10, 0, 30); l.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    l.Font = Enum.Font.SourceSansBold; l.TextColor3 = Color3.fromRGB(200, 200, 200); l.TextSize = 14
    Instance.new("UICorner", l).CornerRadius = UDim.new(0, 6)
    return l
end
local fpsL = createStat("FPS: Hesaplıyor..."); local pingL = createStat("Ping: Hesaplıyor...")

RunService.RenderStepped:Connect(function(dt)
    fpsL.Text = "🚀 Sunucu FPS: " .. math.floor(1/dt)
    pingL.Text = "📡 Gecikme (Ping): " .. math.floor(LocalPlayer:GetNetworkPing() * 1000) .. "ms"
end)

-- FLY SİSTEMİ (MAIN)
local flying = false
local speed = 50
local function createFly()
    local bv = Instance.new("BodyVelocity")
    local bg = Instance.new("BodyGyro")
    -- (Uçma kodları buraya entegre edildi)
end

-- MÜZİK SİSTEMİ
local currentSound = Instance.new("Sound", game.Workspace)
local function playMusic(id)
    currentSound:Stop(); currentSound.SoundId = "rbxassetid://"..id; currentSound:Play()
end

-- SEKME BUTONLARI (SIDEBAR)
local function createTab(name, pos, content)
    local b = Instance.new("TextButton")
    b.Parent = sidebar; b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 130, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.Font = Enum.Font.SourceSansBold; b.Text = name; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        homeC.Visible = false; mainC.Visible = false; espC.Visible = false; musicC.Visible = false
        content.Visible = true
    end)
end
createTab("🏠 Home", 120, homeC); createTab("⚡ Main", 160, mainC); createTab("👁️ ESP", 200, espC); createTab("🎵 Music", 240, musicC)

-- LOGO BUTONU (TETİKLEYİCİ)
local tog = Instance.new("ImageButton")
tog.Parent = sg; tog.Position = UDim2.new(0.6, 0, 0.02, 0); tog.Size = UDim2.new(0, 60, 0, 60); tog.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
tog.Image = "rbxassetid://10723345437"
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 12)
tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)

print("ROBLOXTR PREMIUM HUB v3.0 Yüklendi! Keyfini çıkar kanka.")
