note
	description: "Summary description for {LOUVRE_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_CLASS

create
	make

feature -- Queries
	name: STRING

	equals(other: detachable LOUVRE_CLASS): BOOLEAN
		do
			Result := attached other as ao and then name ~ ao.name
		end

	invalid_assignment_instructions: LINKED_LIST[LOUVRE_ASSIGNMENT_INSTRUCTION]
		do
			create Result.make

			across routines as routine loop
				across routine.item.assignment_instructions as ai loop
					if ai.item.var ~ "Result" and attached {LOUVRE_QUERY} routine.item as query then
						if not (attached ai.item.expression.actual_return_type as rhs and then query.return_type.equals (rhs)) then
							Result.extend (ai.item)
						end
					elseif not (attached attributes[ai.item.var] as lhs_att and then attached ai.item.expression.actual_return_type as rhs and then lhs_att.return_type.equals (rhs)) then
						Result.extend (ai.item)
					end
				end

			end
		end


	attributes: HASH_TABLE[LOUVRE_ATTRIBUTE, STRING]
		do
			create Result.make (0)

			across routines as routine loop
				if attached {LOUVRE_ATTRIBUTE} routine.item as r then
					Result.put(r, routine.key)
				end
			end
		end

	queries: HASH_TABLE[LOUVRE_QUERY, STRING]
		do
			create Result.make (0)

			across routines as routine loop
				if attached {LOUVRE_QUERY} routine.item as r then
					Result.put(r, routine.key)
				end
			end
		end

	commands: HASH_TABLE[LOUVRE_COMMAND, STRING]
		do
			create Result.make (0)

			across routines as routine loop
				if attached {LOUVRE_COMMAND} routine.item as r then
					Result.put(r, routine.key)
				end
			end
		end

	routines: HASH_TABLE[LOUVRE_ROUTINE, STRING]

	to_string: STRING
		do
			create Result.make_from_string("")
			Result := Result + "    " + name + "%N"
			Result := Result + "      " + "Number of attributes: " + attributes.count.out + "%N"

			across attributes is att loop
				Result := Result + att.out + "%N";
			end

			Result := Result + "      " + "Number of queries: " + queries.count.out + "%N"

			across queries is query loop
				Result := Result + query.out + "%N";
			end

			Result := Result + "      " + "Number of commands: " + commands.count.out + "%N"

			across commands is command loop
				Result := Result + command.out + "%N"
			end

		end

	java_string: STRING
		do
			Result := "  class " + name + " {%N"

			across routines as routine loop
				Result := Result + routine.item.java_string + "%N"
			end

			Result := Result + "  }%N"
		end


feature {NONE} -- Initialization

	make(name_: STRING)
			-- Initialization for `Current'.
		do
			name := name_
			create routines.make (0)
		end

end
