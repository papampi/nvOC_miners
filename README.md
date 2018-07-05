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

- checkout the source tree referenced by its commit hash:

`git -C NEWminer/src checkout RELEASE_COMMIT_HASH`

- then check that all went fine with:

`git submodule status`

- finally, add and commit the change as usual:

`git add NEWminer/src`

`git commit -m "Added NEWminer v0.1"`

From now on, every time a submodule update is performed that tree will be checked out.
If you have write access to nvOC_miners repo or you worked from your own fork, you could now do

`git push`

to publish your update on the remote GitHub repo and open a new Pull Request for your miner addition proposal to share it with all nvOC users.

## For contributors: update an existing miner to this repo

### Update binary package & installer
- update the existing installer section in the first part of `nvOC_miner_update.sh` with new version numbers and paths
- create a coherent compressed tarball (in XZ format) with only the updated binaries needed to run and a `version` test file containing either the updated version number as it appears in the name of github release tag in the miner developer repository, or a specific commit reference (hash)
- place this tarball in the same folder of that one for the previous release
- if you think it's useful to keep also old binary versions of the same miner available in this repo look at the ethminer section in the update script to see how you can manage to do that

### Update source code submodule & compiler
If recompilation support is needed:
- check that necessary compile function in the second part of `nvOC_mienr_update.sh` is still working for the updated source tree
- reinit the existing submodule reference:

`cd miners`

`git -C NEWminer submodule deinit --force src`

`git -C NEWminer submodule update --init src`

- it's likely your local repo has been previously cloned in shallow mode (nvOC miners compiling scripts attempt this by default to download less data) so in case you want to checkout an older release you have to unshallow it first:

`git -C NEWminer/src fetch --unshallow`

- if you intend to update to a newer release you have to fetch into your previously cloned repo new commits:

`git -C NEWminer/src fetch`

- checkout the updated tree referenced by its commit hash:

`git -C NEWminer/src checkout RELEASE_COMMIT_HASH`

- then check that all went fine with:

`git submodule status`

- finally, add and commit the change as usual:

`git add NEWminer/src`

`git commit -m "Updated NEWminer to v0.2"`

From now on, every time a submodule update is performed the new release tree will be checked out.
If you have write access to nvOC_miners repo or you worked from your own fork, you could now do

`git push`

to publish your update on the remote GitHub repo and open a new Pull Request for your miner update proposal to share it with all nvOC users.