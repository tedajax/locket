Class = require 'hump.class'
Signal = require 'hump.signal'
dofile 'component'
dofile 'componentfactory'

GameObject = Class
{
	name = "GameObject",
	init = function(self)
		self.objName = 'GameObject'
		self.signal = Signal.new()
		self.components = {}
		self.bEnabled = true

		Signal.register('req_start', self:req_start)
		Signal.register('req_update', self:req_update)
		Signal.register('req_render', self:req_render)
	end
}

function GameObject:req_start()
	self:start()
end

function GameObject:req_update()
	if self.bEnabled then
		self:update()
	end
end

function GameObject:req_render()
	if self.bEnabled then
		self.render()
	end
end

function GameObject:start()
	for cname, comp in pairs(self.components) do
		comp:start()
	end
end

function GameObject:update()
	for cname, comp in pairs(self.components) do
		comp:update()
	end
end

function GameObject:render()
	for cname, comp in pairs(self.components) do
		comp:render()
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
	local comp = ComponentFactory.get():new_component(cname, self, unpack(args))
	if self:has_dependencies(comp.dependencies) then
		if not self.components[cname] then
			self.components[cname] = comp
		else
			return nil
		end
	else
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

	Signal.remove('req_start', self:req_start)
	Signal.remove('req_update', self:req_update)
	Signal.remove('req_render', self:req_render)
end