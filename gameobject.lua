Class = require 'hump.class'
Signal = require 'hump.signal'

GameObject = Class
{
	name = "GameObject",
	function(self)
		self.objName = 'GameObject'
		self.signal = Signal.new()
		self.components = {}
		self.bEnabled = true

		self.startFunc = Signal.register('req_start', function() self:req_start() end)
		self.updateFunc = Signal.register('req_update', function() self:req_update() end)
		self.renderFunc = Signal.register('req_render', function() self:req_render() end)
	end
}

function GameObject:req_start()
	self:start()
end

function GameObject:req_update(dt)
	if self.bEnabled then
		self:update(dt)
	end
end

function GameObject:req_render()
	if self.bEnabled then
		self.render()
	end
end

function GameObject:start()
	for cname, comp in pairs(self.components) do
		comp:req_start()
	end
end

function GameObject:update(dt)
	for cname, comp in pairs(self.components) do
		comp:req_update(dt)
	end
end

function GameObject:render()
	for cname, comp in pairs(self.components) do
		comp:req_render()
	end
end

function GameObject:has_dependencies(dependencies)
	if type(dependencies) ~= 'table' then
		return false, "\'dependencies\' not of type <table>"
	end

	for dep, has in pairs(dependencies) do
		if has then
			if not self.components[dep] then
				return false, "GameObject \'"..self.objName.."\' is missing dependency \'"..dep.."\'"
			end
		end
	end

	return true, nil
end

function GameObject:add_component(cname, ...)
	local comp = ComponentFactory.get():new_component(cname, self, unpack(arg))
	local ok, err = self:has_dependencies(comp.dependencies)
	if self:has_dependencies(comp.dependencies) then
		if not self.components[cname] then
			self.components[cname] = comp
		else
			return nil
		end
	else
		print(err)
		return nil
	end
	
	return comp
end

function GameObject:remove_component(cname)
	local comp = self.components[cname]
	if comp then
		comp:destroy()
		self.components[cname] = nil
		return comp
	else
		return nil
	end
end

function GameObject:get_component(cname)
	return self.components[cname]
end

function GameObject:destroy()
	for cname, comp in pairs(self.components) do
		self:RemoveComponent(comp)
	end

	Signal.remove('req_start', self.startFunc)
	Signal.remove('req_update', self.updateFunc)
	Signal.remove('req_render', self.renderFunc)
end