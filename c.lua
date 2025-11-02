local G, T, R = getgenv, typeof, rawset
local S = G().Signals

local AddSignal = setmetatable(S, {
    __newindex = function(t, k, v)
        if T(v) == "RBXScriptConnection" then
            R(t, k, v)
        else
            R(t, k, nil)
        end
    end
})

return AddSignal
