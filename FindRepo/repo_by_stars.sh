curl -G https://api.github.com/search/repositories \
 --data-urlencode "q=stars:>1000" \
 --data-urlencode "sort=stars" \
 --data-urlencode "order=desc" \
 -H "Accept: application/vnd.github.v3+json" \
 > repo.log
