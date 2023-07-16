#!/usr/bin/env bash

APT_PACKAGES=(build-essential ca-certificates curl file file-roller fonts-dejavu gdebi-core gnupg gzip libbz2-dev libffi-dev libfuse2 liblzma-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev rar tk-dev uidmap unrar unzip wget xz-utils zip zlib1g-dev gnome-tweaks tailscale openssh-server fonts-jetbrains-mono mlocate xclip atool w3m xlsx2csv jq catdoc exiftool mediainfo)
ARCHITECTURE=$(dpkg --print-architecture)
BOLD_GREEN="\e[1;32m"
CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")
CWD=$(pwd)
END_COLOR="\e[0m"
FINGERPRINT_PACKAGES=(open-fprintd fprintd-clients python3-validity)
FPRINT_PPA="ppa:uunicorn/open-fprintd"
GNOME_EXTENSIONS=(gsconnect@andyholmes.github.io vitals@CoreCoding.com user-theme@gnome-shell-extensions.gcampax.github.com)
HM_BIN="$HOME/.nix-profile/bin"
NIX_BIN="/nix/var/nix/profiles/default/bin/"
PACKAGES_TO_REMOVE=(gnome-contacts gnome-calendar totem geary evince xterm fprintd simple-scan gparted)
DOCKER_PACKAGES=(docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin)

FLATPAK_PACKAGES=(
	ch.protonmail.protonmail-bridge
	com.github.ransome1.sleek
	com.github.tchx84.Flatseal
	com.protonvpn.www
	org.wezfurlong.wezterm
)

clean() {
	echo -e "${BOLD_GREEN}Cleaning up...${END_COLOR}"
	sudo apt clean
	sudo apt autoclean
	sudo apt autoremove -y
}

update() {
	echo -e "${BOLD_GREEN}Updating...${END_COLOR}"
	sudo apt update -y
	sudo apt dist-upgrade -y
}

remove_locks() {
	echo -e "${BOLD_GREEN}Removing locks...${END_COLOR}"
	sudo rm /var/lib/dpkg/lock-frontend
	sudo rm /var/cache/apt/archives/lock
	sudo dpkg --add-architecture i386
}

install_flatpak() {
	echo -e "${BOLD_GREEN}Installing flatpak programs...${END_COLOR}"
	flatpak install "${FLATPAK_PACKAGES[@]}" -y
}

install_apt() {
	echo -e "${BOLD_GREEN}Installing required programs...${END_COLOR}"
	sudo apt install "${APT_PACKAGES[@]}" -y
}

remove_programs() {
	echo -e "${BOLD_GREEN}Removing programs...${END_COLOR}"
	apt list --installed | grep libreoffice | cut -d "/" -f 1 | tr '\n' ' ' | xargs sudo apt remove -y
	sudo apt remove "${PACKAGES_TO_REMOVE[@]}" -y
	clean
}

install_nix() {
	echo -e "${BOLD_GREEN}Installing Nix package manager...${END_COLOR}"
	sh <(curl -L https://nixos.org/nix/install) --daemon
	export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
}

home_manager_setup() {
	export NIXPKGS_ALLOW_UNFREE=1

	"$NIX_BIN/nix-channel" --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	"$NIX_BIN/nix-channel" --update
	"$NIX_BIN/nix-shell" '<home-manager>' -A install

	export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"

	[[ -d "$HOME/.config/home-manager" ]] && rm -r "$HOME/.config/home-manager/"
	[[ -f "$HOME/.profile" ]] && rm "$HOME/.profile"

	mkdir "$HOME/.config/home-manager"
	ln -s "$CWD/nix/home.nix" "$HOME/.config/home-manager/home.nix"
	"$HM_BIN/home-manager" switch
}

python_setup() {
	echo -e "${BOLD_GREEN}Setting up asdf...${END_COLOR}"
	source "$HOME/.nix-profile/share/asdf-vm/asdf.sh"
	asdf plugin add python
	asdf install python 3.11.3
	asdf global python 3.11.3
	python -m pip install --upgrade pip

	echo -e "${BOLD_GREEN}Setting up poetry...${END_COLOR}"
	python -m poetry config virtualenvs.in-project true

	echo -e "${BOLD_GREEN}Setting up python debugger...${END_COLOR}"
	mkdir "$HOME/.virtualenvs"
	cd "$HOME/.virtualenvs" || exit
	python -m venv debugpy
	"$HOME/.virtualenvs/debugpy/bin/python" -m pip install --upgrade pip
	"$HOME/.virtualenvs/debugpy/bin/python" -m pip install debugpy
	cd "$CWD" || exit
}

fingerprint_setup() {
	echo -e "${BOLD_GREEN}Setting up fingerprint...${END_COLOR}"
	sudo add-apt-repository "$FPRINT_PPA" -y
	update
	sudo apt install "${FINGERPRINT_PACKAGES[@]}" -y
	clean
	echo -e "${BOLD_GREEN}Run 'fprintd-enroll' to config your fingerprint${END_COLOR}"
}

install_deb() {
	echo -e "${BOLD_GREEN}Installing deb packages...${END_COLOR}"

	for program in "${DEB_PACKAGES[@]}"; do
		key="${program%%:*}"   # deletes after ":"
		value="${program##*:}" # deletes before ":"

		wget -O "/tmp/${key}.deb" "https://${value}"
		sudo gdebi "/tmp/${key}.deb"
	done
}

tailscale_repo() {
	echo -e "${BOLD_GREEN}Adding Tailscale repository...${END_COLOR}"
	sudo curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
	sudo curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list >/dev/null
	update
}

install_gnome_extensions() {
	echo -e "${BOLD_GREEN}Installing gnome extensions...${END_COLOR}"

	for extension in "${GNOME_EXTENSIONS[@]}"; do
		"$HM_BIN/gext" install "${extension}"
	done
}

install_docker() {
	sudo install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	echo "deb [arch=$ARCHITECTURE signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
	update
	sudo apt install "${DOCKER_PACKAGES[@]}" -y
}

update
remove_locks
remove_programs
tailscale_repo
install_apt
install_nix
install_deb
home_manager_setup
python_setup
install_gnome_extensions

read -rp "Configure fingerprint? [y/n] " fingerprint
[[ $fingerprint == "y" ]] && fingerprint_setup

echo -e "${BOLD_GREEN}Done!${END_COLOR}"
echo -e "${BOLD_GREEN}pCloud download link: <https://www.pcloud.com/pt/how-to-install-pcloud-drive-linux.html?download=electron-64>${END_COLOR}"
