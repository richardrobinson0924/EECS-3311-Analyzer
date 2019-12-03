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
			current_instruction := Void
			status := "OK."

			set_out(to_string)
		end

feature -- model attributes

	current_instruction: detachable LOUVRE_ASSIGNMENT_INSTRUCTION

feature {NONE}
	status: STRING

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

feature -- model operations
	user_classes: HASH_TABLE[LOUVRE_CLASS, STRING]
		local
			access: CLASS_POOL_ACCESS
		do
			create Result.make (0)
			Result.copy (access.pool.classes)
			Result.remove ("INTEGER")
			Result.remove ("BOOLEAN")
			Result.remove ("NONE")
		end


	default_update
			-- Perform update to the model state.
		do
			set_out(to_string)
		end

	reset
			-- Reset model state.
		do
			make
		end

	update_current_instruction
		do
			if attached current_instruction as ci and then ci.expression.is_complete then
				current_instruction := Void
			end
		end

	type_check
		require
			no_current_instruction: Current.current_instruction = Void
		local
			s: STRING
			list: LINKED_LIST[LOUVRE_ASSIGNMENT_INSTRUCTION]
		do
			s := ""
			across user_classes as clazz loop
				list := clazz.item.invalid_assignment_instructions

				if list.count = 0 then
					s := s + "  class " + clazz.item.name + " is type-correct.%N"
				else
					s := s + "  class " + clazz.item.name + " is not type-correct:%N"
					across list is ai loop
						s := s + "    " + ai.var + " = " + ai.expression.to_string + " in routine " + ai.routine.name + " is not type-correct.%N"
					end
				end
			end

			s.remove_tail (1)

			Current.set_out (s)
		end

	java_string: STRING
		do
			Result := ""

			across user_classes is clazz loop
				Result := Result + clazz.java_string
			end

			Result.remove_tail (1)
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
				if not  {CLASS_POOL_ACCESS}.pool.classes.has (tuple.ft) then
					Result.extend(tuple.ft)
				end
			end
		end

	clashing_names(parameters: ARRAY[TUPLE[pn: STRING; pt: ANY]]): LINKED_LIST[STRING]
		do
			create Result.make

			across parameters is tuple loop
				if  {CLASS_POOL_ACCESS}.pool.classes.has (tuple.pn) then
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
			class_name_doesnt_exist:  {CLASS_POOL_ACCESS}.pool.classes[cn] = Void
			no_current_instruction: current_instruction = Void
		do
			 {CLASS_POOL_ACCESS}.pool.add_new_class (create {LOUVRE_CLASS}.make (cn))
		end

	add_call_chain(chain: LOUVRE_CALL_CHAIN)
		require
			current_instruction: attached current_instruction
			non_empty_cahin: chain.chain.count = 0
		do
			check attached Current.current_instruction as ci then
				ci.expression.set_next_null_operand_to (chain)
			end
		end

	add_expression(expression: LOUVRE_EXPRESSION)
		require
			current_instruction: attached current_instruction
		do
			check attached Current.current_instruction as ci then
				ci.expression.set_next_null_operand_to (expression)
			end
		end


	add_command(cn: LOUVRE_CLASS ; command_name: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: LOUVRE_CLASS]])
		require
			no_current_instruction: current_instruction = Void
			class_exists:  {CLASS_POOL_ACCESS}.pool.classes.has (cn.name)
			non_existing_feature: not cn.routines.has (command_name)
			no_invalid_classes: across ps is tuple all {CLASS_POOL_ACCESS}.pool.classes.has (tuple.ft.name) end
			no_clashing_classes: across ps is tuple all not {CLASS_POOL_ACCESS}.pool.classes.has (tuple.pn) end
			no_duplicate_names: duplicate_names(ps).count = 0
		do
			cn.routines.put (create {LOUVRE_COMMAND}.make (cn, command_name, ps), command_name);
		end

	add_attribute(cn: LOUVRE_CLASS ; fn: STRING ; ft: LOUVRE_CLASS)
		require
			no_current_instruction: current_instruction = Void
			class_exists: {CLASS_POOL_ACCESS}.pool.classes.has (cn.name)
			non_existing_feature: not  {CLASS_POOL_ACCESS}.pool.classes.has (fn)
			valid_type:  {CLASS_POOL_ACCESS}.pool.classes.has (ft.name)
		do
			cn.routines.put (create {LOUVRE_ATTRIBUTE}.make (cn, fn, ft), fn);
		end

	add_query(cn: LOUVRE_CLASS ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: LOUVRE_CLASS]] ; rt: LOUVRE_CLASS)
		require
			no_current_instruction: current_instruction = Void
			class_exists: {CLASS_POOL_ACCESS}.pool.classes.has (cn.name)
			non_existing_feature: not cn.routines.has (fn)
			no_invalid_classes: across ps is tuple all {CLASS_POOL_ACCESS}.pool.classes.has (tuple.pt.name) end
			non_clashing_names: across ps is tuple all not {CLASS_POOL_ACCESS}.pool.classes.has (tuple.pn) end
			no_duplicate_names: duplicate_names(ps).count = 0
			valid_type:  {CLASS_POOL_ACCESS}.pool.classes.has (rt.name)
		do
			cn.routines.put (create {LOUVRE_QUERY}.make (cn, fn, ps, rt), fn);
		end


	set_status(s: STRING)
		do
			status := s
		end

	set_out(s: STRING)
		do
			out := s
		end

feature -- queries
	out: STRING

	to_string : STRING
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
