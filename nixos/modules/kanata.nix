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

  # TODO: add your actual Kanata keyboard config here, then it will autostart as a system service.
  # Example shape:
  # services.kanata = {
  #   enable = true;
  #   keyboards.internalKeyboard = {
  #     devices = [ "/dev/input/by-path/YOUR_KEYBOARD_EVENT_DEVICE" ];
  #     config = ''
  #       (defsrc caps)
  #       (deflayer base esc)
  #     '';
  #   };
  # };
}
