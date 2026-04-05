# OpenClaw / sonraki geliştirici için el kitabı

Bu dosya **neo_cosmos (Galaktik Sınır)** projesinde yapılan hata giderme ve yapılandırma düzeltmelerini, **asset eşlemesini** ve **bilinen tuzakları** özetler. Amaç: temiz clone sonrası **build kırmadan** devam etmek.

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
- **Assets**: Alt klasörler ayrı listelenir; Flutter’da `assets/images/` yalnızca **doğrudan** o klasördeki dosyaları alır, alt klasörleri otomatik eklemez.
- Gemini görselleri ve UI dilimleri için `assets/images/ui/` ve kökteki `1.1.png` … `3.png` dosyaları tek tek manifeste eklendi.

### iOS (CocoaPods / Xcode)

- Eksik **`ios/`** iskeleti: `flutter create . --platforms=ios` ile `Podfile`, `Runner.xcodeproj` vb. yenilendi.
- **BoringSSL-GRPC / Xcode 16 — `unsupported option '-G'`**: `Podfile` `post_install` içinde `BoringSSL-GRPC` kaynaklarından `-GCC_WARN_INHIBIT_ALL_WARNINGS` / `-G` temizlendi; `platform :ios, '13.0'` ve pod `IPHONEOS_DEPLOYMENT_TARGET` 13.
- **firebase_auth — non-modular header**: `use_frameworks! :linkage => :static` + tüm podlarda ve Runner’da `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES = YES`.
- **AdMob çöküşü**: `Info.plist` içine Google’ın **test** `GADApplicationIdentifier` eklendi (`ca-app-pub-3940256099942544~1458002511`). Yayında kendi AdMob App ID ile değiştir.
- **Firebase plist uyarısı**: `ios/Runner/GoogleService-Info.plist` placeholder olarak projeye ve **Copy Bundle Resources**’a eklendi. Gerçek projede Firebase Console’dan indirilen dosya ile değiştir.

### `.gitignore` (bu repoya özel dikkat)

- `lib/**/*.g.dart` ve `lib/**/*.freezed.dart` **artık ignore edilmiyor** (clone sonrası derlenebilirlik).
- `firebase_options.dart` ve `GoogleService-Info.plist` **commitlenebilir** (placeholder). Gerçek gizli anahtarları asla public repoya koyma; prod için environment / CI secret kullan.

---

## 2. Gemini görselleri — dosya adları ve kodda kullanım

Dosyalar **`assets/images/`** altında (kullanıcı sıralamasına göre gruplandı).

| Dosya | `AssetPaths` sabiti | Önerilen kullanım (şu anki kod) |
|--------|---------------------|----------------------------------|
| `1.1.png` | `heroHubPrimary` | **Üs** sekmesi tam ekran arka plan (`BaseScreen` tab 0). |
| `1.2.png` | `heroHubVariantA` | İsteğe bağlı: üs içi ikinci panel, carousel veya header şeridi (henüz bağlanmadı — OpenClaw ekleyebilir). |
| `1.3.png` | `heroHubVariantB` | İsteğe bağlı: bina grid üstü banner / modül arka planı. |
| `2.1.png` | `heroInventory` | **Envanter** sekmesi arka plan + önizleme kartında görsel. |
| `2.2.png` | `heroExploration` | **Keşif** sekmesi. |
| `2.3.png` | `heroCombat` | **Savaş** sekmesi. |
| `3.png` | `heroMeta` | **Ayarlar** (veya global “meta” ekran: splash, kredi, hakkında). |

### `assets/images/ui/`

| Dosya | Sabit | Önerilen kullanım |
|--------|--------|-------------------|
| `button_normal.png` | `uiButtonNormal` | Özel düğme `DecorationImage` / `Ink.image`. |
| `button_pressed.png` | `uiButtonPressed` | `GestureDetector` + state ile basılı görünüm. |
| `icon_menu.png` | `uiIconMenu` | Drawer / menü FAB. |
| `icon_back.png` | `uiIconBack` | Geri ok (iç ekranlar). |

**Kritik:** Yeni PNG eklerken mutlaka `pubspec.yaml` → `flutter: assets:` listesine **dosya veya klasör** ekle. Aksi halde runtime’da “Unable to load asset” ve testler kırılır.

**Performans:** `1.x` / `2.x` dosyaları çok büyükse (ör. 8 MB) release öncesi sıkıştırma veya çözünürlük düşürme önerilir; Git için isteğe bağlı [Git LFS](https://git-lfs.com).

---

## 3. UI ve oynanış (mevcut sürüm)

- **Material 3** açıldı; kartlarda cam benzeri panel (`_GlassCard`), tam ekran **scenic** arka plan (`ScenicBackground`).
- **AppBar**: “Nasıl oynanır?” → `showGameplayGuide` ile Türkçe kısa rehber.
- **Yükselt** düğmeleri: `GameConstants.buildingCosts` ile **kaynak kontrolü**; yetersizse SnackBar; yeterliyse kaynak düşer + demo SnackBar (sunucu / kuyruk yok).
- **Hızlandır**: SnackBar ile “yakında” mesajı.
- Alt navigasyon sekmeleri **çalışıyor**; Envanter / Keşif / Savaş / Ayarlar içerikleri taslak + ilgili hero görseli.

OpenClaw’ın bir sonraki adımları için öneri: Firestore `UserModel` / `BaseModel` bağlama, gerçek yükseltme zamanlayıcısı, `google_mobile_ads` yalnızca `MobileAds.instance.initialize()` hazır olduğunda, keşif için `google_generative_ai` API anahtarı güvenli saklama.

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

## 5. GitHub’a push

Bu proje için oluşturulan uzak depo (örnek): **https://github.com/ahmetulukan/galaktik-sinir**  
(`neo-cosmos` adı hesapta zaten kullanıldığı için `galaktik-sinir` seçildi.)

Yeni clone sonrası:

```bash
git clone https://github.com/ahmetulukan/galaktik-sinir.git
cd galaktik-sinir
flutter pub get
cd ios && pod install && cd ..
```

---

*Son güncelleme: proje içi düzeltmeler ve OpenClaw devretme notları bu dosyada toplanmıştır.*
