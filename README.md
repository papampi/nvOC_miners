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
In this example we assume you want to add a fictitious miner called "NEWminer" to this repository

### Create a new branch to work on
To allow your changes to be shared with the nvOC community you need to create your own branch where you can do all your changes.
It's very easy:
- change your working directory to nvOC miners path if you are not there already:

`cd miners`

- create the branch (it is best if you choose a meaningful name):

`git checkout --force -b add-NEWminer 19-2.1`

As you can see your branch will use `19-2.1` as base branch.

### Add binary package & installer
- create the installer section in the first part of `nvOC_miner_update.sh`
- create a coherent compressed tarball (in XZ format) with only the binaries needed to run and a `version` test file containing either the version number as it appears in the name of github release tag in the miner developer repository, or a specific commit reference (hash)
- place this tarball in a new folder inside `miners`, for example `mienrs/NEWminer`
- if you think it's useful to keep also old binary versions of the same miner available in this repo look at the ethminer section in the update script to see how you can manage to do that

### Add source code submodule & compiler
If recompilation support is needed:
- change your working directory to nvOC miners path if you are not there already:

`cd miners`

- add the necessary compile function in the second part of `nvOC_mienr_update.sh`
- add the source repo as submodule of this `nvOC_miners` repo:

`git -C NEWminer submodule add https://repo_url src`

- checkout the source tree referenced by its commit hash:

`git -C NEWminer/src checkout RELEASE_COMMIT_HASH`

- then check that all went fine with:

`git submodule status`

- finally, add and commit the change as usual:

`git add NEWminer/src`

`git commit -m "Added NEWminer v0.1"`

From now on, every time a submodule update is performed the new release tree will be checked out.

- test the compiler script is working for the new miner:

`bash nvOC_miner_update.sh`

Choose to compile that miner when prompted.

- if you have write access to nvOC_miners repo or you worked from your own fork, you could now do

`git push`

to publish your update on the remote GitHub repo.

You can now open a new Pull Request (PR) for your miner addition proposal to share it with all nvOC users.
After your PR gets merged everyone who use `bash nvOC miners-upgrade` command will get the new miner.

## For contributors: update an existing miner to this repo
In this example we assume you want to update a fictitious miner called "NEWminer" which is part of this repository to a different version

### Create a new branch to work on
To allow your changes to be shared with the nvOC community you need to create your own branch where you can do all your changes.
It's very easy:
- change your working directory to nvOC miners path if you are not there already:

`cd miners`

- create the branch (it is best if you choose a meaningful name):

`git checkout --force -b update-NEWminer 19-2.1`

As you can see your branch will use `19-2.1` as base branch.

### Update binary package & installer
- update the existing installer section in the first part of `nvOC_miner_update.sh` with new version numbers and paths
- create a coherent compressed tarball (in XZ format) with only the updated binaries needed to run and a `version` test file containing either the updated version number as it appears in the name of github release tag in the miner developer repository, or a specific commit reference (hash)
- place this tarball in the same folder of that one for the previous release
- if you think it's useful to keep also old binary versions of the same miner available in this repo look at the ethminer section in the update script to see how you can manage to do that

### Update source code submodule & compiler
If recompilation support is needed:
- change your working directory to nvOC miners path if you are not there already:

`cd miners`

- check that necessary compile function in the second part of `nvOC_mienr_update.sh` is still compatible with updated sources
- restore current submodule reference on clean workspace:

`git -C NEWminer submodule update --init --force src`

- it's likely your local repo has been originally cloned in shallow mode (all nvOC miners compiling scripts attempt this by default to download less data) so in case you want to update the submodule to target an older release, you would have to unshallow it first in order to fetch old commits:

`git -C NEWminer/src fetch --unshallow`

- if you intend to update to a newer release you have to fetch new commits:

`git -C NEWminer/src fetch`

- checkout the updated tree referenced by its commit hash:

`git -C NEWminer/src checkout RELEASE_COMMIT_HASH`

- then check that all went fine with:

`git submodule status`

- finally, add and commit the change as usual:

`git add NEWminer/src`

`git commit -m "Updated NEWminer to v0.2"`

From now on, every time a submodule update is performed the new release tree will be checked out.

- test the compiler script is working for the updated release:

`bash nvOC_miner_update.sh`

Choose to compile that miner when prompted.

- if you have write access to nvOC_miners repo or you worked from your own fork, you could now do

`git push`

to publish your update on the remote GitHub repo.

You can now open a new Pull Request (PR) for your miner update proposal to share it with all nvOC users.
After your PR gets merged everyone who use `bash nvOC miners-upgrade` command will get the updated miner.