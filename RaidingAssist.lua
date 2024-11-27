if game.PlaceId ~= 5931540094 then
    return
end

local args = { [1] = RaidMode }
game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))

while getgenv().Enabled do
    task.wait(1)
    game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()
    game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))
    if getgenv().AutoSkip then
        game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
    end
end
