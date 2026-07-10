-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - EFSANE GERİ DÖNDÜ
-- Kurucu: Mansfer | Tasarım: v2.2 Temalı | Özellikler: v2.5 + v3.0
-- =============================================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Eski Panelleri Temizle
if PlayerGui:FindFirstChild("RobloxTR_v3") then PlayerGui.RobloxTR_v3:Destroy() end

-- ANA EKRAN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxTR_v3"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- GRUP LOGOSU (AÇMA/KAPAMA BUTONU)
local OpenBtn = Instance.new("ImageButton")
OpenBtn.Name = "LogoButton"
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -25)
OpenBtn.Image = "rbxassetid://10723345437"
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.BorderSizePixel = 0
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 10)
LogoCorner.Parent = OpenBtn

-- ANA ÇERÇEVE (v2.2 Siyah-Turuncu Tema)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- SOL MENÜ (Kategoriler)
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame
local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = SideBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "RobloxTR v3.0"
Title.TextColor3 = Color3.fromRGB(255, 165, 0) -- Turuncu
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Parent = SideBar

-- İÇERİK ALANI
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -160, 1, -20)
Container.Position = UDim2.new(0, 155, 0, 10)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- KATEGORİ SİSTEMİ
local function createPage(name)
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
    f.CanvasSize = UDim2.new(0, 0, 2, 0)
    f.ScrollBarThickness = 2
    f.Parent = Container
    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, 10)
    l.Parent = f
    return f
end

local mainPage = createPage("Main")
local espPage = createPage("ESP")
local settingsPage = createPage("Settings")

-- SEKME BUTONLARI
local function createTab(name, page)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, 0)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamSemibold
    b.Parent = SideBar
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = b
    
    b.MouseButton1Click:Connect(function()
        mainPage.Visible = false
        espPage.Visible = false
        settingsPage.Visible = false
        page.Visible = true
    end)
end

createTab("🏠 Main", mainPage)
createTab("👁️ Aim & ESP", espPage)
createTab("⚙️ Settings", settingsPage)
mainPage.Visible = true

-- [MAIN] SLIDER SİSTEMİ (Hız ve Zıplama)
local function createSlider(parent, text, min, max, default, callback)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Parent = parent
    
    local sFrame = Instance.new("Frame")
    sFrame.Size = UDim2.new(1, -10, 0, 10)
    sFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sFrame.Parent = parent
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    fill.BorderSizePixel = 0
    fill.Parent = sFrame
    
    sFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local move = RunService.RenderStepped:Connect(function()
                local pos = math.clamp((UserInputService:GetMouseLocation().X - sFrame.AbsolutePosition.X) / sFrame.AbsoluteSize.X, 0, 1)
                fill.Size = UDim2.new(pos, 0, 1, 0)
                local val = math.floor(min + (max - min) * pos)
                label.Text = text .. ": " .. val
                callback(val)
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then move:Disconnect() end
            end)
        end
    end)
end

createSlider(mainPage, "Speed (Yürüme Hızı)", 16, 200, 50, function(v) LocalPlayer.Character.Humanoid.WalkSpeed = v end)
createSlider(mainPage, "Jump (Zıplama Gücü)", 50, 300, 100, function(v) LocalPlayer.Character.Humanoid.JumpPower = v end)

-- [SETTINGS] FPS BOOST
local function addBtn(parent, text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Parent = parent
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = b
    b.MouseButton1Click:Connect(callback)
end

addBtn(settingsPage, "🚀 FPS Boost (Pürüzsüz Bloklar)", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        end
    end
end)

addBtn(settingsPage, "☀️ FullBright (Aydınlatma)", function()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
end)

-- LOGO BUTONU İŞLEVİ
OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- SÜRÜKLEME SİSTEMİ
local dragging, dragStart, startPos
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
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

print("ROBLOXTR v3.0 YÜKLENDİ! Logo butonuna basarak açabilirsin.")
