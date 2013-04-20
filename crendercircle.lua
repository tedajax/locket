Class = require 'hump.class'
Signal = require 'hump.signal'
Vector = require 'hump.vector'
dofile 'component'
dofile 'componentfactory'
dofile 'gameobject'
dofile 'cpositionable'

CRenderCircle = Class
{
	name = "CRenderCircle",
	inherits = { Component },
	init = function(self, gameObj)
		Component.init(self, gameObj, true)

		self.dependencies = { "CPositionable" }

		self.radius = 16
		self.position = nil
	end
}

function CRenderCircle:start()
	self.position = self:get_component("CPositionable").position
end

function CRenderCircle:render()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.circle(self.position.x, self.position.y, self.radius)
end