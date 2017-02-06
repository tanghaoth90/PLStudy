require 'pp'

sel_langs = [:C, :'C++', :'C#', :'Objective-C', :Go, \
	:Java, :CoffeeScript, :JavaScript, :TypeScript, \
	:Ruby, :Php, :Python, :Perl, :Clojure, :Erlang, \
	:Haskell, :Scala]

fin = open 'results/langs.log', 'r'

while repo_name = fin.gets
	repo_name.delete!("\n")
	repo_langs_str = ""
	while (line = fin.gets) != "\n"
		repo_langs_str += line.delete("\n")
	end
	repo_langs = eval repo_langs_str
	repo_langs.select!{|key,value| sel_langs.include? key}
	puts repo_name
	pp repo_langs
end

