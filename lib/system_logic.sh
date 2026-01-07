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
calculate_award() {
    local log_file="$HOME/.odak_gecmisi.txt"
    
    # Eğer dosya hiç yoksa (ilk açılış), 0 kupa döndür
    if [ ! -f "$log_file" ]; then
        echo "Henüz kupa kazanılmadı."
        return
    fi

    # Dosyadaki 'BAŞARILI' kelimelerini say
    local basari_sayisi=$(grep -c "BAŞARILI" "$log_file" 2>/dev/null || echo 0)

    if [ "$basari_sayisi" -gt 0 ]; then
        # Kaç başarı varsa o kadar 🏆 emojisi yan yana yazılır
        printf '🏆 %.0s' $(seq 1 $basari_sayisi)
        echo " ($basari_sayisi Kupa)"
    else
        echo "Henüz kupa kazanılmadı."
    fi
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

