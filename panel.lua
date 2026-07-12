-- =============================================================================
-- ROBLOXTR PREMIUM HUB (v3.0) - FULL EDITION
-- Kurucu: Mansfer | Tasarım: v2.2 | Özellikler: Fly, ESP, Music, Stats, FPS Boost
-- =============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- ESKİ PANELİ TEMİZLE
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("RobloxTR_Hub") then LocalPlayer.PlayerGui.RobloxTR_Hub:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "RobloxTR_Hub"; sg.Parent = LocalPlayer.PlayerGui; sg.ResetOnSpawn = false

-- ANA PANEL ÇERÇEVESİ
local mf = Instance.new("Frame")
mf.Name = "MainFrame"; mf.Parent = sg; mf.BackgroundColor3 = Color3.fromRGB(15, 15, 20); mf.BackgroundTransparency = 0.1
mf.Position = UDim2.new(0.5, -240, 0.5, -160); mf.Size = UDim2.new(0, 480, 0, 320); mf.Visible = false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 12)

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"; sidebar.Parent = mf; sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); sidebar.Size = UDim2.new(0, 140, 1, 0)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

-- AVATAR VE STATS (HOME)
local avatar = Instance.new("ImageLabel")
avatar.Parent = sidebar; avatar.Position = UDim2.new(0, 45, 0, 15); avatar.Size = UDim2.new(0, 50, 0, 50); avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

local t = Instance.new("TextLabel")
t.Parent = sidebar; t.BackgroundTransparency = 1; t.Position = UDim2.new(0, 0, 0, 70); t.Size = UDim2.new(1, 0, 0, 20)
t.Font = Enum.Font.SourceSansBold; t.Text = "RobloxTR v3.0"; t.TextColor3 = Color3.fromRGB(255, 190, 0); t.TextSize = 16

-- SCROLLING CONTENT AREA
local function CreateScroll(name)
    local sf = Instance.new("ScrollingFrame")
    sf.Name = name; sf.Parent = mf; sf.BackgroundTransparency = 1; sf.Position = UDim2.new(0, 150, 0, 20); sf.Size = UDim2.new(0, 315, 0, 280)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.ScrollBarThickness = 2; sf.Visible = false
    Instance.new("UIListLayout", sf).Padding = UDim.new(0, 8)
    return sf
end

local homeC = CreateScroll("Home"); homeC.Visible = true
local mainC = CreateScroll("Main")
local espC = CreateScroll("ESP")
local musicC = CreateScroll("Music")
local setC = CreateScroll("Settings")

-- [HOME] STATS
local function addStat(pnt, txt)
    local l = Instance.new("TextLabel"); l.Parent = pnt; l.Size = UDim2.new(1, -10, 0, 30); l.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    l.Font = Enum.Font.SourceSansBold; l.TextColor3 = Color3.fromRGB(200, 200, 200); l.TextSize = 13; Instance.new("UICorner", l).CornerRadius = UDim.new(0, 6)
    return l
end
local fpsL = addStat(homeC, "FPS: ..."); local pingL = addStat(homeC, "Ping: ...")
RunService.RenderStepped:Connect(function(dt)
    fpsL.Text = "🚀 FPS: " .. math.floor(1/dt)
    pingL.Text = "📡 Ping: " .. math.floor(LocalPlayer:GetNetworkPing() * 1000) .. "ms"
end)

-- [TAB BUTTONS]
local function addTab(name, pos, content)
    local b = Instance.new("TextButton"); b.Parent = sidebar; b.Position = UDim2.new(0, 10, 0, pos); b.Size = UDim2.new(0, 120, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35); b.Font = Enum.Font.SourceSansBold; b.Text = name; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        for _, v in pairs(mf:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
        content.Visible = true
    end)
end
addTab("🏠 Home", 100, homeC); addTab("⚡ Main", 140, mainC); addTab("👁️ ESP", 180, espC); addTab("🎵 Music", 220, musicC); addTab("⚙️ Settings", 260, setC)

-- [HELPERS]
local function CreateSlider(pnt, label, min, max, def, cb)
    local f = Instance.new("Frame"); f.Parent = pnt; f.Size = UDim2.new(1, -10, 0, 45); f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel"); lbl.Parent = f; lbl.BackgroundTransparency = 1; lbl.Position = UDim2.new(0, 10, 0, 5); lbl.Text = label..": "..def; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame"); bar.Parent = f; bar.Position = UDim2.new(0, 10, 0, 30); bar.Size = UDim2.new(1, -20, 0, 5); bar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    local fill = Instance.new("Frame"); fill.Parent = bar; fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
    bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(p, 0, 1, 0); local val = math.floor(min + p * (max - min)); lbl.Text = label..": "..val; cb(val)
    end end)
