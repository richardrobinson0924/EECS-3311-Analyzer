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
	make

feature
	name: STRING
		once
			Result := "INTEGER"
		end

feature {NONE} -- Initialization

	make(i: INTEGER)
			-- Initialization for `Current'.
		do
			value := i
		end

end
