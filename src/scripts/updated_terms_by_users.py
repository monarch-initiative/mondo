import requests
from datetime import datetime, timedelta
import os
import subprocess
from dotenv import load_dotenv
import json
from tabulate import tabulate

# TODO: Change for general use if this code is used for a production process, e.g. GH Action
ENV_FILE_PATH = "/Users/twhetzel/.env-github"
load_dotenv(dotenv_path=ENV_FILE_PATH)

GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")

if not GITHUB_TOKEN:
    print("Error: GITHUB_TOKEN is not set. Please check your .env file.")
    exit(1)

GITHUB_OWNER = "monarch-initiative"
GITHUB_REPO = "mondo"
API_URL = f"https://api.github.com/repos/{GITHUB_OWNER}/{GITHUB_REPO}/issues"
GH_ISSUE_AUTHORS = ["RyanFWebb", "clauseMDM"]

DAYS_BACK = 20  # Number of days to look back for issues. 20 days was selected for this example to have relevant data(closed issues) for testing
days_back_ago = datetime.utcnow() - timedelta(days=DAYS_BACK)
SINCE_DATE = days_back_ago.replace(microsecond=0).isoformat() + "Z"

GITHUB_URL = f"https://api.github.com/repos/{GITHUB_OWNER}/{GITHUB_REPO}/issues?state=closed&since={SINCE_DATE}&per_page=100"

headers = {
    "Authorization": f"Bearer {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json"
}

def fetch_issues():
    """ Query GitHub API """
    issues_data = []

    response = requests.get(GITHUB_URL, headers={"Accept": "application/vnd.github.v3+json"})

    if response.status_code == 200:
        issues = response.json()
        for issue in issues:
            issue_url = f"https://github.com/{GITHUB_OWNER}/{GITHUB_REPO}/issues/{issue['number']}"
            issues_data.append({
                "number": issue.get("number"),
                "title": issue.get("title"),
                "status": issue.get("state"),
                "created_at": issue.get("created_at"),
                "updated_at": issue.get("updated_at"),
                "author": issue.get("user").get("login"),
                "closed_at": issue.get("closed_at"),
                "issue_url": issue_url
            })
    else:
        print(f"Error fetching closed isues: {response.status_code}, {response.text}")

    return issues_data

def query_mondo_terms(issue_url):
    """Query Mondo to find terms associated with a given GitHub issue URL."""
    
    sparql_query = f"""
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX owl: <http://www.w3.org/2002/07/owl#>
    PREFIX obo: <http://purl.obolibrary.org/obo/>
    PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
    PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>

    SELECT DISTINCT ?mondoCURIE ?mondoLabel
    WHERE {{
        ?mondoClass a owl:Class ;
                rdfs:label ?mondoLabel ;
                oboInOwl:id ?mondoCURIE .

    # Match the issue URL annotation
    ?mondoClass IAO:0000233 ?issueUrl .
    
    # Filter for the specific GitHub issue URL
    FILTER(STR(?issueUrl) = "{issue_url}")
    }}
    """

    # Local OWL file path (alternative can be released version of Mondo)
    MONDO_FILE = "../ontology/mondo-edit.obo"

    # TODO: Store query and data in another location if this code is used in a production process
    # Define the query file path
    query_file = "tmp/query.sparql"
    output_file = "tmp/mondo_results.tsv"

    # Write the query to a temporary file
    with open(query_file, "w") as f:
        f.write(sparql_query)

    # Run the ROBOT query command
    try:
        subprocess.run(
            [
                "robot", "query",
                "--input", MONDO_FILE,
                "--query", query_file, output_file
            ],
            check=True
        )

        if not os.path.exists(output_file) or os.stat(output_file).st_size == 0:
            print(f"Warning: No results found for {issue_url}")
            return []

        # Read and process results
        mondo_terms = []
        with open(output_file, "r") as f:
            next(f)
            for line in f:
                cols = line.strip().split("\t")
                if len(cols) >= 2:
                    mondo_terms.append((cols[0], cols[1]))  # (Mondo ID, Label)

        return mondo_terms
    
    except subprocess.CalledProcessError as e:
        print(f"Error running ROBOT: {e}")
        return []
    


# Run the function and print results
all_issues = fetch_issues()

print("\nAll Retrieved Closed GitHub Issues")
all_user_results = []
for issue in all_issues:
    # Get Issue URL information for ticket from GH_ISSUE_AUTHORS
    for author in GH_ISSUE_AUTHORS:
        if author == issue['author']:
            print(f"{issue['author']} -- {issue['issue_url']}")
            all_user_results.append(query_mondo_terms(issue['issue_url']))

# Save results as Markdown table
flattened_data = [row[0] for row in all_user_results]
# Remove extra quotes around strings
cleaned_data = [(mondo_id.strip('"'), disease_name.strip('"')) for mondo_id, disease_name in flattened_data]
headers = ["MONDO ID", "Disease Name"]
# Generate Markdown table
markdown_table = tabulate(cleaned_data, headers=headers, tablefmt="pipe")

# Print and save to file
print(markdown_table)

# TODO: Save file in another location if this code is used in a production process
with open("tmp/mondo_table.md", "w") as md_file:
    md_file.write(markdown_table)
