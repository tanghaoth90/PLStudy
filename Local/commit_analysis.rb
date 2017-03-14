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

proj_info = { 
#	:'freeCodeCamp/freeCodeCamp' => '~/codebase/freeCodeCamp', \
#	:'tensorflow/tensorflow' => '~/codebase/tensorflow', \
#	:'Microsoft/CNTK' => '~/codebase/CNTK', \
#	:'rapid7/metasploit-framework' => '~/codebase/metasploit-framework', \
#	:'facebook/osquery' => '~/codebase/osquery', \
#	:'scikit-learn/scikit-learn' => '~/codebase/scikit-learn'
#	:'BuildTimeAnalyzer-for-XCode' => '~/codebase/BuildTimeAnalyzer-for-Xcode'
#	:'Framework7' => '~/codebase/Framework7'
#	:'timesheet.js' => '~/codebase/timesheet.js',
#	:'CotEditor' => '~/codebase/CotEditor',
#	:'vue' => '~/codebase/vue',
#	:'laravel' => '~/codebase/laravel'
	:'echo' => '~/codebase/echo',
	:'performance-bookmarklet' => '~/codebase/performance-bookmarklet',
	:'Dotzu' => '~/codebase/Dotzu'
	}
extfile_info = { 
#	:'freeCodeCamp/freeCodeCamp' => ['.js'], \
#	:'tensorflow/tensorflow' => ['.cc', '.py'], \
#	:'Microsoft/CNTK' => ['.cpp', '.py', '.cu'], \
#	:'rapid7/metasploit-framework' => ['.rb'], \
#	:'facebook/osquery' => ['.cpp'], \
#	:'scikit-learn/scikit-learn' => ['.py'] 
#	:'BuildTimeAnalyzer-for-XCode' => ['.swift']
#	:'Framework7' => ['.js']
#	:'timesheet.js' => ['.js'],
#	:'CotEditor' => ['.swift'],
#	:'vue' => ['.js'],
#	:'laravel' => ['.php']
	:'echo' => ['.go'],
	:'performance-bookmarklet' => ['.js'],	
	:'Dotzu' => ['.swift']
	}

proj_info.each do |repo_name, repo_dc|
	#log = `cd #{repo_dc} && git log --numstat --pretty=format:"%H%n%s"`
	outfile = File.open 'commit_info/' + repo_name.to_s.gsub('/', '-')+'.log', 'w'
	puts repo_name
	commits = `cd #{repo_dc} && git log --no-merges --numstat --pretty=format:"**%n%H%n%s"`.split "**\n"
	extfile_info[repo_name].each do |ext|
		puts ext
		outfile.puts ext
		change_lines = []
		total_linenum = `cd #{repo_dc} && git ls-files | grep '.#{ext}' | xargs cat | wc -l`
		puts total_linenum
		outfile.puts total_linenum
		commits.each do |commit|
			lines = commit.split "\n"
			if lines.size < 2 then next end
			commit_message = lines[1]
			if ['format'].any? { |word| commit_message.include? word} then next end
			changes = lines[2..lines.size]
			delta_loc = 0
			changes.each do |c|
				cs = c.split
				if cs[2].end_with?(ext) then delta_loc += cs[0].to_i+cs[1].to_i end
			end
			change_lines.push delta_loc
		end
		puts change_lines.join " "
		outfile.puts change_lines.join " "
	end
	outfile.close
end

