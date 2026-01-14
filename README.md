
# 🛡️ Pardus Odak Asistanı (Pardus Focus Assistant)

Pardus ve Debian tabanlı sistemler için geliştirilmiş; verimliliği artırmak amacıyla dikkat dağıtıcı web sitelerini (Instagram, YouTube vb.) geçici olarak engelleyen profesyonel bir odaklanma aracıdır.

> **Geliştirici:** Rumeysa Ersoy  
> **Platform:** Pardus / Debian GNU/Linux  
> **Dil:** Bash Scripting (YAD & Whiptail)

---

## 🎥 Tanıtım Videosu
Projenin nasıl çalıştığını, kupa kazanma anını ve ses efektlerini aşağıdaki videodan izleyebilirsiniz.

[![Pardus Odak Asistanı Tanıtım](https://img.youtube.com/vi/jqDHAif7XJA/0.jpg)](https://www.youtube.com/watch?v=jqDHAif7XJA)

*(Videoyu izlemek için yukarıdaki görsele tıklayın)*

## 📸 Uygulama Ekran Görüntüleri
---

## 📸 Uygulama Ekran Görüntüleri

### 🎨 1. Grafik Kullanıcı Arayüzü (GUI)
YAD kütüphanesi ile zenginleştirilmiş, kullanıcı dostu modern arayüz.

| Ana Ayar Ekranı | Akış (Çalışma) Modu |
| :---: | :---: |
| ![Ana Ekran](assets/anaekran.png) | ![Çalışma Modu](assets/calismamodu.png) |
| *Süre ve mola ayarlarının yapıldığı ekran.* | *Odaklanma sırasındaki sayaç.* |

**Erişim Engeli & Sonuç Ekranları:**

| ⛔ Erişim Engeli | 🏆 Hedef Tamamlandı |
| :---: | :---: |
| ![Erişim Engeli](assets/erisimengeli.png) | ![Hedef Tamamlandı](assets/hedeftamamlandi.png) |
| *Yasaklı siteye girildiğinde çıkan uyarı.* | *Süre başarıyla tamamlandığında.* |

| ⚠️ Odak Bozuldu | ☕ Mola Zamanı |
| :---: | :---: |
| ![Odak Bozuldu](assets/odakbozuldu.png) | ![Mola Zamanı](assets/molazamani.png) |
| *Süre bitmeden vazgeçilirse.* | *Dinlenme sayacı.* |

**📊 İstatistikler:**

![İstatistikler](assets/calismagecmisi.png)
*Geçmiş çalışma verileri ve kupa koleksiyonu.*

---

### ⌨️ 2. Terminal Kullanıcı Arayüzü (TUI)
Hız ve verimlilik arayanlar için Whiptail ile geliştirilmiş klavye odaklı akış.

| TUI Ana Menü | Çalışma Süresi Ayarı |
| :---: | :---: |
| ![TUI Ana Ekran](assets/tuianaekran.png) | ![TUI Çalışma](assets/tuicalismazamani.png) |

| Mola Süresi Ayarı | Derin Odak Seçimi |
| :---: | :---: |
| ![TUI Mola](assets/tuimolasuresi.png) | ![TUI Derin Odak](assets/tuiderinodak.png) |

**Odaklanma ve Sonuç:**

| Odak Modu Aktif | Tebrikler Ekranı |
| :---: | :---: |
| ![TUI Odak](assets/tuiodakmoduaktif.png) | ![TUI Tebrikler](assets/tuitebrikler.png) |

**📈 Detaylı Rapor (Terminal):**

![TUI İstatistik](assets/tuicalismaistatistik.png)
---

## ⚙️ Kurulum ve Kullanım

## 1. Depoyu Klonlayın
```bash
git clone https://github.com/rumeysaersoyy/pardus-odak-asistani.git
cd pardus-odak-asistani
```
## 2. Uygulamayı Başlatın

Uygulamayı çalıştırmak için aşağıdaki yöntemlerden birini seçebilirsiniz.

### A) Otomatik Başlatma (Task ile - Önerilen) 🚀

Tek komutla kurulum yapar ve uygulamayı başlatır:
```bash
task start
```

### B) Manuel Başlatma

Eğer sisteminizde task yüklü değilse:

```bash
# 1. Gerekli izinleri verin
chmod +x install.sh main.sh lib/*.sh

# 2. Kurulumu yapın
./install.sh

# 3. Uygulamayı başlatın
sudo ./main.sh

```

    ⚠️ Önemli Not: Uygulama, site engelleme özelliği için /etc/hosts dosyasına müdahale eder. Bu nedenle çalıştırırken yönetici şifrenizi (sudo) girmeniz gerekmektedir.
