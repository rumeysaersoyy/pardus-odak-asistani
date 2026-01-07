#!/bin/bash

echo "📦 Gerekli paketler kontrol ediliyor..."

# Paket listesini güncelle
sudo apt-get update

# yad (arayüz) ve bc (matematik işlemleri) paketlerini yükle
# whiptail genelde yüklü gelir ama garanti olsun diye ekleyelim.
sudo apt-get install -y yad bc whiptail

echo "✅ Kurulum tamamlandı! 'sudo ./main.sh' ile programı başlatabilirsin."
