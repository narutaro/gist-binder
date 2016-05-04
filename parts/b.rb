#!/usr/bin/env ruby

require 'baby_erubis'

all = [
	{date: 'Apr 1st', title: 'My post title 1', desc: 'Some description 1'},
	{date: 'Apr 2nd', title: 'My post title 2', desc: 'Some description 2'},
	{date: 'Apr 3rd', title: 'My post title 3', desc: 'Some description 3'},
	{date: 'Apr 4th', title: 'My post title 4', desc: 'Some description 4'},
	{date: 'Apr 5th', title: 'My post title 5', desc: 'Some description 5'},
	{date: 'Apr 6th', title: 'My post title 6', desc: 'Some description 6'}
]

template = BabyErubis::Html.new.from_file('example.html.erb', 'utf-8')
context = {:title=>'Example', :items=>all}
output = template.render(context)
print output

