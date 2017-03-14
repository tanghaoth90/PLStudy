#!/bin/bash ruby

require 'octokit'
require 'pp'

#Octokit.auto_paginate = true

topics = ['analyzer', 'middleware']

topicfile = File.open 'topic.log', 'w'

topics.each do |t|

	puts '#' + t
	topicfile.puts '#' + t

	repos = Octokit.search_repos 'topic:middleware', \
		:sort => 'stars', :order => 'desc', \
		:per_page => 10
		
	repos.items[0..2].each do |repo|
		puts repo.full_name
		`git clone #{repo.clone_url}`
	end

end

topicfile.close
