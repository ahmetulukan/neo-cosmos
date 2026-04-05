# OpenClaw / sonraki geliştirici için el kitabı

Bu dosya **Neo Cosmos** (`neo_cosmos`) projesinde yapılan hata giderme ve yapılandırma düzeltmelerini, **resmi görsel üretim spesifikasyonunu**, **sekme arka planı dosyalarını** ve **bilinen tuzakları** özetler. Amaç: temiz clone sonrası **build kırmadan** devam etmek.

---

## OpenClaw ile eşzamanlı çalışma (ekip ↔ ajan)

1. **Teslim bildirimi:** OpenClaw bir sprinti bitirdiğinde bu repoda **mutlaka** şunları güncellesin veya yeni bir `docs/OPENCLAW_STATUS.md` (veya bu dosyanın sonuna tarihli bölüm) eklesin:
   - Ne yaptı (madde madde)
   - Ne kaldı / bilinen sorunlar
   - Sonraki önerilen adımlar
   - `flutter analyze` / `flutter test` çalıştırdı mı (evet/hayır)

2. **Ekip ritmi:** İnsan geliştiriciler projeye **birkaç günde bir** bakacak; önce **OpenClaw’ın bıraktığı notları** okuyacak.

3. **İnsan push’u sonrası:** Ekip `main`’e yeni commit attığında OpenClaw **önce `git pull` / güncel `main`** ile devam etmeli; çakışma varsa çözüm önerisi veya birleştirme notu yazmalı. Eski dal üzerinden körü körüne devam etmemeli.

4. **Build kırılmaması:** Yeni asset → `pubspec.yaml` listesi; yeni native bağımlılık → `pod install` notu; model değişimi → `build_runner` komutu handoff’ta belirtilsin.

---

## 1. Yapılan hata gidermeleri (özet)

### Dart / Flutter analiz

- **Freezed / json_serializable**: `*.freezed.dart` ve `*.g.dart` üretimi için `dart run build_runner build --delete-conflicting-outputs` kullanıldı. Bu dosyalar repoda **tutuluyor** (`.gitignore`’dan çıkarıldı) böylece `build_runner` olmadan da analiz/test çalışır.
- **`lib/firebase_options.dart`**: Projede yoktu; `DefaultFirebaseOptions` ile **placeholder** eklendi. Üretim için `flutterfire configure` veya Firebase Console değerleriyle güncellenmeli.
- **`lib/core/theme/app_theme.dart`**: `CardTheme` → `CardThemeData`; `ColorScheme.dark` içindeki kullanım dışı `background` kaldırıldı; `withOpacity` → `withValues(alpha: …)` (uyarı giderimi).
- **`test/widget_test.dart`**: Varsayılan `MyApp` / sayaç testi kaldırıldı; `ProviderScope` + `BaseScreen` duman testi yazıldı.

### `pubspec.yaml`

- **`flutter_lints`** eklendi (`analysis_options.yaml` include çözülsün diye).
- **`json_annotation: ^4.9.0`** (json_serializable uyarısı).
- **Assets**: Alt klasörler ayrı listelenir; Flutter’da bir klasör yolu yalnızca **o klasörün doğrudan çocuklarını** paketler; alt klasörler için ayrı satır gerekir.
- Tam ekran görseller (`1.1.png` … `3.png`) ve `assets/images/ui/` manifeste tek tek eklendi.

### iOS (CocoaPods / Xcode)

- Eksik **`ios/`** iskeleti: `flutter create . --platforms=ios` ile `Podfile`, `Runner.xcodeproj` vb. yenilendi.
- **BoringSSL-GRPC / Xcode 16 — `unsupported option '-G'`**: `Podfile` `post_install` içinde `BoringSSL-GRPC` kaynaklarından `-GCC_WARN_INHIBIT_ALL_WARNINGS` / `-G` temizlendi; `platform :ios, '13.0'` ve pod `IPHONEOS_DEPLOYMENT_TARGET` 13.
- **firebase_auth — non-modular header**: `use_frameworks! :linkage => :static` + tüm podlarda ve Runner’da `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES = YES`.
- **AdMob çöküşü**: `Info.plist` içine Google’ın **test** `GADApplicationIdentifier` eklendi (`ca-app-pub-3940256099942544~1458002511`). Yayında kendi AdMob App ID ile değiştir.
- **Firebase plist uyarısı**: `ios/Runner/GoogleService-Info.plist` placeholder olarak projeye ve **Copy Bundle Resources**’a eklendi. Gerçek projede Firebase Console’dan indirilen dosya ile değiştir.

### `.gitignore` (bu repoya özel dikkat)

- `lib/**/*.g.dart` ve `lib/**/*.freezed.dart` **artık ignore edilmiyor** (clone sonrası derlenebilirlik).
- `firebase_options.dart` ve `GoogleService-Info.plist` **commitlenebilir** (placeholder). Gerçek gizli anahtarları public repoya koyma; prod için environment / CI secret kullan.

---

