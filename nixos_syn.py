import subprocess
from pathlib import Path


REPO_ROOT = Path(__file__).parent.resolve()
NIXOS_DIR = REPO_ROOT / "nixos"


def run(cmd: list[str]) -> None:
    print("$", " ".join(cmd))
    subprocess.run(cmd, check=True)


def main() -> None:
    print("Press a number from below:")
    print("1. Rebuild desktop")
    print("2. Rebuild server")
    print("3. Update flake lock")
    print("4. Check flake")

    choice = input("$ ").strip()

    if choice == "1":
        run(["sudo", "nixos-rebuild", "switch", "--flake", f"{NIXOS_DIR}#desktop"])
    elif choice == "2":
        run(["sudo", "nixos-rebuild", "switch", "--flake", f"{NIXOS_DIR}#server"])
    elif choice == "3":
        run(["nix", "flake", "update", "--flake", str(NIXOS_DIR)])
    elif choice == "4":
        run(["nix", "flake", "check", str(NIXOS_DIR)])
    else:
        print("Please enter 1, 2, 3, or 4")


if __name__ == "__main__":
    main()
