local character = {}
local tMatrix = require("tMatrix")

function character.newCharacter(pos, dim, ai)
   local self = {}
   self.pos, self.dim = {}, {}
   self.indice = 0
   self.time = 0
   self.block = {} -- para los bordes de la matriz
   self.block = {up = false, down = false, right = false, left = false}
   self.obst = {} -- para los objetos del mapa
   self.obst = {up = false, down = false, right = false, left = false}
   self.gonnatravel = {up = false, down = false, right = false, left = false}

   tilewidth, tileheight = nil

   self.pos = pos
   self.dim = {w = dim.w or 16, h = dim.h or 16}

   self.dir = ""
   self.moving = false

   function changepos(dir, tw, th, col) --self.indice no funciona con los extremos !!!
      if dir == "up" and not self.block.up and not self.obst.up then
         self.indice = self.indice - col
--       self.pos.y = self.pos.y - th
         self.pos.y = self.pos.y - 1
      end
      if dir == "down" and not self.block.down and not self.obst.down then
         self.indice = self.indice + col
--       self.pos.y = self.pos.y + th
         self.pos.y = self.pos.y + 1
      end
      if dir == "right" and not self.block.right and not self.obst.right then
         self.indice = self.indice + 1
--       self.pos.x = self.pos.x + tw
         self.pos.x = self.pos.x + 1 
      end

      if dir == "left" and not self.block.left and not self.obst.left then
         self.indice = self.indice - 1
--       self.pos.x = self.pos.x - tw
         self.pos.x = self.pos.x - 1
      end
      self.moving = false
      self.time = 0
   end

   function obst(mapai, col)
      if mapai[self.indice + 1 - col] == 1 or 3 then
         self.obst.up = false
      else
         self.obst.up = true
      end
      if mapai[self.indice] == 1 then
         self.obst.left = false
      else
         self.obst.left = true
      end
      if mapai[self.indice + 1 + col] == 1 then
         self.obst.down = false
      else
         self.obst.down = true
      end
      if mapai[self.indice + 2] == 1 then
         self.obst.right = false
      else
         self.obst.right = true
      end
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
      tilewidth, tileheight = tw, th
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
               changepos(self.dir, tw, th, col)
               if tMatrix.iftravel({self.pos.x, self.pos.y, 1}) then
                  self.pos.x, self.pos.y = tMatrix.travel({self.pos.x, self.pos.y, 1})
                  self.pos.y = self.pos.y + 1
                  self.indice = (self.pos.x - 1) * col + (self.pos.y - 1)
               end
            end
         end
      end
   end

   function self:drawCharacter()
      love.graphics.rectangle("fill", self.pos.x*tilewidth, self.pos.y*tileheight, self.dim.w, self.dim.h)
      love.graphics.print(self.pos.x..","..self.pos.y..";"..self.indice, love.graphics.getWidth()/2, love.graphics.getHeight() - 200)
   end
   return self
end

return character
