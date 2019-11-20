note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_BOOL_VALUE
inherit
	ETF_BOOL_VALUE_INTERFACE
create
	make
feature -- command
	bool_value(c: BOOLEAN)
    	do
			-- perform some update on the model state
			if attached model.current_instruction as ci then
				ci.expression.set_next_null_operand_to (create {LOUVRE_BOOLEAN}.make_value (c))
				model.update_current_instruction
				model.set_status ("OK.")
				model.set_out (model.to_string)
			else
    			model.set_status("Error (An assignment instruction is not currently being specified).")
			end

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
