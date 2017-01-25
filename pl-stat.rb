require 'rugged'
require 'linguist'

codebase_dir = '/home/tanghao/codebase/'
Dir.entries(codebase_dir).select{|entry| File.directory? File.join(codebase_dir,entry) and !(entry=='.' || entry=='..')}.each do |proj_dir|
  puts proj_dir
  puts "---"
  puts ""
  repo = Rugged::Repository.new(codebase_dir+proj_dir)
  project = Linguist::Repository.new(repo, repo.head.target_id)
  puts "Primary language: ".concat(project.language)
  total_bytes = project.languages.map{|l,b| b}.inject(0, :+)
  puts "| Language | Percentage | Bytes |"
  puts "|:--:|:--:|:--:|"
  project.languages.sort_by {|l,b| b}.reverse.each do |l,b|
    puts "| " + l + " | " + (b * 100 / total_bytes.to_f).round(1).to_s + " | " + b.to_s + " |"
  end
  puts "Total bytes: " + total_bytes.to_s
  puts ""
end
