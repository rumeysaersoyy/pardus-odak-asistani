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

### 🖥️ Başlangıç ve Mod Seçimi
Uygulama, hem görsel (GUI) hem de performans odaklı terminal (TUI) arayüzü seçenekleriyle başlar.

![Arayüz Seçimi](assets/baslangic_ekran_secimi.png)

---

### 🎨 1. Grafik Kullanıcı Arayüzü (GUI)
YAD kütüphanesi ile zenginleştirilmiş, kullanıcı dostu modern arayüz.

| Ana Menü ve Ayarlar | Odaklanma Modu (Sayaç) |
| :---: | :---: |
| ![GUI Ana Ekran](assets/gui_ana_ekran.png) | ![GUI Sayaç](assets/gui_sayac.png) |
| *Çalışma süreleri ve site engelleme ayarı.* | *Geri sayım ve motivasyon mesajları.* |

| Mola Teklifi | Mola Sayacı |
| :---: | :---: |
| ![GUI Mola Sorusu](assets/gui_mola_sorusu.png) | ![GUI Mola Sayacı](assets/gui_mola_sayaci.png) |
| *Hedef süresi dolduğunda mola onayı.* | *Dinlenme süreci takibi.* |

**Performans Takibi ve Hatalar:**
* **Çalışma Raporu:** ![GUI İstatistik](assets/gui_istatistik.png)  
* **İptal Durumu (Odak Bozuldu):** ![Odak Bozuldu](assets/gui_odak_bozuldu.png)
* **Engellenen Platformlar:** ![Engelleme Detayı](assets/engellenecek_platformlar.png)

---

### ⌨️ 2. Terminal Kullanıcı Arayüzü (TUI)
Hız ve verimlilik arayanlar için Whiptail ile geliştirilmiş klavye odaklı akış.

| TUI Ana Menü | Yapılandırma Özet |
| :---: | :---: |
| ![TUI Menü](assets/tui_menu.png) | ![TUI Başlatma Onayı](assets/tui_baslatma_onayi.png) |

**TUI Kullanım Adımları:**
* **Süre Ayarları:** ![TUI Süre Girişi](assets/tui_sure_girisi.png) ![TUI Mola Girişi](assets/tui_mola_girisi.png)
* **Odak Onayı ve Sayaç:** ![TUI Odak Sorusu](assets/tui_odak_modu_sorusu.png) ![TUI Sayaç](assets/tui_sayac.png)
* **Mola Akışı:** ![TUI Mola Sorusu](assets/tui_mola_sorusu.png) ![TUI Mola Sayacı](assets/tui_mola_sayaci.png)
* **Tamamlanma ve Bilgi:** ![TUI Mola Bitiş](assets/tui_mola_bitis.png) ![TUI Hakkında](assets/tui_hakkinda.png)

**Detaylı Çalışma Kayıtları:**
![TUI İstatistik](assets/tui_istatistik.png)

---

## ⚙️ Kurulum ve Kullanım

### 1. Depoyu Klonlayın
```bash
git clone [https://github.com/rumeysaersoyy/pardus-odak-asistani.git](https://github.com/rumeysaersoyy/pardus-odak-asistani.git)
cd pardus-odak-asistani
2. Uygulamayı Başlatın

Uygulamayı çalıştırmak için aşağıdaki yöntemlerden birini seçebilirsiniz.
A) Otomatik Başlatma (Task ile - Önerilen) 🚀

Tek komutla kurulum yapar ve uygulamayı başlatır:
Bash

task start

B) Manuel Başlatma

Eğer sisteminizde task yüklü değilse:
Bash

# 1. Gerekli izinleri verin
chmod +x install.sh main.sh lib/*.sh

# 2. Kurulumu yapın
./install.sh

# 3. Uygulamayı başlatın
sudo ./main.sh

    ⚠️ Önemli Not: Uygulama, site engelleme özelliği için /etc/hosts dosyasına müdahale eder. Bu nedenle çalıştırırken yönetici şifrenizi (sudo) girmeniz gerekmektedir.