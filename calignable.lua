Class = require 'hump.class'
Vector = require 'hump.vector'

CAlignable = Class
{
	name = "CAlignable",
	inherits = { Component },
	function(self, gameObj)
		Component.construct(self, gameObj, false)

		self.dependencies = { }

		self.originName = "top left"
		self.oldOriginName = self.originName
		self.origin = Vector.zero
	end
}

function CAlignable:start()
end

function CAlignable:updateOrigin()
	if self.originName == "top left" then
		self.origin = Vector(0, 0)
	elseif self.originName == "top" then
		self.origin = Vector(0.5, 0)
	elseif self.originName == "top right" then
		self.origin = Vector(1, 0)
	elseif self.originName == "left" then
		self.origin = Vector(0, 0.5)
	elseif self.originName == "center" then
		self.origin = Vector(0.5, 0.5)
	elseif self.originName == "right" then
		self.origin = Vector(1, 0.5)
	elseif self.originName == "bottom left" then
		self.origin = Vector(0, 1)
	elseif self.originName == "bottom" then
		self.origin = Vector(0.5, 1)
	elseif self.originName == "bottom right" then
		self.origin = Vector(1, 1)
	end
end

function CAlignable:update(dt)
	if self.oldOriginName ~= self.originName then
		self:updateOrigin()
		self.oldOriginName = self.originName
	end
end

function CAlignable:get_blank_data()
	return {
		originName = "top left",
		origin = Vector.zero
	}
end

function CAlignable:get_data()
	return {
		originName = self.originName,
		origin = self.origin
	}
end

function CAlignable:build(data)
	self.originName = data.originName
	self.origin = data.origin
end

ComponentFactory.get():register("CAlignable", function(...) return CAlignable(unpack(arg)) end)