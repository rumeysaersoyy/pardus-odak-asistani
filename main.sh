#!/bin/bash

# Proje Hakkında:
# Pardus Odak Asistanı
# Geliştirici: Rumeysa Ersoy
# Amaç: Kullanıcının dikkat dağıtıcı siteleri engellemesini sağlamak.

# 1. Root (Yönetici) Kontrolü
# /etc/hosts dosyası ile oynayacağımız için yönetici izni şart.
if [ "$EUID" -ne 0 ]; then
  echo "⚠️  UYARI: Bu program sistem dosyalarını düzenlediği için yönetici yetkisi gerektirir."
  echo "Lütfen şu komutla çalıştırın: sudo ./main.sh"
  exit 1
fi

# 2. Çalıştırma İzni Kontrolü (Dosyalar çalıştırılabilir mi?)
chmod +x lib/focus_logic.sh lib/gui.sh lib/tui.sh

# 3. Arayüz Seçimi
# Kullanıcıya hangi arayüzü istediğini soralım.
echo "---------------------------------"
echo "   PARDUS ODAK ASİSTANI v1.0"
echo "---------------------------------"
echo "1) Grafik Arayüz (GUI - Renkli)"
echo "2) Terminal Arayüzü (TUI - Siyah Ekran)"
echo "---------------------------------"
read -p "Lütfen bir seçim yapın (1 veya 2): " choice

if [ "$choice" == "1" ]; then
    # GUI Başlat
    source lib/gui.sh
    show_gui
elif [ "$choice" == "2" ]; then
    # TUI Başlat
    source lib/tui.sh
    show_tui
else
    echo "❌ Hatalı seçim yaptınız. Program kapatılıyor."
fi
