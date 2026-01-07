#!/bin/bash

source lib/focus_logic.sh
source lib/system_logic.sh

# --- İSTATİSTİK PENCERESİ (KUPA KOLEKSİYONU EKLENDİ) ---
show_stats_window() {
    DATA=$(get_history_data)
    TOTAL_MIN=$(get_total_time)
    
    # Yeni kupa koleksiyonunu hesapla
    KUPALAR=$(calculate_award)
    
    HOURS=$((TOTAL_MIN / 60))
    MINS=$((TOTAL_MIN % 60))
    
    HEADER="<span font='Ubuntu 16' weight='bold' foreground='#2c3e50'>📊 Performans Raporu</span>"
    
    # SUMMARY kısmını kupa koleksiyonunu gösterecek şekilde güncelledik
    SUMMARY="<span color='#7f8c8d'>Toplam Odaklanma:</span> <span color='#d35400' weight='bold'>$HOURS Saat $MINS Dakika</span>\n<span weight='bold' foreground='#2980b9'>🏆 Kupa Koleksiyonun:</span> $KUPALAR"
    
    if [ -z "$DATA" ] || [ "$TOTAL_MIN" == "0" ]; then
        yad --info --title="İstatistikler" --image="office-chart-bar" \
            --text="\n<span font='14'>Henüz kupa kazanılmadı.</span>\n<span color='gray'>Seansları tamamlayarak kupa toplayabilirsin!</span>\n" \
            --width=350 --center --button="Tamam:0" --buttons-layout="center"
    else
        echo -e "$DATA" | yad --list --title="Çalışma Geçmişim" \
            --window-icon="office-chart-bar" --image="office-chart-bar" \
            --text="\n$HEADER\n$SUMMARY\n" \
            --width=480 --height=500 --center \
            --column="Drm:IMG" --column="Tarih" --column="Toplam Süre" \
            --button="Kapat:0" --buttons-layout="center" --separator="" --no-selection
    fi
}

# --- YENİ MOLA SAYACI FONKSİYONU ---
start_break_timer() {
    local break_time=$1
    TOTAL_SEC=$(echo "$break_time * 60" | bc)

    (
        for ((i=0; i<=100; i++)); do
            REMAINING_MIN=$(( (100 - i) * TOTAL_SEC / 100 / 60 ))
            echo "# ☕ Mola: $REMAINING_MIN Dakika kaldı"
            echo "$i"
            sleep $(echo "scale=3; $TOTAL_SEC / 100" | bc)
        done
    ) | yad --progress \
        --title="Mola Zamanı" \
        --text="\n<span font='Ubuntu 22' weight='bold' foreground='#27ae60'>İYİ DİNLENMELER</span>\n<span font='10' foreground='#7f8c8d'><i>Kahveni al, arkana yaslan.</i></span>\n" \
        --percentage=0 \
        --auto-close \
        --width=400 --height=150 --center \
        --borders=30 \
        --window-icon="user-available" \
        --image="coffee" \
        --button="Molayı Bitir!gtk-ok:0" \
        --buttons-layout="center"
}

