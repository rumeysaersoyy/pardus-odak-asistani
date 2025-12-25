#!/bin/bash

# Kapatılacak servisler (Bluetooth ve Yazıcı servisi - Odaklanırken bunlara ihtiyaç yok)
# Not: Pardus/Ubuntu'da 'cups' yazıcı, 'bluetooth' bluetooth servisidir.
SERVICES=("bluetooth" "cups")

# Fonksiyon: Performans Modunu Aç
optimize_system() {
    echo "⚙️  Sistem optimize ediliyor..."

    for service in "${SERVICES[@]}"; do
        # Servis çalışıyorsa durdur
        if systemctl is-active --quiet "$service"; then
            systemctl stop "$service"
            echo "🔻 $service servisi durduruldu (Kaynak tasarrufu)."
        fi
    done

    # RAM Önbelleğini Temizle (Admin yetkisi gerektirir)
    # Bu komut Linux'ta kullanılmayan önbelleği siler, RAM'i rahatlatır.
    sync; echo 3 > /proc/sys/vm/drop_caches
    echo "🧹 RAM önbelleği temizlendi."
}

# Fonksiyon: Performans Modunu Kapat (Eski haline döndür)
restore_system() {
    echo "⚙️  Sistem servisleri geri yükleniyor..."

    for service in "${SERVICES[@]}"; do
        # Servis çalışmıyorsa başlat
        if ! systemctl is-active --quiet "$service"; then
            systemctl start "$service"
            echo "🔺 $service servisi tekrar başlatıldı."
        fi
    done
}

