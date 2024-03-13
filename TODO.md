
# Action Items

Notes of where I left off, the default OpenSearch credentials are admin:admin. 

## Next

- Figure out how to expose OpenSearch and OpenSearch Dashboard to the host computer over ports 9200 and 5601 (respectively)
- Initial a walk through
	- check, via https, if the server is live
	- create a new index
	- index several documents
	- test the search results
	- create an index alias
	- test adding documents via the alias
	- test search documents via the alias
	- figure out how to back up the generated index
- Backup the index and restore it
	- Take the previous OpenSearch instance and do the following
		- back of the index
		- destroy the container
		- create a new container and setup fresh OpenSearch instance
		- restore the index
