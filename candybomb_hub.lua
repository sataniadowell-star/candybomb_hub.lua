-- Candy Bomb Hub Script
-- Escape Tsunami Brainrot Trading Plaza Helper
-- GUI + ESP + Auto Scanner

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)

gui.Name = "CandyBombHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,200,0,120)
frame.Position = UDim2.new(0,20,0,200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "Candy Bomb Hub"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(1,-20,0,40)
toggle.Position = UDim2.new(0,10,0,40)
toggle.Text = "Enable Bomb ESP"
toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggle.TextColor3 = Color3.new(1,1,1)

local notify = Instance.new("TextLabel", frame)
notify.Size = UDim2.new(1,0,0,30)
notify.Position = UDim2.new(0,0,1,-30)
notify.BackgroundTransparency = 1
notify.TextColor3 = Color3.fromRGB(0,255,0)
notify.Text = "Status: OFF"

local enabled = false

local keywords = {
    "bomb",
    "candybomb",
    "explode",
    "danger"
}

local function highlight(obj)

    if obj:FindFirstChild("CandyBombESP") then return end

    local h = Instance.new("Highlight")
    h.Name = "CandyBombESP"
    h.FillColor = Color3.fromRGB(255,0,0)
    h.OutlineColor = Color3.fromRGB(255,255,255)
    h.FillTransparency = 0.3
    h.Parent = obj

end

local function scan()

    for _,v in pairs(workspace:GetDescendants()) do

        local name = string.lower(v.Name)

        for _,k in pairs(keywords) do

            if string.find(name,k) then
                highlight(v)
                notify.Text = "Bomb candidate detected!"
            end

        end

    end

end

toggle.MouseButton1Click:Connect(function()

    enabled = not enabled

    if enabled then
        notify.Text = "Status: ON"
        toggle.Text = "Disable Bomb ESP"

        scan()

        workspace.DescendantAdded:Connect(function(v)

            if enabled then

                local name = string.lower(v.Name)

                for _,k in pairs(keywords) do

                    if string.find(name,k) then
                        highlight(v)
                        notify.Text = "New bomb object detected!"
                    end

                end

            end

        end)

    else
        notify.Text = "Status: OFF"
        toggle.Text = "Enable Bomb ESP"
    end

end)
