-- ROBLOXTR PREMIUM PANEL (v3.0) - Loadstring Loader
local success, result = pcall(function()
    -- Buraya senin panel.lua dosyanın gerçek linkini ekledim:
    return game:HttpGet("https://raw.githubusercontent.com/arkaplanmansfer-tech/ROBLOXTR/main/panel.lua")
end)

if success and result then
    local executable, err = loadstring(result)
    if executable then
        executable()
    else
        warn("Panel yuklenirken bir mantik hatasi olustu: ", err)
    end
else
    warn("GitHub sunucusuna baglanilamadi veya dosya yolu hatali!")
end
