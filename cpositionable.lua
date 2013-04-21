Class = require 'hump.class'
Signal = require 'hump.signal'
Vector = require 'hump.vector'

CPositionable = Class
{
	name = "CPositionable",
	inherits = { Component },
	function(self, gameObj)
		Component.construct(self, gameObj, false)

		self.position = Vector(50, 50)
	end
}

ComponentFactory.get():register("CPositionable", function(...) return CPositionable(unpack(arg)) end)