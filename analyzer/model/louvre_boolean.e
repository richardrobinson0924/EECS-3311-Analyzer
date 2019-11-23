note
	description: "Summary description for {LOUVRE_BOOLEAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_BOOLEAN
inherit
	LOUVRE_ATOMIC_OPERAND[BOOLEAN]

create
	make_value

feature
	return_type: LOUVRE_CLASS
		once
			Result := {CLASS_POOL_ACCESS}.pool.boolean
		end

feature {NONE} -- Initialization

	make_value(i: BOOLEAN)
			-- Initialization for `Current'.
		do
			value := i
			name := "BOOLEAN"
			create routines.make (0)
		end

end

