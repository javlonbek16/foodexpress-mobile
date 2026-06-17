# FoodExpress — Mobile

> **Texnologiya:** Flutter (Dart)
> **Markaziy hujjatlar:** [foodexpress-docs](https://github.com/javlonbek16/foodexpress-docs)

## 1. Maqsad
Mijoz uchun mobil ilova: login, restoran/menyu ko'rish, buyurtma berish, buyurtma holatini **real-time** kuzatish.

## 2. Talablar
### Funksional
- [ ] Login / register (Auth `:3001`).
- [ ] Restoran va menyu ko'rish (Restaurant `:8001`).
- [ ] Savatcha + buyurtma berish (Order `:8081`).
- [ ] Buyurtma holatini real-time/polling bilan ko'rsatish.
- [ ] "Mening buyurtmalarim".

### Texnik
- [ ] Servislarga to'g'ridan murojaat (Gateway yo'q), JWT `Authorization` header.
- [ ] Secure storage'да token saqlash; avtomatik refresh oqimi (401 → refresh → retry).
- [ ] State management (Provider/Riverpod/Bloc — jamoa tanlaydi).
- [ ] Faqat `CUSTOMER` oqimi.
- [ ] API base URL'lari config/`.env` orqali (lokalда emulator uchun `10.0.2.2`).

## 3. Acceptance criteria
- ✅ Mijoz login qilib, mobil ilovadан buyurtma bera oladi.
- ✅ Buyurtma holati o'zgarishi ilovada yangilanadi.
- ✅ Token muddati tuganда avtomatik refresh ishlaydi.

## 4. Chegaralar
- ❌ API Gateway yo'q. ✅ Faqat lokal (emulator/qurilma).

## 5. O'rganish maqsadi
Flutter UI, REST API integratsiya, secure token storage, refresh oqimi, real-time/polling holat yangilash.
