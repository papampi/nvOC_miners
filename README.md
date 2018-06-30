# nvOC_miners

Here is a quick how-to for reference.

## Init miners repo
as nvOC submodule from nvOC installation path:

`git submodule update --init --depth 1 --remote miners`

or alternatively init as standalone repo:

`git clone https://github.com/papampi/nvOC_miners miners`

## Install or update miners
assuming no changes into local miners repo:

`cd miners`

`git fetch`

`git checkout 19-2.1`

`git pull`

`bash nvOC_miner_update.sh`

otherwise either revert or stash before

## For contributors: add a new miner to this repo

### Add binary package & installer
- create the installer section in the first part of `nvOC_miner_update.sh`
- create a coherent compressed tarball (in XZ format) with only the binaries needed to run and a `version` test file containing either the version number as it appears in the name of github release tag in the miner developer repository, or a specific commit reference (hash)
- place this tarball in a new folder inside `miners`, for example `mienrs/NEWminer`
- if you think it's useful to keep also old binary versions of the same miner available in this repo look at the ethminer section in the update script to see how you can manage to do that

### Add source code submodule & compiler
If recompilation support is needed:
- add the necessary compile function in the second part of `nvOC_mienr_update.sh`
- add the source repo as submodule of this `nvOC_miners` repo:

`cd miners`

`git -C NEWminer submodule add https://repo_url src`

`git -C NEWminer/src checkout RELEASE_COMMIT_HASH`

then check that all went fine with:

`git submodule status`

And finally commit and push as usual:

`git commit -m "Added NEWminer v0.1"`

`git push`

## For contributors: update an existing miner to this repo

### Update binary package & installer
- update the existing installer section in the first part of `nvOC_miner_update.sh` with new version numbers and paths
- create a coherent compressed tarball (in XZ format) with only the updated binaries needed to run and a `version` test file containing either the updated version number as it appears in the name of github release tag in the miner developer repository, or a specific commit reference (hash)
- place this tarball in the same folder of that one for the previous release
- if you think it's useful to keep also old binary versions of the same miner available in this repo look at the ethminer section in the update script to see how you can manage to do that

### Update source code submodule & compiler
If recompilation support is needed:
- check that necessary compile function in the second part of `nvOC_mienr_update.sh` is still working for the updated source tree
- update the existing submodule reference:

`cd miners`

`git -C NEWminer submodule update --init src`

`git -C NEWminer/src checkout RELEASE_COMMIT_HASH`

then check that all went fine with:

`git submodule status`

And finally commit and push as usual:

`git commit -m "Updated NEWminer to v0.2"`

`git push`