end

local function CreateBtn(pnt, txt, cb, color)
    local b = Instance.new("TextButton"); b.Parent = pnt; b.Size = UDim2.new(1, -10, 0, 35); b.BackgroundColor3 = color or Color3.fromRGB(35, 35, 40)
    b.Font = Enum.Font.SourceSansBold; b.Text = txt; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextSize = 14; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() cb(b) end); return b
end

-- [MAIN FEATURES]
CreateSlider(mainC, "Speed", 16, 300, 16, function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end end)
CreateSlider(mainC, "Jump", 50, 300, 50, function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = v end end)

local flying = false
CreateBtn(mainC, "✈️ Fly (Uçma)", function(b)
    flying = not flying; b.BackgroundColor3 = flying and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 40)
    if flying then
        local bv = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart); bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge); bv.Velocity = Vector3.new(0,0,0)
        local bg = Instance.new("BodyGyro", LocalPlayer.Character.HumanoidRootPart); bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge); bg.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
        task.spawn(function() while flying do task.wait(); bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50 end bv:Destroy(); bg:Destroy() end)
    end
end)

-- [ESP & CHAMS]
CreateBtn(espC, "👁️ Name ESP", function(b)
    _G.ESP = not _G.ESP; b.BackgroundColor3 = _G.ESP and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 40)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            if _G.ESP then
                local bg = Instance.new("BillboardGui", p.Character.Head); bg.Name = "TR_ESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 100, 0, 30); bg.StudsOffset = Vector3.new(0, 2, 0)
                local tl = Instance.new("TextLabel", bg); tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1,0,1,0); tl.Text = p.Name; tl.TextColor3 = Color3.fromRGB(255, 190, 0); tl.TextSize = 12
            else if p.Character.Head:FindFirstChild("TR_ESP") then p.Character.Head.TR_ESP:Destroy() end end
        end
    end
end)

-- [MUSIC]
local srv = Instance.new("Sound", Lighting); srv.Volume = 0.5
CreateBtn(musicC, "🎵 Play Phonk", function() srv.SoundId = "rbxassetid://1568280628"; srv:Play() end)
CreateBtn(musicC, "☕ Play Chill", function() srv.SoundId = "rbxassetid://1837879082"; srv:Play() end)
CreateBtn(musicC, "🛑 Stop Music", function() srv:Stop() end)

-- [SETTINGS]
local fb = false
CreateBtn(setC, "💡 FullBright", function(b)
    fb = not fb; Lighting.Ambient = fb and Color3.fromRGB(255,255,255) or Color3.fromRGB(127,127,127); b.BackgroundColor3 = fb and Color3.fromRGB(0,150,0) or Color3.fromRGB(35,35,40)
end)

local boost = false; local mats = {}
CreateBtn(setC, "🚀 FPS Boost", function(b)
    boost = not boost; b.BackgroundColor3 = boost and Color3.fromRGB(0,150,0) or Color3.fromRGB(35,35,40)
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then
        if boost then mats[v] = v.Material; v.Material = Enum.Material.SmoothPlastic else v.Material = mats[v] or Enum.Material.Plastic end
    end end
end)

CreateBtn(setC, "🔗 WhatsApp", function() setclipboard("bit.ly/robloxturkiye") end, Color3.fromRGB(255, 165, 0))

-- LOGO BUTTON & DRAG
local tog = Instance.new("ImageButton", sg); tog.Size = UDim2.new(0, 55, 0, 55); tog.Position = UDim2.new(0.6, 0, 0.02, 0); tog.Image = "rbxassetid://10723345437"; tog.BackgroundColor3 = Color3.fromRGB(20,20,25)
Instance.new("UICorner", tog).CornerRadius = UDim.new(0, 12)
tog.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)

local function Drag(f)
    local s, i, sp; f.InputBegan:Connect(function(inpt) if inpt.UserInputType == Enum.UserInputType.MouseButton1 or inpt.UserInputType == Enum.UserInputType.Touch then s = true; i = inpt.Position; sp = f.Position end end)
    UserInputService.InputChanged:Connect(function(inpt) if s and (inpt.UserInputType == Enum.UserInputType.MouseMovement or inpt.UserInputType == Enum.UserInputType.Touch) then
        local d = inpt.Position - i; f.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end end)
    UserInputService.InputEnded:Connect(function(inpt) if inpt.UserInputType == Enum.UserInputType.MouseButton1 or inpt.UserInputType == Enum.UserInputType.Touch then s = false end end)
end
Drag(mf); Drag(tog)

print("ROBLOXTR v3.0 PREMIUM HUB YÜKLENDİ!")
