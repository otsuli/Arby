# Options Chain Analytics — Roadmap

## Phase 1: Data Collection
Fetch and persist a full options chain for a given ticker + expiration.

- [x] Fetch chain via YFinance.jl (`get_Options`)
- [ ] Parse into structured data: strikes, contract symbols, call/put type
- [ ] Store in PostgreSQL (`underlyings`, `option_contracts`, `option_quotes` tables)
- [ ] Capture per-contract fields:
  - Strike price
  - Call and put prices (bid/ask/last)
  - Volume and open interest
  - Implied volatility (as reported by data source)
- [ ] Snapshot with timestamp on each fetch (build historical archive over time, since Yahoo only exposes live data)

## Phase 2: Financial Math — Pricing & Greeks
Calculate theoretical values independently of the data provider.

- [ ] Implement Black-Scholes pricing model
- [ ] Implement implied volatility solver (Newton-Raphson) — invert Black-Scholes from market price
- [ ] Calculate Greeks from scratch:
  - Delta
  - Gamma
  - Theta
  - Vega
- [ ] Compare calculated IV/Greeks against provider-reported values; log discrepancies

## Phase 3: Visualization
- [ ] Plot volatility smile/skew (IV vs strike, per expiration)
- [ ] Compare implied vol across multiple expirations (partial vol surface)

## Phase 4: Arbitrage Detection
Flag theoretical mispricings in the chain (educational/detection tool, not a trading system).

- [ ] **Put-call parity** — check `Call − Put ≈ Stock − Strike × e^(−rT)`, flag violations beyond realistic bid-ask/transaction-cost tolerance
- [ ] **Bounds violations**:
  - Call price ≥ max(0, Stock − Strike)
  - Call price ≤ Stock price
  - Monotonicity across strikes (deeper ITM > further OTM)
  - Calendar consistency (longer-dated ≥ shorter-dated, same strike)
- [ ] **Vertical/spread arbitrage** — check convexity of price vs strike across adjacent strikes
- [ ] **Box spread arbitrage** — synthetic risk-free payoff check across two strikes (call spread + put spread)

## Phase 5: Automation & History
- [ ] Schedule periodic fetches (daily/hourly) to build a real historical dataset
- [ ] Track IV and arbitrage-flag history per contract over time
- [ ] Compare realized volatility (from historical stock prices) vs. historical implied volatility

## Stretch Goals
- [ ] Multi-ticker support / watchlist
- [ ] Full volatility surface (all expirations at once)
- [ ] Migrate to TimescaleDB once historical data volume grows
- [ ] Alerting (e.g., notify when an arbitrage flag or IV anomaly is detected)