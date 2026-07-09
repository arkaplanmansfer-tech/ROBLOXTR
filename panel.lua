-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.1) - MANSUROV & ORİJİNAL GELİŞMİŞ SÜRÜM
-- =============================================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Eski Panelleri PlayerGui Üzerinden Temizle
if PlayerGui:FindFirstChild("RobloxTR_PremiumPanel") then
    PlayerGui:FindFirstChild("RobloxTR_PremiumPanel"):Destroy()
end

-- ANA EKRAN (ResetOnSpawn = false yapılarak ölünce silinmesi engellendi)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxTR_PremiumPanel"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- ARKA PLAN ÇERÇEVESİ (Klasik v2.2 Köşeli Kutu Tasarımı)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 360, 0, 440)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.Visible = true

-- BAŞLIK
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Title.Text = "⚡ ROBLOXTR PREMIUM PANEL v3.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- KAYDIRILABİLİR BUTON LİSTESİ
local ButtonList = Instance.new("ScrollingFrame")
ButtonList.Name = "ButtonList"
ButtonList.Parent = MainFrame
ButtonList.Size = UDim2.new(1, -20, 1, -50)
ButtonList.Position = UDim2.new(0, 10, 0, 45)
ButtonList.BackgroundTransparency = 1
ButtonList.CanvasSize = UDim2.new(0, 0, 3, 0)
ButtonList.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- AYARLANABİLİR SLIDER SİSTEMİ (0-200 Arası Hız ve Zıplama İçin)
local function createSlider(titleText, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = ButtonList
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 2)
    label.BackgroundTransparency = 1
    label.Text = titleText .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -40, 0, 8)
    bar.Position = UDim2.new(0, 20, 0, 28)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    bar.BorderSizePixel = 0
    bar.Parent = sliderFrame
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    fill.BorderSizePixel = 0
    fill.Parent = bar
    
    local trigger = Instance.new("TextButton")
    trigger.Size = UDim2.new(1, 0, 1, 0)
    trigger.BackgroundTransparency = 1
    trigger.Text = ""
    trigger.Parent = bar
    
    local function update(input)
        local percentage = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(percentage, 0, 1, 0)
        local value = math.floor(min + (percentage * (max - min)))
        label.Text = titleText .. ": " .. tostring(value)
        callback(value)
    end
    
    local sliding = false
    trigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            update(input)
        end
    end)
    trigger.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
end

-- NORMAL BUTON OLUŞTURUCU
local function createFeatureButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = ButtonList
    
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- =============================================================================
-- v3.1 YENİ ÖZELLİKLER LİSTESİ
-- =============================================================================

-- 1. ÖZELLİK: WalkSpeed Slider (0-200)
createSlider("👟 Koşu Hızı (WalkSpeed)", 0, 200, 16, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

-- 2. ÖZELLİK: JumpPower Slider (0-200)
createSlider("🦘 Zıplama Gücü (JumpPower)", 0, 200, 50, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
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

-- 4. ÖZELLİK: Full ESP (Name, Chams, Tracks, Mesafe)
local espActive = false
local function applyESP(player)
    if player == LocalPlayer then return end
    local function drawVisuals(char)
        local root = char:WaitForChild("HumanoidRootPart", 5)
        if not root then return end
        if espActive and not root:FindFirstChild("TR_Visuals") then
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

createFeatureButton("👁️ Gelişmiş Görüş (Full ESP & Chams)", function(btn)
    espActive = not espActive
    btn.Text = espActive and "👁️ Gelişmiş Görüş: AÇIK" or "👁️ Gelişmiş Görüş: KAPALI"
    btn.BackgroundColor3 = espActive and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    for _, p in pairs(Players:GetPlayers()) do applyESP(p) end
end)

-- 5. ÖZELLİK: FullBright (Harita Aydınlatma)
local brightActive = false
createFeatureButton("☀️ Harita Aydınlatma (FullBright): KAPALI", function(btn)
    brightActive = not brightActive
    btn.Text = brightActive and "☀️ Harita Aydınlatma (FullBright): AÇIK" or "☀️ Harita Aydınlatma (FullBright): KAPALI"
    btn.BackgroundColor3 = brightActive and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    if brightActive then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    end
end)

-- 6. ÖZELLİK: Mansur'un İstediği FPS Boost Sitemi (Blok Pürüzleştirici)
createFeatureButton("⚙️ FPS Boost (Kasmayı Engelle)", function(btn)
    btn.Text = "FPS Yükseltildi (Pürüzsüz Mod)!"
    btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsA("MeshPart") then
            obj.Material = Enum.Material.SmoothPlastic
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
                
