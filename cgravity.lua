Class = require 'hump.class'
Vector = require 'hump.vector'

CGravity = Class
{
	name = "CGravity",
	inherits = { Component },
	function(self, gameObj, grav)
		Component.construct(self, gameObj, false)

		self.dependencies = { CPositionable = true }

		self.gravity = grav or 98
		self.velocity = Vector(0, 0)
		self.onGround = false
	end
}

function CGravity:start()
	self.positionable = self:get_component("CPositionable")
end

function CGravity:update(dt)
	if self.onGround then
		self.velocity = Vector.zero
	else
		self.velocity = self.velocity + Vector(0, self.gravity) * dt
		self.positionable.position = self.positionable.position + self.velocity * dt
	end
end

function CGravity:get_blank_data()
	return { gravity = Vector(0, 0) }
end

function CGravity:get_data()
	return { gravity = self.gravity }
end

function CGravity:build(data)
	self.gravity = data.gravity
end

ComponentFactory.get():register("CGravity", function(...) return CGravity(unpack(arg)) end)