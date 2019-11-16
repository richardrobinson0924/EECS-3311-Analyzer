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
    	do
    		if attached model.current_instruction as ci then
				model.set_status ("Error (An assignment instruction is currently being specified for routine " + ci.routine.name + " in class " + ci.lclass.name + ").")
			elseif not model.classes.has (cn) then
				model.set_status ("Error (" + cn + "is not an existing class name).")
			elseif not model.classes.has (rt) then
				model.set_status ("Error (Return type does not refer to a primitive type or an existing class: " + rt + ").")
			elseif across ps is tuple all model.classes.has (tuple.pt) end then
				model.set_status ("Parameters have invalid type")
			elseif model.classes.has (fn) then
				model.set_status ("" + fn + "is already an existing feature name in class " + cn)
			else
				create casted_array.make_empty

				across ps is tuple loop
					check attached model.classes[tuple.pt] as type then
						casted_array.force ([tuple.pn, type], casted_array.count + 1)
					end
				end

				check attached model.classes[rt] as type and then attached model.classes[cn] as clazz then
					model.add_query (clazz, fn, casted_array, type)
				end
			end


			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
