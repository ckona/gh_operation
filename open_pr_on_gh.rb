# Open the PullRequest on Github
#
# Usage
#   ruby open_pr_on_gh.rb <commit_hash>
#

commit_hash = ARGV[0]

merged_log = `git log --merges --oneline --reverse --ancestry-path #{commit_hash}...master`
pr_number = merged_log.match(%r!Merge pull request #([0-9]*) !)[1]

git_remote_url = `git remote get-url origin`
matched = git_remote_url.match(%r{git@github.com:(.*)/(.*).git})
gh_user_name, gh_repo_name = matched[1], matched[2]

url = "#{gh_user_name}/#{gh_repo_name}/pull/#{pr_number}"

`hub browse #{url}`
