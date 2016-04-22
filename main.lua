local tepero = require("tp")
local minas = love.graphics.newImage("minas.png")
local moim = require("moim")
local character = require("character")
local dbcs = require("dialog_box_char_speak")

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
   titulo1 = dbcs.newdbcs("¿Hola, qué tal?, yo bien, como una moto, como un coche, como un radiocaset, como una vaca, ¡En un país multicolor....! Bueno ¿teeeeee importa si canto?, Da igual ya empecé, jajajajajaj", 0)
end

function love.update(dt)
   jugador:move(dt,mcharo:getmap()) --ver la matriz que devuelve mcharo:getmap()
end

function love.draw()
   mcharo:showlayer()
   jugador:drawCharacter()
   titulo1:show()
end
