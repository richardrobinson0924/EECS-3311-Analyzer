note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SUBTRACTION
inherit
	ETF_SUBTRACTION_INTERFACE
create
	make
feature -- command
	subtraction
    	do
    		if attached model.current_instruction as ci then
				ci.expression.set_next_null_operand_to (create {LOUVRE_BINARY_EXPRESSION}.make ({LOUVRE_OPERATOR}.subtraction))
			else
				model.set_status ("Error (Assignment instruction not currently being specified).")
			end

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
