local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local placeId = game.PlaceId

print("[Nameless Remote Registry Test] Loaded for PlaceId:", placeId)

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Nameless Registry",
        Text = "Test script loaded: " .. tostring(placeId),
        Duration = 6
    })
end)

return {
    loaded = true,
    placeId = placeId,
    player = player and player.Name or "Unknown"
}