show_gui() {
    TITLE="Pardus Odak Asistanı"
    
    HEADER="<span font='Ubuntu 18' weight='bold' foreground='#2c3e50'>Derin Odak Modu</span>"
    SUBHEADER="<span font='10' foreground='#7f8c8d'>Dijital gürültüyü sustur, potansiyelini açığa çıkar.</span>"
    TOP_CONTENT="\n$HEADER\n$SUBHEADER\n"
    
    LABEL_TXT="<span weight='bold' foreground='#c0392b'>🛡️  Erişimi Kesilecek Platformlar:</span>"
    BLOCKED_LIST="<span font='9' foreground='#34495e'><i>Youtube, Instagram, Twitter, TikTok, Facebook</i></span>"
    BOTTOM_CONTENT="\n$LABEL_TXT $BLOCKED_LIST"

    while true; do
        OUTPUT=$(yad --title="$TITLE" \
            --form \
            --center \
            --width=480 \
            --height=400 \
            --window-icon="alarm" \
            --image="security-high" \
            --separator="|" \
            --text-align=center \
            --text="$TOP_CONTENT" \
            --field="⏱️   Odak Süresi (Dakika):NUM" "25!1..180!1" \
            --field="☕   Mola Süresi (Dakika):NUM" "5!1..60!1" \
            --field="🚀   Odaklanmaya Başla:CHK" TRUE \
            --field="$BOTTOM_CONTENT:LBL" "" \
            --button="📊 İstatistikler!office-chart-bar:2" \
            --button="Vazgeç!gtk-close:1" \
            --button="ODAKLAN!gtk-media-play:0" \
            --buttons-layout="center" \
            --borders=25)

        EXIT_CODE=$?

        if [ $EXIT_CODE -eq 1 ] || [ $EXIT_CODE -eq 252 ]; then break; fi

        if [ $EXIT_CODE -eq 2 ]; then
            show_stats_window
            continue
        fi

        WORK_TIME=$(echo $OUTPUT | awk -F'|' '{print $1}')
        BREAK_TIME=$(echo $OUTPUT | awk -F'|' '{print $2}')
        BLOCK_SITES=$(echo $OUTPUT | awk -F'|' '{print $3}')

        if [ -z "$WORK_TIME" ] || [ "$WORK_TIME" == "0" ]; then continue; fi

        if [ "$BLOCK_SITES" == "TRUE" ]; then enable_focus; fi

        TOTAL_SEC=$(echo "$WORK_TIME * 60" | bc)
        
        (
            for ((i=0; i<=100; i++)); do
                REMAINING_MIN=$(( (100 - i) * TOTAL_SEC / 100 / 60 ))
                echo "# ⏳ Çalışma: $REMAINING_MIN Dakika kaldı"
                echo "$i"
                sleep $(echo "scale=3; $TOTAL_SEC / 100" | bc)
            done
        ) | yad --progress \
            --title="Akış Modu" \
            --text="\n<span font='Ubuntu 22' weight='bold' foreground='#2980b9'>İYİ ÇALIŞMALAR</span>\n<span font='10' foreground='#7f8c8d'><i>Odaklan, üret, başar.</i></span>\n" \
            --percentage=0 \
            --auto-close \
            --width=400 --height=150 --center \
            --borders=30 \
            --window-icon="alarm" \
            --image="preferences-system-time" \
            --button="Vazgeç!gtk-cancel:1" \
            --buttons-layout="center"

        YAD_STATUS=$?

        if [ "$BLOCK_SITES" == "TRUE" ]; then disable_focus; fi

        # --- SONUÇ VE MOLA GEÇİŞİ (KUPA KOLEKSİYONU BURAYA EKLENDİ) ---
        if [ $YAD_STATUS -eq 0 ]; then
            save_session "$WORK_TIME" "BAŞARILI"
            KUPALAR=$(calculate_award) # Yeni kupa durumunu al
            
            yad --question \
                --title="Hedef Tamamlandı" \
                --text="\n<span font='16' weight='bold' foreground='#27ae60'>HARİKA İŞ ÇIKARDIN! 🎉</span>\n\n<span foreground='#555'>$WORK_TIME dakikalık çalışma bitti ve 1 Kupa kazandın!</span>\n\n<span weight='bold' foreground='#2980b9'>Kupa Koleksiyonun: $KUPALAR</span>\n\n<span weight='bold'>☕ $BREAK_TIME dakikalık molaya çıkmak ister misin?</span>\n" \
                --width=420 --center \
                --button="Hayır, Çık:1" \
                --button="EVET, MOLA VER:0" \
                --window-icon="emblem-default" \
                --image="emblem-default"
            
            if [ $? -eq 0 ]; then
                start_break_timer "$BREAK_TIME"
            fi
            
        else
            # İptal/Vazgeçme Durumu: Süre kaydedilir ama kupa verilmez
            save_session "$WORK_TIME" "YARIM"
            yad --error \
                --title="Odak Bozuldu" \
                --image="dialog-error" \
                --text="\n<span font='16' weight='bold' foreground='#c0392b'>YARIM BIRAKTINIZ 😔</span>\n\n<span foreground='#555'>Süre dolmadan pes ettiğiniz için kupa kazanamadınız.</span>\n\n<span font='10' color='gray'>Bir dahaki sefere daha iyi odaklanabilirsin!</span>\n" \
                --width=380 --center --button="Kapat!gtk-close:0" --buttons-layout="center"
        fi
    done
}