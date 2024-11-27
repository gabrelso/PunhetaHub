if game.PlaceId ~= 5931540094 then
    return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local args = { [1] = RaidMode }
game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))

task.spawn(function()
    while getgenv().Enabled do
        task.wait(1)
        game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()
        if getgenv().AutoSkip then
            game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
        end
    end
end)
