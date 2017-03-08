#!/bin/bash ruby

require 'octokit'
require 'pp'

Octokit.auto_paginate = true

#fout = File.open("logs/langs.log", "w")

#repo_name = "mysqljs/mysql"
repo_name = "tanghaoth90/PLStudy"

repo = Octokit.repo repo_name
puts repo.language
commits = Octokit.commits repo_name
commits.each_with_index do |c,i|
	puts i
	commit = c.rels[:self].get.data
	pp commit.stats
end

