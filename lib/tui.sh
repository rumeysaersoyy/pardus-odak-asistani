#!/bin/bash

# Modülleri dahil et
source lib/focus_logic.sh
source lib/system_logic.sh

show_tui() {
    while true; do
        # 1. Ana Menü
        CHOICE=$(whiptail --title "Pardus Verimlilik İstasyonu" --menu "Hoşgeldiniz! Ne yapmak istersiniz?" 15 60 4 \
        "1" "Çalışma Modunu Başlat" \
        "2" "Ayarlar / Bilgi" \
        "3" "Çıkış" 3>&1 1>&2 2>&3)

        if [ $? -ne 0 ]; then break; fi

        case $CHOICE in
            1)
                # Süre İste
                TIME=$(whiptail --title "Süre" --inputbox "Odaklanma süresi (Dakika):" 10 60 "25" 3>&1 1>&2 2>&3)
                if [ -z "$TIME" ]; then continue; fi

                # Özellik Seçimi (Checklist - Boşluk tuşu ile seçilir)
                FEATURES=$(whiptail --title "Mod Seçimi" --checklist \
                "Hangi özellikleri aktif etmek istersiniz? (Boşluk ile seç)" 15 60 2 \
                "BLOCK" "Siteleri Engelle (Youtube, Instagram...)" ON \
                "PERF"  "Performans Modu (Gereksiz Servisleri Kapat)" ON \
                3>&1 1>&2 2>&3)

                # Kullanıcı iptal ederse başa dön
                if [ $? -ne 0 ]; then continue; fi

                # Seçimleri Uygula
                if [[ $FEATURES == *"BLOCK"* ]]; then enable_focus; fi
                if [[ $FEATURES == *"PERF"* ]]; then optimize_system; fi

                # Geri Sayım
                TOTAL_SEC=$((TIME * 60))
                for ((i=0; i<=100; i++)); do
                    sleep_time=$(awk "BEGIN {print $TOTAL_SEC / 100}")
                    sleep $sleep_time
                    echo $i
                done | whiptail --title "Odaklanılıyor..." --gauge "Lütfen işinize odaklanın. Sistem kilitli." 10 70 0

                # Bitiş
                if [[ $FEATURES == *"BLOCK"* ]]; then disable_focus; fi
                if [[ $FEATURES == *"PERF"* ]]; then restore_system; fi
                
                whiptail --msgbox "Süre doldu! Sistem normale döndü." 10 60
                ;;
            2)
                MSG="Engellenecek Siteler:\n"
                for site in "${SITES[@]}"; do MSG+=" - $site\n"; done
                MSG+="\nKapatılacak Servisler:\n"
                for srv in "${SERVICES[@]}"; do MSG+=" - $srv\n"; done
                
                whiptail --title "Sistem Bilgisi" --msgbox "$MSG" 20 60
                ;;
            3)
                break
                ;;
        esac
    done
    clear
}
