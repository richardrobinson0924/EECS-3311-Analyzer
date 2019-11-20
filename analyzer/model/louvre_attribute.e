note
	description: "Summary description for {LOUVRE_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_ATTRIBUTE
inherit
	LOUVRE_RETURNABLE_ROUTINE redefine out end

create
	make

feature
	lclass: LOUVRE_CLASS

	out: STRING
		do
			Result := "        " + "+ " + name + ": " + return_type.name
		end

	java_string: STRING
		do
			Result := "    " + {CLASS_POOL_ACCESS}.pool.get_java_name(return_type) + " " + name + ";"
		end

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS; attribute_name_: STRING; type_class_: LOUVRE_CLASS)
			-- Initialization for `Current'.
		do
			lclass := lclass_
			name := attribute_name_
			return_type := type_class_

			create assignment_instructions.make (0)
			create parameters.make_empty
		end

end
