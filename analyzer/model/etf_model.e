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
			create s.make_empty
			i := 0
			create classes.make(0)
		end

feature -- model attributes
	s : STRING
	i : INTEGER

	classes: HASH_TABLE[LOUVRE_CLASS, STRING]

	current_instruction: detachable LOUVRE_ASSIGNMENT_INSTRUCTION

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

	add_class(cn: STRING)
		require
			class_name_doesnt_exist: classes[cn] = Void
			no_current_instruction: current_instruction = Void
		do
			classes.put (create {LOUVRE_CLASS}.make (cn), cn)
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("System State: default model state ")
			Result.append ("(")
			Result.append (i.out)
			Result.append (")")
		end

end




