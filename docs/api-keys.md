# API Keys

Some features — like pulling live stock data — need API keys from data providers. Here's how to set them up safely.

## The .env Pattern

API keys go in a file called `.env` in your project folder. Claude can read this file, but it will never share it or commit it to version control.

### Setting Up Keys

1. In your project folder, copy the example file:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and fill in your keys:
   ```
   ALPHA_VANTAGE_API_KEY=your_key_here
   POLYGON_API_KEY=your_key_here
   ```

3. Tell Claude about it:
   > "I've set up my API keys in .env. Use my Alpha Vantage key to pull NVDA price data."

### Why Two Files?

- **`.env`** — your actual keys. Never shared, never committed to git.
- **`.env.example`** — a template showing which keys are needed, but with blank values. Safe to share.

If you move to a new computer, `.env.example` reminds you which keys you need to set up again.

## Free Data Sources

These services have free tiers that are plenty for personal research:

### Alpha Vantage
- **What:** Stock prices, fundamentals, earnings, technical indicators
- **Free tier:** 25 requests/day
- **Get a key:** https://www.alphavantage.co/support/#api-key
- **Good for:** Daily price checks, quarterly fundamental data

### Finnhub
- **What:** Real-time quotes, company news, SEC filings, earnings
- **Free tier:** 60 requests/minute
- **Get a key:** https://finnhub.io/register
- **Good for:** News aggregation, earnings calendars, basic quotes

### Polygon.io
- **What:** Historical prices, options data, market-wide data
- **Free tier:** 5 API calls/minute, delayed data
- **Get a key:** https://polygon.io/dashboard/signup
- **Good for:** Historical analysis, charting data

### FRED (Federal Reserve Economic Data)
- **What:** Economic indicators (GDP, CPI, unemployment, rates)
- **Free tier:** 120 requests/minute
- **Get a key:** https://fred.stlouisfed.org/docs/api/api_key.html
- **Good for:** Macro research, economic context for equity analysis

## Using Keys with Claude

Once your `.env` is set up, Claude can use the keys automatically. Just ask for what you want:

- "Pull the last 2 years of daily NVDA prices from Alpha Vantage"
- "Get the latest FOMC rate decision from FRED"
- "What's the earnings calendar for my watchlist this month?"

Claude will read the key from `.env` and make the API calls.

## Security Rules

1. **Never paste API keys directly into the chat.** Put them in `.env`.
2. **Never commit `.env` to git.** The `.gitignore` is already set up to prevent this.
3. **Free tiers have rate limits.** If Claude is making lots of API calls, it might hit the limit. It'll tell you if that happens.
4. **Rotate keys if exposed.** If you accidentally share a key, go to the provider's dashboard and generate a new one.
