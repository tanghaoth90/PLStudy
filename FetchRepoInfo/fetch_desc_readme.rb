require 'pp'
require 'octokit'

$sel_langs = [:C, :'C++', :'C#', :'Objective-C', :Go, \
	:Java, :CoffeeScript, :JavaScript, :TypeScript, \
	:Ruby, :Php, :Python, :Perl, :Clojure, :Erlang, \
	:Haskell, :Scala]

def parse_get_description()
	fout = File.open 'results/desc.log', 'w'
	open 'results/langs.log', 'r' do |fin|
		while r_name = fin.gets
			r_name.delete!("\n")
			r_langs_str = ""
			while (line = fin.gets) != "\n"
				r_langs_str += line.delete("\n")
			end
			r_langs = eval r_langs_str
			r_langs.select!{ |k,v| $sel_langs.include? k }
			if r_langs.size > 0
				repo = Octokit.repository r_name
				puts r_name
				puts repo.description
				fout.puts r_name
				fout.puts repo.description
			end
		end
	end
end

parse_get_description
