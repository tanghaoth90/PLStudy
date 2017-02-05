#!/bin/bash ruby

require 'octokit'

#client = Octokit::Client.new(:access_token => ENV['GITACCESS'])

#client = Octokit.readme 'tanghaoth90/PLStudy' \
#	, :accept => 'application/vnd.github.html'

puts Octokit.access_token
Octokit.auto_paginate = true

repos = Octokit.search_repositories 'stars:>1000', \
	:sort => 'stars', :order => 'desc', \
	:headers => { 'X-GitHub-OTP' => Octokit.access_token }
	
puts 'Total Repos = ' + repos.items.length.to_s + "\n"

repos.items.each_with_index do |repo,index|
	puts '#' + index.to_s
	puts repo.full_name + ' ' + repo.git_url
	puts repo.languages_url + "\n"
end



