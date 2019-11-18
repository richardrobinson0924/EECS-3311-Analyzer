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

			current_instruction := Void
			status := "OK."
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

	duplicate_names(ps: ITERABLE[TUPLE[pn: STRING; ft: ANY]]): LINKED_LIST[STRING]
		local
			tmp: LINKED_SET[STRING]
			copy_: LINKED_LIST[STRING]
		do
			create tmp.make
			create copy_.make
			tmp.compare_objects
			copy_.compare_objects

			across ps is tuple loop
				tmp.extend (tuple.pn)
				copy_.extend (tuple.pn)
			end

			across tmp is s loop
				copy_.prune (s)
			end

			create Result.make_from_iterable (copy_)
			Result.compare_objects

			across 1 |..| copy_.count is i loop
				from
				until occurances(Result, copy_[i]) <= 1
				loop
					Result.prune(copy_[i])
				end
			end

		end

	invalid_classes(ps: ITERABLE[TUPLE[pn: ANY; ft: STRING]]): LINKED_LIST[STRING]
		do
			create Result.make

			across ps is tuple loop
				if not classes.has (tuple.ft) then
					Result.extend(tuple.ft)
				end
			end
		end

	occurances(list: ITERABLE[STRING]; s: STRING): INTEGER
		local
			count: INTEGER
		do
			count := 0

			across list is element loop
				if element ~ s then
					count := count + 1
				end
			end

			Result := count
		end

	clashing_names(parameters: ARRAY[TUPLE[pn: STRING; pt: ANY]]): LINKED_LIST[STRING]
		do
			create Result.make

			across parameters is tuple loop
				if classes.has (tuple.pn) then
					Result.extend(tuple.pn)
				end
			end
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
			class_exists: classes.has (cn)
			non_clashing_names: clashing_names(ps).count = 0
		do
			check attached classes[cn] as clazz then
				clazz.routines.put (create {LOUVRE_COMMAND}.make (clazz, command_name, ps), command_name);
			end
		end

	add_attribute(cn: LOUVRE_CLASS ; fn: STRING ; ft: LOUVRE_CLASS)
		require
			class_exists: classes.has (cn.name)
			valid_type: classes.has (ft.name)
			non_existing_feature: not classes.has (fn)
		do
			cn.routines.put (create {LOUVRE_ATTRIBUTE}.make (cn, fn, ft), fn);
		end

	add_query(cn: LOUVRE_CLASS ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: LOUVRE_CLASS]] ; rt: LOUVRE_CLASS)
		require
			valid_type: classes.has (rt.name)
			non_existing_feature: not classes.has (fn)
			non_clashing_names: clashing_names(ps).count = 0
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

			Result.remove (Result.count)
		end

end
