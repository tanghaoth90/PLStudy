#!/bin/bash ruby

require 'octokit'
require 'pp'

Octokit.auto_paginate = true

fout = File.open("logs/langs.log", "w")

repos = Octokit.search_repos 'stars:>1000', \
	:sort => 'stars', :order => 'desc', \
	:per_page => 100  
	
puts 'Total Repos = ' + repos.items.length.to_s
puts 'XRR = ' + Octokit.last_response.headers['x-ratelimit-remaining']

repos.items.each_with_index do |repo,index|
	#puts '#' + index.to_s + ' ' + repo.full_name # + ' ' + repo.git_url
	#puts repo.languages_url
	langs_response = repo.rels[:languages].get
	puts repo.full_name
	pp langs_response.data
	puts 'XRR = ' + langs_response.headers['x-ratelimit-remaining']
	
	fout.puts repo.full_name
	PP.pp langs_response.data, fout
end

