#!/usr/bin/env ruby

require 'baby_erubis'
require 'rest-client'

class Gist
	attr_reader :last

	def initialize
		@url = "https://api.github.com/gists/"
	end

	def get_gist(gist_id)
		r = RestClient.get(@url + gist_id)
		json = JSON.parse(r)
		#JSON.pretty_generate(json)
	end
end

gid = open('target_gists.txt', 'r'){|f|
	f.read.split("\n")
}

g = Gist.new

gists = []
gid.each do |id|
	gist = g.get_gist(id)
	gists << {
		date: gist['updated_at'].gsub(/[TZ]/,' '),
		url: gist['html_url'],
		desc: gist['description'],
		title: gist['files'].values[0]['content'].match(/^#(\s*)(.*)\n/)[2]
	}
end

gists.sort! do |a, b|
	b[:date] <=> a[:date]
end

gists.each{|m|
	p m
}

#td = [{:date=>"2016-05-03", :url=>"https://gist.github.com/9c9f8c244ebc654f44ec935c3ecde6ee", :desc=>"multipart gist", :title=>"part_1 portion"}, {:date=>"2016-05-03", :url=>"https://gist.github.com/a11661167a4caed22c7b74bc25f3a1a7", :desc=>"Sample of getting gists which is newly added since last time fetched. ", :title=>"!/usr/bin/env ruby"}, {:date=>"2016-04-24", :url=>"https://gist.github.com/3c75c37759830d34a154718c4fa4e7c0", :desc=>"embed testing", :title=>"Here you go."}]
#td = [{:date=>"2016-05-03", :url=>"https://gist.github.com/9c9f8c244ebc654f44ec935c3ecde6ee", :desc=>"multipart gist", :title=>"part_1 portion"}, {:date=>"2016-05-03", :url=>"https://gist.github.com/a11661167a4caed22c7b74bc25f3a1a7", :desc=>"Sample of getting gists which is newly added since last time fetched. ", :title=>"!/usr/bin/env ruby"}]

template = BabyErubis::Html.new.from_file('index.html.erb', 'utf-8')
context = {:gists=>gists}
output = template.render(context)
#print output

open('out/index.html', 'w'){|f|
	f.puts output
}

