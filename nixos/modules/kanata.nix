{config, ...}:
{
  services.kanata = {
    enable = false;
    keyboards = {
      externalKeyboard = {
        devices = [
          "/dev/input/by-path/pci-0000:02:00.0-usbv2-0:8.4:1.0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
              esc  f1  f2  f3  f4  f5  f6  f7  f8  f9  f10  f11  f12 prtsc pause
              grv  1    2    3    4    5    6    7    8    9    0    -    = bspc ins home pgup
              tab       q    w    e    r    t    y    u    i    o    p    [    ]    \ del end pgdn
              caps      a    s    d    f    g    h    j    k    l    ;    '         ent
              lsft      z    x    c    v    b    n    m    ,    .    /              rsft up
              lctl wkup lalt           spc            ralt rmet rctl left down rght
          )

          (deflayer graphite
              _    _   _   _   _   _   _   _   _   _   _    _    _   @hmr @lyt @rst _
              @~   _    _    _    _    _    _    _    _    _    _    _    _         _
              _         b    l    d    w    z    '    f    o    u    j    _    _    _
              _         n    r    t    s    g    y    h    a    e    i    ;         ent
              _         q    x    m    c    v    k    p    _    _    _              _
              _    _    _    _              _              _    _    _ _    _    _
                                                                         _ _    _    _
          )

          (deflayer qwerty
              _    _   _   _   _   _   _   _   _   _   _    _    _   @hmr @lyt @rst _
              @~   _    _    _    _    _    _    _    _    _    _    _    _         _
              _         _    _    _    _    _    _    _    _    _    _    _    _    _
              @md1      _    _    _    _    _    _    _    _    _    _    @md2      ent
              @lsf      _    _    _    _    _    _    _    _    _    _              @rsf
              _    _    _    @md4           _              @md5 _    rmet _    _    up
                                                                          _    _    _
          )
        '';
      };
    };
  };
}
