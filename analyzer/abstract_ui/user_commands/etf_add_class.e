note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CLASS
inherit
	ETF_ADD_CLASS_INTERFACE
create
	make
feature -- command
	add_class(cn: STRING)
		require else
			add_class_precond(cn)
    	do
			-- perform some update on the model state
			if attached model.current_instruction as ci then
				model.set_status ("Error (An assignment instruction is currently being specified for routine " + ci.routine.name + " in class " + ci.lclass.name + ").")
			elseif  {CLASS_POOL_ACCESS}.pool.classes.has (cn) then
				model.set_status ("Error (" + cn + " is already an existing class name).")
			else
				model.add_class(cn)
				model.set_status("OK.")
				model.set_out (model.to_string)
			end

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
