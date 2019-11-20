note
	description: "Summary description for {LOUVRE_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_QUERY
inherit
	LOUVRE_RETURNABLE_ROUTINE redefine out end

create
	make

feature
	lclass: LOUVRE_CLASS

	java_string: STRING
		do
			Result := "      " + return_type.name + " " + name + "("

			across parameters as tuple loop
				Result := Result + {CLASS_POOL_ACCESS}.pool.get_java_name (tuple.item.type) + " " + tuple.item.name

				if tuple.cursor_index /= parameters.count then
					Result := Result + ","
				end
			end

			Result := Result + ") + {%N"

			across assignment_instructions is ai loop
				Result := Result + "        " + ai.java_string + "%N"
			end

			Result := Result + "}"
		end

	out: STRING
		do
			Result := "        " + "+ " + name

			if parameters.count > 0 then
				Result := Result + "("

				across parameters as p loop
					Result := Result + p.item.type.name
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
