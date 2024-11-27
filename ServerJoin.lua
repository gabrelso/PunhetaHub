local TeleportService = game:GetService("TeleportService")

if game.PlaceId ~= 4520749081 then
    return
end

local function JoinServer()
    while getgenv().Enabled do
        task.wait(1)
        if game.JobId ~= JobID and game.PlaceId == 4520749081 then
            print("Attempting to teleport to JobID:", JobID)
            TeleportService:TeleportToPlaceInstance(4520749081, JobID)
        else
            print("Already in the correct server.")
        end
    end
end

JoinServer()
