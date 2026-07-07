-- ROBLOXTR PREMIUM PANEL (v3.0) - Loadstring Loader
-- Bu kod asıl büyük paneli GitHub üzerinden güvenli bir şekilde çeker.

local success, result = pcall(function()
    return game:HttpGet("https://githubusercontent.com")
end)

if success and result then
    local executable, err = loadstring(result)
    if executable then
        executable()
    else
        warn("Kod yuklenirken bir mantik hatasi olustu: ", err)
    end
else
    warn("GitHub sunucusuna baglanilamadi veya dosya yolu hatali!")
end
