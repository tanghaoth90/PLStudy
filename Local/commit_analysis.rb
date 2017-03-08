#!/bin/bash ruby

require 'pp'

# using "git log" to analyze commits
# git log --numstat --pretty=oneline

# docs: https://www.git-scm.com/docs/git-log
# tutorial: https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History

#Dir.chdir("~/codebase/tensorflow") do
#	system 'git log'
#end

# Todo: deal with buggy commits? 

proj_info = { :'tanghaoth90/PLStudy' => '.', :'tensorflow/tensorflow' => '~/codebase/tensorflow' }
extfile_info = { :'tanghaoth90/PLStudy' => ['.rb'], :'tensorflow/tensorflow' => ['.cpp', '.py'] }

proj_info.each do |repo_name, repo_dc|
	#log = `cd #{repo_dc} && git log --numstat --pretty=format:"%H%n%s"`
	commits = `cd #{repo_dc} && git log --numstat --pretty=format:"%H%n%s"`.split "\n\n"
	change_lines = []
	commits.each do |commit|
		lines = commit.split "\n"
		commit_message = lines[1]
		changes = lines[2..lines.size]
		delta_loc = 0
		changes.each do |c|
			cs = c.split
			if cs[2].end_with? ".rb" then delta_loc += cs[0].to_i+cs[1].to_i end
		end
		change_lines.push delta_loc
	end
	puts change_lines
end

