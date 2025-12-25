#!/bin/bash

# Logic dosyasını dahil et (Fonksiyonları buradan çekeceğiz)
source lib/focus_logic.sh

# Ana TUI Fonksiyonu
show_tui() {
    while true; do
        # 1. Ana Menüyü Göster
        CHOICE=$(whiptail --title "Pardus Odak Asistanı" --menu "Lütfen bir işlem seçin:" 15 60 4 \
        "1" "Odak Modunu Başlat" \
        "2" "Ayarlar (Görüntüle)" \
        "3" "Çıkış" 3>&1 1>&2 2>&3)

        # Çıkış veya İptal durumunu kontrol et
        if [ $? -ne 0 ]; then break; fi

        case $CHOICE in
            1)
                # Süre İste
                TIME=$(whiptail --title "Süre Belirle" --inputbox "Kaç dakika odaklanmak istersin?" 10 60 "25" 3>&1 1>&2 2>&3)
                
                # Eğer iptal ederse veya boş bırakırsa ana menüye dön
                if [ $? -ne 0 ] || [ -z "$TIME" ]; then continue; fi

                # Odak Modunu Aktif Et
                enable_focus

                # Geri Sayım Döngüsü (Gauge / Yükleme Çubuğu)
                # Dakikayı saniyeye çevir
                TOTAL_SEC=$((TIME * 60))
                
                for ((i=0; i<=100; i++)); do
                    sleep_time=$(awk "BEGIN {print $TOTAL_SEC / 100}")
                    sleep $sleep_time
                    echo $i
                done | whiptail --title "Odaklanıyor..." --gauge "Lütfen işinize odaklanın. Kalan süre bitince siteler açılacak." 10 70 0

                # Süre bitince
                disable_focus
                whiptail --title "Tebrikler!" --msgbox "Süre doldu! Mola verebilirsin." 10 60
                ;;
            2)
                # Engelli siteleri göster
                MSG="Engellenecek Siteler:\n---------------------\n"
                for site in "${SITES[@]}"; do
                    MSG+="$site\n"
                done
                whiptail --title "Ayarlar" --msgbox "$MSG" 15 50
                ;;
            3)
                break
                ;;
        esac
    done
    
    # Çıkarken her ihtimale karşı temizle
    clear
    echo "Güle güle!"
}
