local CollectionService = game:GetService("CollectionService")

-- Function to handle when a tracked model is added to Workspace
local function onTrackedModelAdded(model)
    if model.Parent == workspace then
        print(model.Name .. " has been added to Workspace!")
    end
end

-- Monitor tagged models
CollectionService:GetInstanceAddedSignal("TrackedModel"):Connect(onTrackedModelAdded)
