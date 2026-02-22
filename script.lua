local coin = script.Parent
local respawnTime = 5 -- Kaç saniye sonra geri gelsin

local debounce = false

coin.Touched:Connect(function(hit)
    if debounce then return end
    
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        debounce = true
        
        player.leaderstats.Coins.Value += 1
        
        coin.Transparency = 1
        coin.CanCollide = false
        
        wait(respawnTime)
        
        coin.Transparency = 0
        coin.CanCollide = true
        debounce = false
    end
end)
