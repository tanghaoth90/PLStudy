import commands

lg2exts = dict({
	'C':['.c', '.C'], #.h, .H
	'C++':['.cpp', '.inl', '.hh', '.hpp', '.ipp', '.cp', '.cc'], #.h, .inc
	'C#':['.cs', 'cake', 'cshtml'],
#	'Objective-C':['.h', '.m'],
#	Go:['.go'],
	Java:['.java'],
#	CoffeeScript:['.coffee', '.cake', '.cjsx'],
	JavaScript:['.js', '.es', '.gs', '.xsjs', '.xsjslib', '.frag', '.jsb', '.jscad'],
#	TypeScript:['.ts', '.tsx'],
	Ruby:['.rb', '.jbuilder', '.pluginspec', '.rabl', '.rack'], #.spec, .fcgi
	PHP:['.php', '.phps'], #.fcgi, .inc
	Python:['.py', '.pyde', '.pyp', '.cgi', '.rpy']#, #.spec, .fcgi
#	Perl:['.pl', '.pm', '.pod', '.cgi', '.al', '.fcgi'],
#	Clojure:['.clj', '.hic', '.hl', '.cljc', '.cljs', '.cljscm', '.cljx', '.cl2', '.boot'],
#	Erlang:['.escript', '.erl', '.app.src', '.es', '.yrl', '.xrl'],
#	Haskell:['.hs'],
#	Scala:['.sc', '.sbt'],
#	Swift:['.swift']
})

gitdir = "/home/tanghao/codebase/laravel"
gitpath = gitdir + "/.git"
splitter = "@@**@@"
(status, output) = commands.getstatusoutput(
	"git --git-dir " + gitpath
	+ " log --numstat --no-merges --pretty=format:"+splitter+"%h" )
commits = output.split(splitter)
chgs = ""
i = 0
chgsdic = dict({})
for lg in lg2exts.keys():
	chgsdic[lg] = []
for commit in commits[1:]:
	lines = commit.split("\n")
	sha1 = lines[0]
	i += 1
	chg = 0
	for line in lines[1:]:
		flds = line.split("\t")
		if len(flds) == 3:
			for (lg, exts) in lg2exts.items():
				(inslines, dellines, filename) = flds
				if inslines.isdigit() and dellines.isdigit() and filename.endswith(".php"):
					chg += int(inslines) + int(dellines)
	chgs += str(chg) + " "
	#print "#" + str(i) + " " + sha1 + " " + str(chg)
	#(status, output) = commands.getstatusoutput(
	#	"git --git-dir " + gitdir + " diff --numstat " + sha1 )
print chgs
#subprocess.call(["git", "--git-dir", "/home/tanghao/codebase/laravel/.git",
#	"log", "--numstat", "--no-merges", "--pretty=format:**%n%h%n%s"])
#	#"blame", "--show-stats"])

