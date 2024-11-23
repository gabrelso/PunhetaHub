-- SUPPOSED TO ASSIST PEOPLE WITH RAIDS 
-- Made by lv7gab, don't sue my ass.

local vim = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local args = { [1] = "Hard" }
game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))

while getgenv().Enabled do
    task.wait(1)
    game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args)) 
    game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()
    
    if getgenv().AutoSkip then
        game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
    end
end

local function pressShift()
    vim:SendKeyEvent(true, "LeftShift", false, game)
    vim:SendKeyEvent(false, "LeftShift", false, game)
end 

game.Players.PlayerAdded:Connect(function(player) 
    if player == LocalPlayer then
        LocalPlayer.CharacterAdded:Connect(function(character)
            task.wait(5)
            if getgenv().AutoShiftlock then
                pressShift() 
            end
        end)
    end
end)
