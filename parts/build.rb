#!/usr/bin/env ruby

require 'mustache'

data = {
  "repo": [
		"lepo": [ { "name": "resque" }, { "name": "hub" }, { "name": "rip" } ],
		"lepo": [ { "name": "aresque" }, { "name": "ahub" }, { "name": "arip" } ]
	]
}

Mustache.template_file = './template_partial.mustache'
puts Mustache.render(data)


