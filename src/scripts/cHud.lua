-- imports
local x, y = guiGetScreenSize()
local components = {"weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "radar", "area_name"}

local scale = math.min(math.max(y / 768, 0.50), 2)

local parent_w = 300
local parent_h = 100
local parent_x = x / 2 - parent_w * scale / 2 - (800) * scale / 2 * scale - (50) * scale
local parent_y = y / 2 - parent_h * scale / 2 + (800) * scale / 2 * scale - (50) * scale

local tick = getTickCount()
local circleScale, sizeStroke = 68, 4
local circleLeft, circleTop = circleScale + 35, x - circleScale - 25

-- remove hud components
addEventHandler("onClientResourceStart", root, function()
    for _, component in ipairs(components) do
        setPlayerHudComponentVisible(component, false)
    end
end)

-- such responsive resolution
addEventHandler("onClientResourceStart", root, function(x, y)
    local x, y = guiGetScreenSize()
    if ((x >= 1920) and (y >= 1080)) then
        scale = math.min(math.max(y / 1080, 0.50), 2)
        parent_x = x / 2 - parent_w * scale / 2 - (1400) * scale / 2 * scale - (50) * scale
        parent_y = y / 2 - parent_h * scale / 2 + (1000) * scale / 2 * scale - (50) * scale
        circleScale, sizeStroke = 70, 3
        circleLeft, circleTop = circleScale + 35, parent_x - circleScale - 25
    end
end)

--create backgrounds for circleStrokes
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
    createCircleStroke('bgHeart', circleScale, circleScale, sizeStroke)
    createCircleStroke('heart', circleScale, circleScale, sizeStroke)

    createCircleStroke('bgArmor', circleScale, circleScale, sizeStroke)
    createCircleStroke('armor', circleScale, circleScale, sizeStroke)

    createCircleStroke('bgPizza', circleScale, circleScale, sizeStroke)
    createCircleStroke('pizza', circleScale, circleScale, sizeStroke)

    createCircleStroke('bgWater', circleScale, circleScale, sizeStroke)
    createCircleStroke('water', circleScale, circleScale, sizeStroke)
end)


-- draw new hud components
function drawHud()
    --alpha effect
    alpha = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - tick) / 1000), 'Linear')

    -- hud background
    dxDrawImage(parent_x, parent_y, parent_w * scale, parent_h * scale, "src/assets/background.png");

    -- heart circle
    dxDrawCircle(parent_x + (40) * scale, parent_y + (50) * scale, 33 * scale, 0, 360, tocolor(65, 65, 65))
    dxDrawImage(parent_x + (52) * scale, parent_y + (40) * scale, parent_w * scale / 4 - (100) * scale, parent_h * scale / 4, "src/assets/icons/heart.png")
    drawItem('bgHeart', parent_x + (5) * scale, parent_y + (15) * scale, tocolor(101, 101, 101, alpha))
    drawItem('heart', parent_x + (5)  * scale, parent_y + (15) * scale, tocolor(255, 255, 255, alpha))

    -- armor circle
    dxDrawCircle(parent_x + (115) * scale, parent_y + (50) * scale, 33 * scale, 0, 360, tocolor(65, 65, 65))
    drawItem('bgArmor', parent_x + (80) * scale, parent_y + (15) * scale, tocolor(101, 101, 101, alpha))
    drawItem('armor', parent_x + (80)  * scale, parent_y + (15) * scale, tocolor(255, 255, 255, alpha))
    dxDrawImage(parent_x + (128) * scale, parent_y + (40) * scale, parent_w * scale / 4 - (100) * scale, parent_h * scale / 4, "src/assets/icons/armor.png")

    -- pizza circle
    dxDrawCircle(parent_x + (190) * scale, parent_y + (50) * scale, 33 * scale, 0, 360, tocolor(65, 65, 65))
    drawItem('bgPizza', parent_x + (155) * scale, parent_y + (15) * scale, tocolor(101, 101, 101, alpha))
    drawItem('pizza', parent_x + (155)  * scale, parent_y + (15) * scale, tocolor(255, 255, 255, alpha))
    dxDrawImage(parent_x + (201) * scale, parent_y + (39) * scale, parent_w * scale / 4 - (100) * scale, parent_h * scale / 4, "src/assets/icons/pizza.png", 60)

    -- water circle
    dxDrawCircle(parent_x + (260) * scale, parent_y + (50) * scale, 33 * scale, 0, 360, tocolor(65, 65, 65))
    drawItem('bgWater', parent_x + (225) * scale, parent_y + (15) * scale, tocolor(101, 101, 101, alpha))
    drawItem('water', parent_x + (225)  * scale, parent_y + (15) * scale, tocolor(255, 255, 255, alpha))
    dxDrawImage(parent_x + (273) * scale, parent_y + (40) * scale, parent_w * scale / 4 - (100) * scale, parent_h * scale / 4, "src/assets/icons/water.png")

    -- elements for svg
    local heart = math.floor(getElementHealth(localPlayer))
    local armor = math.floor(getPedArmor(localPlayer) or false)
    
    if ( armor == 0 or false) then
        tick = 0
    end
    
    -- create svgOffSet element
    setSVGOffset('heart', heart)
    setSVGOffset('armor', armor)
    --setSVGOffset('pizza', (getElementData(localPlayer) or 100))
    --setSVGOffset('water', (getElementData(localPlayer) or 100))

end
addEventHandler('onClientRender', root, drawHud)
