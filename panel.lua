-- ============================================
-- 📁 RobloxTR 1.0 - Admin Paneli (Ana Hal)
-- 🚀 Kullanım: loadstring(game:HttpGet("URL"))()
-- ============================================

loadstring([[
    -- 🔧 AYARLAR
    local PANEL_ACMA_TUSU = "Z"
    local PANEL_BASLIK = "⚡ RobloxTR 1.0 ⚡"
    
    -- 📋 KOMUTLAR (Admin Komutları)
    local COMMANDS = {
        {emoji = "❤️", name = "Heal", color = {0, 255, 100}},
        {emoji = "💀", name = "Kill", color = {255, 0, 0}},
        {emoji = "🚀", name = "Fly", color = {0, 150, 255}},
        {emoji = "🛡️", name = "God", color = {0, 255, 255}},
        {emoji = "🔥", name = "Fire", color = {255, 100, 0}},
        {emoji = "❄️", name = "Freeze", color = {100, 200, 255}},
        {emoji = "💨", name = "Speed", color = {200, 200, 255}},
        {emoji = "🌀", name = "Spin", color = {150, 0, 255}},
        {emoji = "⭐", name = "Star", color = {255, 215, 0}},
        {emoji = "🌙", name = "Moon", color = {200, 200, 200}},
        {emoji = "⚡", name = "Lightning", color = {255, 255, 0}},
        {emoji = "🌈", name = "Rainbow", color = {255, 0, 255}},
        {emoji = "🎮", name = "Game", color = {0, 255, 0}},
        {emoji = "🎯", name = "Aim", color = {255, 0, 100}},
        {emoji = "🧊", name = "Ice", color = {0, 200, 255}},
        {emoji = "🌋", name = "Lava", color = {255, 100, 0}},
        {emoji = "🦅", name = "Eagle", color = {150, 150, 255}},
        {emoji = "🐉", name = "Dragon", color = {200, 0, 200}},
        {emoji = "👾", name = "Alien", color = {0, 255, 100}},
        {emoji = "🤖", name = "Robot", color = {100, 100, 200}},
        {emoji = "🧙", name = "Wizard", color = {150, 0, 255}},
        {emoji = "🦸", name = "Hero", color = {255, 215, 0}},
        {emoji = "💎", name = "Diamond", color = {0, 255, 255}},
        {emoji = "🔮", name = "Crystal", color = {200, 0, 255}},
    }
    
    -- ============================================
    -- 🎮 SİSTEM
    -- ============================================
    
    local player = game.Players.LocalPlayer
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local UserInputService = game:GetService("UserInputService")
    
    -- RemoteEvent
    local remoteEvent = replicatedStorage:FindFirstChild("RobloxTR_Event")
    if not remoteEvent then
        remoteEvent = Instance.new("RemoteEvent")
        remoteEvent.Name = "RobloxTR_Event"
        remoteEvent.Parent = replicatedStorage
    end
    
    -- Sunucu Scripti (otomatik)
    if not game:GetService("ServerScriptService"):FindFirstChild("RobloxTR_Server") then
        local serverScript = Instance.new("Script")
        serverScript.Name = "RobloxTR_Server"
        serverScript.Source = [=[
            local remoteEvent = game:GetService("ReplicatedStorage"):FindFirstChild("RobloxTR_Event")
            if not remoteEvent then
                remoteEvent = Instance.new("RemoteEvent")
                remoteEvent.Name = "RobloxTR_Event"
                remoteEvent.Parent = game:GetService("ReplicatedStorage")
            end
            
            remoteEvent.OnServerEvent:Connect(function(plr, cmdName)
                local char = plr.Character
                if not char then return end
                local humanoid = char:FindFirstChild("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not humanoid or not hrp then return end
                
                if cmdName == "Heal" then
                    humanoid.Health = humanoid.MaxHealth
                    plr:Chat("❤️ Şifa verildi!")
                elseif cmdName == "Kill" then
                    humanoid.Health = 0
                    plr:Chat("💀 Öldürüldün!")
                elseif cmdName == "Fly" then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(0, 50, 0)
                    bv.MaxForce = Vector3.new(0, 4000, 0)
                    bv.Parent = hrp
                    plr:Chat("🚀 3 saniyeliğine uçuş!")
                    task.wait(3)
                    bv:Destroy()
                elseif cmdName == "God" then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    plr:Chat("🛡️ 5 saniyeliğine ölümsüz!")
                    task.wait(5)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                elseif cmdName == "Fire" then
                    local fire = Instance.new("Fire")
                    fire.Size = 5
                    fire.Parent = hrp
                    plr:Chat("🔥 Ateşe verildin!")
                    task.wait(3)
                    fire:Destroy()
                elseif cmdName == "Freeze" then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.MaxForce = Vector3.new(1, 1, 1) * 1e9
                    bv.Parent = hrp
                    plr:Chat("❄️ Donduruldun!")
                    task.wait(3)
                    bv:Destroy()
                elseif cmdName == "Speed" then
                    humanoid.WalkSpeed = 50
                    plr:Chat("💨 Hızlandın!")
                    task.wait(5)
                    humanoid.WalkSpeed = 16
                elseif cmdName == "Spin" then
                    plr:Chat("🌀 Dönüyorsun!")
                    for i = 1, 10 do
                        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(36), 0)
                        task.wait(0.05)
                    end
                elseif cmdName == "Star" then
                    local att = Instance.new("Attachment")
                    att.Parent = hrp
                    local glow = Instance.new("PointLight")
                    glow.Color = Color3.fromRGB(255, 215, 0)
                    glow.Range = 20
                    glow.Brightness = 5
                    glow.Parent = att
                    plr:Chat("⭐ Yıldız oldun!")
                    task.wait(3)
                    att:Destroy()
                elseif cmdName == "Moon" then
                    local att = Instance.new("Attachment")
                    att.Parent = hrp
                    local glow = Instance.new("PointLight")
                    glow.Color = Color3.fromRGB(200, 200, 255)
                    glow.Range = 15
                    glow.Brightness = 3
                    glow.Parent = att
                    plr:Chat("🌙 Ay ışığı!")
                    task.wait(3)
                    att:Destroy()
                elseif cmdName == "Lightning" then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(0, 100, 0)
                    bv.MaxForce = Vector3.new(0, 8000, 0)
                    bv.Parent = hrp
                    plr:Chat("⚡ Yıldırım hızı!")
                    task.wait(2)
                    bv:Destroy()
                elseif cmdName == "Rainbow" then
                    for i = 1, 10 do
                        hrp.BrickColor = BrickColor.Random()
                        task.wait(0.1)
                    end
                    plr:Chat("🌈 Gökkuşağı oldun!")
                elseif cmdName == "Game" then
                    plr:Chat("🎮 Oyun modu aktif!")
                elseif cmdName == "Aim" then
                    plr:Chat("🎯 Hedef belirlendi!")
                elseif cmdName == "Ice" then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.MaxForce = Vector3.new(1, 1, 1) * 1e9
                    bv.Parent = hrp
                    hrp.BrickColor = BrickColor.new("Bright blue")
                    plr:Chat("🧊 Buz tuttu!")
                    task.wait(3)
                    bv:Destroy()
                    hrp.BrickColor = BrickColor.new("Medium stone grey")
                elseif cmdName == "Lava" then
                    hrp.BrickColor = BrickColor.new("Bright red")
                    plr:Chat("🌋 Lav oldun!")
                    task.wait(3)
                    hrp.BrickColor = BrickColor.new("Medium stone grey")
                elseif cmdName == "Eagle" then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(0, 30, 0)
                    bv.MaxForce = Vector3.new(0, 3000, 0)
                    bv.Parent = hrp
                    plr:Chat("🦅 Kartal gibi uç!")
                    task.wait(4)
                    bv:Destroy()
                elseif cmdName == "Dragon" then
                    local fire = Instance.new("Fire")
                    fire.Size = 10
                    fire.Parent = hrp
                    plr:Chat("🐉 Ejderha ateşi!")
                    task.wait(4)
                    fire:Destroy()
                elseif cmdName == "Alien" then
                    hrp.BrickColor = BrickColor.new("Bright green")
                    plr:Chat("👾 Uzaylı oldun!")
                    task.wait(3)
                    hrp.BrickColor = BrickColor.new("Medium stone grey")
                elseif cmdName == "Robot" then
                    hrp.BrickColor = BrickColor.new("Dark grey")
                    plr:Chat("🤖 Robot modu!")
                    task.wait(3)
                    hrp.BrickColor = BrickColor.new("Medium stone grey")
                elseif cmdName == "Wizard" then
                    plr:Chat("🧙 Büyü yapıldı!")
                elseif cmdName == "Hero" then
                    humanoid.Health = humanoid.MaxHealth
                    plr:Chat("🦸 Kahraman oldun!")
                elseif cmdName == "Diamond" then
                    hrp.BrickColor = BrickColor.new("Really blue")
                    plr:Chat("💎 Elmas oldun!")
                    task.wait(3)
                    hrp.BrickColor = BrickColor.new("Medium stone grey")
                elseif cmdName == "Crystal" then
                    local glow = Instance.new("PointLight")
                    glow.Color = Color3.fromRGB(200, 0, 255)
                    glow.Range = 20
                    glow.Brightness = 10
                    glow.Parent = hrp
                    plr:Chat("🔮 Kristal ışığı!")
                    task.wait(3)
                    glow:Destroy()
                end
            end)
        ]=]
        serverScript.Parent = game:GetService("ServerScriptService")
    end
    
    -- ============================================
    -- 📱 GUI
    -- ============================================
    
    local oldGui = player.PlayerGui:FindFirstChild("RobloxTR_Gui")
    if oldGui then oldGui:Destroy() end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "RobloxTR_Gui"
    gui.Parent = player.PlayerGui
    gui.ResetOnSpawn = false
    gui.Enabled = false
    
    -- Açma Butonu (sağ alt)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(1, -60, 1, -60)
    toggleBtn.Text = "⚡"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextScaled = true
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    toggleBtn.BackgroundTransparency = 0.15
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = gui
    toggleBtn.ZIndex = 10
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = toggleBtn
    
    -- Ana Panel
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui
    mainFrame.ZIndex = 5
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 215, 0)
    stroke.Parent = mainFrame
    
    -- Başlık
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = PANEL_BASLIK
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 1
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Kapatma
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.TextScaled = true
    closeBtn.BackgroundTransparency = 1
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        gui.Enabled = false
    end)
    
    -- Scroll
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -45)
    scroll.Position = UDim2.new(0, 5, 0, 45)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = mainFrame
    
    -- Butonlar
    local columns = 3
    local btnWidth = 0.28
    local btnHeight = 0.11
    local startY = 0.02
    
    local maxRows = 0
    
    for i, cmd in ipairs(COMMANDS) do
        local row = math.floor((i-1) / columns)
        local col = (i-1) % columns
        
        if row > maxRows then maxRows = row end
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(btnWidth, 0, btnHeight, 0)
        btn.Position = UDim2.new(
            0.03 + (col * (btnWidth + 0.035)),
            0,
            startY + (row * (btnHeight + 0.025)),
            0
        )
        btn.Text = cmd.emoji .. " " .. cmd.name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.BackgroundColor3 = Color3.fromRGB(cmd.color[1], cmd.color[2], cmd.color[3])
        btn.BackgroundTransparency = 0.2
        btn.BorderSizePixel = 0
        btn.Parent = scroll
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            remoteEvent:FireServer(cmd.name)
            btn.BackgroundColor3 = Color3.fromRGB(0, 180, 60)
            task.wait(0.15)
            btn.BackgroundColor3 = Color3.fromRGB(cmd.color[1], cmd.color[2], cmd.color[3])
        end)
    end
    
    scroll.CanvasSize = UDim2.new(0, 0, 0, (maxRows + 1) * 70 + 20)
    
    -- Panel aç/kapa
    toggleBtn.MouseButton1Click:Connect(function()
        gui.Enabled = not gui.Enabled
    end)
    
    -- Z tuşu
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Z then
            gui.Enabled = not gui.Enabled
        end
    end)
    
    print("✅ RobloxTR 1.0 yüklendi! (" .. #COMMANDS .. " admin komut)")
    print("📱 Sağ alttaki ⚡ butonuna tıkla")
    print("⌨️ PC: Z tuşuna bas")
]])()

print("🎮 RobloxTR 1.0 başlatıldı! (Ana admin paneli)")
