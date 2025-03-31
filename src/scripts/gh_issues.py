from github import Github
import argparse
from datetime import datetime, timezone
from collections import Counter, defaultdict
from tqdm import tqdm
from pathlib import Path
import csv


def get_date_obj(date_str: str) -> datetime:
    """ Get today's date. """
    return datetime.strptime(date_str, "%Y-%m-%d").replace(tzinfo=timezone.utc)


def main(repo_name: str, token: str, from_date: str, to_date: str, outpath: str, user_report: str) -> None:
    """ 
    Get all closed and opened GitHub issues between two dates and get the 
    count of all tags for each of these groups of issues.
    """
    g = Github(token)
    repo = g.get_repo(repo_name)

    opened_usernames = Counter()
    closed_usernames = Counter()

    opened_user_labels = defaultdict(set)
    closed_user_labels = defaultdict(set)

    from_dt = get_date_obj(from_date)
    to_dt = get_date_obj(to_date)

    output_path = Path(outpath)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    user_report_path = Path(user_report)
    user_report_path.parent.mkdir(parents=True, exist_ok=True)

    print(f"\nAnalyzing issues in {repo_name} from {from_date} to {to_date}...\n")

    # Get GitHub issues
    issues = repo.get_issues(state="all", since=from_dt)

    new_issues = []
    closed_issues = []
    new_labels = Counter()
    closed_labels = Counter()

    # Process issues
    for issue in tqdm(issues, desc="Processing issues", total=issues.totalCount, miniters=20, ncols=80, colour="green"):
        if issue.pull_request:
            continue  # Skip PRs

        label_names = [label.name for label in issue.labels]

        if from_dt <= issue.created_at <= to_dt:
            new_issues.append(issue)
            new_labels.update(label_names)
            if issue.user:
                opened_usernames[issue.user.login] += 1
                opened_user_labels[issue.user.login].update(label_names)

        if issue.closed_at and from_dt <= issue.closed_at <= to_dt:
            closed_issues.append(issue)
            closed_labels.update(label_names)
            if issue.user:
                closed_usernames[issue.user.login] += 1
                closed_user_labels[issue.user.login].update(label_names)

    # Prepare data to save to file
    rows = [
        {"type": "new_issue", "label": "", "count": len(new_issues)},
        {"type": "closed_issue", "label": "", "count": len(closed_issues)},
    ]

    for label, count in sorted(new_labels.items()):
        rows.append({"type": "label_new", "label": label, "count": count})

    for label, count in sorted(closed_labels.items()):
        rows.append({"type": "label_closed", "label": label, "count": count})

    # Prepare metadata for file
    timestamp = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%SZ")
    metadata_line = f"# Stats generated on {timestamp} for GitHub issues from {from_date} to {to_date}\n"

    # Save issue stats to file
    with open(outpath, "w", newline="") as f:
        f.write(metadata_line)
        writer = csv.DictWriter(f, fieldnames=["type", "label", "count"])
        writer.writeheader()
        writer.writerows(rows)

    print(f"GitHub Issue Stats written to: {outpath}")


    # Save username stats to file
    with open(user_report_path, "w", newline="") as f:
        f.write(metadata_line)
        fieldnames = ["type", "github_handle", "count", "labels"]
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()

        for username, count in opened_usernames.most_common():
            writer.writerow({
                "type": "opened",
                "github_handle": username,
                "count": count,
                "labels": ",".join(sorted(opened_user_labels[username]))
            })

        for username, count in closed_usernames.most_common():
            writer.writerow({
                "type": "closed",
                "github_handle": username,
                "count": count,
                "labels": ",".join(sorted(closed_user_labels[username]))
            })

    print(f"GitHub Usernames written to: {user_report_path}")




if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Analyze GitHub issues in a date range.")
    parser.add_argument("--repo", required=True, help="e.g. monarch-initiative/mondo")
    parser.add_argument("--token", required=True, help="GitHub Personal Access Token")
    parser.add_argument("--from", dest="from_date", required=True, help="Start date (YYYY-MM-DD)")
    parser.add_argument("--to", dest="to_date", required=True, help="End date (YYYY-MM-DD)")
    parser.add_argument("--outpath", required=True, help="Path to save the community statistics report (e.g., reports/mondo_stats/mondo-community-stats/...)")
    parser.add_argument("--user-report", required=True, help="Path to save the GitHub usernames report (e.g., reports/mondo_stats/.../mondo_community_usernames.tsv)"
)

    args = parser.parse_args()

    main(args.repo, args.token, args.from_date, args.to_date, args.outpath, args.user_report)
