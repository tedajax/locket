Class = require 'hump.class'
Vector = require 'hump.vector'

CPlatformCollision = Class
{
	name = "CPlatformCollision",
	inherits = { Component },
	function(self, gameObj)
		Component.construct(self, gameObj, false)

		self.dependencies = { CAABoundingBox = true, CGravity = true }
	end
}

function CPlatformCollision:start()
	self.positionable = self:get_component("CPositionable")
	self.collider = self:get_component("CAABoundingBox")
	self.gravity = self:get_component("CGravity")
end

function CPlatformCollision:update(dt)
end

function CPlatformCollision:on_collision_enter(collider)
	local x = self.positionable.position.x
	local y = collider.positionable.position.y - (collider.height / 2 + self.collider.height / 2)
	self.positionable.position = Vector(x, y)
	self.gravity.onGround = true
end

function CPlatformCollision:on_collision_stay(collider)
end

function CPlatformCollision:on_collision_exit(collider)
	self.gravity.onGround = false
end

function CPlatformCollision:get_blank_data()

end

function CPlatformCollision:get_data()
end

function CPlatformCollision:build(data)

end

ComponentFactory.get():register("CPlatformCollision", function(...) return CPlatformCollision(unpack(arg)) end)