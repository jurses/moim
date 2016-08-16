local tepero = require("mapa/tp")
local minas = love.graphics.newImage("mapa/minas.png")
local moim = require("mapa/moim")
local character = require("personaje/character")
local dbcs = require("dialogo/dialog_box_char_speak")
local info = require("dialogo/texto")

function love.load()
   pos = {x=0, y=0}
   dim = {w=16, h=16}

   -- Mapa --
   mcharo = moim.newlayer(tepero, 1)
   mcharo:newTileset(minas, 1)
   mcharo:readlayer()

   -- Personajes --
   jugador = character.newCharacter(pos, dim, false)
   jugador:setpipes(tepero, 2) -- (nombre del mapa, numero de la capa de las tuberias)
   -- Diálogo --
   titulo1 = dbcs.newdbcs(info.text, 0)
end

function love.update(dt)
   jugador:move(dt, mcharo:getmap()) --ver la matriz que devuelve mcharo:getmap()
end

function love.draw()
   mcharo:showlayer()
   jugador:drawCharacter()
   titulo1:show()
end
