local dialog_box_char_speak = {}
--
dbcs = dialog_box_char_speak
--
function dbcs.newdbcs(text, type_of_text)
    local MxChar = 132
    local priv = {}
    local publ = {}
    priv.text = text
    priv.tt = type_of_text
    priv.pos = {}
    priv.dim = {}
    priv.letra = love.graphics.newFont("FantasqueSansMono-Regular.ttf",14)

    -- divide dialogo --
    priv.max_lines = math.floor(priv.text:len() / MxChar)
    priv.box_lines = 4

    priv.dim = {w = 263, h = 65}
    priv.pos = {x = love.graphics.getWidth()/2 - priv.dim.w/2,
                y = love.graphics.getHeight() - priv.dim.h - 20}

    love.graphics.setFont(priv.letra)

    function drawRect()
        love.graphics.setColor(0, 0, 255, 255)
        love.graphics.rectangle('fill', priv.pos.x, priv.pos.y, priv.dim.w, priv.dim.h)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle('line', priv.pos.x, priv.pos.y, priv.dim.w, priv.dim.h)
    end

    function drawText()
        for i=0, priv.max_lines, priv.box_lines do
            print(priv.text)
            love.graphics.printf(priv.text, priv.pos.x + 7, priv.pos.y + 1, priv.dim.w - 7, 'left')
        end
    end

    function publ:show()
        drawRect()
        drawText()
    end

    return publ 
end

return dbcs
