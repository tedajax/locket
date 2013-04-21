Class = require 'hump.class'
Vector = require 'hump.vector'

CSpriteRenderer = Class
{
	name = "CSpriteRenderer",
	inherits = { Component },
	function(self, gameObj)
		Component.construct(self, gameObj, true)

		self.dependencies = { CPositionable = true, CAlignable = true, CColorable = true }

		self.image = nil
	end
}

function CSpriteRenderer:get_blank_data()
	return { image = nil }
end

function CSpriteRenderer:get_data()
	return { image = self.image }
end

function CSpriteRenderer:build(data)
	self.image = data.image
end


ComponentFactory.get():register("CSpriteRenderer", function(...) return CSpriteRenderer(unpack(arg)) end)