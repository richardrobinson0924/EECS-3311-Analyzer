note
	description: "Summary description for {CLASS_POOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_POOL

create {CLASS_POOL_ACCESS} make

feature
	classes: HASH_TABLE[LOUVRE_CLASS, STRING]

	add_new_class(clazz: LOUVRE_CLASS)
		do
			classes.extend(clazz, clazz.name)
		end

	get(key: STRING): LOUVRE_CLASS
		do
			check attached classes[key] as clazz then Result := clazz end
		end

feature {CLASS_POOL_ACCESS}
	make
		do
			create classes.make(0)
			classes.extend(create {LOUVRE_CLASS}.make("INTEGER"), "INTEGER")
			classes.extend(create {LOUVRE_CLASS}.make("BOOLEAN"), "BOOLEAN")
		end

end
