local moim = {}

function moim.newlayer(mapa, layer)
   local self = {}

   if mapa.layers[layer].type == "tilelayer" then
      local quad = {} --[a][b] a=pagina de tiles
                        -- b=nº de tile
      self.indet = 0 -- the index to the tilesets a
      self.tilecount = {}
      self.matrixaux = {}

      for i=1, #mapa.tilesets do
         quad[i] = {}
      end
      
      function self:showlayer(x,y)
         x = x or 0
         y = y or 0
         love.graphics.draw(self.mapaBatch,x,y)
      end

      function self:getmap()
         return self.matrixaux, mapa.tilesets[self.indet].tilewidth, mapa.tilesets[self.indet].tileheight, mapa.width 
      end

      function self:getntiles()
         return #quad[self.indet]
      end

      function self:readlayer()
         local x,y

         for i,v in ipairs(mapa.layers[layer].data) do
            if self.indet > 1 then
               v = v - mapa.tilesets[self.indet].firstgid + 1 
            end
            self.matrixaux[i] = v
            if (i%mapa.layers[layer].width) == 0 then
                  x=mapa.layers[layer].width
                  y=i/mapa.layers[layer].width
            else
                  x=i%mapa.layers[layer].width
                  y=math.floor(i/mapa.layers[layer].width) + 1 
            end

            if v ~= 0 then
               self.mapaBatch:add(quad[self.indet][v], (x-1)*mapa.tilesets[self.indet].tilewidth, (y-1)*mapa.tilesets[self.indet].tileheight)
            end
         end
      end

      function self:newTileset(newTileset, indet)
         self.indet = indet

         local hm = mapa.tilesets[self.indet].imageheight/mapa.tilesets[self.indet].tileheight 
         local hw = mapa.tilesets[self.indet].imagewidth/mapa.tilesets[self.indet].tilewidth 
         self.mapaBatch = love.graphics.newSpriteBatch(newTileset,mapa.width*mapa.height) --crea el mapabatch
         for i=1, hm do
            for j=1, hw do
               index = (i-1)*(mapa.tilesets[self.indet].imagewidth/mapa.tilesets[self.indet].tilewidth) + j
               quad[self.indet][index]=love.graphics.newQuad((j-1)*mapa.tilesets[self.indet].tileheight, (i-1)*mapa.tilesets[self.indet].tilewidth, mapa.tilesets[self.indet].tilewidth, mapa.tilesets[self.indet].tileheight, mapa.tilesets[self.indet].imagewidth, mapa.tilesets[self.indet].imageheight)
            end
         end
      end
   elseif mapa.layers[layer].type == "objectgroup" then
       self.aux_k = nil

       function self:isOnPipe(indice)
         local i,j

         if indice == 0 then
            i=0 j=0
        else
            j=(indice+1) % (mapa.width) - 1
            i=math.floor(indice/mapa.width)
          end

        for k=1, #mapa.layers[layer].objects do
            if mapa.layers[layer].objects[k].x == j * mapa.tilewidth and
               mapa.layers[layer].objects[k].y == i * mapa.tileheight then
               self.aux_k = k
               return  true 
            end
         end

         return false
        end

      function self:topipe()
          return    mapa.layers[layer].objects[self.aux_k].properties.tpx,
                    mapa.layers[layer].objects[self.aux_k].properties.tpy,
                    mapa.layers[layer].objects[self.aux_k].properties.map
      end
   end
   return self
end

return moim
