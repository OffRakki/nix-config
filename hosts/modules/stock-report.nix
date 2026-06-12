{ pkgs, ... }:

let
  benchmark = "AUVP11.SA";
  tickers = [
    "PETR4.SA" "VALE3.SA" "ITUB4.SA" "BBDC4.SA" "B3SA3.SA" "BBAS3.SA"
    "ABEV3.SA" "WEGE3.SA" "ELET3.SA" "RENT3.SA" "SUZB3.SA" "CMIG4.SA"
    "JBSS3.SA" "NTCO3.SA" "LREN3.SA" "RADL3.SA" "GGBR4.SA" "CSNA3.SA"
    "USIM5.SA" "TIMS3.SA" "VIVT3.SA" "TOTS3.SA" "BPAC11.SA" "EQTL3.SA"
    "SBSP3.SA" "HAPV3.SA" "PRIO3.SA" "EMBR3.SA" "MGLU3.SA" "AZUL4.SA"
    "MRFG3.SA" "BEEF3.SA" "VBBR3.SA" "UGPA3.SA" "CCRO3.SA" "ENGI11.SA"
    "CPLE6.SA" "RRRP3.SA" "RAIZ4.SA" "BRFS3.SA" "PCAR3.SA" "ASAI3.SA"
    "KLBN11.SA" "SOMA3.SA" "FLRY3.SA" "RDOR3.SA" "RECV3.SA" "SANB11.SA"
    "KNRI11.SA" "MXRF11.SA" "HGLG11.SA" "XPLG11.SA" "BTLG11.SA"
    "HGRE11.SA" "BCFF11.SA" "KNCR11.SA" "VISC11.SA" "XPML11.SA"
  ];
  allTickers = [ benchmark ] ++ tickers;

  stockReport = pkgs.writers.writePython3Bin "stock-report" {
    libraries = [ pkgs.python3Packages.yfinance ];
  } ''
    import os
    import sys
    from datetime import date

    import yfinance as yf

    TICKERS = ${builtins.toJSON allTickers}
    BENCHMARK = ${builtins.toJSON benchmark}
    OUTPUT_DIR = "/home/rakki/Documents/Stocks"

    def main():
        os.makedirs(OUTPUT_DIR, exist_ok=True)

        try:
            data = yf.download(TICKERS, period="5d", interval="1d", auto_adjust=True)
        except Exception:
            return

        if data.empty:
            return

        close = data["Close"].dropna(how="all")
        if len(close) < 2:
            return

        yesterday = close.iloc[-2]
        today = close.iloc[-1]
        changes = ((today - yesterday) / yesterday * 100).dropna()

        dt = date.today()
        lines = [
            "===== Resumo do Mercado - {} =====".format(dt.strftime("%d/%m/%Y")),
            "",
        ]

        bench = changes.get(BENCHMARK)
        if bench is not None:
            lines.append("Benchmark {}: {:+.2f}%".format(BENCHMARK, bench))
            lines.append("")

        sorted_ch = changes.reindex(changes.abs().sort_values(ascending=False).index)
        gainers = sorted_ch[sorted_ch > 0]
        losers = sorted_ch[sorted_ch < 0]

        lines.append("Top 5 altas:")
        for t, v in gainers.head(5).items():
            lines.append("  {}: +{:.2f}%".format(t.replace(".SA", ""), v))

        lines.append("")
        lines.append("Top 5 baixas:")
        for t, v in losers.head(5).items():
            lines.append("  {}: {:.2f}%".format(t.replace(".SA", ""), v))

        lines.append("")
        up = int((changes > 0).sum())
        down = int((changes < 0).sum())
        flat = len(changes) - up - down
        lines.append("Resumo: {} altas, {} baixas, {} estaveis".format(up, down, flat))

        path = "{}/{}.txt".format(OUTPUT_DIR, dt.isoformat())
        with open(path, "w", encoding="utf-8") as f:
            f.write("\n".join(lines) + "\n")

    if __name__ == "__main__":
        main()
  '';
in {
  systemd.services.stock-report = {
    enable = true;
    description = "Daily Brazilian Stock Report";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "rakki";
    };
    script = "${stockReport}/bin/stock-report";
  };

  systemd.timers.stock-report = {
    enable = true;
    description = "Daily timer for stock report at 9AM";
    timerConfig = {
      OnCalendar = "*-*-* 09:00:00";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
