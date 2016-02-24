local tMatrix = {}

tMatrix.a={ {4,8,1}, {19,21,1} }
tMatrix.b={ {15,16,1}, {22,5,1} }

function tMatrix.iftravel(ocord)
   for i=1, #tMatrix.a do
      if tMatrix.a[i][1] == ocord[1] then
         for j=1, #tMatrix.a do
            if tMatrix.a[j][2] == ocord[2] then
               for k=1, #tMatrix.a do
                  if tMatrix.a[k][3] == ocord[3] then
                     return true 
                  end
               end
            end
         end
      end
   end
   for i=1, #tMatrix.b do
      if tMatrix.b[i][1] == ocord[1] then
         for j=1, #tMatrix.b do
            if tMatrix.b[j][2] == ocord[2] then
               for k=1, #tMatrix.b do
                  if tMatrix.b[k][3] == ocord[3] then
                     return true 
                  end
               end
            end
         end
      end
   end
   return false
end

function tMatrix.travel(ocord) --ocord coordenadas origen
   for i=1, #tMatrix.a do
      if tMatrix.a[i][1] == ocord[1] then
         for j=1, #tMatrix.a do
            if tMatrix.a[j][2] == ocord[2] then
               for k=1, #tMatrix.a do
                  if tMatrix.a[k][3] == ocord[3] then
                     return tMatrix.b[i][1], tMatrix.b[i][2], tMatrix.b[i][3]
                  end
               end
            end
         end
      end
   end
   for i=1, #tMatrix.b do
      if tMatrix.b[i][1] == ocord[1] then
         for j=1, #tMatrix.b do
            if tMatrix.b[j][2] == ocord[2] then
               for k=1, #tMatrix.b do
                  if tMatrix.b[k][3] == ocord[3] then
                     return tMatrix.a[i][1], tMatrix.a[i][2], tMatrix.a[i][3]
                  end
               end
            end
         end
      end
   end
   return ocord
end

return tMatrix
