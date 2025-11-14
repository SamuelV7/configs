import shutil


def copyDir(src: str, dest: str):
    shutil.copytree(src, dest, dirs_exist_ok=True)
    print(f"Copied directory {src} to {dest}")


nix_os = {
    "local": "./nixos/",
    "system": "/etc/nixos/"
}


def main():
    print("1. Copy local copy of nixOS configs to system")
    print("2. Copy system copy of nixOS configs to local")

    user_input = input("$ ")

    if int(user_input) == 1:
        copyDir(nix_os["local"], nix_os["system"])
    elif int(user_input) == 2:
        copyDir(nix_os["system"], nix_os["local"])


main()
