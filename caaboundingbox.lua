Class = require 'hump.class'
Vector = require 'hump.vector'

CAABoundingBox = Class
{
	name = "CAABoundingBox",
	inherits = { Component },
	function(self, gameObj, staticObj)
		Component.construct(self, gameObj, true)

		self.dependencies = { CPositionable = true, CAlignable = true}

		self.layer = "default"
		self.collidesWith = { default = true, wall = true }

		self.cells = nil
		self.static = false
		if staticObj ~= nil then self.static = staticObj end

		self.width = 64
		self.height = 64

		self.collCount = 0
		self.isColliding = false
		self.collidingWith = {}

		self.debugOn = true
	end
}

function CAABoundingBox:start()
	self.positionable = self:get_component("CPositionable")
	self.alignable = self:get_component("CAlignable")
end

function CAABoundingBox:left()
	local ox = self.alignable.origin.x * self.width

	return self.positionable.position.x - ox
end

function CAABoundingBox:right()
	local ox = self.alignable.origin.x * self.width

	return self.positionable.position.x + self.width - ox
end

function CAABoundingBox:top()
	local oy = self.alignable.origin.y * self.height

	return self.positionable.position.y - oy
end

function CAABoundingBox:bottom()
	local oy = self.alignable.origin.y * self.height

	return self.positionable.position.y + self.height - oy
end

function CAABoundingBox:topleft()
	return Vector(self:left(), self:top())
end

function CAABoundingBox:topright()
	return Vector(self:right(), self:top())
end

function CAABoundingBox:bottomleft()
	return Vector(self:left(), self:bottom())
end

function CAABoundingBox:bottomright()
	return Vector(self:right(), self:bottom())
end

function CAABoundingBox:on_collision_enter(collider)
	self.collidingWith[collider] = true
	self.collCount = self.collCount + 1
	if self.collCount > 0 then self.isColliding = true end
end

function CAABoundingBox:on_collision_stay(collider)
end

function CAABoundingBox:on_collision_exit(collider)
	self.collidingWith[collider] = false
	self.collCount = self.collCount - 1
	if self.collCount <= 0 then self.isColliding = false end
end

function CAABoundingBox:collides(other)
	if self.collidesWith[other.layer] then
		return self:right() >= other:left() and self:left() <= other:right() and
	   		   self:bottom() >= other:top() and self:top() <= other:bottom()
	else
		return false
	end
end

function CAABoundingBox:render()
	if not self.debugOn then return end

	local ox = self.alignable.origin.x * self.width
	local oy = self.alignable.origin.y * self.height

	if self.isColliding then
		love.graphics.setColor(255, 0, 0)
	else
		love.graphics.setColor(0, 255, 0)
	end
	love.graphics.rectangle("line", self.positionable.position.x - ox, self.positionable.position.y - oy, self.width, self.height)
end

ComponentFactory.get():register("CAABoundingBox", function(...) return CAABoundingBox(unpack(arg)) end)