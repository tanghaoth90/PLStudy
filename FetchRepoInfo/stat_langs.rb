fin = open 'results/langs.log', 'r'

while repo_name = fin.gets
	langs = ""
	while (line = fin.gets) != "\n"
		langs += line.delete!("\n")
	end
	puts repo_name + " " + langs 
end
