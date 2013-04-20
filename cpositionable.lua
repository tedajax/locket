Class = require 'hump.class'
Signal = require 'hump.signal'
Vector = require 'hump.vector'
dofile 'component'
dofile 'componentfactory'
dofile 'gameobject'

CPositionable = Class
{
	name = "CPositionable",
	inherits = { Component },
	init = function(self, gameObj)
		Component.init(self, gameObj, false)

		self.position = Vector(0, 0)
	end
}
