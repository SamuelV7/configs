import shutil
from pathlib import Path


def copyDir(src: str, dest: str):
    shutil.copytree(src, dest, dirs_exist_ok=True)
    print(f"Copied directory {src} to {dest}")


def configDir():
    return str(Path("~/.config/").expanduser())


print("Path Expanded User ", str(Path("~/.tmux.conf").expanduser()))

dirs_list = {
    "neovim": {
        "local": "./nvim/",
        "system": configDir() + "/nvim/"
    },
    "tmux": {
        "local": "./tmux/.tmux.conf",
        "system": str(Path("~/.tmux.conf").expanduser())
    },
    "starship": {
        "local": "./starship/starship.toml",
        "system": configDir() + "/starship.toml"
    },
    "wezTerm": {
        "local": "./wezterm/.wezterm.lua",
        "system": str(Path("~/.wezterm.lua").expanduser())
    },
}


def makePaths(dirs: dict[str, dict[str, str]], src: str, dest: str) -> list[str, str]:
    return [{"src": v[src], "dest": v[dest]} for k, v in dirs.items()]


def fileOrDirCp(src_dest: dict[str, str]):
    print("src Dest, Cp Fn", src_dest)
    if Path(src_dest["src"]).is_dir():
        copyDir(src_dest["src"], src_dest["dest"])
        print(f"copying Dir {src_dest['src']} to {src_dest['dest']}", src_dest)
    elif Path(src_dest["src"]).is_file():
        Path(src_dest["dest"]).parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(src_dest["src"], src_dest["dest"])


def Copy(src: str, dest: str, paths: list[dict[str, str]]):
    paths_dict = makePaths(dirs_list, src, dest)
    for item in paths_dict:
        print(f"Item {item}")
        fileOrDirCp(item)


# copy from local to system
def CopySystemToLocal():
    # get paths
    Copy("system", "local", dirs_list)


# copy from system to local
def CopyLocaltoSystem():
    Copy("local", "system", dirs_list)


# ask user if they want to merge local to system or vice vers
def getUserInput():
    print("Press 1 or 2 from below:")
    print("1. Copy local copy to system")
    print("2. Copy system copy to local")
    userInput = input("$ ")

    if int(userInput) == 1:
        CopyLocaltoSystem()
    elif int(userInput) == 2:
        CopySystemToLocal()
    else:
        print("Please enter either 1 or 2")


getUserInput()
