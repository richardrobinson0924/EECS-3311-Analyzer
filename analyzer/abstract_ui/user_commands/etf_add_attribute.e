note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ATTRIBUTE
inherit
	ETF_ADD_ATTRIBUTE_INTERFACE
create
	make
feature -- command
	add_attribute(cn: STRING ; fn: STRING ; ft: STRING)
		require else
			add_attribute_precond(cn, fn, ft)
    	do
    		if attached model.current_instruction as ci then
				model.set_status ("Error (An assignment instruction is currently being specified for routine " + ci.routine.name + " in class " + ci.lclass.name + ").")
			elseif attached {LOUVRE_CLASS}  {CLASS_POOL_ACCESS}.pool.classes[cn] as clazz then
				if clazz.routines.has (fn) then
					model.set_status ("Error (" + fn + " is already an existing feature name in class " + cn + ").")
				elseif attached  {CLASS_POOL_ACCESS}.pool.classes[ft] as type then
					model.add_attribute (clazz, fn, type)
					model.set_status ("OK.")
					model.set_out (model.to_string)
				else
					model.set_status ("Error (Return type does not refer to a primitive type or an existing class: " + ft + ").")
				end
			else
				model.set_status ("Error (" + cn + " is not an existing class name).")
			end


--			elseif not model.classes.has (cn) then
--				model.set_status ("Error (" + cn + " is not an existing class name).")
--			elseif not model.classes.has (ft) then
--				model.set_status ("Error (Type does not exist")
--			elseif model.classes.has (fn) then
--				model.set_status ("Error (" + fn + " is already an existing feature name in class " + cn + ").")
--			else
--				check attached model.classes[ft] as type and then attached model.classes[cn] as clazz then
--					if clazz.has(ft)  then

--					end
--					model.add_attribute (clazz, fn, type)
--					model.set_status ("OK.")
--				end
--			end

			model.set_out (model.to_string)

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
