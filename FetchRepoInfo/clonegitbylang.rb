#!/bin/bash ruby

require 'octokit'
require 'pp'

#Octokit.auto_paginate = true


# lg2ext : map each language to corresponding file extensions
# reference : https://github.com/github/linguist/   directory: linguist/samples/<language>/
lg2ext = {
	:C => ['.c', '.h', '.C', '.H'], 
	:'C++' => ['.cpp', '.h', '.inl', '.hh', '.hpp', '.ipp', '.inc', '.cp', '.cc'], 
	:'C#' => ['.cs', 'cake', 'cshtml'],
	:'Objective-C' => ['.h', '.m'],
	:Go => ['.go'],
	:Java => ['.java'],
	:CoffeeScript => ['.coffee', '.cake', '.cjsx'],
	:JavaScript => ['.js', '.es', '.gs', '.xsjs', '.xsjslib', '.frag', '.jsb', '.jscad'],
	:TypeScript => ['.ts', '.tsx'],
	:Ruby => ['.rb', '.spec', '.jbuilder', '.pluginspec', '.rabl', '.rack', '.fcgi'],
	:PHP => ['.php', '.inc', '.phps', '.fcgi'],
	:Python => ['.py', '.pyde', '.pyp', '.cgi', '.fcgi', '.rpy', '.spec'],
	:Perl => ['.pl', '.pm', '.pod', '.cgi', '.al', '.fcgi'],
	:Clojure => ['.clj', '.hic', '.hl', '.cljc', '.cljs', '.cljscm', '.cljx', '.cl2', '.boot'],
	:Erlang => ['.escript', '.erl', '.app.src', '.es', '.yrl', '.xrl'],
	:Haskell => ['.hs'],
	:Scala => ['.sc', '.sbt']
	}

lg2ext.each do |lg,ext|

	pp lg
	pp ext
	puts

#	repos = Octokit.search_repos 'language:'.join(l), \
#		:sort => 'stars', :order => 'desc', \
#		:per_page => 100
#		
#	repos.items[0..2].each do |repo|
#		puts repo.full_name
#		`git clone #{repo.clone_url}`
#	end

end
