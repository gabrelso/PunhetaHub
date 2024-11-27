local TeleportService = game:GetService("TeleportService")

if game.PlaceId ~= 4520749081 or game.PlaceId ~= 6381829480 or game.PlaceId ~= 15759515082 then
    return
end

local function JoinServer()
    while getgenv().Enabled do task.wait(1)
        if game.JobId ~= JobID then
            print("Attempting to teleport to JobID:", JobID)
            TeleportService:TeleportToPlaceInstance(PlaceID, JobID)
        else
            print("Already in the correct server.")
        end
    end
end

JoinServer()
