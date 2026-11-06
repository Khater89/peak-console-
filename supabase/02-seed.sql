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

-- Nov 2026 (v1.1): two more Peak PV services - EV charging points and off-grid solar.
insert into brand_content_options (option_id,brand_id,content_type,category,option_label,option_value,active,sort_order,notes) values
('pv-ev-points','peakpv','service','ev','EV Charging Points','EV Charging Points',true,8,'Buildings, hotels, farms, company parking'),
('pv-offgrid','peakpv','service','solar','Off-Grid Solar','Off-Grid Solar',true,9,'No grid or weak grid')
on conflict (option_id) do nothing;
insert into service_details (brand_id,service_value,summary,scenarios,differentiators,keywords,avoid) values
('peakpv','EV Charging Points','Supply and installation of EV charging points (wall chargers, single-phase or three-phase) for residential building garages, hotels, farms and company parking, with the supply cable, breaker and protection sized and checked. Can be combined with a solar system.','Residential building where residents bought electric cars and need charging in the garage; hotel or company that wants charging for guests or staff cars; farm or villa with several cars.','Site visit and load check before installation; proper cable, breaker and protection; installation through a licensed partner company.','نقاط شحن, شاحن سيارة كهربائية, شحن بالعمارة, كراج, مواقف, سيارة كهربائية','Charging-time promises, prices, brand claims, commercial shops.'),
('peakpv','Off-Grid Solar','Fully independent solar system with lithium batteries for sites with no grid or a weak grid, sized on the real daily loads.','Farm or rest house far from the grid; well pump or poultry house with frequent outages; home that wants to run without the grid.','Load study first; battery and inverter sized for night use and cloudy days; installation through a licensed partner company.','أوف جريد, نظام مستقل, بطاريات, بدون كهربا, مزرعة','Backup-duration promises, prices, zero-bill claims.')
on conflict do nothing;
