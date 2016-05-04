#!/usr/bin/env ruby

class Gist
	attr_reader :last

	def initialize
		require 'rest-client'
		require 'date'
		@token = "token ca1b672299693f071c3e7a10147f4044fbfbde12"
		@user = 'narutaro'
		@url = "https://api.github.com/users/#{@user}/gists"
		@p = {:Authorization => @token}
		@ts = DateTime.parse(open('/tmp/last.ts', 'r'){|f| f.read})
	end

	def update_ts
		open('/tmp/last.ts', 'w'){|f| f.puts DateTime.now.new_offset(0)}
	end

	def get_gists_pretty
		r = RestClient.get(@url, @p)
		json = JSON.parse(r)
		JSON.pretty_generate(json)
	end

	def get_new_gist
		r = RestClient.get(@url, @p)
		new_gist = JSON.parse(r).select{|g| @ts < Date.parse(g['updated_at'])}
		new_gist.collect{|ng| ng['files'].values}[0]
	end
end

g = Gist.new
g.get_new_gist.each{|hash|
	if hash['language'] == 'Markdown'
		r = RestClient.get(hash['raw_url'])
		open(hash['filename'], 'w'){|f|
			f.puts r
		}
	end
}
#g.update_ts
