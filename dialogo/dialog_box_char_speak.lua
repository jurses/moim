local dialog_box_char_speak = {}
local colaTxt = require("dialogo/cola")
--
dbcs = dialog_box_char_speak
--
function dbcs.newdbcs(text, type_of_text, w, h)
    local MxChar = 132 --cantidad de carácteres en el campo
    local priv = {}
    local publ = {}
    priv.text = text
    priv.tt = type_of_text
    priv.pos = {}
    priv.dim = {}
    priv.colaTxt = colaTxt.new()

    if io.open("FantasqueSansMono-Regular.ttf","r") ~= nil then
      priv.letra = love.graphics.newFont("FantasqueSansMono-Regular.ttf",14)
      love.graphics.setFont(priv.letra)
    end

    priv.dim = {w = w or 270, h = h or 70}
    priv.pos = {x = love.graphics.getWidth()/2 - priv.dim.w/2,
                y = love.graphics.getHeight() - priv.dim.h - 20}

    function drawRect()
        love.graphics.setColor(0, 0, 255, 255)
        love.graphics.rectangle('fill', priv.pos.x, priv.pos.y, priv.dim.w, priv.dim.h)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle('line', priv.pos.x, priv.pos.y, priv.dim.w, priv.dim.h)
    end

    function drawText()
    end

    function publ:show()
        drawRect()
        drawText()
    end

    return publ
end

return dbcs
