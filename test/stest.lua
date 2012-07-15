#!bin/lem
--
-- This file is part of LEM, a Lua Event Machine.
-- Copyright 2011-2012 Emil Renner Berthing
--
-- LEM is free software: you can redistribute it and/or
-- modify it under the terms of the GNU General Public License as
-- published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version.
--
-- LEM is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with LEM.  If not, see <http://www.gnu.org/licenses/>.
--

print('Entered ' .. arg[0])

local utils   = require 'lem.utils'
local streams = require 'lem.streams'

local server = assert(streams.tcp4_listen('*', arg[1] or 8080))

--timer(10, function() exit(0) end)
utils.timer(10, function()
	print 'Closing server'
	server:close()
end)

local ok, err = server:autospawn(function(i, o)
	print 'Accepted a connection'
	local sleeper = utils.sleeper()

	while true do
		local line, err = i:read('*l')
		if not line then
			if err == 'closed' then
				print("Client closed connection")
				return
			end

			error(err)
		end

		print("Client sent: '" .. line .. "'")
		if line ~= 'ping' then break end

		sleeper:sleep(0.4)
		assert(o:write('pong\n'))
	end

	print "Ok, I'm out"
	assert(i:close())
	assert(o:close())
end)

if not ok and err ~= 'interrupted' then error(err) end

print('Exiting ' .. arg[0])

-- vim: syntax=lua ts=2 sw=2 noet:
