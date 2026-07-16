-- ============================================
-- 📁 RobloxTR v3.0 - Gelişmiş Panel
-- 🚀 Kullanım: loadstring(game:HttpGet("URL"))()
-- ============================================

loadstring([[
    -- ============================================
    -- 📋 AYARLAR
    -- ============================================
    
    local player = game.Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local TweenService = game:GetService("TweenService")
    
    -- ============================================
    -- 🎮 HİLE DURUMLARI
    -- ============================================
    
    local hacks = {
        fly = false,
        noClip = false,
        esp = false,
        chams = false,
        lagFix = false,
        tpCooldown = 3,
    }
    
    local flyVelocity = nil
    local espObjects = {}
    local chamsObjects = {}
    
    -- ============================================
    -- 🛠️ HİLE FONKSİYONLARI
    -- ============================================
    
    -- FLY
    local function toggleFly()
        hacks.fly = not hacks.fly
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        if hacks.fly then
            flyVelocity = Instance.new("BodyVelocity")
            flyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            flyVelocity.Parent = hrp
        else
            if flyVelocity then
                flyVelocity:Destroy()
                flyVelocity = nil
            end
        end
    end
    
    -- NO CLIP
    local function toggleNoClip()
        hacks.noClip = not hacks.noClip
        local char = player.Character
        if not char then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not hacks.noClip
            end
        end
    end
    
    -- PLAYER TP (Başka oyuncuya ışınlanma)
    local function tpToPlayer(targetPlayer)
        if not targetPlayer then return end
        local char = player.Character
        local targetChar = targetPlayer.Character
        if not char or not targetChar then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
        if not hrp or not targetHrp then return end
        
        hrp.CFrame = targetHrp.CFrame + Vector3.new(0, 3, 0)
    end
    
    -- ESP (Name ESP + Box ESP)
    local function toggleESP()
        hacks.esp = not hacks.esp
        if hacks.esp then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player then
                    addESP(plr)
                end
            end
            game.Players.PlayerAdded:Connect(addESP)
        else
            for _, obj in pairs(espObjects) do
                obj:Destroy()
            end
            espObjects = {}
        end
    end
    
    local function addESP(plr)
        if plr == player then return end
        plr.CharacterAdded:Connect(function(char)
            createESP(char, plr)
        end)
        if plr.Character then
            createESP(plr.Character, plr)
        end
    end
    
    local function createESP(char, plr)
        if not hacks.esp then return end
        local head = char:FindFirstChild("Head")
        if not head then return end
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "TR_ESP"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 200, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.Parent = head
        
        local label = Instance.new("TextLabel")
        label.Parent = billboard
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Font = Enum.Font.SourceSansBold
        label.TextColor3 = Color3.fromRGB(255, 50, 50)
        label.TextSize = 14
        label.Text = plr.Name
        
        table.insert(espObjects, billboard)
    end
    
    -- CHAMS ESP (Oyuncuları renkli göster)
    local function toggleChams()
        hacks.chams = not hacks.chams
        if hacks.chams then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player then
                    addChams(plr)
                end
            end
            game.Players.PlayerAdded:Connect(addChams)
        else
            for _, obj in pairs(chamsObjects) do
                obj:Destroy()
            end
            chamsObjects = {}
        end
    end
    
    local function addChams(plr)
        if plr == player then return end
        plr.CharacterAdded:Connect(function(char)
            createChams(char)
        end)
        if plr.Character then
            createChams(plr.Character)
        end
    end
    
    local function createChams(char)
        if not hacks.chams then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                local highlight = Instance.new("Highlight")
                highlight.Parent = part
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                table.insert(chamsObjects, highlight)
            end
        end
    end
    
    -- LAG FIX (Performans iyileştirme)
    local function toggleLagFix()
        hacks.lagFix = not hacks.lagFix
        if hacks.lagFix then
            -- Grafik ayarlarını düşür
            game:GetService("Workspace").GlobalShadow = false
            game:GetService("Workspace").FogEnd = 100
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("Part") or v:IsA("UnionOperation") then
                    v.Material = Enum.Material.SmoothPlastic
                end
            end
        else
            -- Eski haline döndür (kısmi)
            game:GetService("Workspace").GlobalShadow = true
            game:GetService("Workspace").FogEnd = 1000
        end
    end
    
    -- ============================================
    -- 📱 PANEL ARAYÜZÜ (ESKI v2.2)
    -- ============================================
    
    -- Eski GUI'yi sil
    local oldGui = player.PlayerGui:FindFirstChild("RobloxTR_Gui")
    if oldGui then oldGui:Destroy() end
    
    local sg = Instance.new("ScreenGui")
    sg.Name = "RobloxTR_Gui"
    sg.Parent = player.PlayerGui
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.ResetOnSpawn = false
    
    -- ANA PANEL
    local mf = Instance.new("Frame")
    mf.Name = "MainFrame"
    mf.Parent = sg
    mf.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mf.BackgroundTransparency = 0.15
    mf.Position = UDim2.new(0.25, 0, 0.15, 0)
    mf.Size = UDim2.new(0, 480, 0, 400)
    mf.Visible = false
    
    local mc = Instance.new("UICorner")
    mc.CornerRadius = UDim.new(0, 10)
    mc.Parent = mf
    
    -- SIDEBAR
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Parent = mf
    sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    sidebar.BackgroundTransparency = 0.3
    sidebar.Size = UDim2.new(0, 140, 1, 0)
    
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 10)
    sc.Parent = sidebar
    
    -- BAŞLIK
    local t = Instance.new("TextLabel")
    t.Parent = sidebar
    t.BackgroundTransparency = 1
    t.Position = UDim2.new(0, 12, 0, 15)
    t.Size = UDim2.new(0, 120, 0, 25)
    t.Font = Enum.Font.SourceSansBold
    t.Text = "RobloxTR v3.0"
    t.TextColor3 = Color3.fromRGB(255, 190, 0)
    t.TextSize = 18
    t.TextXAlignment = Enum.TextXAlignment.Left
    
    local st = Instance.new("TextLabel")
    st.Parent = sidebar
    st.BackgroundTransparency = 1
    st.Position = UDim2.new(0, 12, 0, 35)
    st.Size = UDim2.new(0, 120, 0, 15)
    st.Font = Enum.Font.SourceSans
    st.Text = "Kurucu: Mansfer"
    st.TextColor3 = Color3.fromRGB(150, 150, 150)
    st.TextSize = 12
    st.TextXAlignment = Enum.TextXAlignment.Left
    
    -- KAPATMA (X)
    local cb = Instance.new("TextButton")
    cb.Parent = mf
    cb.BackgroundTransparency = 1
    cb.Position = UDim2.new(0, 445, 0, 10)
    cb.Size = UDim2.new(0, 25, 0, 25)
    cb.Font = Enum.Font.SourceSansBold
    cb.Text = "X"
    cb.TextColor3 = Color3.fromRGB(255, 50, 50)
    cb.TextSize = 18
    cb.MouseButton1Click:Connect(function()
        mf.Visible = false
    end)
    
    -- İÇERİK FRAME'LERI
    local mainContent = Instance.new("Frame")
    mainContent.Name = "MainContent"
    mainContent.Parent = mf
    mainContent.BackgroundTransparency = 1
    mainContent.Position = UDim2.new(0, 150, 0, 45)
    mainContent.Size = UDim2.new(0, 315, 0, 340)
    mainContent.Visible = true
    
    local aimContent = Instance.new("Frame")
    aimContent.Name = "AimContent"
    aimContent.Parent = mf
    aimContent.BackgroundTransparency = 1
    aimContent.Position = UDim2.new(0, 150, 0, 45)
    aimContent.Size = UDim2.new(0, 315, 0, 340)
    aimContent.Visible = false
    
    local settingsContent = Instance.new("Frame")
    settingsContent.Name = "SettingsContent"
    settingsContent.Parent = mf
    settingsContent.BackgroundTransparency = 1
    settingsContent.Position = UDim2.new(0, 150, 0, 45)
    settingsContent.Size = UDim2.new(0, 315, 0, 340)
    settingsContent.Visible = false
    
    -- LAYOUT
    local l1 = Instance.new("UIListLayout")
    l1.Parent = mainContent
    l1.SortOrder = Enum.SortOrder.LayoutOrder
    l1.Padding = UDim.new(0, 6)
    
    local l2 = Instance.new("UIListLayout")
    l2.Parent = aimContent
    l2.SortOrder = Enum.SortOrder.LayoutOrder
    l2.Padding = UDim.new(0, 8)
    
    local l3 = Instance.new("UIListLayout")
    l3.Parent = settingsContent
    l3.SortOrder = Enum.SortOrder.LayoutOrder
    l3.Padding = UDim.new(0, 6)
    
    -- SIDEBAR BUTONLARI
    local mBtn = Instance.new("TextButton")
    mBtn.Parent = sidebar
    mBtn.Position = UDim2.new(0, 10, 0, 75)
    mBtn.Size = UDim2.new(0, 120, 0, 30)
    mBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mBtn.Font = Enum.Font.SourceSansBold
    mBtn.Text = "🏠 Main"
    mBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    mBtn.TextSize = 13
    Instance.new("UICorner", mBtn).CornerRadius = UDim.new(0, 5)
    
    local aBtn = Instance.new("TextButton")
    aBtn.Parent = sidebar
    aBtn.Position = UDim2.new(0, 10, 0, 115)
    aBtn.Size = UDim2.new(0, 120, 0, 30)
    aBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    aBtn.Font = Enum.Font.SourceSansBold
    aBtn.Text = "🎯 Aim & ESP"
    aBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    aBtn.TextSize = 13
    Instance.new("UICorner", aBtn).CornerRadius = UDim.new(0, 5)
    
    local sBtn = Instance.new("TextButton")
    sBtn.Parent = sidebar
    sBtn.Position = UDim2.new(0, 10, 0, 155)
    sBtn.Size = UDim2.new(0, 120, 0, 30)
    sBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    sBtn.Font = Enum.Font.SourceSansBold
    sBtn.Text = "⚙️ Settings"
    sBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    sBtn.TextSize = 13
    Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 5)
    
    -- SIDEBAR GEÇİŞLER
    mBtn.MouseButton1Click:Connect(function()
        mainContent.Visible = true
        aimContent.Visible = false
        settingsContent.Visible = false
        mBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        aBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        sBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    end)
    
    aBtn.MouseButton1Click:Connect(function()
        mainContent.Visible = false
        aimContent.Visible = true
        settingsContent.Visible = false
        mBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        aBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        sBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    end)
    
    sBtn.MouseButton1Click:Connect(function()
        mainContent.Visible = false
        aimContent.Visible = false
        settingsContent.Visible = true
        mBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        aBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        sBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    end)
    
    -- ============================================
    -- 📋 BUTON / SLIDER OLUŞTURUCU
    -- ============================================
    
    local function CreateBtn(pnt, txt, bg)
        local b = Instance.new("TextButton")
        b.Parent = pnt
        b.Size = UDim2.new(0, 295, 0, 38)
        b.BackgroundColor3 = bg
        b.Font = Enum.Font.SourceSansBold
        b.Text = txt
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 14
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        return b
    end
    
    local function CreateSlider(pnt, labelTxt, min, max, default, callback)
        local f = Instance.new("Frame")
        f.Parent = pnt
        f.Size = UDim2.new(0, 295, 0, 45)
        f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
        
        local lbl = Instance.new("TextLabel")
        lbl.Parent = f
        lbl.BackgroundTransparency = 1
        lbl.Position = UDim2.new(0, 10, 0, 2)
        lbl.Size = UDim2.new(0, 200, 0, 20)
        lbl.Font = Enum.Font.SourceSansBold
        lbl.Text = labelTxt .. ": " .. default
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        
        local box = Instance.new("TextBox")
        box.Parent = f
        box.Position = UDim2.new(0, 240, 0, 4)
        box.Size = UDim2.new(0, 45, 0, 18)
        box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        box.Font = Enum.Font.SourceSansBold
        box.Text = tostring(default)
        box.TextColor3 = Color3.fromRGB(255, 190, 0)
        box.TextSize = 12
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
        
        local bar = Instance.new("Frame")
        bar.Parent = f
        bar.Position = UDim2.new(0, 10, 0, 28)
        bar.Size = UDim2.new(0, 275, 0, 6)
        bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 3)
        
        local fill = Instance.new("Frame")
        fill.Parent = bar
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
        Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)
        
        local function update(val)
            val = math.clamp(val, min, max)
            lbl.Text = labelTxt .. ": " .. math.floor(val)
            box.Text = tostring(math.floor(val))
            fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
            callback(val)
        end
        
        box.FocusLost:Connect(function()
            local num = tonumber(box.Text)
            if num then update(num) else box.Text = tostring(min); update(min) end
        end)
        
        local active = false
        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                active = true
                local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                update(min + p * (max - min))
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                update(min + p * (max - min))
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                active = false
            end
        end)
        
        return f
    end
    
    -- ============================================
    -- 🏠 MAIN SEKME (Fly, No Clip, TP, TP Süresi)
    -- ============================================
    
    -- Fly Butonu
    local flyBtn = CreateBtn(mainContent, "✈️ Fly [Kapali]", Color3.fromRGB(35, 35, 35))
    flyBtn.MouseButton1Click:Connect(function()
        toggleFly()
        flyBtn.Text = hacks.fly and "✈️ Fly [Aktif]" or "✈️ Fly [Kapali]"
        flyBtn.BackgroundColor3 = hacks.fly and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    end)
    
    -- No Clip Butonu
    local noClipBtn = CreateBtn(mainContent, "🚧 No Clip [Kapali]", Color3.fromRGB(35, 35, 35))
    noClipBtn.MouseButton1Click:Connect(function()
        toggleNoClip()
        noClipBtn.Text = hacks.noClip and "🚧 No Clip [Aktif]" or "🚧 No Clip [Kapali]"
        noClipBtn.BackgroundColor3 = hacks.noClip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    end)
    
    -- Player TP (Oyuncu seç + tp)
    local tpBtn = CreateBtn(mainContent, "📌 Player TP (Oyuncu Sec)", Color3.fromRGB(35, 35, 35))
    local selectedPlayer = nil
    tpBtn.MouseButton1Click:Connect(function()
        local players = {}
        for i, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player then
                table.insert(players, plr.Name)
            end
        end
        if #players == 0 then
            tpBtn.Text = "📌 Oyuncu Yok!"
            task.wait(1)
            tpBtn.Text = "📌 Player TP (Oyuncu Sec)"
            return
        end
        -- Basit seçim: sıradaki oyuncuya tp
        selectedPlayer = game.Players:FindFirstChild(players[1])
        if selectedPlayer then
            tpToPlayer(selectedPlayer)
            tpBtn.Text = "📌 " .. selectedPlayer.Name .. "'a TP yapıldı"
            task.wait(1.5)
            tpBtn.Text = "📌 Player TP (Oyuncu Sec)"
        end
    end)
    
    -- TP Süresi (Slider)
    CreateSlider(mainContent, "TP Bekleme Süresi", 1, 10, 3, function(v)
        hacks.tpCooldown = v
    end)
    
    -- ============================================
    -- 🎯 AIM & ESP SEKME (ESP, Chams)
    -- ============================================
    
    -- ESP Butonu
    local espBtn = CreateBtn(aimContent, "👁️ Name ESP [Kapali]", Color3.fromRGB(35, 35, 35))
    espBtn.MouseButton1Click:Connect(function()
        toggleESP()
        espBtn.Text = hacks.esp and "👁️ Name ESP [Aktif]" or "👁️ Name ESP [Kapali]"
        espBtn.BackgroundColor3 = hacks.esp and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    end)
    
    -- Chams ESP Butonu
    local chamsBtn = CreateBtn(aimContent, "🔲 Chams ESP [Kapali]", Color3.fromRGB(35, 35, 35))
    chamsBtn.MouseButton1Click:Connect(function()
        toggleChams()
        chamsBtn.Text = hacks.chams and "🔲 Chams ESP [Aktif]" or "🔲 Chams ESP [Kapali]"
        chamsBtn.BackgroundColor3 = hacks.chams and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    end)
    
    -- ============================================
    -- ⚙️ SETTINGS SEKME (Lag Fix, Fullbright)
    -- ============================================
    
    -- Lag Fix Butonu
    local lagBtn = CreateBtn(settingsContent, "📱 Lag Fix [Kapali]", Color3.fromRGB(35, 35, 35))
    lagBtn.MouseButton1Click:Connect(function()
        toggleLagFix()
        lagBtn.Text = hacks.lagFix and "📱 Lag Fix [Aktif]" or "📱 Lag Fix [Kapali]"
        lagBtn.BackgroundColor3 = hacks.lagFix and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    end)
    
    -- Fullbright Butonu
    local fbTog = false
    local fbBtn = CreateBtn(settingsContent, "💡 FullBr
