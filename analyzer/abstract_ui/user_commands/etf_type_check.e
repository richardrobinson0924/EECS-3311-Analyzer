note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_TYPE_CHECK
inherit
	ETF_TYPE_CHECK_INTERFACE
create
	make
feature -- command
	type_check
    	do
    		if attached model.current_instruction as ci then
				model.set_status ("Error (An assignment instruction is currently being specified for routine " + ci.routine.name + " in class " + ci.lclass.name + ").")
				model.set_out (model.to_string)
			else
				model.set_status ("OK.")
				model.type_check
			end

			-- perform some update on the model state
			etf_cmd_container.on_change.notify ([Current])
    	end

end
