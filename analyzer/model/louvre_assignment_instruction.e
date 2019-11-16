note
	description: "Summary description for {LOUVRE_ASSIGNMENT_INSTRUCTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_ASSIGNMENT_INSTRUCTION

create
	make

feature -- Queries
	var: STRING
	routine: LOUVRE_ROUTINE
	lclass: LOUVRE_CLASS

	expression: detachable EXPRESSION

	to_string: STRING
		do
			Result := "" + var + " := "

			if attached expression as ae then
				Result := Result + ae.out
			else
				Result := Result + "?"
			end
		end

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS; routine_: LOUVRE_ROUTINE; var_: STRING)
			-- Initialization for `Current'.
		do
			var := var_
			routine := routine_
			lclass := lclass_
		end

end
