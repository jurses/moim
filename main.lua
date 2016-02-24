--desierto = require("desierto")
pokemon = require("pokemon")
--local tileset = love.graphics.newImage("desert.png")
local tileset = love.graphics.newImage("pkgold.png")
local minas = love.graphics.newImage("minas.png")
local moim = require("moim")
character = require("character")

function love.load()
   pos = {x= 0, y=0}
   dim = {w=16,h=16}
  jugador = character.newCharacter(pos, dim, false)
   --[[
   mdesierto = moim.newlayer(desierto, 1)
   mrocas = moim.newlayer(desierto, 2)
   mwater = moim.newlayer(desierto, 3)
   mcharo = moim.newlayer(desierto, 4) --suele ser la última capa

   mrocas:newTileset(tileset, 1)
   mdesierto:newTileset(tileset, 1)
   mwater:newTileset(tileset, 1)
   mcharo:newTileset(minas, 2)

   mwater:readlayer()
   mdesierto:readlayer()
   mrocas:readlayer()
   mcharo:readlayer()
   --]]
   msuelo = moim.newlayer(pokemon, 1)
   mcasas = moim.newlayer(pokemon, 2)
   mvalla = moim.newlayer(pokemon, 3)
   mcharo = moim.newlayer(pokemon, 4)

   msuelo:newTileset(tileset, 1)
   mcasas:newTileset(tileset, 1)
   mvalla:newTileset(tileset, 1)
   mcharo:newTileset(minas, 2)

   msuelo:readlayer()
   mcasas:readlayer()
   mvalla:readlayer()
   mcharo:readlayer()
end

function love.update(dt)
   jugador:move(dt,mcharo:getmap()) --ver la matriz que devuelve mcharo:getmap()
end

function love.draw()
   --[[
   mdesierto:showlayer()
   mrocas:showlayer()
   mwater:showlayer()
   --]]

   msuelo:showlayer()
   mcasas:showlayer()
   mvalla:showlayer()
-- mcharo:showlayer()
   
   jugador:drawCharacter()
end
