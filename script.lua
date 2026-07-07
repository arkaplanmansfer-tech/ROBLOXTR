--ROBLOXTR PREMIUM PANEL (v3.0) - Optimize
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--Eski Panelleri Temizle
if CoreGui:FindFirstChild("RobloxTR_PremiumPanel") then
    CoreGui:FindFirstChild("RobloxTR_PremiumPanel"):Destroy()
end

--Ana Ekran (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxTR_PremiumPanel"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- ÖZEL GRUP LOGOLU AÇILIŞ BUTONU (Daire)
local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "LogoToggleButton"
