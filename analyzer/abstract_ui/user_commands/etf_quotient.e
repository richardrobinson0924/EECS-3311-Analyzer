note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_QUOTIENT
inherit
	ETF_QUOTIENT_INTERFACE
create
	make
feature -- command
	quotient
    	do
    		if attached model.current_instruction as ci then
				ci.expression.set_next_null_operand_to (create {LOUVRE_BINARY_EXPRESSION}.make ({LOUVRE_BINARY_OPERATOR}.quotient))
			else
				model.set_status ("Error (An assignment instruction is not currently being specified).")
			end

			model.set_out (model.to_string)

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
