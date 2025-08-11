# bddkR <img width=150px height = 150px src="https://github.com/user-attachments/assets/2fae4c12-3db9-4ddb-86bf-375b6fc265c9" align="right" />

**Türkçe tercih edenler için:**

***Those who prefer English can scroll down the page.***

## Paket Hakkında

`bddkR`, Türkiye'deki bankacılık sektörünün finansal verilerine kolay erişim sağlayan özel olarak geliştirilmiş **ilk** R paketidir. Bu paket, Python'da [`bddkdata`](https://pypi.org/project/bddkdata/) kütüphanesinin R ekosistemine uyarlanmış versiyonudur. BDDK'nın (Bankacılık Düzenleme ve Denetleme Kurumu) resmi web sitesinden yayınlanan aylık finansal raporları, bankacılık istatistikleri ve sektörel göstergeleri otomatik olarak çeker ve analiz için hazır hale getirir. Araştırmacılar, finans uzmanları ve veri analistleri için tasarlanan bu araç, bankacılık verilerini hızla tibble formatında sunar.

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

_Yakında CRAN'da_ 

R ortamınızda paketi kullanmaya başlamak için:

1. R yazılımını indirin ve kurun: https://www.r-project.org/
2. Bağımlı paketleri sisteminize ekleyin:

1. R yazılımını indirin ve kurun: https://www.r-project.org/
2. Bağımlı paketleri sisteminize ekleyin:

```
install.packages(c("httr", "jsonlite", "dplyr", "writexl", "lubridate"))
```
3. GitHub deposundan bddkR paketini yükleyin:

```
# devtools kurulu değilse önce yükleyin
install.packages("devtools")
```
# Ana paketi GitHub'dan çekin

```
devtools::install_github("ozancanozdemir/bddkR")
```

# Ana Fonksiyon

```fetch_data``` :  BDDK'nın API sisteminden bankacılık verilerini çeker ve düzenler.

## Parametreler:

+ start_year (sayı): Veri çekmeye başlanacak yıl (örn: 2023)
+ start_month (sayı): Başlangıç ayı (1=Ocak, 12=Aralık)
+ end_year (sayı): Veri çekmenin biteceği yıl
+ end_month (sayı): Bitiş ayı (1-12 arası)
+ table_no (sayı): İstenilen tablo numarası (1-17)
+ currency (metin): Para birimi ("TL" ya da "USD")
+ group (sayı): Banka grubu kodu (10001-30003)
+ lang (metin): Dil seçeneği ("tr"=Türkçe, "en"=İngilizce)
+ save_excel (mantıksal): Excel kaydetme seçeneği (TRUE/FALSE)

## Çıktı:

tibble formatında bankacılık verisi (veri bulunamadığında NULL)

## Erişilebilir Finansal Tablolar:

+ Bilanço Tablosu
+ Gelir-Gider Durumu
+ Kredi Portföyü
+ Bireysel Krediler
+ Sektörel Kredi Dağılımı
+ KOBİ Finansmanı
+ Sendikasyon ve Sekürütizasyon
+ Menkul Kıymet Portföyü
+ Mevduat Yapısı
+ Vade Bazlı Mevduatlar
+ Likidite Göstergeleri
+ Sermaye Yeterliliği
+ Döviz Pozisyonu
+ Bilanço Dışı Kalemler
+ Finansal Oranlar
+ Operasyonel Bilgiler
+ Uluslararası Şube Verileri

## Banka Kategorileri:

+ 10001: Mevduat Bankaları
+ 10002: Kalkınma ve Yatırım Bankaları
+ 10003: Katılım Bankaları
+ 10004: Tüm Bankalar
+ 20001: Devlet Bankaları
+ 20002: Özel Sermayeli Bankalar
+ 20003: Yabancı Sermayeli Bankalar
+ 30001: Büyük Ölçekli Bankalar
+ 30002: Orta Ölçekli Bankalar
+ 30003: Küçük Ölçekli Bankalar

# Kullanım Örnekleri

```
library(bddkR)

# 2024 yılı bilanço verilerini çek
bilanço_verileri <- fetch_data(
  start_year = 2024,
  start_month = 1,
  end_year = 2024,
  end_month = 12,
  table_no = 1,
  currency = "TL",
  group = 10001,
  lang = "tr",
  save_excel = FALSE
)

# Sonuçları incele
head(bilanço_verileri)

# Gelir tablosunu İngilizce olarak çek ve Excel'e kaydet
income_statement <- fetch_data(
  start_year = 2023,
  start_month = 6,
  end_year = 2024,
  end_month = 6,
  table_no = 2,
  currency = "TL",
  group = 10004,
  lang = "en",
  save_excel = TRUE
)

# Çoklu tablo analizi için döngü
sektör_analizi <- list()
for (tablo in c(1, 2, 3, 15)) {  # Bilanço, Gelir, Kredi, Oranlar
  sektör_analizi[[tablo]] <- fetch_data(
    start_year = 2024,
    start_month = 1,
    end_year = 2024,
    end_month = 6,
    table_no = tablo,
    currency = "TL",
    group = 10001,
    lang = "tr"
  )
}

```
# Teknik Notlar

Paket, BDDK'nın güncel web servislerini kullanır ve veri erişiminde herhangi bir kısıtlama yoktur.
API çağrıları sırasında SSL doğrulama ayarları BDDK sunucularına uygun şekilde yapılandırılmıştır.
Veri yapısı optimizasyonu için gereksiz sütunlar otomatik olarak temizlenir.
Tüm fonksiyonlar package::function formatında yazılarak ad çakışmaları önlenmiştir.
Hata durumlarında detaylı bilgi mesajları görüntülenir.

# Lisans
MIT Lisansı altında açık kaynak olarak sunulmaktadır.

-------------

## About the Package

`bddkR` is the **first** R package specifically developed to provide easy access to financial data from the banking sector in Turkey. This package is an adaptation of the Python library [`bddkdata`](https://pypi.org/project/bddkdata/) for the R ecosystem. It automatically retrieves monthly financial reports, banking statistics, and sectoral indicators published by the BRSA (Banking Regulation and Supervision Agency) and prepares them for analysis. Designed for researchers, finance professionals, and data analysts, this tool delivers banking data quickly in tibble format.

## Features

* Access 17 different types of financial tables updated monthly by the BRSA with a single command
* 10 different bank categories such as deposit banks, participation banks, and public/private banks
* Flexible currency options with TL and USD
* Turkish and English interface support for international use
* Outputs in tibble format, R's modern version of data.frame
* Easy reporting with Excel export feature
* Use of `::` operator for namespace safety
* SSL and security settings configured automatically

## Installation

To start using the package in your R environment:

1. Download and install R: https://www.r-project.org/
2. Add the required dependencies to your system:

```
install.packages(c("httr", "jsonlite", "dplyr", "writexl", "lubridate"))
```

3. Install the `bddkR` package from GitHub:

```
#Install devtools if not already installed
install.packages("devtools")
```


# Pull the main package from GitHub

```
devtools::install_github("ozancanozdemir/bddkR")
```

## Main Function

```fetch_data``` : Retrieves and organizes banking data from the BRSA's API system.

## Parameters:

+ start_year (numeric): Year to start retrieving data (e.g., 2023)
+ start_month (numeric): Starting month (1=January, 12=December)
+ end_year (numeric): Year to end data retrieval
+ end_month (numeric): Ending month (1-12)
+ table_no (numeric): Desired table number (1-17)
+ currency (string): Currency ("TL" or "USD")
+ group (numeric): Bank group code (10001-30003)
+ lang (string): Language option ("tr"=Turkish, "en"=English)
+ save_excel (logical): Option to save as Excel (TRUE/FALSE)

## Output:

Banking data in tibble format (NULL if no data is found)

## Available Financial Tables:

+ Balance Sheet
+ Income Statement
+ Loan Portfolio
+ Retail Loans
+ Sectoral Loan Distribution
+ SME Financing
+ Syndication and Securitization
+ Securities Portfolio
+ Deposit Structure
+ Maturity-Based Deposits
+ Liquidity Indicators
+ Capital Adequacy
+ Foreign Exchange Position
+ Off-Balance Sheet Items
+ Financial Ratios
+ Operational Information
+ International Branch Data

## Bank Categories:

+ 10001: Deposit Banks
+ 10002: Development and Investment Banks
+ 10003: Participation Banks
+ 10004: All Banks
+ 20001: State-Owned Banks
+ 20002: Privately-Owned Banks
+ 20003: Foreign-Owned Banks
+ 30001: Large-Scale Banks
+ 30002: Medium-Scale Banks
+ 30003: Small-Scale Banks

## Usage Examples

```
library(bddkR)

Retrieve 2024 balance sheet data
balance_data <- fetch_data(
start_year = 2024,
start_month = 1,
end_year = 2024,
end_month = 12,
table_no = 1,
currency = "TL",
group = 10001,
lang = "tr",
save_excel = FALSE
)

View results
head(balance_data)

Retrieve income statement in English and save to Excel
income_statement <- fetch_data(
start_year = 2023,
start_month = 6,
end_year = 2024,
end_month = 6,
table_no = 2,
currency = "TL",
group = 10004,
lang = "en",
save_excel = TRUE
)

Loop for multi-table analysis
sector_analysis <- list()
for (table in c(1, 2, 3, 15)) { # Balance Sheet, Income, Loans, Ratios
sector_analysis[[table]] <- fetch_data(
start_year = 2024,
start_month = 1,
end_year = 2024,
end_month = 6,
table_no = table,
currency = "TL",
group = 10001,
lang = "tr"
)
}
```

## Technical Notes

The package uses the BRSA's updated web services with no restrictions on data access.  
SSL verification settings are configured according to BRSA servers during API calls.  
Unnecessary columns are automatically cleaned for optimized data structure.  
All functions are written in package::function format to prevent naming conflicts.  
Detailed error messages are displayed in case of issues.

## License

Released under the MIT License as open-source software.




