import sys, os, csv, json, urllib2

def get_json_obj(json_url):
	try:
		response = urllib2.urlopen(json_url+"?client_id=%s&client_secret=%s"%(os.environ['PL_CLT_ID'], os.environ['PL_CLT_SEC'])).read()
		json_obj = json.loads(response)
	except:
		print "Encounter a URL Error."
		sys.exit(1)
	return json_obj

with open('time2.csv', 'rb') as csvfile:
	reader = csv.reader(csvfile)
	for row_id, (user_name, proj_name, _, issue_id, _) in enumerate(reader):
		#if row_id >= 0: break
		if row_id < 28 or row_id > 40: continue
		print ".../%s/%s/issues/%s" % (user_name, proj_name, issue_id), 
		issue_json = get_json_obj("https://api.github.com/repos/%s/%s/issues/%s" % (user_name, proj_name, issue_id))
		addnum, delnum = -1, -1
		if "pull_request" in issue_json: 
			# if this issue is a pull request, use "addition" and "deletion" information of the corresponding pull request
			print "pull_request ", 
			pr_json = get_json_obj(issue_json["pull_request"]["url"])
			addnum, delnum = pr_json["additions"], pr_json["deletions"]
		else:
			events_json = get_json_obj(issue_json["events_url"])
			commit_list = [event["commit_url"] for event in events_json if event["commit_url"]]
			if len(commit_list) > 0: 
				# if some events in this issue contains "commit_id"
				print "events",
			else:
				# if none of events contains "commit_id"
				print "[may] comments",
			if len(commit_list) > 0:
				stats_list = [get_json_obj(commit_url)["stats"] for commit_url in commit_list]
				addnum = sum(stats["additions"] for stats in stats_list)
				delnum = sum(stats["deletions"] for stats in stats_list)
		print "add:%d del:%d" % (addnum, delnum)

print "Normal termination."
