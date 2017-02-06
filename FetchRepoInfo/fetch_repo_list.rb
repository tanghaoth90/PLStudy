#!/bin/bash ruby

require 'octokit'
require 'pp'

#Octokit.auto_paginate = true

repos = Octokit.search_repos 'stars:>1000', \
	:sort => 'stars', :order => 'desc', \
	:per_page => 100  
	
puts 'Total Repos = ' + repos.items.length.to_s + "\n"

puts 'x-ratelimit-remaining after searching = ' \
	+ Octokit.last_response.headers['x-ratelimit-remaining']

repos.items.each_with_index do |repo,index|
	puts '#' + index.to_s + ' ' + repo.full_name # + ' ' + repo.git_url
	puts repo.languages_url
	langs_response = repo.rels[:languages].get
	puts 'x-ratelimit-remaining after getting languages = ' \
		+ langs_response.headers['x-ratelimit-remaining']
	pp langs_response.data
	break
end

