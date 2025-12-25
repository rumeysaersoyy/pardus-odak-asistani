#!/bin/bash

# Dosya yolları
HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/etc/hosts.backup"

# Engellenecek siteler (İstediğin kadar ekleyebilirsin)
SITES=("www.instagram.com" "instagram.com" "www.twitter.com" "twitter.com" "www.youtube.com" "youtube.com" "www.facebook.com" "facebook.com")

# Fonksiyon: Odak Modunu Başlat
enable_focus() {
    echo "🔒 Odak modu aktifleşiyor..."

    # 1. Yedek al (Eğer yoksa)
    if [ ! -f "$BACKUP_FILE" ]; then
        cp "$HOSTS_FILE" "$BACKUP_FILE"
        echo "✅ Yedek alındı."
    fi

    # 2. Siteleri engelle
    for site in "${SITES[@]}"; do
        if ! grep -q "$site" "$HOSTS_FILE"; then
            echo "127.0.0.1 $site" >> "$HOSTS_FILE"
            echo "🚫 $site engellendi."
        fi
    done
}

# Fonksiyon: Odak Modunu Bitir
disable_focus() {
    echo "🔓 Odak modu kapatılıyor..."

    # Yedeği geri yükle
    if [ -f "$BACKUP_FILE" ]; then
        cp "$BACKUP_FILE" "$HOSTS_FILE"
        rm "$BACKUP_FILE"
        echo "✅ Siteler açıldı."
    else
        echo "⚠️ Yedek bulunamadı, işlem yapılmadı."
    fi
}
