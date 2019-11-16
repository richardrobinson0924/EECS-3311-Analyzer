note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create classes.make(0)
			classes.extend ({LOUVRE_TYPE}.louvre_boolean_type, "BOOLEAN")
			classes.extend ({LOUVRE_TYPE}.louvre_integer_type, "INTEGER")

			status := ""
		end

feature -- model attributes
	classes: HASH_TABLE[LOUVRE_CLASS, STRING]

	current_instruction: detachable LOUVRE_ASSIGNMENT_INSTRUCTION

feature {NONE}
	status: STRING

feature -- model operations
	user_classes: HASH_TABLE[LOUVRE_CLASS, STRING]
		do
			create Result.make (0)
			Result.copy (classes)
			Result.remove ("INTEGER")
			Result.remove ("BOOLEAN")
		end


	default_update
			-- Perform update to the model state.
		do
		end

	reset
			-- Reset model state.
		do
			make
		end

	set_current_instruction(i: detachable LOUVRE_ASSIGNMENT_INSTRUCTION)
		do
			current_instruction := i
		end

	add_class(cn: STRING)
		require
			class_name_doesnt_exist: classes[cn] = Void
			no_current_instruction: current_instruction = Void
		do
			classes.put (create {LOUVRE_CLASS}.make (cn), cn)
		end

	add_command(cn: STRING ; command_name: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]])
		require
			class_exists: classes[cn] /= Void
		do
			check attached classes[cn] as clazz then
				clazz.routines.put (create {LOUVRE_COMMAND}.make (clazz, command_name, ps), command_name);
			end
		end

	add_attribute(cn: LOUVRE_CLASS ; fn: STRING ; ft: LOUVRE_CLASS)
		require
			valid_type: classes.has (ft.name)
			non_existing_feature: not classes.has (fn)
		do
			cn.routines.put (create {LOUVRE_ATTRIBUTE}.make (cn, fn, ft), fn);
		end

	add_query(cn: LOUVRE_CLASS ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: LOUVRE_CLASS]] ; rt: LOUVRE_CLASS)
		require
			valid_type: classes.has (rt.name)
			non_existing_feature: not classes.has (fn)
		do
			cn.routines.put (create {LOUVRE_QUERY}.make (cn, fn, ps, rt), fn);
		end


	set_status(s: STRING)
		do
			status := s
		end

feature -- queries
	out : STRING
		do
			Result := "  Status: " + status + "%N"
			Result := Result + "  Number of classes being specified: " + user_classes.count.out + "%N"

			across user_classes as c loop
				Result := Result + c.item.to_string
			end

			if attached current_instruction as aci then
				Result := Result + "  Routine currently being implemented: {" + aci.lclass.name + "}." + aci.routine.name + "%N"
				Result := Result + "  Assignment being specified: " + aci.to_string + "%N"
			end
		end

end
