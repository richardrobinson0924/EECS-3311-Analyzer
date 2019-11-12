note
	description: "Summary description for {LOUVRE_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_CLASS
inherit
	ANY
	redefine out end

create
	make

feature -- Queries
	name: STRING
	attributes: HASH_TABLE[LOUVRE_ATTRIBUTE, STRING]
	queries: HASH_TABLE[LOUVRE_QUERY, STRING]
	commands: HASH_TABLE[LOUVRE_COMMAND, STRING]

	out: STRING
		do
			create Result.make_from_string("")
			Result := Result + "    " + name + "%N"
			Result := Result + "      " + "Number of attributes: " + attributes.count.out + "%N"

			across attributes as att loop
				Result := Result + "        " + "+ " + att.key + ": " + att.item.type_name + "%N";
			end

			Result := Result + "      " + "Number of commands: " + attributes.count.out + "%N"

			across commands is command loop
				Result := Result + command.out + "%N"
			end

		end


feature {NONE} -- Initialization

	make(name_: STRING)
			-- Initialization for `Current'.
		do
			name := name_
			create attributes.make (0)
			create queries.make (0)
			create commands.make (0)
		end

end
