note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MULTIPLICATION
inherit
	ETF_MULTIPLICATION_INTERFACE
create
	make
feature -- command
	multiplication
    	do
			-- perform some update on the model state
			if attached model.current_instruction as ci then
				ci.expression.set_next_null_operand_to (create {LOUVRE_BINARY_EXPRESSION}.make ({LOUVRE_BINARY_OPERATOR}.multiplication))
				model.set_status ("OK.")
				model.set_out (model.to_string)
			else
				model.set_status ("Error (Assignment instruction not currently being specified).")
			end


			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
