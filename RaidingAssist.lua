-- SUPPOSED TO ASSIST PEOPLE WITH RAIDS 
-- Made by lv7gab, don't sue my ass.

local vim = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local raidSelect = { [1] = RaidMode }
game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(raidSelect))

while getgenv().Enabled do
    task.wait(0.65)
    game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(raidSelect)) 
    game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()
    
    if getgenv().AutoSkip then
        game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    local characterModel = workspace:WaitForChild("PlayerCharacters"):WaitForChild(LocalPlayer.Name)
    if getgenv().AutoShiftlock then
        task.wait(2)
        vim:SendKeyEvent(true, "LeftShift", false, nil)
        vim:SendKeyEvent(false, "LeftShift", false, nil)
    end
end)
