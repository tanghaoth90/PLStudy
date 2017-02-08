require 'pp'

$sel_langs = [:C, :'C++', :'C#', :'Objective-C', :Go, \
	:Java, :CoffeeScript, :JavaScript, :TypeScript, \
	:Ruby, :Php, :Python, :Perl, :Clojure, :Erlang, \
	:Haskell, :Scala]

def parse_repo2langs()
	open 'results/langs.log', 'r' do |fin|
		result = {}
		while r_name = fin.gets
			r_name.delete!("\n")
			r_langs_str = ""
			while (line = fin.gets) != "\n"
				r_langs_str += line.delete("\n")
			end
			r_langs = eval r_langs_str
			r_langs.select!{ |k,v| $sel_langs.include? k }
			result[r_name] = r_langs
		end
		return result
	end
end

def lang_count(repo2langs, threshold, fout)
	repo2lnum = {}
	repo2langs_thre = {}
	repo2langs.each do |r_name, r_langs|
		total_size = r_langs.values.inject(0){ |sum,x| sum+x }
		threshold_size = (total_size*threshold).floor
		r_langs_thre = r_langs.select{ |k,v| v>threshold_size }
		repo2lnum[r_name] = r_langs_thre.size
		repo2langs_thre[r_name] = r_langs_thre
	end
	h = Hash.new(0)
	repo2lnum.values.each{ |v| h.store(v, h[v]+1) }
	h = h.sort
	fout.puts
	fout.puts '| #Languages | #Repositories |'
	fout.puts '|:--:| --:| --:|'
	h.reverse.each do |num_of_lang, num_of_r|
		fout.puts '| ' + num_of_lang.to_s + ' | ' + num_of_r.to_s + ' |'
	end
	fout.puts
	repo2lnum.sort_by{|k,v| v}.reverse.each_with_index do |(k,v),i|
		if i >= 30 
			break 
		end
		fout.puts (i+1).to_s + ". [" + k + "](" + \
			+ "https://github.com/" + k +
			+ ") **" + v.to_s + "** "
		fout.puts
		PP.pp repo2langs_thre[k], fout
		fout.puts
	end
end

repo2langs = parse_repo2langs()
open 'results/repos_with_most_langs.md', 'w' do |fout|
	[0, 0.05, 0.1, 0.15, 0.20].reverse.each do |threshold|
		fout.puts '### Threshold = ' + threshold.to_s + ' ###'
		lang_count repo2langs, threshold, fout
	end
end

