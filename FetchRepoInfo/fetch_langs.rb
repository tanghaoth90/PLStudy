#!/bin/bash ruby

require 'octokit'
require 'pp'

Octokit.auto_paginate = true

fin = File.open("total_category.txt", "r")
fout = File.open("total_category_with_language.txt", "w")

i = 0
while line = fin.gets do
	st = line.split
	u = st[0]
	r = st[1]
	c = st[2]
	repo_name = u + "/" + r
	repo = Octokit.repo repo_name
	repo_language = repo.language
	if repo_language.nil? then repo_language = "no_language" end
	fout.puts u + " " + r + " " + c + " " + repo_language
	i += 1
	puts "##{i}" + u + " " + r + " " + c + " " + repo_language
end

fin.close
fout.close

#repo_name = "tanghaoth90/PLStudy"
#repo = Octokit.repo repo_name
#puts repo.language
#commits = Octokit.commits repo_name
#commits.each_with_index do |c,i|
#	puts i
#	commit = c.rels[:self].get.data
#	pp commit.stats
#end

