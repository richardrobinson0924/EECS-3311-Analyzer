note
	description: "Summary description for {LOUVRE_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_COMMAND
inherit
	ANY redefine out end

create
	make

feature -- Queries
	lclass: LOUVRE_CLASS
	command_name: STRING
	parameters: ARRAY[TUPLE[name: STRING; type: STRING]]

	out: STRING
		do
			create Result.make_from_string("        " + "+ " + command_name)
			if parameters.count > 0 then
				Result := Result  + "(";

				across parameters as p loop
					Result := Result + p.item.type
					if p.cursor_index /= parameters.count then
						Result := Result + ", "
					end
				end

				Result := Result + ")"
			end
		end

feature {NONE} -- Initialization

	make(lclass_: LOUVRE_CLASS; fn: STRING; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]])
			-- Initialization for `Current'.
		do
			lclass := lclass_
			command_name := fn
			parameters := ps
		end

end
