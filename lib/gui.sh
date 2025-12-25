#!/bin/bash

# Modülleri dahil et
source lib/focus_logic.sh
source lib/system_logic.sh

show_gui() {
    while true; do
        # YAD Formunu Güncelledik: Artık 3 seçenek var
        OUTPUT=$(yad --title="Pardus Verimlilik İstasyonu" \
            --form \
            --center \
            --width=450 \
            --height=350 \
            --window-icon="utilities-system-monitor" \
            --image="utilities-terminal" \
            --text="<big><b>Çalışma Modunu Yapılandır</b></big>\nLütfen ayarları seçiniz:" \
            --field="⏱️ Odak Süresi (Dk):NUM" "25" \
            --field="🌐 Siteleri Engelle (Youtube vb.):CHK" TRUE \
            --field="🚀 Performans Modu (Servisleri Kapat):CHK" TRUE \
            --button="BAŞLAT! (Focus):0" \
            --button="Çıkış:1")

        if [ $? -ne 0 ]; then break; fi

        # Verileri Ayıkla
        TIME=$(echo $OUTPUT | awk -F'|' '{print $1}')
        BLOCK_SITES=$(echo $OUTPUT | awk -F'|' '{print $2}')
        OPTIMIZE_SYS=$(echo $OUTPUT | awk -F'|' '{print $3}')

        if [ -z "$TIME" ] || [ "$TIME" == "0" ]; then
            yad --error --text="Lütfen geçerli bir süre girin!"
            continue
        fi

        # Seçimlere göre işlemleri başlat
        if [ "$BLOCK_SITES" == "TRUE" ]; then enable_focus; fi
        if [ "$OPTIMIZE_SYS" == "TRUE" ]; then optimize_system; fi

        # Geri Sayım Ekranı
        TOTAL_SEC=$(echo "$TIME * 60" | bc)
        for ((i=0; i<=100; i++)); do
            echo "$i"
            echo "# Kalan Süre: $(( (100 - i) * TOTAL_SEC / 100 / 60 )) dk"
            sleep $(echo "scale=3; $TOTAL_SEC / 100" | bc)
        done | yad --progress --title="Çalışma Modu Aktif" --text="Sistem kilitlendi, verimlilik modu açık." --percentage=0 --auto-close --width=400 --center --no-buttons

        # Bitiş İşlemleri
        if [ "$BLOCK_SITES" == "TRUE" ]; then disable_focus; fi
        if [ "$OPTIMIZE_SYS" == "TRUE" ]; then restore_system; fi
        
        yad --info --text="Süre doldu! Sistem normale döndü." --center
        break
    done
}
