note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_QUERY
inherit
	ETF_ADD_QUERY_INTERFACE
create
	make
feature -- command
	add_query(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: STRING]] ; rt: STRING)
		require else
			add_query_precond(cn, fn, ps, rt)
		local
			casted_array: ARRAY[TUPLE[pn: STRING; pt: LOUVRE_CLASS]]
			s: STRING
    	do
    		if attached model.current_instruction as ci then
				model.set_status ("Error (An assignment instruction is currently being specified for routine " + ci.routine.name + " in class " + ci.lclass.name + ").")
			elseif attached {LOUVRE_CLASS}  {CLASS_POOL_ACCESS}.pool.classes[cn] as clazz then
				if clazz.routines.has (fn) then
					model.set_status ("Error (" + fn + " is already an existing feature name in class " + cn + ").")
				elseif model.invalid_classes (ps).count > 0 then
					s := "Error (Parameter types do not refer to primitive types or existing classes: "

					across model.invalid_classes (ps) as name loop
						s := s + name.item
						if name.cursor_index < model.invalid_classes(ps).count then
							s := s + ", "
						end
					end

					s := s + ")."
					model.set_status(s)
				elseif not  {CLASS_POOL_ACCESS}.pool.classes.has (rt) then
					model.set_status ("Error (Return type does not refer to a primitive type or an existing class: " + rt + ").")
				elseif model.clashing_names (ps).count > 0 then
					s := "Error (Parameter names clash with existing classes: "

					across model.clashing_names (ps) as name loop
						s := s + name.item
						if name.cursor_index < model.clashing_names(ps).count then
							s := s + ", "
						end
					end

					s := s + ")."
					model.set_status(s)
				elseif model.duplicate_names(ps).count > 0 then
					s := "Error (Duplicated parameter names: "

					across model.duplicate_names(ps) as name loop
						s := s + name.item
						if name.cursor_index < model.duplicate_names(ps).count then
							s := s + ", "
						end
					end

					s := s + ")."
					model.set_status(s)
				else
					create casted_array.make_empty

					across ps is tuple loop
						check attached  {CLASS_POOL_ACCESS}.pool.classes[tuple.pt] as type then
							casted_array.force ([tuple.pn, type], casted_array.count + 1)
						end
					end

					check attached  {CLASS_POOL_ACCESS}.pool.classes[rt] as type2 then
						model.add_query (clazz, fn, casted_array, type2)
					end

					model.set_status ("OK.")
					model.set_out (model.to_string)
				end
			else
				model.set_status ("Error (" + cn + " is not an existing class name).")
			end


			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
