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
    		if attached model.current_instruction as ci then
				model.set_status ("Error (An assignment instruction is currently being specified for routine " + ci.routine.name + " in class " + ci.lclass.name + ").")
			elseif attached {CLASS_POOL_ACCESS}.pool.classes[cn] as clazz then
    			if attached {LOUVRE_ROUTINE} clazz.routines[fn] as routine then
    				if attached {LOUVRE_ATTRIBUTE} routine as att then
    					model.set_status ("Error (Attribute " + fn + " in class " + cn + " cannot be specified with an implementation).")
    				else
    					routine.assignment_instructions.extend(create {LOUVRE_ASSIGNMENT_INSTRUCTION}.make (clazz, routine, n))
						model.set_current_instruction (routine.assignment_instructions.last)

						model.set_status ("OK.")
						model.set_out (model.to_string)
    				end

				else
					model.set_status ("Error (" + fn + " is not an existing feature name in class " + cn + ").")
    			end
    		else
    			model.set_status ("Error (" + cn + " is not an existing class name).")
    		end

    		model.set_out (model.to_string)

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
