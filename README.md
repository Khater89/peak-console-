# Peak PV Console

Marketing console for **Peak PV** (Jordanian solar & EV chargers), based on Madama Console.
Plain HTML/CSS/JS — no build step.

```
index.html  style.css  app.js   ->  GitHub Pages  (the console)
supabase/                       ->  Supabase project fbkrrzlwmygzdoozrlgg (already set up)
n8n/peakpv-marketing-engine-v1.0.json  ->  n8n (the engine)
```

## 1. Console — GitHub Pages
Upload `index.html`, `style.css`, `app.js` to the root of a **new** repo (for example `peakpv-console`).
The connection is already in the `DEFAULTS` block of `app.js` (Supabase URL + publishable key + function slugs).
Only `hook` is empty: paste your n8n production webhook URL ending in `/webhook/peakpv-engine-run`
(or set it from the console's **Connection** tab).

Settings are stored under `peakpv.cfg`, so they never mix with the Madama console on the same github.io domain.

## 2. Data — Supabase (done)
Tables, permissions, the Peak PV brand, 7 services with approved facts and Jordanian occasions are already in the project.
The SQL files here are the record: `01-schema.sql`, `02-seed.sql`, `03-grants.sql`, `04-branding-check.sql`.

Still to fill on `brands` (row `peakpv`): `whatsapp_url`, `contact_phone`, `logo_url`, `facebook_page_id`,
`instagram_user_id`, `linkedin_organization_id`, `telegram_channel_id`, `telegram_url`, then the `publish_*` flags.
`04-branding-check.sql` shows what is missing.

### Edge Functions (deployed, Verify JWT off)
| slug | secrets to set in Supabase → Edge Functions → Secrets |
|---|---|
| `notify-telegram` | `TELEGRAM_BOT_TOKEN`, `TELEGRAM_CHAT_ID` (private review chat) |
| `rewrite-copy` | `OPENAI_API_KEY` |

## 3. Engine — n8n
Create the credentials listed in the workflow's **SETUP** note (exact names), import
`n8n/peakpv-marketing-engine-v1.0.json`, set the Drive folder, and **activate** it.

## Publishing
Facebook + Instagram (Meta page token), LinkedIn (own token, company page), and the Telegram channel
(mirrors each Facebook post). Nothing publishes until you approve it and the `publish_*` flag is true.

## Security note
Like the Madama console, the browser uses the publishable key with `anon` policies: anyone with the link can
create orders. Keep the link private, or add Supabase Auth and switch the policies to `authenticated`.
