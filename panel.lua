-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - TAM VE ÇALIŞAN SÜRÜM
-- =============================================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Eski Panelleri Temizle
if PlayerGui:FindFirstChild("RobloxTR_PremiumPanel") then
    PlayerGui:FindFirstChild("RobloxTR_PremiumPanel"):Destroy()
end

-- ANA EKRAN (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxTR_PremiumPanel"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- MODERN ANA PANEL ÇERÇEVESİ
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 480, 0, 360)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true -- PANELİ GÖRÜNÜR YAPTIK

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- ÜST BAŞLIK BAR
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

-- SEKME MENÜSÜ
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 130, 1, -45)
TabContainer.Position = UDim2.new(0, 0, 0, 45)
TabContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabContainer

-- İÇERİK ALANI
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -140, 1, -55)
ContentContainer.Position = UDim2.new(0, 135, 0, 50)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- SEKMELERİ OLUŞTURMA
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
    page.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    page.ScrollBarThickness = 4
    page.Parent = ContentContainer
    
    local pLayout = Instance.new("UIListLayout")
    pLayout.Padding = UDim.new(0, 8)
    pLayout.Parent = page
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    end)
    
    table.insert(tabs, {btn = tabBtn, page = page})
    return page
end

local mainPage = createTab("👤 Oyuncu")
local espPage = createTab("👁️ ESP")
local tpPage = createTab("📍 Işınlanma")

tabs[1].page.Visible = true
tabs[1].btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local function addBtn(parent, text, callback)
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
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- OYUNCU ÖZELLİKLERİ
addBtn(mainPage, "Hız (WalkSpeed 75)", function()
    LocalPlayer.Character.Humanoid.WalkSpeed = 75
end)

addBtn(mainPage, "Zıplama (JumpPower 120)", function()
    LocalPlayer.Character.Humanoid.JumpPower = 120
end)

-- IŞINLANMA SİSTEMİ
addBtn(tpPage, "En Yakın Oyuncuya Git", function()
    local closest = nil
    local dist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                dist = d
                closest = p
            end
        end
    end
    if closest then
        LocalPlayer.Character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame
    end
end)

-- SÜRÜKLEME SİSTEMİ (Mobil/PC)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("ROBLOXTR PREMIUM PANEL v3.0 Başarıyla Yüklendi!")
