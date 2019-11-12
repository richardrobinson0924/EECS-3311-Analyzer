note
	description: "Summary description for {LOUVRE_ASSIGNMENT_INSTRUCTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_ASSIGNMENT_INSTRUCTION
inherit
	ANY
	redefine out end

create
	make

feature -- Queries
	lclass: LOUVRE_CLASS
	lcommand: LOUVRE_COMMAND
	var: STRING

	out: STRING
		do
			create Result.make_from_string("");
			Result := Result + "  Routine currently being implemented: {" + lclass.name.out + "}." + lcommand.command_name.out + "%N"
			Result := Result + "  Assignment being specified: " + expression + "%N"
		end

	expression: STRING

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS; lcommand_: LOUVRE_COMMAND; var_: STRING)
			-- Initialization for `Current'.
		do
			lclass := lclass_
			lcommand := lcommand_
			var := var_


			expression := "" + var + " := ?"
		end

end
