# Open the file on Github
#
# Usage
#   ruby open_file_on_gh.rb <target_file_path> <line_number>
#
# - only ssh
# - only master branch
# - hub command must exist
# - github repository name equal local repository name

target_file_path = File.absolute_path(ARGV[0])
line_number = ARGV[1]

git_remote_url = `cd #{File.dirname(target_file_path)};git remote get-url origin`
matched = git_remote_url.match(%r{git@github.com:(.*)/(.*).git})
gh_user_name, gh_repo_name = matched[1], matched[2]

gh_file_path = target_file_path.match(%r!#{gh_user_name}/#{gh_repo_name}/(.*)!)
if gh_file_path.nil?
  gh_file_path = target_file_path.match(%r!#{gh_repo_name}/(.*)!)[1]
else
  gh_file_path = gh_file_path[1]
end

url = "#{gh_user_name}/#{gh_repo_name}/blob/master/#{gh_file_path}#L#{line_number}"

`hub browse #{url}`

return 0
