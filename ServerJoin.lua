local PlaceID
local TeleportService = game:GetService("TeleportService")

if Sea == "1st" then
    PlaceID = 4520749081
elseif Sea == "2nd" then
    PlaceID = 6381829480
elseif Sea == "3rd" then
    PlaceID = 15759515082
end

local function joinServer()
    while true do
        task.wait(1)
        if game.PlaceId == PlaceID and game.PlaceId ~= 5931540094 and game.JobId ~= JobID then
            TeleportService:TeleportToPlaceInstance(PlaceID, JobID), JobID)
        end
    end
end

repeat task.wait() until game:IsLoaded()
joinServer()
