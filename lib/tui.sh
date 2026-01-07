#!/bin/bash

# Ortak mantık ve kupa hesaplama dosyalarını dahil et
source lib/focus_logic.sh
source lib/system_logic.sh

show_tui() {
    while true; do
        # --- ANA MENÜ ---
        CHOICE=$(whiptail --title "Pardus Odak Asistanı" \
        --menu "\nLütfen bir işlem seçin:" 18 65 4 \
        "1" "🚀  Odaklanma Oturumu Başlat" \
        "2" "📊  Çalışma İstatistikleri & Kupalar" \
        "3" "ℹ️   Uygulama Hakkında" \
        "4" "❌  Çıkış" 3>&1 1>&2 2>&3)

        if [ $? -ne 0 ]; then break; fi

        case $CHOICE in
            1)
                # 1. ADIM: SÜRE GİRİŞLERİ
                TIME=$(whiptail --title "Zamanlayıcı" --inputbox "⏱️  Çalışma süresi (Dakika):" 10 60 "25" 3>&1 1>&2 2>&3)
                if [ -z "$TIME" ]; then continue; fi

                BREAK_TIME=$(whiptail --title "Zamanlayıcı" --inputbox "☕  Mola süresi (Dakika):" 10 60 "5" 3>&1 1>&2 2>&3)
                if [ -z "$BREAK_TIME" ]; then BREAK_TIME=5; fi

                # 2. ADIM: ODAK MODU SEÇİMİ
                if (whiptail --title "Derin Odak" --yesno "Dikkat dağıtıcı siteler engellensin mi?" 10 60); then
                    BLOCK_ENABLED="EVET"
                else
                    BLOCK_ENABLED="HAYIR"
                fi

                # 3. ADIM: BAŞLATMA
                if (whiptail --title "Başlatılıyor" --yesno "Odaklanma süresi başlıyor. Hazır mısın?" 10 60); then
                    
                    if [ "$BLOCK_ENABLED" == "EVET" ]; then enable_focus; fi
                    
                    # --- ÇALIŞMA SAYACI ---
                    TOTAL_SEC=$((TIME * 60))
                    
                    {
                        for ((i=0; i<=100; i++)); do
                            sleep_time=$(echo "scale=3; $TOTAL_SEC / 100" | bc)
                            sleep $sleep_time
                            echo $i
                        done
                    } | whiptail --gauge "ODAKLANMA MODU AKTİF\nLütfen işinize konsantre olun..." 10 60 0

                    # --- KUPA VE KAYIT KONTROLÜ (İSTEDİĞİN GÜNCELLEME) ---
                    if [ $? -eq 0 ]; then
                        # Süre Başarıyla Bitti
                        if [ "$BLOCK_ENABLED" == "EVET" ]; then disable_focus; fi
                        save_session "$TIME" "BAŞARILI"
                        
                        KUPALAR=$(calculate_award)
                        whiptail --title "Tebrikler!" --msgbox "Harika! Süreyi tamamladın ve 1 Kupa kazandın! 🎉\n\nKoleksiyonun: $KUPALAR" 12 60
                        
                        # Mola Teklifi
                        if (whiptail --title "Mola" --yesno "☕ Mola başlasın mı?" 10 60); then
                            SEC_BREAK=$((BREAK_TIME * 60))
                            {
                                for ((i=0; i<=100; i++)); do
                                    sleep $(echo "scale=3; $SEC_BREAK / 100" | bc); echo $i
                                done
                            } | whiptail --gauge "Dinleniyorsun..." 10 60 0
                            whiptail --msgbox "Mola bitti! Yeni seansa hazırsın." 10 60
                        fi
                    else
                        # Kullanıcı Vazgeçti veya İptal Etti
                        if [ "$BLOCK_ENABLED" == "EVET" ]; then disable_focus; fi
                        save_session "$TIME" "YARIM"
                        
                        whiptail --title "Yarım Kaldı" --msgbox "Yarım bıraktınız, bir dahaki sefere daha iyi odaklanabilirsin! 😔\n(Süre kaydedildi ama kupa verilmedi)" 12 60
                    fi
                fi
                ;;
            2)
                # İSTATİSTİK VE KUPA KOLEKSİYONU
                LOG_FILE="$HOME/.odak_gecmisi.txt"
                KUPALAR=$(calculate_award)
                if [ -f "$LOG_FILE" ]; then
                    TOTAL=$(awk -F'|' '{sum+=$2} END {print sum}' "$LOG_FILE")
                    LIST=$(sort -r "$LOG_FILE" | awk -F'|' '{print "  - " $1 " : " $2 " dk (" $3 ")"}')
                    
                    whiptail --title "Çalışma ve Kupa Raporu" --scrolltext --msgbox \
                    "🏆 KUPA KOLEKSİYONUN:\n$KUPALAR\n\n------------------------------\nToplam Odaklanma: $TOTAL Dakika\n\nDetaylı Geçmiş:\n$LIST" 20 70
                else
                    whiptail --msgbox "Henüz veri yok. İlk kupanı kazanmak için bir oturum başlat!" 10 60
                fi
                ;;
            3)
                whiptail --title "Hakkında" --msgbox "Pardus Odak Asistanı\nGeliştirici: Rumeysa Ersoy" 10 60
                ;;
            4)
                break
                ;;
        esac
    done
    clear
}