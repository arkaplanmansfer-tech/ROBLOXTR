-- =============================================================================
-- ROBLOXTR PREMIUM PANEL (v3.0) - GÜNCEL SÜRÜM
-- Kurucu: Mansfer | Tasarım: v2.2 | Yeni: WhatsApp & Sabit Name ESP
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

-- İÇERİK ALANLARI
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

-- [MAIN]
-- (Speed ve Jump Sliderları buraya eklenebilir, önceki kodla aynı)

-- [ESP SİSTEMİ - GÜNCELLENDİ]
local espEnabled = false
CreateBtn(espC, "👁️ Name ESP (Kesin Çalışan)", function(b)
    espEnabled = not espEnabled
    b.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    
    local function addEsp(plr)
        if plr == LocalPlayer then return end
        local function create()
            if not espEnabled then return end
            local char = plr.Character or plr.CharacterAdded:Wait()
            local head = char:WaitForChild("Head", 10)
            if head and not head:FindFirstChild("TR_ESP") then
                local bg = Instance.new("BillboardGui", head)
                bg.Name = "TR_ESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 200, 0, 50); bg.StudsOffset = Vector3.new(0, 3, 0)
                local tl = Instance.new("TextLabel", bg)
                tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.Font = Enum.Font.SourceSansBold
                tl.TextColor3 = Color3.fromRGB(255, 50, 50); tl.TextSize = 14
                RunService.RenderStepped:Connect(function()
                    if char and char:FindFirstChild("HumanoidRootPart") and tl.Parent then
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                        tl.Text = plr.Name .. " [" .. dist .. "m]"
                    end
                end)
            end
        end
        plr.CharacterAdded:Connect(create)
        create()
    end

    if espEnabled then
        for _, p in pairs(Players:GetPlayers()) do addEsp(p) end
        Players.PlayerAdded:Connect(addEsp)
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("TR_ESP") then
                p.Character.Head.TR_ESP:Destroy()
            end
        end
    end
end)

-- [WHATSAPP BUTONU]
local waBtn = CreateBtn(setC, "🔗 WhatsApp Grubuna Katıl", function()
    setclipboard("bit.ly/robloxturkiye")
    print("Link Kopyalandı!")
end)
waBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
waBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

-- LOGO BUTONU
local tog = Instance.new("ImageButton")
tog.Name = "ToggleButton"; tog.Parent = sg; tog.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tog.Position = UDim2.new(0.60, 0, 0.02, 0); tog.Size = UDim2.new(0, 55, 0, 55)
tog.Image = "rbxassetid://10723345437"
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

print("ROBLOXTR v3.0 Yüklendi! WhatsApp linki Settings kısmında.")
