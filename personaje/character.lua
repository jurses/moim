local character = {}
local pipe = require("../mapa/moim")

function character.newCharacter(pos, dim, ai)
   local priv = {}
   local publ = {}
   local map = {}

   priv.pos, priv.dim = {}, {}
   priv.indice = 0
   priv.time = 0
   priv.block = {up = false, down = false, right = false, left = false}
   priv.obst = {up = false, down = false, right = false, left = false}
   priv.gonnatravel = {up = false, down = false, right = false, left = false}

   map.tilewidth, map.tileheight = nil

   priv.pos = pos
   priv.dim = {w = dim.w or 16, h = dim.h or 16}

   priv.dir = ""
   priv.moving = false
   priv.mtp = nil

   function refreshPos(j,i,col)
      priv.indice = i*col + j
   end

   function publ:setpipes(mapPipe, layerpipe)
      priv.mtp = pipe.newlayer(mapPipe, layerpipe)
   end

   function changepos(dir, tw, th, col) --priv.indice no funciona con los extremos !!!
      if dir == "up" and not priv.block.up and not priv.obst.up then
         priv.indice = priv.indice - col
         priv.pos.y = priv.pos.y - 1
      end
      if dir == "down" and not priv.block.down and not priv.obst.down then
         priv.indice = priv.indice + col
         priv.pos.y = priv.pos.y + 1
      end
      if dir == "right" and not priv.block.right and not priv.obst.right then
         priv.indice = priv.indice + 1
         priv.pos.x = priv.pos.x + 1
      end

      if dir == "left" and not priv.block.left and not priv.obst.left then
         priv.indice = priv.indice - 1
         priv.pos.x = priv.pos.x - 1
      end
      priv.moving = false
      priv.time = 0
   end

   function obst(mapai, col)
      if mapai[priv.indice + 1 - col] == 2 then
         priv.obst.up = true
      else
         priv.obst.up = false
      end
      if mapai[priv.indice] == 2 then
         priv.obst.left = true
      else
         priv.obst.left = false
      end
      if mapai[priv.indice + 1 + col] == 2 then
         priv.obst.down = true
      else
         priv.obst.down = false
      end
      if mapai[priv.indice + 2] == 2 then
         priv.obst.right = true
      else
         priv.obst.right = false
      end
   end

   function matrixlimit(mapai, col)
      if priv.indice + 1 - col <= 0 then
         priv.block.up = true
      else
         priv.block.up = false
      end
      if priv.indice + 1 + col > #mapai then
         priv.block.down = true
      else
         priv.block.down = false
      end
      if (priv.indice+1)%col == 1 or priv.indice == 0 then --izquierdo
         priv.block.left = true
      else
         priv.block.left = false
      end
      if (1+priv.indice)/col == math.floor(1+priv.indice/col) then --checa si está en extremo derch
         priv.block.right = true
      else
         priv.block.right = false
      end
   end

   function publ:move(dt, mapai, tw, th, col)
      local delay=0.1
      priv.time = priv.time + dt
      map.tilewidth, map.tileheight = tw, th
      if priv.time > delay then
         if not ai then
            if not priv.moving then
               if love.keyboard.isDown("w") then
                  priv.moving = true
                  priv.dir = "up"
               end
               if love.keyboard.isDown("a") then
                  priv.moving = true
                  priv.dir = "left"
               end
               if love.keyboard.isDown("s") then
                  priv.moving = true
                  priv.dir = "down"
               end
               if love.keyboard.isDown("d") then
                  priv.moving = true
                  priv.dir = "right"
               end
            else
               obst(mapai, col)
               matrixlimit(mapai, col)

               changepos(priv.dir, tw, th, col)
               if priv.mtp:isOnPipe(priv.indice) then
                   priv.pos.x, priv.pos.y = priv.mtp:topipe()
                   refreshPos(priv.pos.x, priv.pos.y, col)
                end
            end
         end
      end
   end

   function publ:drawCharacter()
      love.graphics.setColor(255,100,100,255)
      love.graphics.rectangle("fill", priv.pos.x*map.tilewidth, priv.pos.y*map.tileheight, priv.dim.w, priv.dim.h)
      love.graphics.setColor(255,255,255)
      love.graphics.print(priv.pos.x..","..priv.pos.y..";"..priv.indice, love.graphics.getWidth()/2, love.graphics.getHeight() - 200)
   end
   return publ
end

return character
