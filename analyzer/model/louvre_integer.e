note
	description: "Summary description for {LOUVRE_INTEGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_INTEGER
inherit
	LOUVRE_ATOMIC_OPERAND[INTEGER]

create
	make_with_value

feature
	return_type: LOUVRE_CLASS
		once
			Result := {CLASS_POOL_ACCESS}.pool.integer
		end

feature {NONE} -- Initialization

	make_with_value(i: INTEGER)
			-- Initialization for `Current'.
		do
			value := i
			name := "INTEGER"
			create routines.make (0)
		end

end
