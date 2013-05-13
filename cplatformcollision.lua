Class = require 'hump.class'
Vector = require 'hump.vector'
require 'datastructs'

CPlatformCollision = Class
{
	name = "CPlatformCollision",
	inherits = { Component },
	function(self, gameObj)
		Component.construct(self, gameObj, false)

		self.dependencies = { CAABoundingBox = true, CPlayerController = true }

		self.groundBlocks = Set()
	end
}

function CPlatformCollision:start()
	self.positionable = self:get_component("CPositionable")
	self.collider = self:get_component("CAABoundingBox")
	self.controller = self:get_component("CPlayerController")
end

function CPlatformCollision:update(dt)
end

function CPlatformCollision:on_collision_enter(collision)
	local x, y = self.positionable.position.x, self.positionable.position.y
	local collider = collision.collider

	self.groundBlocks:add(collider)
	y = collider.positionable.position.y - (collider.height / 2 + self.collider.height / 2)

	self.positionable.position = Vector(x, y)

	if self.groundBlocks.size > 0 then
		self.controller.onGround = true
	end
end

function CPlatformCollision:on_collision_stay(collision)
	local collider = collision.collider
	local x = self.positionable.position.x
	local y = collider.positionable.position.y - (collider.height / 2 + self.collider.height / 2)
	self.positionable.position = Vector(x, y)
	self.controller.onGround = true
end

function CPlatformCollision:on_collision_exit(collision)
	local collider = collision.collider
	self.groundBlocks:remove(collider)
	if self.groundBlocks.size == 0 then
		self.controller.onGround = false
	end
end

function CPlatformCollision:get_blank_data()
	return {}
end

function CPlatformCollision:get_data()
	return {}
end

function CPlatformCollision:build(data)

end

ComponentFactory.get():register("CPlatformCollision", function(...) return CPlatformCollision(unpack(arg)) end)