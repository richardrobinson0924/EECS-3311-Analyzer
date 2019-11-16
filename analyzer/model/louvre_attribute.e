note
	description: "Summary description for {LOUVRE_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_ATTRIBUTE
inherit
	LOUVRE_ROUTINE redefine out end

create
	make

feature
	type_class: LOUVRE_CLASS
	lclass: LOUVRE_CLASS

	out: STRING
		do
			Result := "        " + "+ " + name + ": " + type_class.name
		end

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS; attribute_name_: STRING; type_class_: LOUVRE_CLASS)
			-- Initialization for `Current'.
		do
			lclass := lclass_
			name := attribute_name_
			type_class := type_class_

			create assignment_instructions.make (0)
		end

end