## 2. Görsel üretim — Nano Banana 2 (resmi prompt listesi)

Aşağıdaki yollar ve promptlar **tasarım kaynağıdır**; dosya adları rastgele değil, bu spesifikasyona göre kullanılmalıdır. Kodda `AssetPaths` bu yolları referans alır.

### 2.1 Kaynak ikonları (512×512, şeffaf arka plan)

| Dosya | Prompt |
|--------|--------|
| `assets/images/resources/titanium.png` | Futuristic titanium ore icon, metallic blue and silver, glowing edges, game asset style, 512x512, transparent background |
| `assets/images/resources/quantum_fuel.png` | Quantum fuel canister icon, purple and green energy glow, sci-fi style, transparent background, 512x512 |
| `assets/images/resources/credit.png` | Premium currency credit icon, golden coin with circuit pattern, holographic effect, 512x512, transparent background |

**Not:** `health.png` ve `energy.png` aynı klasörde UI için kullanılıyor; üretim promptları bu listede yoksa OpenClaw tutarlı stilde tamamlayabilir.

### 2.2 Bina ikonları (256×256)

| Dosya | Prompt |
|--------|--------|
| `assets/images/buildings/mine.png` | Sci-fi mining building icon, industrial design, drills and conveyors, blue metallic, top-down view, 256x256 |
| `assets/images/buildings/refinery.png` | Futuristic refinery icon, pipes and tanks, purple energy glow, industrial sci-fi, 256x256 |
| `assets/images/buildings/command_center.png` | Space command center icon, antenna and radar dishes, military sci-fi, blue and white, 256x256 |

**Not:** `research_lab.png`, `shipyard.png` bu tabloda yok; aynı görsel dilde üretilip eklenebilir.

### 2.3 Gezegen (1024×1024)

| Dosya | Prompt |
|--------|--------|
| `assets/images/planets/alpha.png` | Alien planet with blue oceans and green continents, sci-fi style, from space view, detailed atmosphere, 1024x1024 |

**Not:** `beta.png`, `gamma.png`, `sectors/*` aynı estetikle genişletilebilir.

### 2.4 Tam ekran sekme arka planları (`assets/images/` kökü)

Bu dosyalar (`1.1.png` … `1.3.png`, `2.1.png` … `2.3.png`, `3.png`) **yukarıdaki Nano Banana 2 listesinde ayrı prompt satırı olarak tanımlanmadı**; isimler **üretim / sıra / sekme eşlemesi** için kullanılıyor. Kodda `AssetPaths.heroHubPrimary` vb. bu yolları işaret eder.

| Dosya | `AssetPaths` | Kodda kullanım |
|--------|----------------|-----------------|
| `1.1.png` | `heroHubPrimary` | Üs sekmesi tam ekran arka plan |
| `1.2.png` | `heroHubVariantA` | İsteğe bağlı ek üs görseli |
| `1.3.png` | `heroHubVariantB` | İsteğe bağlı ek üs görseli |
| `2.1.png` | `heroInventory` | Envanter sekmesi |
| `2.2.png` | `heroExploration` | Keşif sekmesi |
| `2.3.png` | `heroCombat` | Savaş sekmesi |
| `3.png` | `heroMeta` | Ayarlar / meta ekran |

İstenirse dosyalar **anlamlı ada** (ör. `hub_background.png`) yeniden adlandırılabilir; o zaman `pubspec.yaml` ve `AssetPaths` birlikte güncellenmelidir.

### 2.5 `assets/images/ui/`

Küçük UI parçaları (`button_normal.png`, `button_pressed.png`, `icon_menu.png`, `icon_back.png`). Prompt listesi bu dört dosya için ayrıca tanımlanmadıysa OpenClaw oyun stiline uygun kısa promptlar yazabilir.

**Kritik:** Yeni PNG eklerken `pubspec.yaml` → `flutter: assets:` güncellenmeli.

---

## 3. UI ve oynanış (mevcut sürüm)

- **Material 3**; kartlarda cam benzeri panel, tam ekran arka plan (`ScenicBackground`).
- **AppBar**: “Nasıl oynanır?” → Türkçe kısa rehber.
- **Yükselt** / **Hızlandır**: demo davranış + SnackBar (sunucu kuyruğu yok).
- Alt sekmeler çalışır; Envanter / Keşif / Savaş / Ayarlar taslak + ilgili hero görseli.

---

## 4. Yerel komut kontrol listesi

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # model değişirse
flutter analyze
flutter test
cd ios && pod install && cd ..
```

---

## 5. GitHub

Kanonical depo: **[https://github.com/ahmetulukan/neo-cosmos](https://github.com/ahmetulukan/neo-cosmos)**

```bash
git clone https://github.com/ahmetulukan/neo-cosmos.git
cd neo-cosmos
flutter pub get
cd ios && pod install && cd ..
```

---

*Son güncelleme: Neo Cosmos markası, resmi asset promptları ve OpenClaw eşzamanlılık notları.*
