#!/bin/bash ruby

require 'octokit'
require 'pp'

#Octokit.auto_paginate = true

topics = ['analyzer', 'middleware']

topics.each do |t|

	repos = Octokit.search_repos 'topic:middleware', \
		:sort => 'stars', :order => 'desc', \
		:per_page => 10
		
	repos[0..3].each do |repo|

		puts "x"


	end

end


