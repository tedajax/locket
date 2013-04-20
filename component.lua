Class = require 'hump.class'
Signal = require 'hump.signal'
dofile 'gameobject'
dofile 'componentfactory'

Component = Class
{
	name = "CBase",
	init = function(self, gameObj, bRender)
		self.dependencies = {}
		self.gameObject = gameObj
		self.bEnabled = true
		self.bRenderable = bRender

		self.gameObject.signal.register('req_start', self:req_start)
		self.gameObject.signal.register('req_update', self:req_update)
			
		if self.bRenderable then
			self.gameObject.signal.register('req_render', self:req_render)
		end

		-- not sure if this will work
		ComponentFactory.get():register(self.name, self.init)
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
	self.gameObject.signal.remove('req_start', self:start)
	self.gameObject.signal.remove('req_update', self:update)
	self.gameObject.signal.remove('req_render', self:render)
end