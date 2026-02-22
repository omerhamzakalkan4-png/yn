-- MM2 AUTO COIN FARM - ENGLISH VERSION
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- SETTINGS
_G.AutoFarm = true -- Set to false to stop farming
local CollectionSpeed = 0.3 -- Speed delay to prevent kicks (0.3 is safe)

-- MAIN FARMING FUNCTION
task.spawn(function()
    print("System: MM2 Auto-Farm Started!")
    
    while _G.AutoFarm do
        task.wait(0.1)
        
        -- Locates the CoinContainer in the workspace
        local CoinContainer = workspace:FindFirstChild("CoinContainer", true)
        
        if CoinContainer and #CoinContainer:GetChildren() > 0 then
            local Coins = CoinContainer:GetChildren()
            
            for _, coin in pairs(Coins) do
                if _G.AutoFarm and coin:IsA("BasePart") then
                    -- TELEPORTS CHARACTER TO THE COIN POSITION
                    if Character and Character:FindFirstChild("HumanoidRootPart") then
                        Character.HumanoidRootPart.CFrame = coin.CFrame
                        task.wait(CollectionSpeed) -- Short wait to ensure coin is collected
                    end
                end
            end
        else
            -- If no coins are found (Waiting for match to start)
            print("Status: Searching for coins... Waiting for match to begin.")
            task.wait(2)
        end
    end
end)

-- ANTI-AFK SYSTEM (Prevents Disconnection)
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    print("System: Anti-AFK Active.")
end)

print("------------------------------------------")
print("MM2 ENGLISH SCRIPT LOADED!")
print("Character will automatically move to coins.")
print("------------------------------------------")
