import sys, os, csv, json, urllib2, re

def get_json_obj(json_url):
	try:
		response = urllib2.urlopen(json_url+"?client_id=%s&client_secret=%s"%(os.environ['PL_CLT_ID'], os.environ['PL_CLT_SEC'])).read()
		json_obj = json.loads(response)
	except:
		print "Encounter a URL Error. " + json_url
		return None
	return json_obj

with open('time2.csv', 'rb') as csvfile, open('issue_change.csv', 'wb') as csvoutfile:
	reader = csv.reader(csvfile)
	writer = csv.writer(csvoutfile)
	for row_id, (user_name, proj_name, lang, issue_id, _) in enumerate(reader):
		issue_json = get_json_obj("https://api.github.com/repos/%s/%s/issues/%s" % (user_name, proj_name, issue_id))
		msg, addnum, delnum = "no_commits", -1, -1
		if issue_json:
			if "pull_request" in issue_json: # if this issue is a pull request, use "addition" and "deletion" information of the corresponding pull request
				msg = "pull_request"
				pr_json = get_json_obj(issue_json["pull_request"]["url"])
				addnum, delnum = pr_json["additions"], pr_json["deletions"]
			else:
				events_json = get_json_obj(issue_json["events_url"])
				commit_list = [event["commit_url"] for event in events_json if event["commit_url"] and get_json_obj(event["commit_url"])]
				msg = "no_commits"
				if len(commit_list) > 0: # if some events in this issue contains "commit_id"
					msg = "events"
				else: # if none of events contains "commit_id", check all comments
					comments_json = get_json_obj(issue_json["comments_url"])
					get_commit_url = lambda s: "https://api.github.com/repos/%s/%s/commits/%s" % (user_name, proj_name, s)
					for comment in comments_json:
						body = comment["body"]
						commit_list = [get_commit_url(s) for s in re.findall(r"[0-9a-f]+",body) if len(s) > 20 and get_json_obj(get_commit_url(s))]
				if len(commit_list) > 0:
					if msg == "no_commits": msg = "comments"
					stats_list = [get_json_obj(commit_url)["stats"] for commit_url in commit_list]
					addnum = sum(stats["additions"] for stats in stats_list)
					delnum = sum(stats["deletions"] for stats in stats_list)
		else:
			msg = "absent"
		print "%d .../%s/%s/issues/%s" % (row_id, user_name, proj_name, issue_id), 
		print "%s add:%d del:%d" % (msg, addnum, delnum)
		writer.writerow([user_name, proj_name, lang, issue_id, msg, addnum, delnum])
print "Normal termination."
