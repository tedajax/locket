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

function Component:req_pre_update(dt)
	if self.bEnabled then
		self:pre_update(dt)
	end
end

function Component:req_update(dt)
	if self.bEnabled then
		self:update(dt)
	end
end

function Component:req_post_update(dt)
	if self.bEnabled then
		self:post_update(dt)
	end
end

function Component:req_render()
	if self.bEnabled then
		self:render()
	end
end

function Component:start()

end

function Component:pre_update(dt)
end

function Component:update(dt)

end

function Component:post_update(dt)

end

function Component:render()
	
end

function Component:destroy()
	
end

function Component:get_blank_data()
	return {}
end

-- sets the component fields based on a data table
-- useful for a simple 'prefab' system
function Component:build(data)
	
end

function Component:get_component(cname)
	return self.gameObject:get_component(cname)
end

function Component:receive_message(msg, ...)
	if self[msg] ~= nil and type(self[msg]) == "function" then
		self[msg](self, unpack(arg))
	end
end

function Component:send_message(msg, ...)
	self.gameObject:send_message(msg, unpack(arg))
end

ComponentFactory.get():register("CBase", function(...) return Component(unpack(arg)) end)