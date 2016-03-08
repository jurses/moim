local tepero = require("tp")
local minas = love.graphics.newImage("minas.png")
local moim = require("moim")
local character = require("character")

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
end

function love.update(dt)
   jugador:move(dt,mcharo:getmap()) --ver la matriz que devuelve mcharo:getmap()
end

function love.draw()
   mcharo:showlayer()
   jugador:drawCharacter()
end
