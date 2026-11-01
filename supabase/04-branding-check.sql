-- Shows which branding fields are still empty for Peak PV.
-- The engine reads these in Generate Content Image and the two Creatomate nodes.
select brand_id, company_name,
       case when brand_primary_color = '' then 'MISSING' else brand_primary_color end as primary_color,
       case when brand_secondary_color = '' then 'MISSING' else brand_secondary_color end as secondary_color,
       case when logo_url = '' then 'MISSING (add a direct https link to the PNG logo)' else 'set' end as logo,
       case when whatsapp_url = '' then 'MISSING' else whatsapp_url end as whatsapp,
       case when facebook_page_id = '' then 'MISSING' else 'set' end as facebook_page,
       case when instagram_user_id = '' then 'MISSING' else 'set' end as instagram,
       case when linkedin_organization_id = '' then 'MISSING' else 'set' end as linkedin,
       case when telegram_channel_id = '' then 'MISSING' else telegram_channel_id end as telegram_channel
from brands order by brand_id;

-- Fill in when ready, then turn publishing on:
-- update brands set
--   whatsapp_url = 'https://wa.me/9627XXXXXXXX',
--   contact_phone = '07XXXXXXXX',
--   logo_url = 'https://khater89.github.io/peakpv/logo.png',
--   facebook_page_id = '...', instagram_user_id = '...',
--   linkedin_organization_id = '...', telegram_channel_id = '@peakpv_jo', telegram_url = 'https://t.me/peakpv_jo',
--   publish_facebook = true, publish_instagram = true, publish_linkedin = true, publish_telegram = true
-- where brand_id = 'peakpv';
