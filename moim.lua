local moim = {}

function moim.newlayer(mapa, layer)
   local priv = {}
   local publ = {}

   if mapa.layers[layer].type == "tilelayer" then
      local quad = {} --[a][b] a=pagina de tiles
                        -- b=nº de tile
      priv.indet = 0 -- the index to the tilesets a
      priv.tilecount = {}
      priv.matrixaux = {}

      for i=1, #mapa.tilesets do
         quad[i] = {}
      end
      
      function publ:showlayer(x,y)
         x = x or 0
         y = y or 0
         love.graphics.draw(priv.mapaBatch,x,y)
      end

      function publ:getmap()
         return priv.matrixaux, mapa.tilesets[priv.indet].tilewidth, mapa.tilesets[priv.indet].tileheight, mapa.width 
      end

      function publ:getntiles()
         return #quad[priv.indet]
      end

      function publ:readlayer()
         local x,y

         for i,v in ipairs(mapa.layers[layer].data) do
            if priv.indet > 1 then
               v = v - mapa.tilesets[priv.indet].firstgid + 1 
            end
            priv.matrixaux[i] = v
            if (i%mapa.layers[layer].width) == 0 then
                  x=mapa.layers[layer].width
                  y=i/mapa.layers[layer].width
            else
                  x=i%mapa.layers[layer].width
                  y=math.floor(i/mapa.layers[layer].width) + 1 
            end

            if v ~= 0 then
               priv.mapaBatch:add(quad[priv.indet][v], (x-1)*mapa.tilesets[priv.indet].tilewidth, (y-1)*mapa.tilesets[priv.indet].tileheight)
            end
         end
      end

      function publ:newTileset(newTileset, indet)
         priv.indet = indet

         local hm = mapa.tilesets[priv.indet].imageheight/mapa.tilesets[priv.indet].tileheight 
         local hw = mapa.tilesets[priv.indet].imagewidth/mapa.tilesets[priv.indet].tilewidth 
         priv.mapaBatch = love.graphics.newSpriteBatch(newTileset,mapa.width*mapa.height) --crea el mapabatch
         for i=1, hm do
            for j=1, hw do
               index = (i-1)*(mapa.tilesets[priv.indet].imagewidth/mapa.tilesets[priv.indet].tilewidth) + j
               quad[priv.indet][index]=love.graphics.newQuad((j-1)*mapa.tilesets[priv.indet].tileheight, (i-1)*mapa.tilesets[priv.indet].tilewidth, mapa.tilesets[priv.indet].tilewidth, mapa.tilesets[priv.indet].tileheight, mapa.tilesets[priv.indet].imagewidth, mapa.tilesets[priv.indet].imageheight)
            end
         end
      end
   elseif mapa.layers[layer].type == "objectgroup" then
       priv.aux_k = nil

       function publ:isOnPipe(indice)
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
               priv.aux_k = k
               return  true 
            end
         end

         return false
        end

      function publ:topipe()
          return    mapa.layers[layer].objects[priv.aux_k].properties.tpx,
                    mapa.layers[layer].objects[priv.aux_k].properties.tpy,
                    mapa.layers[layer].objects[priv.aux_k].properties.map
      end
   end
   return priv
end

return moim
