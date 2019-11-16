note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ASSIGNMENT_INSTRUCTION
inherit
	ETF_ADD_ASSIGNMENT_INSTRUCTION_INTERFACE
create
	make
feature -- command
	add_assignment_instruction(cn: STRING ; fn: STRING ; n: STRING)
		require else
			add_assignment_instruction_precond(cn, fn, n)
    	do
    		if attached model.classes[cn] as clazz then
    			if attached clazz.routines[fn] as routine then
    				routine.assignment_instructions.extend(create {LOUVRE_ASSIGNMENT_INSTRUCTION}.make (clazz, routine, n))
					model.set_current_instruction (routine.assignment_instructions.last)
				else
					model.set_status ("Error (" + fn + " is not an existing feature name in class " + cn + ").")
    			end
    		else
    			model.set_status ("Error (Class " + cn + "is not an existing class)")
    		end

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
