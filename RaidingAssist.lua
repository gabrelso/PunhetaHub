if game.PlaceId ~= 5931540094 then
    return
end

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


repeat wait() until game:IsLoaded() and workspace:FindFirstChild("MOB") and workspace.MOB:FindFirstChild("Shadowtorn Cruelty") and getgenv().AutoShiftlock
local vim = game:GetService("VirtualInputManager") vim:SendKeyEvent(true, "LeftShift", false, game) vim:SendKeyEvent(false, "LeftShift", false, game) 
