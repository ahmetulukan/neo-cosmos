# 🦞 TEAM SYNC - Neo Cosmos Geliştirme Takımı

**Proje:** Neo Cosmos (Space Strategy Game)  
**GitHub:** https://github.com/ahmetulukan/neo-cosmos  
**Drive Roadmap:** https://docs.google.com/document/d/1YuQBhFziKfiaIzRKfIikeZ2ziROYivK9oMVrBXYCfOA/edit  
**MVP Hedef:** 25 Nisan 2026

---

## 📋 ÇALIŞMA PROTOKOLÜ

### **GÜNLÜK RUTİN**
1. **Sabah 08:00:** `git pull origin main` (Ahmet'in değişikliklerini çek)
2. **08:00-18:00:** Kod geliştirme (Drive roadmap'ine göre)
3. **Her 2 Saatte:** Geliştirme raporu (Telegram)
4. **Akşam 18:00:** `git push origin main` (günlük değişiklikleri push et)

### **İŞBÖLÜMÜ**
- **Dinko (OpenClaw):** Flutter kod geliştirme, Firebase entegrasyonu, AI prompt mühendisliği
- **Ahmet:** Firebase kurulumu, görsel üretimi, GitHub repo yönetimi, geliştirme desteği

### **DRIVE DOKÜMANTASYONU**
- Tüm roadmap'ler, raporlar, prompt'lar Drive'da olacak
- MD dosyaları sadece local notlar için

---

## 📅 SPRINT DURUMU (15 Günlük Plan)

### **GÜN 1 (5 Nisan): ✅ TAMAMLANDI**
- Flutter SDK kurulumu
- Proje yapısı ve temel UI
- GitHub repo oluşturuldu

### **GÜN 2 (6 Nisan): 🔄 DEVAM EDİYOR**
- **Hedef:** OGame tarzı Dashboard ve Navigasyon
- **Tamamlanan:** BaseScreen, ResourceDisplay, BuildingCard, NavigationBar
- **Devam Eden:** Firebase Auth, Kaynak yönetimi sistemi
- **İlerleme:** %80

### **GÜN 3 (7 Nisan): PLANLANDI**
- Firebase veri modelleri
- Çevrimdışı destek sistemi
- Sync mekanizması

---

## 🎯 AKTİF GÖREVLER

### **DİNKO'NUN ŞU AN ÇALIŞTIĞI:**
1. **Firebase Auth entegrasyonu** (devam ediyor)
2. **Kaynak yönetimi sistemi** (başlayacak)
3. **Hive local cache optimizasyonu**

### **AHMET'TEN BEKLENENLER:**

#### **ACİL (Bugün İçin):**
1. **Firebase Config Dosyaları:**
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
   - **Not:** Firebase Console'dan indirilecek

2. **Görsel Asset'ler (Drive'daki Prompt Listesinden):**
   - `assets/images/resources/titanium.png`
     - **Prompt:** "Futuristic titanium ore icon, metallic blue and silver, glowing edges, game asset style, 512x512, transparent background"
   
   - `assets/images/resources/quantum_fuel.png`
     - **Prompt:** "Quantum fuel canister icon, purple and green energy glow, sci-fi style, transparent background, 512x512"
   
   - `assets/images/resources/credit.png`
     - **Prompt:** "Premium currency credit icon, golden coin with circuit pattern, holographic effect, 512x512, transparent background"

#### **ORTA VADELİ:**
3. **Gemini 3 Flash API Key:**
   - Google AI Studio'dan alınacak
   - `.env` dosyasına eklenebilir

4. **AdMob Hesabı (Opsiyonel):**
   - Monetizasyon için hazırlık

---

## 🔄 GİTHUB SENKRONİZASYON DURUMU

### **SON COMMIT'LER:**
1. **`961fbdc`** - "feat: Gün 2 - Firebase Auth entegrasyonu başlatıldı"
   - AuthService oluşturuldu
   - Hive local cache entegre edildi
   - Riverpod provider'lar eklendi

2. **`c92467a`** - "docs: update OpenClaw status with Day 1 summary"
   - Gün 1 raporu güncellendi

### **BRANCH DURUMU:**
- **Current:** `main`
- **Last Pull:** Bugün 08:00'de yapılacak
- **Next Push:** Bugün 18:00'de yapılacak

### **DEĞİŞİKLİK KONTROLÜ:**
```bash
# Ahmet değişiklik yaptıysa:
git status
git diff
git pull origin main

# Dinko değişiklik yaptıysa:
git add .
git commit -m "feat: [açıklama]"
git push origin main
```

---

## 🎨 GÖRSEL İHTİYAÇ LİSTESİ

### **ACİL (Gün 2 İçin):**
| Dosya | Boyut | Prompt | Durum |
|-------|-------|--------|-------|
| `titanium.png` | 512x512 | Futuristic titanium ore icon... | ⏳ Bekleniyor |
| `quantum_fuel.png` | 512x512 | Quantum fuel canister icon... | ⏳ Bekleniyor |
| `credit.png` | 512x512 | Premium currency credit icon... | ⏳ Bekleniyor |

### **YAKIN VADELİ (Gün 3-4):**
| Dosya | Boyut | Açıklama |
|-------|-------|----------|
| `mine.png` | 256x256 | Maden ocağı ikonu |
| `refinery.png` | 256x256 | Rafineri ikonu |
| `command_center.png` | 256x256 | Komuta merkezi ikonu |
| `alpha.png` | 1024x1024 | Alpha gezegeni |

---

## 🚨 TEKNİK ENGELER

### **ACİL ÇÖZÜM BEKLENEN:**
1. **Firebase Config:** `google-services.json` dosyası olmadan Firebase çalışmıyor
2. **Home Assistant:** Token geçersiz, yeni token gerekiyor

### **ÇÖZÜLMÜŞ SORUNLAR:**
1. ✅ **OpenClaw Versiyon:** 2026.4.5'e güncellendi
2. ✅ **Cron Jobs:** Telegram outbound sorunu çözüldü
3. ✅ **Drive Roadmap:** Artık Drive'daki dokümanlar baz alınıyor

---

## 📞 İLETİŞİM KANALLARI

### **ACİL DURUMLAR:**
- **Telegram:** Doğrudan mesaj
- **GitHub Issues:** Teknik sorunlar için
- **Drive Comments:** Dokümantasyon feedback'i için

### **GÜNLÜK RAPORLAR:**
- **08:00:** Sabah rutini (Günaydın + plan)
- **Her 2 Saatte:** Geliştirme raporu
- **18:00:** Gün sonu raporu + GitHub push
- **22:00:** Akşam kapanış (Notion + Blog + Home Assistant)

### **HAFTALIK DEĞERLENDİRME:**
- **Pazar 22:00:** Haftalık planlama
- **Drive'da:** Haftalık rapor dokümanı

---

## 🎯 SONRAKİ ADIMLAR

### **BUGÜN (6 Nisan) İÇİN:**
1. Firebase Auth tamamlama (config dosyaları geldikten sonra)
2. Kaynak yönetimi sistemi kurulumu
3. Hive cache optimizasyonu
4. Akşam 18:00'de GitHub push

### **YARIN (7 Nisan) İÇİN:**
1. Firebase veri modelleri tamamlama
2. Çevrimdışı destek sistemi
3. Sync mekanizması implementasyonu

---

## 📊 METRİKLER

### **SPRINT İLERLEME:**
- **Gün 1:** ✅ %100
- **Gün 2:** 🔄 %80
- **Toplam:** %15.3

### **KOD KALİTESİ:**
- **Analiz:** `flutter analyze` (henüz çalıştırılmadı)
- **Test:** `flutter test` (henüz çalıştırılmadı)
- **Build:** `flutter build linux` (çalışıyor)

### **DOKÜMANTASYON:**
- **Drive:** ✅ Aktif kullanımda
- **GitHub README:** ✅ Güncel
- **Team Sync:** ✅ Bu dosya

---

**Son Güncelleme:** 6 Nisan 2026, 14:10  
**Güncelleyen:** Dinko (OpenClaw)  
**Sonraki Kontrol:** 16:00 (2 saat sonra)

🦞 **KOD GELİŞTİRMEYE DEVAM EDİYORUM!**