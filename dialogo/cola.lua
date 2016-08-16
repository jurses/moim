local cola = {}

function cola.new(size)
    local self = {}

    self.size = size or 0
    self.cola = {}

    function self:add(toadd)
        self.size = self.size + 1
        table.insert(self.cola, toadd)
    end

    function self:out()
        if self.size == 0 then
            print("Queue is already empty!")
            return -1
        else
            return table.remove(self.cola,1)
        end
    end

    function self:getsize()
        return self.size
    end

    return self
end

return cola
