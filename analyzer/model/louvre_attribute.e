note
	description: "Summary description for {LOUVRE_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_ATTRIBUTE

create
	make

feature
	attribute_name: STRING
	type_name: STRING
	lclass: LOUVRE_CLASS

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS; attribute_name_, type_name_: STRING)
			-- Initialization for `Current'.
		do
			lclass := lclass_
			attribute_name := attribute_name_
			type_name := type_name_
		end

end
