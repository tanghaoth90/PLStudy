require 'pp'

$sel_langs = [:C, :'C++', :'C#', :'Objective-C', :Go, \
	:Java, :CoffeeScript, :JavaScript, :TypeScript, \
	:Ruby, :Php, :Python, :Perl, :Clojure, :Erlang, \
	:Haskell, :Scala]

def lang_count(threshold)
	fin = open 'results/langs.log', 'r'
	lnums = []
	while repo_name = fin.gets
		repo_name.delete!("\n")
		repo_langs_str = ""
		while (line = fin.gets) != "\n"
			repo_langs_str += line.delete("\n")
		end
		repo_langs = eval repo_langs_str
		repo_langs.select!{ |k,v| $sel_langs.include? k }
		total_size = repo_langs.values.inject(0){ |sum,x| sum+x }
		th_size = (total_size * threshold).floor
		repo_langs_th = repo_langs.select{ |k,v| v>th_size }
#		puts repo_name + " " + repo_langs_th.size.to_s
		lnums << repo_langs_th.size
	end
	h = Hash.new(0)
	lnums.each{ |v| h.store(v, h[v]+1) }
#	pp lnums
	p h 
	fin.close
end

[0, 0.05, 0.1, 0.15, 0.20].each do |t|
	lang_count t
end

