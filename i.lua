local c = game:GetService("CollectionService")

c:GetInstanceAddedSignal("TrackedModel"):Connect(function(model)
    warn(model.Name)
end)
