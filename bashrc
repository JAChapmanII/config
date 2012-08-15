# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LC_COLLATE=${LC_COLLATE-C}

export HOME=${HOME-/home/$(whoami)}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME-${HOME}/.config}

export HOST=${HOST-$HOSTNAME}
export HOST=${HOST-$(hostname)}

localBashrc="${XDG_CONFIG_HOME}/bashrc-${HOST}"
[[ -f "${localBashrc}" ]] && source "${localBashrc}"

# important and standard binary locations
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

pathDirs=(
	$HOME/bin                        # personal binary directory
	/opt/android-sdk/tools           # android development directory
	/opt/android-sdk/platform-tools  # android development directory
)
for (( i = 0; i < ${#pathDirs[@]}; i++ )); do
	[[ -d "${pathDirs[$i]}" ]] && export PATH=$PATH:${pathDirs[$i]}
done

includeFiles=(
	${XDG_CONFIG_HOME}/aliases    # aliases file
	${XDG_CONFIG_HOME}/functions  # functions file
	$HOME/bin/mssha               # keep track of ssh-agent
)
for (( i = 0; i < ${#includeFiles[@]}; i++ )); do
	[[ -f "${includeFiles[$i]}" ]] && source ${includeFiles[$i]}
done

if [[ -d "/etc/profile.d" ]]; then
	for profile in /etc/profile.d/*.sh; do
		source $profile
	done
fi

[[ -f ${XDG_CONFIG_HOME}/dircolors ]] &&
	eval $(dircolors ${XDG_CONFIG_HOME}/dircolors)

PS1='[~]$ '

function cd() {
	dest="${@-$HOME}"
	if [[ ! -d "$dest" ]]; then
		echo "cd: $dest: No such directory"
		return 1
	fi
	builtin cd "$dest"

	# get absolute path
	d="$(pwd)"

	IFS=$'\n'
	PPIECES=( $(echo $d | sed 's:/:\n:g') )
	PMAP=

	for (( i = 0; i < ${#PPIECES[@]}; ++i )); do
		PMAP[$i]='\e[0;36m'
	done

	if which git &> /dev/null; then
		p=
		for (( i = 0; i < ${#PPIECES[@]}; ++i )); do
			p="$p/${PPIECES[$i]}"
			builtin cd "$p"
			if git rev-parse &> /dev/null; then
				PMAP[$i]='\e[1;32m'
			fi
		done
	fi
	builtin cd "$d"

	FDIR=
	for (( i = 0; i < ${#PPIECES[@]}; ++i )); do
		if (( i != ${#PPIECES[@]} - 1 )); then
			PPIECES[$i]=${PPIECES[$i]:0:1}
		fi
		FDIR=$FDIR/'\['${PMAP[(($i))]}'\]'${PPIECES[$i]}'\[\e[0m\]'
	done
	unset IFS

	SPART=
	if [[ -n "$SCHROOT_SESSION_ID" ]]; then
		SPART='\[\e[0;31m\][32]\[\e[0m\]'
	fi

	HOSTP='\[\e[0;36m\]'$(echo "${HOST}" | cut -d'.' -f1)'\[\e[0m\]'
	export PS1="(${HOSTP}${FDIR})${SPART}> "
}
cd

shopt -s cmdhist
shopt -s histappend histverify
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

