-- ============================================================================
--  Peak PV - seed data: the brand, its services, occasions and approved facts.
--  The AI may only use the facts in service_details; each row has a Must-avoid line.
-- ============================================================================
insert into public.brands (brand_id, active, company_name, brand_context, target_audience, tone_of_voice, default_cta, timezone, content_language, brand_primary_color, brand_secondary_color, image_branding_instructions, publish_facebook, publish_instagram, publish_linkedin, publish_telegram, created_at, updated_at)
values ('peakpv', true, 'Peak PV',
'Peak PV is a small Jordanian company that designs on-grid, hybrid (with batteries) and off-grid solar systems and supplies home EV chargers. Every system is sized from the customer''s last 12 electricity bills. Installation is carried out through a licensed partner installation company. The customer gets a free bill study by sending a photo of the electricity bill on WhatsApp. Under Jordan''s net-value mechanism, homes, farms, small and medium industry and hotels can connect a system up to 100% of their last-12-months consumption, and the energy produced is credited on the same electricity bill. Peak PV does not serve commercial shops.',
'Jordanian homeowners with high electricity bills (non-subsidized tariff or above 600 kWh a month), poultry/livestock farms, greenhouses, wells and irrigation pumps, small workshops, bakeries and small factories, hotels and serviced apartments, and electric-car owners.',
'Warm, direct, honest and simple; sounds like a trusted local engineer, not a big corporation. No hype.',
'ابعتلنا صورة فاتورة الكهرباء على واتساب ونعملك دراسة مجانية',
'Asia/Amman','Arabic (simple Jordanian dialect)','#0E1B36','#F7A51E',
'Clean, sunny, trustworthy look. Navy #0E1B36 and solar-orange #F7A51E accents in clothing or details. Authentic Jordanian buildings, flat concrete rooftops with water tanks, farms and villas. Do not invent or redraw any logo; leave clean negative space in one corner for the official Peak PV logo.',
false,false,false,false, now()::text, now()::text)
on conflict (brand_id) do nothing;
-- (brand_content_options and service_details rows: see the live project; exported below)
