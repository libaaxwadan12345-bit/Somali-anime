SOMALI ANIME — bilowga app-ka

Faylasha:
- index.html / style.css / app.js: muuqaalka bilowga ah ee web app-ka.
- manifest.json / sw.js: aasaaska PWA.
- backend.sql: jadwalada database-ka iyo policies-ka Supabase.

MUHIIM:
1. Kani waa starter, ma aha app production oo dhamaystiran.
2. Supabase Project URL iyo Publishable key keligood kuma filna; frontend-kan weli wuxuu u baahan yahay in Supabase Auth, database queries, iyo Storage uploads si buuxda loogu xiro.
3. Ha gelin browser-ka Secret/service_role key.
4. Supabase Free wuxuu leeyahay xad kaydin iyo bandwidth; ma jiro cloud storage aan xad lahayn.
5. Soo geli oo keliya anime/video aad leedahay ama aad fasax sharci ah u haysato.

Tallaabooyinka:
- Fur backend.sql gudaha Supabase SQL Editor oo orod hal mar.
- Admin role: marka user-ku ku jiro auth.users/profiles, ku beddel EMAILKAAGA:
  update public.profiles set role='admin' where email='EMAILKAAGA';
- Hosting HTTPS ayaa loo baahan yahay si PWA install-ku u shaqeeyo.
