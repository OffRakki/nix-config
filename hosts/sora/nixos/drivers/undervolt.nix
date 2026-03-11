{pkgs, ...}: {
  environment.systemPackages = [pkgs.lact];

  systemd = {
    services = {
      lactd = {
        description = "GPU Undervolt";
        enable = true;
        wantedBy = ["multi-user.target"];
      };
      ### Will stick to BIOS for CPU \\ -30
    };
    packages = [
      pkgs.lact
    ];
  };

  environment.etc."lact/config.yaml" = {
    text = ''
      version: 5
      daemon:
        log_level: info
        admin_group: wheel
        disable_clocks_cleanup: false
      apply_settings_timer: 5
      gpus:
        10DE:2F04-1462:5323-0000:07:00.0:
          fan_control_enabled: true
          fan_control_settings:
            mode: curve
            static_speed: 0.5
            temperature_key: edge
            interval_ms: 500
            curve:
              40: 0.30
              50: 0.35
              60: 0.45
              70: 0.60
              80: 0.80
              85: 1.00
            spindown_delay_ms: 5000
            change_threshold: 2
          power_cap: 210.0
          min_core_clock: 210
          max_core_clock: 2900
          gpu_clock_offsets:
            0: 150
            5: 0
            3: 0
            8: 0
            2: 0
          mem_clock_offsets:
            0: 2000
            2: 0
            5: 0
            8: 0
            3: 0
      current_profile: null
      auto_switch_profiles: false
    '';
  };
}
