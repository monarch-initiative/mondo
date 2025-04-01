# Release Statistics

## General Statistics


## Rare Subset Statistics
`sh run.sh make create-rare-mondo-stats-all -B`
`sh run.sh make MONDO_TAG=v2025-02-04 create-rare-mondo-stats-all -B`

## Synonyms Statistics


## Community Statistics
- What? These statistics include the counts of new and closed issues between two time dates and the count of all issue labels for each set of new and closed tickets between the two dates. A list of unique GitHub handles for new and closed tickets is also generated along with the count of their opened and closed tickets and the list of unique GitHub labels for the set of these opened and closed tickets.

By default, the dates used are the most recent last two Mondo tagged release dates from the date when the statistics are generated. Therefore, if today is 28-Mar-2025, the most recent last two Mondo tagged release dates are 2025-03-04 and 2025-02-04. The date parameters can be overriden if needed (see below for details on how to do this). 

NOTE: The GitHub UI shows issues based on your system settings timezone and the data retrieved by the GitHub API are based on UTC timezone ((Timezones and the REST API)[https://docs.github.com/en/rest/using-the-rest-api/timezones-and-the-rest-api?apiVersion=2022-11-28]). Therefore, depending on your system settings, there will be some variability between GitHub issue data filtered in the GitHub UI versus what is returned from the GitHub API and therefore in the Commuity Statistics reports.

- Usage
  - From the commandline:
    1. Export your GitHub token as: 
    `export GITHUB_TOKEN=<YOUR-GITHUB-TOKEN>`
    1. Run the `make` goal as: 
    `make github-issue-stats` 
    NOTE: This is not run with ODK therefore `sh run.sh` is not needed.
    1. To run with custom dates, e.g. from 2025-02-22 to 2025-03-03, use:
    `make github-issue-stats FROM_DATE=2025-02-22 TO_DATE=2025-03-01`
  
  - From the GitHub Action:
    1. Go to the GitHub Action called "Generate GitHub Issue Statistics"
    1. Click on "Run workflow", select the branch "master" and then click the green "Run workflow" button and optionally add the to and from dates. If no dates are specified, the default dates are the most recent last two Mondo tagged release dates from the date when the statistics are generated.
    1. Once complete, scroll to the bottom of the page to find the "Artifacts" section and click on the artifact name to download the ZIP file(s) with the report.

- Examples of GitHub UI filters for Issues:
  - Filter by created date: `is:issue created:2025-02-04..2025-03-04`
  - Filter by closed date: `is:issue closed:2025-02-04..2025-03-04`
  - Filter by closed date and label: `is:issue closed:2025-02-04..2025-03-04 label:"New term request"`

  Tips for searching by dates: [GitHub - Query by dates](https://docs.github.com/en/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)  
  
  NOTE: An issue has a "created_at" event and if closed will have a "closed_at" event, which has a date value ((Issue event types - closed)[https://docs.github.com/en/rest/using-the-rest-api/issue-event-types?apiVersion=2022-11-28#closed] and (REST API endpoints for issue events)[https://docs.github.com/en/rest/issues/events?apiVersion=2022-11-28]). There is no event type of "open", however there is an issue "state" of being "open" or "closed". This also means filtering for issues "created" between two dates can contain issues with a state of being "open" or "closed".


## Ontology Change Statistics


## Alignment Statistics


## Third party maintained - xrefs Statistics


## Third party maintained - other Statistics