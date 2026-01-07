#!/bin/bash

# Dosya yolları
HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/etc/hosts.backup"
LOG_FILE="$HOME/.odak_gecmisi.txt"

# Engellenecek siteler
SITES=("www.instagram.com" "instagram.com" "www.twitter.com" "twitter.com" "www.youtube.com" "youtube.com" "www.facebook.com" "facebook.com" "www.tiktok.com" "tiktok.com")

enable_focus() {
    echo "🔒 Odak modu aktifleşiyor..."
    if [ ! -f "$BACKUP_FILE" ]; then cp "$HOSTS_FILE" "$BACKUP_FILE"; fi
    for site in "${SITES[@]}"; do
        if ! grep -q "$site" "$HOSTS_FILE"; then echo "127.0.0.1 $site" >> "$HOSTS_FILE"; fi
    done
}

disable_focus() {
    echo "🔓 Odak modu kapatılıyor..."
    if [ -f "$BACKUP_FILE" ]; then
        cp "$BACKUP_FILE" "$HOSTS_FILE"
        rm "$BACKUP_FILE"
    fi
}

save_session() {
    local sure=$1
    local durum=$2 # 'BAŞARILI' veya 'YARIM' gelecek
    local tarih=$(date +%Y-%m-%d)
    
    # Yeni format: Tarih | Süre | Durum
   echo "$tarih|$sure|$durum" >> "$HOME/.odak_gecmisi.txt"
}

get_history_data() {
    if [ -f "$LOG_FILE" ]; then
        # 1. Adım: awk ile tarihleri ve süreleri topla -> Çıktı: "2026-01-04|25"
        # 2. Adım: sort -r ile tarihleri YENİDEN ESKİYE sırala
        # 3. Adım: while döngüsü ile satır satır okuyup YAD formatına (3 satırlık bloklar) çevir
        
        awk -F'|' '{arr[$1]+=$2} END {for (i in arr) print i"|"arr[i]}' "$LOG_FILE" | sort -r | while IFS="|" read -r tarih sure; do
            # Sütun 1: İkon (Bu bir resim sütunu olduğu için dosya adı veriyoruz)
            echo "emblem-default"
            
            # Sütun 2: Tarih
            echo "<span weight='bold' foreground='#2c3e50'>$tarih</span>"
            
            # Sütun 3: Süre
            echo "<span foreground='#27ae60'><b>$sure</b> Dakika</span>"
        done
    else
        echo ""
    fi
}
get_total_time() {
    local log_file="$HOME/.odak_gecmisi.txt"
    if [ -f "$log_file" ]; then
        # Dosyadaki tüm süreleri (2. sütun) toplar
        awk -F'|' '{sum+=$2} END {print (sum == "" ? 0 : sum)}' "$log_file"
    else
        echo "0"
    fi
}