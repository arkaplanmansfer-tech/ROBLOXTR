-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - ORİJİNAL TASARIM & TAM ÖZELLİKLİ SÜRÜM
-- =============================================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Paneli Oyuncunun Ekranına Bağla (Mobil Hatalarını Önler)
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Eski Panelleri Temizle
if PlayerGui:FindFirstChild("RobloxTR_PremiumPanel") then
    PlayerGui:FindFirstChild("RobloxTR_PremiumPanel"):Destroy()
end

-- ANA EKRAN (ResetOnSpawn = false yapılarak ölünce silinmesi engellendi)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxTR_PremiumPanel"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- ESKİ v2.2 SÜRÜMÜNÜN ORİJİNAL ARYÜZÜ (Köşeli Klasik Kutu)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 350, 0, 420)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.Visible = true -- İlk açılışta direkt ekrana gelir

-- BAŞLIK
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "ROBLOXTR PREMIUM PANEL v3.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- BUTONLAR İÇİN KAYDIRILABİLİR ALAN
local ButtonList = Instance.new("ScrollingFrame")
ButtonList.Name = "ButtonList"
ButtonList.Parent = MainFrame
ButtonList.Size = UDim2.new(1, -20, 1, -50)
ButtonList.Position = UDim2.new(0, 10, 0, 45)
ButtonList.BackgroundTransparency = 1
ButtonList.CanvasSize = UDim2.new(0, 0, 2.5, 0)
ButtonList.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- TEK TIKLA ÇALIŞAN FONKSİYONEL BUTON SİSTEMİ
local function createFeatureButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = ButtonList
    
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- =============================================================================
-- TÜM ÖZELLİKLER (v2.2 + v2.5 KARIŞIMI TAM LİSTE)
-- =============================================================================

-- 1. ÖZELLİK: Süper Hız
createFeatureButton("⚡ Süper Hız (WalkSpeed 75)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 75
    end
end)

-- 2. ÖZELLİK: Süper Zıplama
createFeatureButton("🚀 Süper Zıplama (JumpPower 120)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 120
    end
end)

-- 3. ÖZELLİK: Duvar İçinden Geçme (Noclip)
local noclip = false
createFeatureButton("🧱 Duvardan Geçme (Noclip): KAPALI", function(btn)
    noclip = not noclip
    btn.Text = noclip and "🧱 Duvardan Geçme (Noclip): AÇIK" or "🧱 Duvardan Geçme (Noclip): KAPALI"
    btn.BackgroundColor3 = noclip and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    
    RunService.Stepped:Connect(function()
        if noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

-- 4. ÖZELLİK: ESP Altyapısı (Tracks, Chams, Mesafe)
local espActive = false
local function applyESP(player)
    if player == LocalPlayer then return end
    local function drawVisuals(char)
        local root = char:WaitForChild("HumanoidRootPart", 5)
        if not root then return end
        
        if espActive and not root:FindFirstChild("TR_Visuals") then
            -- Mesafe ve İsim Etiketi (Tracks)
            local bb = Instance.new("BillboardGui")
            bb.Name = "TR_Visuals"
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.AlwaysOnTop = true
            bb.ExtentsOffset = Vector3.new(0, 3, 0)
            bb.Parent = root
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.TextColor3 = Color3.fromRGB(255, 0, 100)
            txt.Font = Enum.Font.SourceSansBold
            txt.TextSize = 14
            txt.Parent = bb
            
            RunService.RenderStepped:Connect(function()
                if root and root.Parent and txt and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude)
                    txt.Text = player.Name .. " [" .. tostring(distance) .. "m]"
                end
            end)
            
            -- Duvar Arkası Renkli Görme (Chams)
            local highlight = Instance.new("Highlight")
            highlight.Name = "TR_Chams"
            highlight.FillColor = Color3.fromRGB(0, 170, 255)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = char
        end
    end
    if player.Character then drawVisuals(player.Character) end
    player.CharacterAdded:Connect(drawVisuals)
end

createFeatureButton("👁️ Gelişmiş Görüş (ESP & Chams)", function(btn)
    espActive = not espActive
    btn.Text = espActive and "👁️ Gelişmiş Görüş: AÇIK" or "👁️ Gelişmiş Görüş: KAPALI"
    btn.BackgroundColor3 = espActive and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    for _, p in pairs(Players:GetPlayers()) do applyESP(p) end
end)

-- 5. ÖZELLİK: En Yakın Oyuncuya Işınlanma
createFeatureButton("📍 En Yakın Oyuncuya Işınlan (Süreli)", function()
    local target = nil
    local maxDist = math.huge
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < maxDist then target = p; maxDist = dist end
            end
        end
    end
    if target then
        task.wait(0.3) -- Süreli geçiş ayarı
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
    end
end)

-- 6. ÖZELLİK: Geçici Görünmezlik & Aydınlatma
createFeatureButton("🌓 Görünmezlik & Aydınlatma Fullle", function()
    game:GetService("Lighting").Brightness = 2
    game:GetService("Lighting").ClockTime = 14
    game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 1 end
        end
    end
end)

-- 7. ÖZELLİK: Harita Kilitlenmesini Önleyen Optimize Et Butonu
createFeatureButton("⚙️ Sistemi Optimize Et (Lag Engelleyici)", function(btn)
    btn.Text = "Sistem Optimize Edildi!"
    btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    -- Harita kilitlenmesini ve ağır log birikmesini önleyen temizleyici kod
    game:ClearMessageQueue()
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Default
end)

-- 8. ÖZELLİK: WhatsApp Grup Linki Butonu
createFeatureButton("💬 WhatsApp Grubumuza Katıl", function()
    -- Mobil cihazlarda panodan kopyalama sistemi
    setclipboard("https://whatsapp.com")
    print("WhatsApp grup linki panoya kopyalandı!")
end)

-- =============================================================================
-- 3 ÇİZGİ YERİNE ROBLOXTR GRUP LOGOLU DAİRE AÇILIŞ BUTONU
-- =============================================================================
local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "LogoToggleButton"
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 15, 0, 15)
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
OpenButton.Image = "rbxassetid://10723345437" -- Premium Kalkan Logosu

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0) -- Tam pürüzsüz daire yapar
ButtonCorner.Parent = OpenButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(0, 170, 255)
ButtonStroke.Thickness = 2
ButtonStroke.Parent = OpenButton

-- Paneli Açma / Kapatma Mekanizması
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Sürükleme Özelliği
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
