require 'pp'
require 'octokit'

$sel_langs = [:C, :'C++', :'C#', :'Objective-C', :Go, \
	:Java, :CoffeeScript, :JavaScript, :TypeScript, \
	:Ruby, :Php, :Python, :Perl, :Clojure, :Erlang, \
	:Haskell, :Scala]

flagdesc = false
flagreadme = true
fout = File.open 'results/desc.log', 'w'
fout_readme = File.open 'results/readmes/readmes.log', 'w'
fin = File.open 'results/langs.log', 'r'
i = 0
while r_name = fin.gets
	r_name.delete!("\n")
	r_langs_str = ""
	while (line = fin.gets) != "\n"
		r_langs_str += line.delete("\n")
	end
	r_langs = eval r_langs_str
	r_langs.select!{ |k,v| $sel_langs.include? k }
	if r_langs.size > 0
		if flagdesc 
			repo = Octokit.repository r_name
			puts r_name
			puts repo.description
			fout.puts r_name
			fout.puts repo.description
		end
		if flagreadme
			rdm = Octokit.readme r_name, :accept => 'application/vnd.github.raw'
			i += 1
			puts r_name + ' ' + i.to_s
			fout_readme.puts r_name + " " + i.to_s
			fout_newreadme = File.open 'results/readmes/' + i.to_s + '.readme', 'w'
			fout_newreadme.puts rdm
			fout_newreadme.close
		end
	end
end

