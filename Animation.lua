-- Define Services
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

local player = players.LocalPlayer
local isPlaying = false
local tool = nil -- Ensure tool is globally referenced

print("[DEBUG] Script Loaded")

-- Tool Name & Version System
local TOOL_NAME = "Unlimited Flexworks"
local TOOL_VERSION = "1.6" -- Change this when updating

-- Function to Remove Outdated Tools & Keep Latest Version
local function removeOutdatedTools()
print("[DEBUG] Removing outdated tools")
local backpack = player:FindFirstChild("Backpack")
local starterGear = player:FindFirstChild("StarterGear")

if backpack then    
    for _, item in pairs(backpack:GetChildren()) do    
        if item:IsA("Tool") and item.Name == TOOL_NAME then    
            item:Destroy()    
        end    
    end    
end    
    
if starterGear then    
    for _, item in pairs(starterGear:GetChildren()) do    
        if item:IsA("Tool") and item.Name == TOOL_NAME then    
            item:Destroy()    
        end    
    end    
end

end

-- Function to Display Captions with Typewriter Effect
local function playCaptions(textSequence, delays, speed)
print("[DEBUG] Displaying captions")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlexworksCaptionGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:FindFirstChild("PlayerGui")

local usernameLabel = Instance.new("TextLabel", screenGui)    
usernameLabel.Size = UDim2.new(0.6, 0, 0.05, 0)    
usernameLabel.Position = UDim2.new(0.2, 0, 0.75, 0)    
usernameLabel.BackgroundTransparency = 1    
usernameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)    
usernameLabel.Font = Enum.Font.SourceSansBold    
usernameLabel.TextScaled = true    
usernameLabel.Text = "[" .. player.Name .. "]"    
    
local captionLabel = Instance.new("TextLabel", screenGui)    
captionLabel.Size = UDim2.new(0.6, 0, 0.05, 0)    
captionLabel.Position = UDim2.new(0.2, 0, 0.8, 0)    
captionLabel.BackgroundTransparency = 1    
captionLabel.TextColor3 = Color3.fromRGB(255, 50, 50)    
captionLabel.Font = Enum.Font.SourceSansBold    
captionLabel.TextScaled = true    
captionLabel.Text = ""    
    
for i, text in ipairs(textSequence) do    
    local typeSpeed = speed[i] or 0.05    
    for j = 1, #text do    
        captionLabel.Text = string.sub(text, 1, j)    
        wait(typeSpeed)    
    end    
    wait(delays[i])    
end    
wait(2)    
screenGui:Destroy()

end

-- Function to Play Execution Voiceline and Captions at Startup
local function playExecution()
print("[DEBUG] Playing execution voiceline and captions at startup")

-- Play startup sound    
local sound = Instance.new("Sound")    
sound.SoundId = "rbxassetid://132515779133572"    
sound.Volume = 2    
sound.Looped = false    
sound.Parent = game:GetService("SoundService")    
sound:Play()    
    
-- Ensure playCaptions exists before calling    
if type(playCaptions) == "function" then    
    playCaptions({"I'm done messing around...", "This should end it all."}, {0.5, 0.5}, {0.05, 0.05})    
else    
    print("[ERROR] playCaptions function is missing or not recognized!")    
end

end

-- Ensure execution audio and captions play at startup
playExecution()

-- Ensure the tool exists at script execution
print("[DEBUG] Initializing tool")
tool = createTool()
if tool then
setupTool()
else
print("[ERROR] Tool creation failed on execution")
end
ensureToolPersistence()
print("[DEBUG] Script execution completed")
