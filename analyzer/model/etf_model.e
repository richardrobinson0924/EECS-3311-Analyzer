note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create classes.make(0)
			status := ""
		end

feature -- model attributes
	classes: HASH_TABLE[LOUVRE_CLASS, STRING]

	current_instruction: detachable LOUVRE_ASSIGNMENT_INSTRUCTION

feature {NONE}
	status: STRING

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
		end

	reset
			-- Reset model state.
		do
			make
		end

	set_current_instruction(i: detachable LOUVRE_ASSIGNMENT_INSTRUCTION)
		do
			current_instruction := i
		end

	add_class(cn: STRING)
		require
			class_name_doesnt_exist: classes[cn] = Void
			no_current_instruction: current_instruction = Void
		do
			classes.put (create {LOUVRE_CLASS}.make (cn), cn)
		end

	add_command(cn: STRING ; command_name: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]])
		do
			check attached classes[cn] as clazz then
				clazz.commands.put (create {LOUVRE_COMMAND}.make (clazz, command_name, ps), command_name);
			end
		end



	set_status(s: STRING)
		do

		end

feature -- queries
	out : STRING
		do
			Result := "  Status: " + status + "%N"
			Result := Result + "  Number of classes being specified: " + classes.count.out + "%N"

			across classes is c loop
				Result := Result + c.out
			end
		end

end
