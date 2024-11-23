local vim = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

LocalPlayer.CharacterAdded:Connect(function(character)
    if getgenv().AutoShiftlock then
        task.wait(1.5)
        vim:SendKeyEvent(true, "LeftShift", false, nil)
        vim:SendKeyEvent(false, "LeftShift", false, nil)
    end
end)

while getgenv().Enabled do
    task.wait(0.65)
    local raidSelect = {
        [1] = RaidMode
    }
    game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(raidSelect)) 
    game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()
    
    if getgenv().AutoSkip then
        game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
    end
end
