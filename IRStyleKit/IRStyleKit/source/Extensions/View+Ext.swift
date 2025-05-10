//
//  View+Ext.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

//import SwiftUI
//
//public extension View {
//    /// Captures the view as a `UIImage` via `ImageRenderer` (iOS 16+).
//    @MainActor
//    func snapshot(scale: CGFloat? = nil) -> UIImage? {
//        SnapshotManager.captureImage(self, scale: scale)
//    }
//}

/*

### SwiftUI Snapshot Kullanım Alanları (Gerçek Dünya Senaryoları)

1. **Paylaşılabilir İçerikler (Sertifika, Rozet, Kart)**

   * Kullanıcıların tamamladıkları görevleri, başarı rozetlerini veya kartları görsel olarak paylaşmasını sağlar.
   * Örnek: Nike Run Club, antrenman özetlerini SwiftUI görünümünden snapshot alarak paylaşır.

2. **Fiş, Fatura, PDF Oluşturma**

   * SwiftUI ile oluşturulan fatura, bilet, fiş gibi içerikleri görsel ya da PDF formatında dışa aktarır.
   * Özellikle e-posta ile gönderim veya yazdırma için idealdir.

3. **Performans Optimizasyonu**

   * Karmaşık ve nadiren güncellenen görünümler (örneğin grafikler, haritalar) bir kez render edilir, sonra snapshot görüntüsü kullanılır.
   * Görsel olarak aynıyken CPU/GPU yükü azaltılır.

4. **Bulanık Arka Planlar / Overlay Efektleri**

   * Modal veya popup arkasında özel bulanıklık efekti için mevcut görünümden snapshot alınır, sonra bu görsel blur uygulanarak arka plan yapılır.
   * `CoreImage` ile özel blur efektleri üretilebilir.

5. **Animasyonlar ve Geçişler**

   * Snapshot kullanılarak ağır render maliyeti olan görünümler yerine görsellerle geçiş animasyonları yapılır.
   * `matchedGeometryEffect`, `drag and drop` gibi durumlarda görünüm yerine görüntü taşınabilir.

6. **Görsel Dışa Aktarım ve Düzenleme**

   * SwiftUI ile oluşturulan çizimler, meme’ler, harita anotasyonları gibi özel içerikler görsel olarak dışa aktarılabilir.
   * Kullanıcı tarafından oluşturulan veya statik içeriklerin kaydedilmesi/başka bir yere gönderilmesi için kullanılır.

7. **Test ve Görsel QA (Kalite Güvencesi)**

   * Snapshot testleri ile görünüm çıktıları referans görsellerle karşılaştırılır.
   * QA mühendisleri veya tasarımcılar uygulama içindeki belirli görünümleri hızlıca görüntüleyip değerlendirmek için snapshot alabilir.

8. **Gerçek Uygulama Örnekleri**

   * Strava, Nike gibi uygulamalar paylaşılabilir içerikler için snapshot kullanır.
   * DoorDash gibi firmalar snapshot testleriyle UI değişikliklerini izler.
   * Swift Charts gibi grafikler içeren uygulamalarda rapor veya sosyal medya paylaşımı için snapshot alınır.

---

Detaylara inmek istersen her maddeyi örnek kodla açabiliriz. Hangi başlıktan başlayalım?

*/
