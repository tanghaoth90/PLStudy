require 'rugged'
require 'linguist'

repo = Rugged::Repository.new('../../codebase/scikit-learn')
project = Linguist::Repository.new(repo, repo.head.target_id)
puts project.language
puts project.languages
