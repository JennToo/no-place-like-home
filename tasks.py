import os
import subprocess

from invoke import task

APT_PACKAGES = """
neovim
python-pip
python3-pip
build-essential
ruby
ruby-dev
keepass2
curl
apt-transport-https
"""

PIP3_PACKAGES = """
flake8
pylint
invoke
neovim
black
virtualenv
"""

RUBY_PACKAGES = """
neovim
"""

CARGO_PACKAGES = [("rg", "ripgrep")]


@task
def install_apt_packages(c):
    c.sudo("add-apt-repository -y -n ppa:neovim-ppa/stable")
    c.sudo("apt-get update")
    c.sudo("apt-get install -y {}".format(format_list(APT_PACKAGES)))


@task(install_apt_packages)
def install_pip3_packages(c):
    c.run("python3 -m pip install --upgrade {}".format(format_list(PIP3_PACKAGES)))


@task(install_apt_packages)
def install_rust(c):
    if exists("~/.cargo/bin/cargo"):
        return
    c.run("curl https://sh.rustup.rs -sSf | sh -s -- -y")
    c.run("rustup component add clippy rls rust-src")


@task(install_rust)
def install_cargo_packages(c):
    for (bin, pkg) in CARGO_PACKAGES:
        if not exists("~/.cargo/bin/{}".format(bin)):
            c.run("cargo install {}".format(pkg))


@task(install_apt_packages)
def install_ruby_packages(c):
    c.run("gem install --user {}".format(format_list(RUBY_PACKAGES)))


@task(install_apt_packages, install_pip3_packages, install_rust, install_ruby_packages)
def setup_nvim(c):
    # This uses subprocess specifically because nvim needs to borrow the TTY
    # that the command was run with. c.run loses the TTY
    subprocess.check_call(
        ". ~/.profile && nvim +PlugInstall +PlugUpdate +qa", shell=True
    )


@task(install_apt_packages)
def install_docker(c):
    c.run(
        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
    )
    c.sudo(
        'add-apt-repository "deb [arch=amd64] '
        'https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
    )
    c.sudo("apt-get install -y docker-ce")
    c.sudo("adduser $(id -un) docker")


@task(
    install_apt_packages,
    install_pip3_packages,
    install_cargo_packages,
    setup_nvim,
    install_docker,
)
def setup(c):
    pass


def format_list(l):
    return " ".join(l.split())


def exists(p):
    return os.path.exists(os.path.expanduser(p))
