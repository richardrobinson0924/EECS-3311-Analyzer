note
	description: "Summary description for {CLASS_POOL_ACCESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	CLASS_POOL_ACCESS

create
	default_create,
	make

feature
	pool: CLASS_POOL
		once
			create Result.make
		ensure
			instance_free: class
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

invariant
	pool = pool

end
