# Open file in Github
#
# Usage
#   ruby open_file_in_github.rb <project_dir_path> <target_file_path>
#
# - only ssh
# - only master branch
# - hub command must exist
# - github repository name equal local repository name

project_root_path = ARGV[0]
absolute_file_path = ARGV[1]

git_remote_url = `cd #{project_root_path};git remote get-url origin`
matched = git_remote_url.match(%r{git@github.com:(.*)/(.*).git})
gh_user_name, gh_repo_name = matched[1], matched[2]
file_path = absolute_file_path.match(%r!#{gh_repo_name}/(.*)!)[1]

url = "#{gh_user_name}/#{gh_repo_name}/blob/master/#{file_path}"

`hub browse #{url}`
