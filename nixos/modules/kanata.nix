{ pkgs, ... }:

{
  boot.kernelModules = [ "uinput" ];
  hardware.uinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.groups.uinput = { };

  environment.systemPackages = with pkgs; [
    kanata
  ];

  # This applies once a services.kanata keyboard named "internalKeyboard" is configured.
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards.internalKeyboard = {
      devices = [
        "/dev/input/by-id/usb-SINO_WEALTH_RK_Bluetooth_Keyboar-event-kbd"
      ];

      config = ''
        (defsrc
          caps)

        (deflayermap (base)
          ;; Tap Caps Lock as Escape, hold it as Left Control.
          caps (tap-hold 200 200 esc lctl))
      '';
    };
  };
}
