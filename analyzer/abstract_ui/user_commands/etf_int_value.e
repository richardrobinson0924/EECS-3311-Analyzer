note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INT_VALUE
inherit
	ETF_INT_VALUE_INTERFACE
create
	make
feature -- command
	int_value(c: INTEGER_32)
    	do
    		if attached model.current_instruction as ci then
				ci.expression.set_next_null_operand_to (create {LOUVRE_INTEGER}.make_with_value (c))
				model.update_current_instruction
				model.set_status ("OK.")
			else
    			model.set_status("Error (An assignment instruction is not currently being specified).")
			end

			model.set_out (model.to_string)

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
