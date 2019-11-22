	note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_COMMAND
inherit
	ETF_ADD_COMMAND_INTERFACE
create
	make
feature -- command


	add_command(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]])
		require else
			add_command_precond(cn, fn, ps)
		local
			s: STRING
			cast: ARRAY[TUPLE[pn: STRING; ft: LOUVRE_CLASS]]
    	do
			-- perform some update on the model state
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
					create cast.make_empty

					across ps is tuple loop
						check attached  {CLASS_POOL_ACCESS}.pool.classes[tuple.ft] as type then
							cast.force ([tuple.pn, type], cast.count + 1)
						end
					end

					model.add_command (clazz, fn, cast)

					model.set_status ("OK.")
					model.set_out (model.to_string)
				end
			else
				model.set_status ("Error (" + cn + " is not an existing class name).")
			end

			model.set_out (model.to_string)

			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
