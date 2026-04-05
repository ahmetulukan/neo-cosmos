# 🚀 Neo Cosmos - Space Strategy Game

**Neo Cosmos**, OGame mekaniklerinden esinlenen ancak benzersiz özellikler ekleyen bir uzay temalı mobil oyundur. Oyun, kaynak yönetimi, bina geliştirme ve Gemini 3 Flash destekli yapay zeka keşif sistemlerini birleştirir.

Geliştirici el kitabı (düzeltmeler, iOS/Android tuzakları, Gemini asset eşlemesi): [docs/OPENCLAW_HANDOFF.md](docs/OPENCLAW_HANDOFF.md).

## 🎮 Özellikler

- **Uzay Temalı UI:** Karanlık uzay teması, futuristik tasarım
- **Kaynak Yönetimi:** Titanium, Quantum Fuel, Credit
- **Bina Geliştirme:** Maden, Rafineri, Komuta Merkezi
- **AI Keşif Sistemi:** Gemini 3 Flash entegrasyonu
- **Firebase Backend:** Gerçek zamanlı veri senkronizasyonu
- **Çoklu Platform:** Android, iOS, Linux
- **Monetizasyon:** AdMob reklam entegrasyonu

## 🛠️ Teknoloji Stack

- **Flutter 3.41.6** - Çapraz platform geliştirme
- **Riverpod 2.6.1** - State management
- **Hive 2.2.3** - Local database
- **Firebase** - Backend (Auth, Firestore)
- **Google Generative AI** - Gemini 3 Flash entegrasyonu
- **Google Mobile Ads** - AdMob monetizasyon

## 📱 Ekranlar

1. **Ana Ekran:** Kaynak göstergeleri, bina kartları
2. **Bina Yükseltme:** Bina geliştirme ve timer'lar
3. **Keşif Ekranı:** AI destekli keşif sistemi
4. **Savaş Ekranı:** Uzay savaşları ve taktikler
5. **Market:** Kaynak alım-satım

## 🚀 Kurulum

### Gereksinimler
- Flutter SDK 3.41.6+
- Dart 3.11.4+
- Firebase projesi
- Gemini API key

### Adımlar
```bash
# 1. Repository'yi klonla
git clone https://github.com/ahmetulukan/neo-cosmos.git
cd neo-cosmos

# 2. Bağımlılıkları yükle
flutter pub get

# 3. Firebase dosyalarını ekle
# - android/app/google-services.json
# - ios/Runner/GoogleService-Info.plist

# 4. Çalıştır
flutter run
```

## 🔧 Firebase Kurulumu

1. **Firebase Console**'da proje oluştur
2. **Android uygulaması ekle:**
   - Package name: `com.neocosmos.app`
   - App ID: `1:906825850331:android:0f57352fef701493731bfe`
3. **iOS uygulaması ekle:**
   - Bundle ID: `com.neocosmos.app`
   - App ID: `1:906825850331:ios:1bc5f41166e590be731bfe`
4. **google-services.json** ve **GoogleService-Info.plist** dosyalarını indir

## 🎨 Görsel Asset'ler

Görseller `assets/images/` klasöründe:
- `resources/` - Kaynak ikonları
- `buildings/` - Bina ikonları
- `planets/` - Gezegen görselleri
- `sectors/` - Sektör görselleri
- `ui/` - UI elementleri

## 📁 Proje Yapısı

```
lib/
├── main.dart                    # Giriş noktası
├── features/                    # Ekranlar
│   ├── base/                    # Ana ekran
│   ├── building/                # Bina yükseltme
│   ├── exploration/             # Keşif sistemi
│   └── battle/                  # Savaş sistemi
├── core/                        # Çekirdek yapı
│   ├── constants.dart           # Sabitler
│   ├── theme/                   # Tema
│   └── providers/               # Riverpod providers
├── models/                      # Veri modelleri
│   ├── user_model.dart          # Kullanıcı modeli
│   ├── base_model.dart          # Üs modeli
│   └── exploration_model.dart   # Keşif modeli
└── shared_widgets/              # Paylaşılan widget'lar
```

## 🔐 API Key'ler

`.env.local` dosyası oluşturun:
```env
FIREBASE_API_KEY=your_firebase_api_key
GEMINI_API_KEY=your_gemini_api_key
ADMOB_APP_ID=your_admob_app_id
```

## 🎯 MVP Hedefleri

1. ✅ Çalışan üs yönetimi ekranı
2. ⏳ Çalışan kaynak yönetimi sistemi
3. ⏳ Çalışan bina yükseltme mekaniği
4. ⏳ Çalışan yapay zeka keşif sistemi
5. ⏳ Çalışan ödüllü reklam sistemi

**Hedef Tarih:** 25 Nisan 2026

## 🤝 Katkıda Bulunma

1. Fork'la
2. Feature branch oluştur (`git checkout -b feature/amazing-feature`)
3. Değişiklikleri commit et (`git commit -m 'Add amazing feature'`)
4. Branch'i push et (`git push origin feature/amazing-feature`)
5. Pull Request aç

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 📞 İletişim

Ahmet Ulukan - [@ahmetulukan](https://github.com/ahmetulukan)

Proje Linki: [https://github.com/ahmetulukan/neo-cosmos](https://github.com/ahmetulukan/neo-cosmos)