# Peak PV Console

Marketing console for **Peak PV** (Jordanian solar & EV chargers), based on Madama Console.
Plain HTML/CSS/JS — no build step.

```
index.html  style.css  app.js   ->  GitHub Pages  (the console)
supabase/                       ->  Supabase project fbkrrzlwmygzdoozrlgg (already set up)
n8n/peakpv-marketing-engine-v1.1.json  ->  n8n (the engine)
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
`n8n/peakpv-marketing-engine-v1.1.json`, set the Drive folder, and **activate** it.

### Before activating the engine (checklist)
1. **Credentials** — none are attached yet, which is why nodes show errors. Create them in n8n with the exact names in the
   workflow's *SETUP* note (Peak PV Supabase, OpenAI, Google Drive, Meta Token, LinkedIn Token, Telegram; Creatomate and
   Gemini are only for video, which v1.1 keeps off), then open each red node and pick the credential.
2. **Placeholders** — in *Runtime Configuration* replace `YOUR_PEAKPV_DRIVE_FOLDER_ID` and `YOUR_TELEGRAM_CHAT_ID`, and pick
   the same Drive folder on the four *Upload … to Google Drive* nodes.
3. **Schedules** — *Audit Decisions* and *Queue Processor* (every 5 minutes) are enabled: the first moves approved audits to
   the publishing queue (the console webhook does not reach it), the second publishes posts when their scheduled time comes.
   *Plan Intake* and *Job Intake* are inherited from Madama and stay disabled.
4. **Telegram previews** — the preview nodes are disabled while `telegram_preview_enabled` is `true`; enable them (except the
   video one) once the Telegram credential and chat ID are set, or set the flag to `false`.

## v1.1 (Nov 2026) — images + Arabic only
Every post is one image + Arabic text (copy, CTA, hashtags and the band on the image). Video is off in the console and in the engine
(n8n node *Force Image Only*). Services now include **EV Charging Points** and **Off-Grid Solar**. All platforms are on by default.

## Publishing
Facebook + Instagram (Meta page token), LinkedIn (own token, company page), and the Telegram channel
(mirrors each Facebook post). Nothing publishes until you approve it and the `publish_*` flag is true.

## Security note
Like the Madama console, the browser uses the publishable key with `anon` policies: anyone with the link can
create orders. Keep the link private, or add Supabase Auth and switch the policies to `authenticated`.
