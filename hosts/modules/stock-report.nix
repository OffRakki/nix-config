{pkgs, ...}: let
  benchmark = "AUVP11.SA";
  tickers = [
    "PETR4.SA"
    "VALE3.SA"
    "ITUB4.SA"
    "BBDC4.SA"
    "B3SA3.SA"
    "BBAS3.SA"
    "ABEV3.SA"
    "WEGE3.SA"
    "ELET3.SA"
    "RENT3.SA"
    "SUZB3.SA"
    "CMIG4.SA"
    "JBSS3.SA"
    "NTCO3.SA"
    "LREN3.SA"
    "RADL3.SA"
    "GGBR4.SA"
    "CSNA3.SA"
    "USIM5.SA"
    "TIMS3.SA"
    "VIVT3.SA"
    "TOTS3.SA"
    "BPAC11.SA"
    "EQTL3.SA"
    "SBSP3.SA"
    "HAPV3.SA"
    "PRIO3.SA"
    "EMBR3.SA"
    "MGLU3.SA"
    "AZUL4.SA"
    "MRFG3.SA"
    "BEEF3.SA"
    "VBBR3.SA"
    "UGPA3.SA"
    "CCRO3.SA"
    "ENGI11.SA"
    "CPLE6.SA"
    "RRRP3.SA"
    "RAIZ4.SA"
    "BRFS3.SA"
    "PCAR3.SA"
    "ASAI3.SA"
    "KLBN11.SA"
    "SOMA3.SA"
    "FLRY3.SA"
    "RDOR3.SA"
    "RECV3.SA"
    "SANB11.SA"
    "KNRI11.SA"
    "MXRF11.SA"
    "HGLG11.SA"
    "XPLG11.SA"
    "BTLG11.SA"
    "HGRE11.SA"
    "BCFF11.SA"
    "KNCR11.SA"
    "VISC11.SA"
    "XPML11.SA"
  ];
  allTickers = [benchmark] ++ tickers;
  tickersPy = builtins.replaceStrings [","] [", "] (builtins.toJSON allTickers);

  pythonEnv = pkgs.python3.withPackages (ps: [ps.yfinance]);

  stockReport = pkgs.writers.writeBashBin "stock-report" ''
        export PATH="${pythonEnv}/bin:$PATH"
        exec ${pythonEnv}/bin/python3 << 'PYEOF'
    import os, sys
    from datetime import date
    from collections import defaultdict

    import yfinance as yf

    TICKERS = ${tickersPy}
    BENCHMARK = ${builtins.toJSON benchmark}
    OUTPUT_DIR = "/home/rakki/Documents/Stocks"

    def get_sectors(tickers):
        sectors = {}
        for t in tickers:
            try:
                info = yf.Ticker(t, timeout=10).info
                s = info.get("sector") or info.get("industry") or "N/A"
                sectors[t] = s
            except Exception:
                sectors[t] = "N/A"
        return sectors

    def fmt(v):
        if v is None:
            return "N/A"
        return "{:+.2f}%".format(v)

    def main():
        os.makedirs(OUTPUT_DIR, exist_ok=True)

        data = yf.download(TICKERS, period="5d", interval="1d", auto_adjust=True, progress=False)
        if data.empty:
            with open("{}/erro.txt".format(OUTPUT_DIR), "w") as f:
                f.write("Sem dados disponiveis\n")
            return

        close = data["Close"].dropna(how="all")
        if len(close) < 2:
            return

        yesterday_close = close.iloc[-2]
        today_close = close.iloc[-1]
        changes = ((today_close - yesterday_close) / yesterday_close * 100).dropna()

        wtd = None
        if len(close) >= 5:
            week_start_close = close.iloc[-5]
            wtd = ((today_close - week_start_close) / week_start_close * 100).dropna()

        volume = data.get("Volume")
        vol_change = None
        if volume is not None:
            vol = volume.dropna(how="all")
            if len(vol) >= 2:
                today_vol = vol.iloc[-1]
                yesterday_vol = vol.iloc[-2]
                vc = ((today_vol - yesterday_vol) / yesterday_vol * 100)
                vol_change = vc.replace([float("inf"), -float("inf")], float("nan")).dropna()

        sectors = get_sectors(TICKERS)

        dt = date.today()

        total = len(changes)
        gainers_count = int((changes > 0).sum())
        losers_count = int((changes < 0).sum())
        flat_count = total - gainers_count - losers_count
        avg_change = changes.mean()
        median_change = changes.median()
        std_change = changes.std()

        bench_change = changes.get(BENCHMARK)

        wtd_bench = None
        if wtd is not None and BENCHMARK in wtd.index:
            wtd_bench = wtd[BENCHMARK]

        md = []
        md.append("# Relatorio de Mercado")
        md.append("")
        md.append("**{}** — {} ativos analisados, {} do benchmark {}.\n".format(
            dt.strftime("%d/%m/%Y"), total,
            fmt(bench_change) if bench_change is not None else "N/A",
            BENCHMARK
        ))

        md.append("## Visao Geral\n")
        md.append("| Indicador | Valor |")
        md.append("| --- | --- |")
        md.append("| Ativos analisados | {} |".format(total))
        md.append("| Altas / Baixas / Estaveis | {} / {} / {} |".format(gainers_count, losers_count, flat_count))
        md.append("| Variacao media | {} |".format(fmt(avg_change)))
        md.append("| Mediana | {} |".format(fmt(median_change)))
        md.append("| Desvio padrao | {:.2f}% |".format(std_change))
        if bench_change is not None:
            md.append("| Benchmark {} | {} |".format(BENCHMARK, fmt(bench_change)))
        if wtd_bench is not None:
            md.append("| Benchmark (WTD) | {} |".format(fmt(wtd_bench)))
        md.append("")

        if bench_change is not None:
            bench_dir = "positivo" if bench_change > 0 else "negativo"
            breadth = gainers_count - losers_count
            if breadth > 10:
                breadth_desc = "Ampla maioria dos ativos fechou em alta"
            elif breadth > 3:
                breadth_desc = "Maioria dos ativos fechou em alta"
            elif breadth < -10:
                breadth_desc = "Ampla maioria dos ativos fechou em baixa"
            elif breadth < -3:
                breadth_desc = "Maioria dos ativos fechou em baixa"
            else:
                breadth_desc = "Mercado dividido entre altas e baixas"

            vol_note = ""
            if vol_change is not None:
                vm = vol_change.mean()
                if abs(vm) > 30:
                    vol_note = " Volume significativamente acima da media."
                elif vm > 15:
                    vol_note = " Volume acima da media, indicando maior participacao."
                elif vm < -15:
                    vol_note = " Volume abaixo da media, indicando baixa participacao."

            narrative = "{} com o benchmark em territorio {} ({:.2f}%).{}".format(
                breadth_desc, bench_dir, bench_change, vol_note
            )
            if abs(avg_change) > 1.5:
                narrative += " Movimento acentuado no mercado (variacao media de {:.2f}%).".format(avg_change)
            if std_change > 2.5:
                narrative += " Dispersao elevada entre os ativos — sinal de indecisao ou rotacao setorial."
            elif std_change < 1:
                narrative += " Baixa dispersao — movimento uniforme entre os ativos."
            md.append("> {}".format(narrative))
            md.append("")

        sector_perf = defaultdict(list)
        for ticker in changes.index:
            s = sectors.get(str(ticker), "N/A")
            sector_perf[s].append(changes[ticker])

        sector_avgs = {}
        for sector, perfs in sector_perf.items():
            avg = sum(perfs) / len(perfs)
            sector_avgs[sector] = (avg, len(perfs))

        best_sector = max(sector_avgs, key=lambda k: sector_avgs[k][0]) if sector_avgs else None
        worst_sector = min(sector_avgs, key=lambda k: sector_avgs[k][0]) if sector_avgs else None

        md.append("## Desempenho por Setor\n")
        md.append("| Setor | Variacao Media | Ativos |")
        md.append("| --- | --- | --- |")
        for sector in sorted(sector_avgs, key=lambda k: sector_avgs[k][0], reverse=True):
            avg, cnt = sector_avgs[sector]
            md.append("| {} | {} | {} |".format(sector, fmt(avg), cnt))
        md.append("")
        if best_sector and worst_sector and best_sector != worst_sector:
            md.append("> Destaque positivo: **{}** ({}). Destaque negativo: **{}** ({}).".format(
                best_sector, fmt(sector_avgs[best_sector][0]),
                worst_sector, fmt(sector_avgs[worst_sector][0])
            ))
            md.append("")

        sorted_ch = changes.reindex(changes.abs().sort_values(ascending=False).index)
        gainers = sorted_ch[sorted_ch > 0]
        losers = sorted_ch[sorted_ch < 0]

        md.append("## Principais Altas\n")
        md.append("| # | Ativo | Variacao | Setor | Semana |")
        md.append("| --- | --- | --- | --- | --- |")
        for i, (t, v) in enumerate(gainers.head(10).items(), 1):
            ts = str(t).replace(".SA", "")
            sec = sectors.get(str(t), "")
            w = fmt(wtd[t]) if wtd is not None and t in wtd.index else "-"
            md.append("| {} | {} | {} | {} | {} |".format(i, ts, fmt(v), sec, w))
        md.append("")

        md.append("## Principais Baixas\n")
        md.append("| # | Ativo | Variacao | Setor | Semana |")
        md.append("| --- | --- | --- | --- | --- |")
        for i, (t, v) in enumerate(losers.head(10).items(), 1):
            ts = str(t).replace(".SA", "")
            sec = sectors.get(str(t), "")
            w = fmt(wtd[t]) if wtd is not None and t in wtd.index else "-"
            md.append("| {} | {} | {} | {} | {} |".format(i, ts, fmt(v), sec, w))
        md.append("")

        if vol_change is not None and len(vol_change) > 0:
            avg_vol_pct = vol_change.mean()
            vol_up = int((vol_change > 0).sum())
            vol_down = int((vol_change < 0).sum())

            md.append("## Analise de Volume\n")
            md.append("Variacao media de volume: **{:+.2f}%** ({} acima, {} abaixo da media).\n".format(avg_vol_pct, vol_up, vol_down))

            top_vol = vol_change.sort_values(ascending=False).head(5)
            md.append("### Maiores Altas de Volume\n")
            md.append("| Ativo | Volume | Preco | Setor |")
            md.append("| --- | --- | --- | --- |")
            for t, v in top_vol.items():
                ts = str(t).replace(".SA", "")
                ch = changes.get(t)
                ch_str = fmt(ch) if ch is not None else "-"
                sec = sectors.get(str(t), "")
                md.append("| {} | {:+.2f}% | {} | {} |".format(ts, v, ch_str, sec))
            md.append("")

            bottom_vol = vol_change.sort_values().head(5)
            md.append("### Maiores Baixas de Volume\n")
            md.append("| Ativo | Volume | Preco | Setor |")
            md.append("| --- | --- | --- | --- |")
            for t, v in bottom_vol.items():
                ts = str(t).replace(".SA", "")
                ch = changes.get(t)
                ch_str = fmt(ch) if ch is not None else "-"
                sec = sectors.get(str(t), "")
                md.append("| {} | {:+.2f}% | {} | {} |".format(ts, v, ch_str, sec))
            md.append("")

        md.append("## Tabela Completa\n")
        md.append("| # | Ativo | Diario | Semana | Volume | Setor |")
        md.append("| --- | --- | --- | --- | --- | --- |")
        for i, (t, v) in enumerate(sorted_ch.items(), 1):
            ts = str(t).replace(".SA", "")
            w = "{:+.2f}%".format(wtd[t]) if wtd is not None and t in wtd.index else "-"
            vl = "{:+.2f}%".format(vol_change[t]) if vol_change is not None and t in vol_change.index else "-"
            sec = sectors.get(str(t), "")
            md.append("| {} | {} | {} | {} | {} | {} |".format(i, ts, fmt(v), w, vl, sec))
        md.append("")

        md.append("## Resumo\n")
        md.append("| Indicador | Valor |")
        md.append("| --- | --- |")
        md.append("| Data | {} |".format(dt.strftime("%d/%m/%Y")))
        if bench_change is not None:
            md.append("| Benchmark {} | {} |".format(BENCHMARK, fmt(bench_change)))
        md.append("| Altas | {} ({:.1f}%) |".format(gainers_count, gainers_count / total * 100))
        md.append("| Baixas | {} ({:.1f}%) |".format(losers_count, losers_count / total * 100))
        md.append("| Estaveis | {} |".format(flat_count))
        md.append("| Media | {} |".format(fmt(avg_change)))
        md.append("| Mediana | {} |".format(fmt(median_change)))
        md.append("")
        md.append("---")
        md.append("*Gerado automaticamente pelo sistema NixOS.*")

        path = "{}/{}.md".format(OUTPUT_DIR, dt.isoformat())
        with open(path, "w", encoding="utf-8") as f:
            f.write("\n".join(md) + "\n")

    main()
    PYEOF
  '';
in {
  systemd.services.stock-report = {
    enable = true;
    description = "Daily Brazilian Stock Report";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "rakki";
      ExecStart = "${stockReport}/bin/stock-report";
    };
  };

  systemd.timers.stock-report = {
    enable = true;
    description = "Daily timer for stock report at 9AM";
    timerConfig = {
      OnCalendar = "*-*-* 09:00:00";
      Persistent = true;
    };
    wantedBy = ["timers.target"];
  };
}
