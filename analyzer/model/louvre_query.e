note
	description: "Summary description for {LOUVRE_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_QUERY
inherit
	LOUVRE_ROUTINE redefine out end

create
	make

feature
	return_type: LOUVRE_CLASS
	lclass: LOUVRE_CLASS
	parameters: ARRAY[TUPLE[pn: STRING; pt: LOUVRE_CLASS]]

	out: STRING
		do
			Result := "        " + "+ " + name

			if parameters.count > 0 then
				Result := Result + "("

				across parameters as p loop
					Result := Result + p.item.pt.name
					if p.cursor_index < parameters.count then
						Result := Result + ";"
					end
				end

				Result := Result + ")"
			end

			Result := Result + ": " + return_type.name
		end

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS ; query_name: STRING ; parameters_: ARRAY[TUPLE[pn: STRING; pt: LOUVRE_CLASS]] ; return_type_: LOUVRE_CLASS)
			-- Initialization for `Current'.
		do
			lclass := lclass_
			name := query_name
			return_type := return_type_
			parameters := parameters_

			create assignment_instructions.make (0)
		end

end
