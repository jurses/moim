local character = {}
local pipe = require("moim")

function character.newCharacter(pos, dim, ai)
   local self = {}
   local map = {}

   self.pos, self.dim = {}, {}
   self.indice = 0
   self.time = 0
   self.block = {up = false, down = false, right = false, left = false}
   self.obst = {up = false, down = false, right = false, left = false}
   self.gonnatravel = {up = false, down = false, right = false, left = false}

   map.tilewidth, map.tileheight = nil

   self.pos = pos
   self.dim = {w = dim.w or 16, h = dim.h or 16}

   self.dir = ""
   self.moving = false
   self.mtp = nil

   function self:setpipes(mapPipe, layerpipe)
      self.mtp = pipe.newlayer(mapPipe, layerpipe)
   end

   function changepos(dir, tw, th, col) --self.indice no funciona con los extremos !!!
      if dir == "up" and not self.block.up and not self.obst.up then
         self.indice = self.indice - col
         self.pos.y = self.pos.y - 1
      end
      if dir == "down" and not self.block.down and not self.obst.down then
         self.indice = self.indice + col
         self.pos.y = self.pos.y + 1
      end
      if dir == "right" and not self.block.right and not self.obst.right then
         self.indice = self.indice + 1
         self.pos.x = self.pos.x + 1 
      end

      if dir == "left" and not self.block.left and not self.obst.left then
         self.indice = self.indice - 1
         self.pos.x = self.pos.x - 1
      end
      self.moving = false
      self.time = 0
   end

   function obst(mapai, col)
      if mapai[self.indice + 1 - col] == 2 then
         self.obst.up = true
      else
         self.obst.up = false
      end
      if mapai[self.indice] == 2 then
         self.obst.left = true
      else
         self.obst.left = false
      end
      if mapai[self.indice + 1 + col] == 2 then
         self.obst.down = true
      else
         self.obst.down = false
      end
      if mapai[self.indice + 2] == 2 then
         self.obst.right = true
      else
         self.obst.right = false
      end
   end

   function obst(mapai, col)
      if mapai[self.indice + 1 - col] == 3 then
         self.gonnatravel.up = true
      else
         self.gonnatravel.up = false
      end
      if mapai[self.indice] == 3 then
         self.gonnatravel.left = true
      else
         self.gonnatravel.left = false
      end
      if mapai[self.indice + 1 + col] == 3 then
         self.gonnatravel.down = true
      else
         self.gonnatravel.down = false
      end
      if mapai[self.indice + 2] == 3 then
         self.gonnatravel.right = true
      else
         self.gonnatravel.right = false
      end
   end

   function ispipe(mapai)
      if self.gonnatravel.up == true and self.dir == "up" then
         return true
      end
      if self.gonnatravel.down == true and self.dir == "down" then
         return true
      end
      if self.gonnatravel.left == true and self.dir == "left" then
         return true
      end
      if self.gonnatravel.right == true and self.dir == "right" then
         return true
      end
      return false
   end
 
   function matrixlimit(mapai, col)
      if self.indice + 1 - col <= 0 then
         self.block.up = true
      else
         self.block.up = false
      end
      if self.indice + 1 + col > #mapai then
         self.block.down = true
      else
         self.block.down = false
      end
      if (self.indice+1)%col == 1 or self.indice == 0 then --izquierdo 
         self.block.left = true
      else
         self.block.left = false
      end
      if (1+self.indice)/col == math.floor(1+self.indice/col) then --checa si está en extremo derch
         self.block.right = true
      else
         self.block.right = false
      end
   end

   function self:move(dt, mapai, tw, th, col)
      local delay=0.1
      self.time = self.time + dt
      map.tilewidth, map.tileheight = tw, th
      if self.time > delay then
         if not ai then
            if not self.moving then
               if love.keyboard.isDown("w") then
                  self.moving = true
                  self.dir = "up"
               end
               if love.keyboard.isDown("a") then
                  self.moving = true
                  self.dir = "left"
               end
               if love.keyboard.isDown("s") then
                  self.moving = true
                  self.dir = "down"
               end
               if love.keyboard.isDown("d") then
                  self.moving = true
                  self.dir = "right"
               end
            else
               obst(mapai, col)
               matrixlimit(mapai, col)
               --ispipe funciona mal
               if ispipe(mapai) then
                  print("estoy funcionando"..self.indice..","..self.pos.x..","..self.pos.y)
                  self.pos.x, self.pos.y = self.mtp:topipe(self.indice)
               end
               changepos(self.dir, tw, th, col)
            end
         end
      end
   end

   function self:drawCharacter()
      love.graphics.setColor(255,100,100,255)
      love.graphics.rectangle("fill", self.pos.x*map.tilewidth, self.pos.y*map.tileheight, self.dim.w, self.dim.h)
      love.graphics.setColor(255,255,255)
      love.graphics.print(self.pos.x..","..self.pos.y..";"..self.indice, love.graphics.getWidth()/2, love.graphics.getHeight() - 200)
   end
   return self
end

return character
