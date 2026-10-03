setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-pimp-my-shell
  mkdir -p $TESTDIR
  export PROJNAME=test-pimp-my-shell
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

health_checks() {
  # Do something useful here that verifies the add-on
  ddev ahoy --version
  ddev exec 'grep -q __start_ahoy /usr/share/bash-completion/completions/ahoy'
  ddev fish -c 'complete -C "ahoy comp"' | grep -q completion
  printf "version: 3\ntasks:\n  hello: echo hi\n" > Taskfile.yml
  ddev __complete task "" | grep -qx hello
  printf "ahoyapi: v2\ncommands:\n  hello:\n    cmd: echo hi\n" > .ahoy.yml
  ddev __complete ahoy "" | grep -qx hello
  ddev __complete upterm "" | grep -qx host
  ddev fish --version
  ddev exec bash -cli z
  ddev exec starship --version
  ddev exec --raw bash -cli "fzf --version"
  ddev exec bat --version
  ddev gum --version
  # gum v2 before 2.0.2 leaked mode 2026/2027 queries after `gum spin`.
  [ -z "$(ddev exec "script -q -c 'TERM=xterm-ghostty gum spin --title x -- true' /dev/null" | grep -F '?2026')" ]
  ddev exec editor --version | grep -i vim
  ddev fish -c "fisher --version"
  ddev fish -c "tide --version"
  ddev fish -c "bass"
  ddev exec 'eza --version'
  ddev exec 'bash -ic "go version"'
  ddev fish -c 'go version'
  ddev exec bun --version
  ddev fish -c 'bun --version'
  ddev exec 'bash -ic "spacer --version"'
  ddev fish -c "spacer --version"
  ddev exec 'bash -ic "sysbox version"'
  ddev fish -c "sysbox version"
  ddev exec 'bash -ic "delta --version"'
  ddev fish -c "delta --version"
  ddev exec git config --global core.pager | grep -qx delta
  ddev exec 'bash -ic "tte --version"'
  ddev fish -c 'tte --version'
  ddev exec 'bash -ic "lazygit --version"'
  ddev fish -c 'lazygit --version'
  ddev exec 'bash -ic "ov --version"'
  ddev fish -c 'ov --version'
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev add-on get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev add-on get ${DIR}
  ddev restart
  health_checks
}
