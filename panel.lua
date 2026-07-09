-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - GERÇEK VE GELİŞMİŞ SÜRÜM (Mobil Uyumlu)
-- =============================================================================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Eski Panelleri PlayerGui Üzerinden Temizleme Altyapısı
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("RobloxTR_PremiumPanel") then
    PlayerGui:FindFirstChild("RobloxTR_PremiumPanel"):Destroy()
end

-- ANA EKRAN (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxTR_PremiumPanel"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- MODERN ANA PANEL ÇERÇEVESİ (Karanlık Tema & Neon Detaylı)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 480, 0, 360)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Panel Kenar Çizgisi (Neon Efekti)
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- ÜST BAŞLIK BAR BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "⚡ ROBLOXTR PREMIUM PANEL v3.0"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- SEKME MENÜSÜ (Sol Panel)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 130, 1, -45)
TabContainer.Position = UDim2.new(0, 0, 0, 45)
TabContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 5)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabContainer

-- İÇERİK ALANI (Sağ Panel)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -140, 1, -55)
ContentContainer.Position = UDim2.new(0, 135, 0, 50)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- SEKMELERİ OLUŞTURMA SİSTEMİ
local tabs = {}
local function createTab(tabName)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -10, 0, 35)
    tabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    tabBtn.Text = tabName
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.Font = Enum.Font.GothamSemibold
    tabBtn.TextSize = 13
    tabBtn.Parent = TabContainer
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = tabBtn
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 2, 0)
    page.ScrollBarThickness = 4
    page.Parent = ContentContainer
    
    local pLayout = Instance.new("UIListLayout")
    pLayout.Padding = UDim.new(0, 8)
    pLayout.Parent = page
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
            t.btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    table.insert(tabs, {btn = tabBtn, page = page})
    return page
end

-- SEKME SAYFALARI
local mainPage = createTab("👤 Oyuncu")
local espPage = createTab("👁️ ESP / Görüş")
local tpPage = createTab("📍 Işınlanma")
local animPage = createTab("🎭 Animasyon")

-- İlk sekmeyi varsayılan olarak aç
tabs[1].page.Visible = true
tabs[1].btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
tabs[1].btn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ÖZELLİK BUTONU EKLEME FONKSİYONU
local function addTrack(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = parent
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- =============================================================================
-- [1. SEKME] OYUNCU ÖZELLİKLERİ
-- =============================================================================
addTrack(mainPage, "Süper Hız Aktif Et (WalkSpeed 75)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 75
    end
end)

addTrack(mainPage, "Süper Zıplama Aktif Et (JumpPower 120)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 120
    end
end)

local noclip = false
addTrack(mainPage, "Duvar İçinden Geçme (Noclip): KAPALI", function(btn)
    noclip = not noclip
    btn.Text = noclip and "Duvar İçinden Geçme (Noclip): AÇIK" or "Duvar İçinden Geçme (Noclip): KAPALI"
    btn.BackgroundColor3 = noclip and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(25, 25, 35)
    
    RunService.Stepped:Connect(function()
        if noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

addTrack(mainPage, "Görünmezlik & Aydınlatma Fullle", function()
    game:GetService("Lighting").Brightness = 2
    game:GetService("Lighting").ClockTime = 14
    game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
    
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 1 end
        end
    end
end)

-- =============================================================================
-- [2. SEKME] GELİŞMİŞ ESP SİSTEMİ
-- =============================================================================
local espEnabled = false
local chamsEnabled = false

local function applyESP(player)
    if player == LocalPlayer then return end
    
    local function createVisuals(char)
        local root = char:WaitForChild("HumanoidRootPart", 5)
        if not root then return end
        
        if espEnabled and not root:FindFirstChild("TR_Esp") then
            local bb = Instance.new("BillboardGui")
            bb.Name = "TR_Esp"
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.AlwaysOnTop = true
            bb.ExtentsOffset = Vector3.new(0, 3, 0)
            bb.Parent = root
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.TextColor3 = Color3.fromRGB(255, 0, 100)
            txt.Font = Enum.Font.GothamBold
            txt.TextSize = 12
            txt.Parent = bb
            
            RunService.RenderStepped:Connect(function()
                if root and root.Parent and txt and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude)
                    txt.Text = player.Name .. "\n[" .. tostring(dist) .. "m]"
                end
            end)
        end
        
        if chamsEnabled and not char:FindFirstChild("TR_Chams") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "TR_Chams"
            highlight.FillColor = Color3.fromRGB(0, 170, 255)
            highlight.FillTransparency = 0.4
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.OutlineTransparency = 0
            highlight.Parent = char
        end
    end
    
    if player.Character then createVisuals(player.Character) end
    player.CharacterAdded:Connect(createVisuals)
end

addTrack(espPage, "Kutulu ESP & Mesafe (Tracks): KAPALI", function(btn)
    espEnabled = not espEnabled
    btn.Text = espEnabled and "Kutulu ESP & Mesafe (Tracks): AÇIK" or "Kutulu ESP & Mesafe (Tracks): KAPALI"
    btn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(25, 25, 35)
    for _, p in pairs(Players:GetPlayers()) do applyESP(p) end
end)

addTrack(espPage, "Duvar Arkası Renkli Görme (Chams): KAPALI", function(btn)
    chamsEnabled = not chamsEnabled
    btn.Text = chamsEnabled and "Duvar Arkası Renkli Görme (Chams): AÇIK" or "Duvar Arkası Renkli Görme (Chams): KAPALI"
        
