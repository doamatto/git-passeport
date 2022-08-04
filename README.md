## Usage
1. Add `git-passeport.sh` to your server and make it executable (`chmod +x git-passeport.sh`)
2. Create a `git` user (`adduser git`)
3. Add SSH keys to the user (`.ssh/authorized_keys`) prefixed by `command="git-passeport.sh repo..."`
  - **Note:** you should specify the exact directory of the Shell file. Wildcards (`folder/*`) aren't supported as of now.
