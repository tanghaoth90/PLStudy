require 'pp'

sel_langs = [:C, :'C++', :'C#', :'Objective-C', :Go, \
	:Java, :CoffeeScript, :JavaScript, :TypeScript, \
	:Ruby, :Php, :Python, :Perl, :Clojure, :Erlang, \
	:Haskell, :Scala]

fin = open 'results/langs.log', 'r'

while repo_name = fin.gets
	repo_name.delete!("\n")
	langs_str = ""
	while (line = fin.gets) != "\n"
		langs_str += line.delete("\n")
	end
	langs = eval langs_str
	langs.select!{|key,value| sel_langs.include? key}
	puts repo_name
	pp langs
end

