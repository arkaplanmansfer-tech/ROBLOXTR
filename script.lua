-- ROBLOXTR PREMIUM PANEL (v1.0) - Optimised & Compressed
local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Eski Panelleri Temizle
if CoreGui:FindFirstChild("RobloxTR_PremiumPanel") then CoreGui["RobloxTR_PremiumPanel"]:Destroy() end

-- Ana Ekran (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxTR_PremiumPanel"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- 🔵 ÖZEL GRUP LOGOLU AÇILIŞ BUTONU (Daire Şeklinde)
local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "LogoToggleButton"
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 65, 0, 65)
OpenButton.Position = UDim2.new(0, 20, 0, 150)
OpenButton.Image = "rbxassetid://95571728354389" -- Senin Grubunun Orijinal Logosu!
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
OpenButton.BorderSizePixel = 0

local UICornerLogo = Instance.new("UICorner")
UICornerLogo.CornerRadius = UDim.new(1, 0)
UICornerLogo.Parent = OpenButton

-- 📱 ANA PANEL ÇERÇEVESİ
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 580, 0, 340)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local UICornerPanel = Instance.new("UICorner")
UICornerPanel.CornerRadius = UDim.new(0, 12)
UICornerPanel.Parent = MainFrame

-- Üst Başlık Çubuğu
local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
TitleBar.Text = "ANIMASYONLAR VE GELISTIRILMIS AYARLAR"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 15
TitleBar.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 12)
UICornerTitle.Parent = TitleBar

-- Kapatma Menüsü Tuşu (X)
local CloseX = Instance.new("TextButton")
CloseX.Size = UDim2.new(0, 35, 0, 30)
CloseX.Position = UDim2.new(1, -45, 0, 5)
CloseX.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseX.Text = "X"
CloseX.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseX.Font = Enum.Font.GothamBold
CloseX.TextSize = 14
CloseX.Parent = MainFrame
local UICornerX = Instance.new("UICorner")
UICornerX.CornerRadius = UDim.new(0, 6)
UICornerX.Parent = CloseX
CloseX.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- Alt Menü Sekme Çubuğu (Tabs)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.Position = UDim2.new(0, 0, 1, -40)
TabBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
TabBar.Parent = MainFrame

-- 📂 SAYFALARI OLUŞTURMA (Container)
local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, 0, 1, -80)
PageContainer.Position = UDim2.new(0, 0, 0, 40)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = MainFrame

local Pages = {}
local function createPage(name)
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, -20, 1, -20)
    f.Position = UDim2.new(0, 10, 0, 10)
    f.BackgroundTransparency = 1
    f.CanvasSize = UDim2.new(0, 0, 2, 0)
    f.ScrollBarThickness = 4
    f.Visible = false
    f.Parent = PageContainer
    local layout = Instance.new("UIListLayout")
    layout.Parent = f
    layout.Padding = UDim.new(0, 8)
    Pages[name] = f
    return f
end

local animPage = createPage("Animasyonlar")
local flyPage = createPage("Uçuş & TP")
local espPage = createPage("ESP Menü")
Pages["Animasyonlar"].Visible = true

-- 📑 Sekme Değiştirme Buton Fonksiyonu
local function addTabButton(text, targetPage, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.3, 0, 1, 0)
    btn.Position = UDim2.new(posX, 0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text:upper()
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = TabBar
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        targetPage.Visible = true
    end)
end
addTabButton("Animasyonlar", animPage, 0.02)
addTabButton("Uçuş & TP", flyPage, 0.35)
addTabButton("ESP Ayarları", espPage, 0.68)

-- 🖱️ SÜRÜKLENEBİLİR (DRAG) YAPMA FONKSİYONU
local function makeDraggable(frame, target)
    target = target or frame
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = target.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(TitleBar, MainFrame)
makeDraggable(OpenButton)

OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==========================================
-- 🕺 1. SEKME: 10'LU POPÜLER ANİMASYONLAR MENÜSÜ
-- ==========================================
local function playEmote(id)
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://"..id
        local track = hum:LoadAnimation(anim)
        track:Play()
    end
end

local emotes = {
    {name = "Twerk (Eğlence)", id = "4090534224"},
    {name = "Gölge Boksu (Shadow Boxing)", id = "14884033325"},
    {name = "Parande / Arka Takla", id = "251010640"},
    {name = "Zombi Yürüyüşü", id = "616159670"},
    {name = "Ninja Koşusu", id = "656118341"},
    {name = "Askeri Selam Durma", id = "3338399557"},
    {name = "Yere Yatıp Şınav Çekme", id = "4682417215"},
    {name = "Çılgın Hip-Hop Dansı", id = "507771019"},
    {name = "Süper Kahraman İnişi", id = "10920935574"},
    {name = "Breakdance Şov", id = "507772626"}
}

for _, emo in ipairs(emotes) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    b.Text = emo.name
    b.TextColor3 = Color3.fromRGB(230, 230, 230)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.Parent = animPage
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = b
    b.MouseButton1Click:Connect(function() playEmote(emo.id) end)
end

-- ==========================================
-- ✈️ 2. SEKME: GELİŞMİŞ UÇUŞ (FLY) VE SÜRELİ TP
-- ==========================================
local flySpeed = 50
local flying = false
local flyConnection

-- Uçuş Durumu Ekranda Anlık Bilgi Paneli (Resimdeki gibi)
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 0, 45)
StatusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
StatusLabel.Text = "UCUS DURUMU: GROUNDED\nHIZ: 50 | TAKVIYE: KAPALI"
StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextSize = 12
StatusLabel.Parent = flyPage

local function toggleFly()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    flying = not flying
    if flying then
        StatusLabel.Text = "UCUS DURUMU: FLYING\nHIZ: "..flySpeed.." | TAKVIYE: AKTIF"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        local bg = Instance.new("BodyGyro", root) bg.P = 9e4 bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) bg.cframe = root.CFrame
        local bv = Instance.new("BodyVelocity", root) bv.velocity = Vector3.new(0,0.1,0) bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        flyConnection = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            local velocity = Vector3.new(0,0,0)
            -- Basit yön takibi (Delta mobil buton uyumlu)
            bv.velocity = cam.CFrame.LookVector * flySpeed
            bg.cframe = cam.CFrame
        end)
    else
        StatusLabel.Text = "UCUS DURUMU: GROUNDED\nHIZ: "..flySpeed.." | TAKVIYE: KAPALI"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
        if flyConnection then flyConnection:Disconnect() end
        if root:FindFirstChild("BodyGyro") then root.BodyGyro:Destroy() end
        if root:FindFirstChild("BodyVelocity") then root.BodyVelocity:Destroy() end
    end
end

local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(1, -10, 0, 35)
FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
FlyBtn.Text = "UÇUŞU AÇ / KAPAT (FLY)"
FlyBtn.TextColor3 = Color3.fromRGB(255,255,255)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.Parent = flyPage
local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = FlyBtn
FlyBtn.MouseButton1Click:Connect(toggleFly)

-- Süreli TP Arayüzü (Metin Giriş Kutusu)
local TimeInput = Instance.new("TextBox")
TimeInput.Size = UDim2.new(1, -10, 0, 35)
TimeInput.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TimeInput.PlaceholderText = "Süreli TP Aralığı Yazın (Saniye Örn: 0.5)"
TimeInput.Text = "1"
TimeInput.TextColor3 = Color3.fromRGB(255,255,255)
TimeInput.Font = Enum.Font.Gotham
