-- config things --
local cfg = getgenv().Config
local helper = cfg.helper
local premium = cfg.premium
local verified = cfg.verified

-- waits for friend to be in the game --
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local friend = cfg.helper ~= "" and Players:WaitForChild(helper) or Players.LocalPlayer

-- waits for game to load --
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local friend = Players.LocalPlayer

-- sets user data (spoofing yourself) --
local UserData = game:HttpGet("https://users.roblox.com/v1/users/" .. tostring(Players.LocalPlayer.UserId), true)
local decodedData = game:GetService("HttpService"):JSONDecode(UserData)

-- changes premium/verified status --
local spoofedPlayer = Players.LocalPlayer
local oldNamecall
oldNamecall = hookmetamethod(game, "__index", function(self, key)
    if self == spoofedPlayer then
        if key == "MembershipType" and premium then
            return Enum.MembershipType.Premium
        end
        if key == "HasVerifiedBadge" and verified then
            return true
        end
    end
    return oldNamecall(self, key)
end)

print("Premium spoof:", premium)
print("Verified spoof:", verified)
