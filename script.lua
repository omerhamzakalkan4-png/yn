As per your request, I have translated the entire script into English, including the UI elements, descriptions, and console messages. The speed limit remains capped at 25 for your safety.

MM2 Safe Auto-Farm (English Version)
Lua
-- MM2 SAFE AUTO-COIN FARM (TWEEN VERSION - MAX SPEED 25)
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- UI LIBRARY
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MM2 SAFE FARM", "DarkTheme")
local MainTab = Window:NewTab("Main Menu")
local Section = MainTab:NewSection("Auto Farm Settings")

_G.AutoFarm = false
local FarmSpeed = 15 -- Default starting speed

-- TWEEN MOVEMENT FUNCTION (Smooth Gliding)
local function MoveTo(targetCFrame)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local part = character.HumanoidRootPart
        local distance = (part.Position - targetCFrame.p).Magnitude
        -- Calculation: Distance / Speed = Time
        local info = TweenInfo.new(distance / FarmSpeed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(part, info, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- ON/OFF TOGGLE
Section:NewToggle("Enable Auto-Farm", "Character glides smoothly to coins", function(state)
    _G.AutoFarm = state
    
    task.spawn(function()
        while _G.AutoFarm do
            task.wait(0.5)
            local coins = workspace:FindFirstChild("CoinContainer", true)
            
            if coins then
                for _, coin in pairs(coins:GetChildren()) do
                    if not _G.AutoFarm then break end
                    if coin:IsA("BasePart") then
                        local move = MoveTo(coin.CFrame)
                        if move then
                            -- Wait until character reaches the coin before moving to the next
                            move.Completed:Wait() 
                            task.wait(0.2) -- Collection buffer
                        end
                    end
                end
            else
                print("Status: Waiting for match/coins...")
                task.wait(2)
            end
        end
    end)
end)

-- SPEED SLIDER (MAX 25)
Section:NewSlider("Farm Speed", "Max 25 is recommended to avoid kicks", 25, 5, function(s)
    FarmSpeed = s
end)

-- ANTI-AFK SYSTEM
local Section2 = MainTab:NewSection("Utility")
Section2:NewButton("Enable Anti-AFK", "Prevents being kicked for inactivity", function()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    print("System: Anti-AFK Enabled")
end)

print("------------------------------------------")
print("MM2 ENGLISH SAFE FARM LOADED")
print("Max Speed: 25 | Movement: Tween")
print("------------------------------------------")
