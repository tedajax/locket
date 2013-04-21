Class = require 'hump.class'
Signal = require 'hump.signal'

Component = Class
{
	name = "CBase",
	function(self, gameObj, bRender)
		self.dependencies = {}
		self.gameObject = gameObj
		self.bEnabled = true
		self.bRenderable = bRender
	end	
}

function Component:req_start()
	self:start()
end

function Component:req_update()
	if self.bEnabled then
		self:update()
	end
end

function Component:req_render()
	if self.bEnabled then
		self:render()
	end
end

function Component:start()

end

function Component:update()

end

function Component:render()
	
end

function Component:destroy()
	
end

function Component:get_component(cname)
	return self.gameObject:get_component(cname)
end

ComponentFactory.get():register("CBase", function(...) return Component(unpack(arg)) end)