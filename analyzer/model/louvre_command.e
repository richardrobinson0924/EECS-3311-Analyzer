note
	description: "Summary description for {LOUVRE_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_COMMAND
inherit
	LOUVRE_ROUTINE redefine out end

create
	make

feature -- Queries
	lclass: LOUVRE_CLASS

	java_string: STRING
		do
			Result := "    void " + name + "("

			across parameters as tuple loop
				Result := Result + {CLASS_POOL_ACCESS}.pool.get_java_name (tuple.item.type) + " " + tuple.item.name

				if tuple.cursor_index /= parameters.count then
					Result := Result + ", "
				end
			end

			Result := Result + ") {%N"

			across assignment_instructions is ai loop
				Result := Result + "      " + ai.java_string + "%N"
			end

			Result := Result + "    }"
		end

	out: STRING
		do
			create Result.make_from_string("        " + "+ " + name)
			if parameters.count > 0 then
				Result := Result  + "(";

				across parameters as p loop
					Result := Result + p.item.type.name
					if p.cursor_index /= parameters.count then
						Result := Result + ", "
					end
				end

				Result := Result + ")"
			end
		end

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS; fn: STRING; ps: ARRAY[TUPLE[pn: STRING; ft: LOUVRE_CLASS]])
			-- Initialization for `Current'.
		do
			lclass := lclass_
			name := fn
			parameters := ps

			create assignment_instructions.make(0)
		end

end
