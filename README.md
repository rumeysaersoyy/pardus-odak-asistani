🛡️ Pardus Odak Asistanı (Pardus Focus Assistant)

Pardus ve Debian tabanlı Linux sistemleri için geliştirilmiş; verimliliği artırmak amacıyla dikkat dağıtıcı web sitelerini engelleyen, oyunlaştırma (gamification) tabanlı ve çift arayüz destekli bir odaklanma asistanıdır.

    Geliştirici: Rumeysa Ersoy

    Dil: Bash Scripting (YAD & Whiptail)

    Özellik: GUI & TUI Desteği + Kupa Sistemi 🏆

🎥 Tanıtım Videosu

Projenin nasıl çalıştığını, kupa kazanma anını ve ses efektlerini aşağıdaki videodan izleyebilirsiniz.

(Videoyu izlemek için yukarıdaki görsele tıklayın)
🏗️ Teknik Mimari ve Dosya Yapısı

Proje, modüler bir yapıda tasarlanmıştır. Her fonksiyonel birim (zamanlayıcı, arayüz, sistem mantığı) ayrı kütüphane dosyalarında tutulmuştur.
Plaintext

pardus-odak-asistani/
├── assets/              # Uygulama görselleri ve ikonlar
├── lib/                 # Modüler script kütüphaneleri
│   ├── gui.sh           # YAD tabanlı grafik arayüz fonksiyonları
│   ├── tui.sh           # Whiptail tabanlı terminal arayüzü
│   ├── focus_logic.sh   # Odaklanma döngüsü ve sayaç mantığı
│   └── system_logic.sh  # Site engelleme ve kupa/veri yönetimi
├── Taskfile.yaml        # Go-Task otomasyon dosyası
├── install.sh           # Bağımlılıkları kuran script
├── main.sh              # Projenin ana giriş noktası (Entry Point)
├── LICENSE              # Lisans dosyası
└── README.md            # Proje dokümantasyonu

📸 Kullanım ve Arayüzler
1. Grafik Kullanıcı Arayüzü (GUI)

Modern, renkli ve fare ile kolayca kontrol edilebilen arayüz.

<table> <tr> <td align="center"><b>Ana Ayar Ekranı</b></td> <td align="center"><b>Akış (Çalışma) Modu</b></td> </tr> <tr> <td><img src="assets/anaekran.png" width="400"></td> <td><img src="assets/calismamodu.png" width="400"></td> </tr> <tr> <td align="center"><i>Süre ve mola ayarlarının yapıldığı ekran.</i></td> <td align="center"><i>Odaklanma sırasındaki sayaç.</i></td> </tr> </table>

Erişim Engeli & Sonuç Ekranları:

<table> <tr> <td align="center"><b>⛔ Erişim Engeli</b></td> <td align="center"><b>🏆 Hedef Tamamlandı</b></td> </tr> <tr> <td><img src="assets/erisimengeli.png" width="400"></td> <td><img src="assets/hedeftamamlandi.png" width="400"></td> </tr> <tr> <td align="center"><i>Yasaklı siteye girildiğinde çıkan uyarı.</i></td> <td align="center"><i>Süre başarıyla tamamlandığında.</i></td> </tr> </table>

<table> <tr> <td align="center"><b>⚠️ Odak Bozuldu</b></td> <td align="center"><b>☕ Mola Zamanı</b></td> </tr> <tr> <td><img src="assets/odakbozuldu.png" width="400"></td> <td><img src="assets/molazamani.png" width="400"></td> </tr> <tr> <td align="center"><i>Süre bitmeden vazgeçilirse.</i></td> <td align="center"><i>Dinlenme sayacı.</i></td> </tr> </table>

📊 İstatistikler:

<div align="center"> <img src="assets/calismagecmisi.png" width="600">

<i>Geçmiş çalışma verileri ve kupa koleksiyonu.</i> </div>
2. Terminal Kullanıcı Arayüzü (TUI)

Hız ve minimalizm arayanlar için klavye odaklı Whiptail arayüzü.

<table> <tr> <td align="center"><b>Ana Menü</b></td> <td align="center"><b>Çalışma Süresi Ayarı</b></td> </tr> <tr> <td><img src="assets/tuianaekran.png" width="400"></td> <td><img src="assets/tuicalismazamani.png" width="400"></td> </tr> </table>

<table> <tr> <td align="center"><b>Mola Süresi Ayarı</b></td> <td align="center"><b>Derin Odak Seçimi</b></td> </tr> <tr> <td><img src="assets/tuimolasuresi.png" width="400"></td> <td><img src="assets/tuiderinodak.png" width="400"></td> </tr> </table>

Odaklanma ve Sonuç:

<table> <tr> <td align="center"><b>Odak Modu Aktif</b></td> <td align="center"><b>Tebrikler Ekranı</b></td> </tr> <tr> <td><img src="assets/tuiodakmoduaktif.png" width="400"></td> <td><img src="assets/tuitebrikler.png" width="400"></td> </tr> </table>

📈 Detaylı Rapor (Terminal):

<div align="center"> <img src="assets/tuicalismaistatistik.png" width="600"> </div>
🛠️ Kurulum ve Çalıştırma Rehberi

Bu programı bilgisayarınızda çalıştırmak için aşağıdaki adımları sırasıyla uygulayın.
1. Adım: Dosyaları Bilgisayara İndirin

Önce terminali açın (Genellikle Ctrl + Alt + T tuşlarıyla açılır) ve şu komutu yapıştırıp Enter tuşuna basın:
Bash

git clone https://github.com/rumeysaersoyy/pardus-odak-asistani.git
cd pardus-odak-asistani

2. Adım: Programı Çalıştırın

Burada iki yöntem var. A Yöntemi en kolayıdır, eğer çalışmazsa B Yöntemini deneyin.
A) En Kolay Yöntem (Otomatik) 🚀

Terminalde şu komutu yazıp Enter'a basın. Bu komut her şeyi (kurulumu ve başlatmayı) kendi yapar.
Bash

task start

B) Manuel Yöntem (Klasik)

Eğer yukarıdaki çalışmazsa, sırasıyla şu iki komutu yazıp Enter'a basın:

    Önce gerekli izinleri verelim ve kurulumu yapalım:

Bash

chmod +x install.sh main.sh lib/*.sh && ./install.sh

    Şimdi programı başlatalım:

Bash

sudo ./main.sh

    ❓ Neden Şifre Soruyor? > Uygulama, "Instagram, YouTube" gibi siteleri engelleyebilmek için bilgisayarın sistem ayarlarına (/etc/hosts) müdahale eder. Bu yüzden çalıştırırken Pardus giriş şifrenizi ister. Şifrenizi yazarken ekranda yıldız (*) çıkmaz, siz yazıp Enter'a basın.
