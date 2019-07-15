# Open the PullRequest on Github
#
# Usage
#   ruby open_pr_on_gh.rb <file_path> <line_number>
#

file_path = ARGV[0]
line_number = ARGV[1]

file_path = File.absolute_path(file_path)
dir_path = File.dirname(file_path)

commit_hash = `cd #{dir_path};git blame -n -L #{line_number},#{line_number} #{file_path} | cut -d ' ' -f 1`
puts commit_hash
puts `cd #{dir_path};git log --merges --oneline --reverse --ancestry-path #{commit_hash}...feature/open_pr_fix_arg`
exit
pr_number = `cd #{dir_path};git log --merges --oneline --reverse --ancestry-path #{commit_hash}...master | grep 'Merge pull request #' | head -n 1 | cut -d ' ' -f 5 | sed -e 's/#//'`

git_remote_url = `cd #{dir_path};git remote get-url origin`
matched = git_remote_url.match(%r{git@github.com:(.*)/(.*).git})
gh_user_name, gh_repo_name = matched[1], matched[2]

url = "#{gh_user_name}/#{gh_repo_name}/pull/#{pr_number}"

`hub browse #{url}`
