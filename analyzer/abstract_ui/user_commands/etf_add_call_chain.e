note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CALL_CHAIN
inherit
	ETF_ADD_CALL_CHAIN_INTERFACE
create
	make
feature -- command
	add_call_chain(chain: ARRAY[STRING])
		do
    		if attached model.current_instruction as ci then
    			if chain.count = 0 then
    				model.set_status ("Error (Call chain is empty).")
    			else
    				model.add_call_chain (create {LOUVRE_CALL_CHAIN}.make(chain, ci.routine, ci.lclass))
    				model.update_current_instruction
    				model.set_status ("OK.")
    				model.set_out (model.to_string)
    			end
    		else
    			model.set_status("Error (An assignment instruction is not currently being specified).")
    		end

    		model.set_out (model.to_string)

			-- perform some update on the model state

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
