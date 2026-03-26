-- Enemy Candy Bomb Detector (12-candy table version)
-- Highlights ONLY bombs placed on your candies

local detected = {}
local maxBombs = 3

local function highlightBomb(obj)

    if detected[obj] then return end
    if #detected >= maxBombs then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "EnemyBombESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.15
    highlight.Parent = obj

    detected[obj] = true
    print("Enemy bomb detected:", obj:GetFullName())

end


local function checkCandy(obj)

    -- most common server-side indicators
    if obj:GetAttribute("BombOwner") == "Enemy" then
        highlightBomb(obj)
    end

    if obj:GetAttribute("IsBomb") == true then
        highlightBomb(obj)
    end

    if obj:FindFirstChild("BombMarker") then
        highlightBomb(obj)
    end

end


-- scan candies already on table
for _, v in pairs(workspace:GetDescendants()) do

    if v:IsA("Part") or v:IsA("Model") then
        checkCandy(v)
    end

end


-- detect bombs when enemy places them
workspace.DescendantAdded:Connect(function(v)

    task.wait(0.2)

    if v:IsA("Part") or v:IsA("Model") then
        checkCandy(v)
    end

end)


-- detect attribute changes live (MOST IMPORTANT)
workspace.DescendantAdded:Connect(function(v)

    v.AttributeChanged:Connect(function()

        if v:GetAttribute("BombOwner") == "Enemy" then
            highlightBomb(v)
        end

        if v:GetAttribute("IsBomb") == true then
            highlightBomb(v)
        end

    end)

end)


print("Enemy bomb detector active (max 3 bombs).")
