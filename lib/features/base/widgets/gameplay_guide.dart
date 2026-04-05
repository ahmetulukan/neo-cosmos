import 'package:flutter/material.dart';

void showGameplayGuide(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Nasıl oynanır?'),
      content: SingleChildScrollView(
        child: Text(
          'Galaktik Sınır, üs kurma (kaynak, bina) ve ileride keşif / savaş / envanter '
          'ekranlarından oluşan bir hibrit oyundur.\n\n'
          '• Üs: Titan, Quantum Yakıt ve Kredi üretir veya harcarsın. Binaları yükselterek '
          'üretimi artırırsın.\n\n'
          '• Alt menü: Envanter, Keşif, Savaş ve Ayarlar sekmeleri şu an taslak; '
          'iş mantığı (Firestore, AI hikâye vb.) sonraki sprintlerde bağlanacak.\n\n'
          '• Bu sürüm: Yükselt düğmeleri kaynak kontrolü yapar ve demo mesajı gösterir; '
          'gerçek zamanlayıcı ve sunucu senkronu henüz yok.\n\n'
          'İpucu: Üretim verimliliği ve aktif yükseltmeler ileride canlı veriye bağlanacak.',
          style: Theme.of(ctx).textTheme.bodyMedium,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Tamam'),
        ),
      ],
    ),
  );
}
