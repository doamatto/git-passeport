| :exclamation:  [This repository is now maintained on Sourcehut here.](https://git.sr.ht/~maatt/git-passeport)   |
|-----------------------------------------------------------------------------------------------------------------|

## Usage
1. Add `git-passeport.sh` to your server and make it executable (`chmod +x git-passeport.sh`)
2. Build `app.go` (`go build applet.go`)
3. Create a `git` user (`adduser git`)
4. Add SSH keys to the user (`.ssh/authorized_keys`) prefixed by `command="git-passeport.sh"`
  - **Note:** you should specify the exact directory of the Shell file. Wildcards (`folder/*`) aren't supported as of now.
4. Ensure your bare repositories (`git init --bare example.git`) are owned by the `git` user
