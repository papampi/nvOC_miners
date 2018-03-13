# nvOC_miners

Here is a quick how-to for reference.

Init miners repo as nvOC submodule:
from nvOC root
`cd NVOC`
`git submodule update miners`

or alternatively init as standalone repo:
`git clone https://github.com/<fork>/nvOC_miners miners`

Install or update miners (assuming no changes into miners local repo by user):
`cd miners`
`git pull origin master`
`bash nvOC_miner_update.sh`

otherwise either revert or stash before

For contributors, release a miner (added or updated) as binary package:
- create the installer section in `nvOC_miner_update.sh`
- add a coherent tarball with only the binary needed to run and the version file containing (preferentially) either the git tag of the release if exists or the commit hash
- if it's useful to keep old binary versions available look at the ethminer installer for reference

If recompilation support is provided:
- add the necessary section in `nvOC_mienr_update.sh`
- add the source repo as submodule of this `nvOC_miners` repo:
`cd miners/NEWminer`
`git submodule add https://repo_url src`
`cd src`
`git checkout RELEASE_COMMIT_HASH`
`cd ..`

then check that all went fine with:
`git submodule status`

And finally commit as usual.