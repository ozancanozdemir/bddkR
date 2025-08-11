# bddkR <img width=150px height = 150px src="https://github.com/user-attachments/assets/2fae4c12-3db9-4ddb-86bf-375b6fc265c9" />

**Türkçe tercih edenler için:**
***Those who prefer English can scroll down the page.***

## Açıklama

`bddkR`, Türkiye'deki bankacılık sektörünün finansal verilerine kolay erişim sağlayan özel olarak geliştirilmiş bir R paketidir. Bu paket, Python'da popüler olan `bddkdata` kütüphanesinin R ekosistemine uyarlanmış versiyonudur. BDDK'nın (Bankacılık Düzenleme ve Denetleme Kurumu) resmi web sitesinden yayınlanan aylık finansal raporları, bankacılık istatistikleri ve sektörel göstergeleri otomatik olarak çeker ve analiz için hazır hale getirir. Araştırmacılar, finans uzmanları ve veri analistleri için tasarlanan bu araç, bankacılık verilerini hızla tibble formatında sunar.

## Özellikler

* BDDK'nın aylık olarak güncellediği 17 farklı finansal tablo türüne tek komutla erişim
* Mevduat bankaları, katılım bankaları, kamu-özel banka ayrımı gibi 10 farklı banka kategorisi
* TL ve USD para birimi seçenekleri ile esnek veri çekme
* Türkçe ve İngilizce arayüz desteği ile uluslararası kullanım
* R'ın moderne data.frame yapısı olan tibble formatında sonuç
* Excel eksportlama özelliği ile raporlama kolaylığı
* Namespace güvenliği için `::` operatörü kullanımı
* SSL ve güvenlik ayarları otomatik olarak yapılandırılmış

## Kurulum

R ortamınızda paketi kullanmaya başlamak için:

1. R yazılımını indirin ve kurun: https://www.r-project.org/
2. Bağımlı paketleri sisteminize ekleyin:

```r
