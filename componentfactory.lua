Class = require 'hump.class'
Signal = require 'hump.signal'

ComponentFactory = Class
{
	name = 'ComponentFactory',
	function(self)
		self.factoryTable = {}
	end
}

function ComponentFactory.get()
	if ComponentFactory.instance == nil then
		ComponentFactory.instance = ComponentFactory()
	end
	return ComponentFactory.instance
end

function ComponentFactory:register(name, constructor)
	assert(type(name) == "string", "Component name must be string")
	assert(type(constructor) == "function", "Component constructor must be function")

	if not self.factoryTable[name] then
		self.factoryTable[name] = constructor
	end
end

function ComponentFactory:new_component(ctype, ...)
	assert(type(ctype) == "string", "Argument \'ctype\' must be string")
	assert(self.factoryTable[ctype], "No component registered for type: \'"..ctype.."\'.  Did you forget to register it?")
	return self.factoryTable[ctype](unpack(arg))
end

	