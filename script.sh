#!/bin/bash

# Pastikan ffmpeg terinstal
command -v ffmpeg >/dev/null 2>&1 || { echo >&2 "Harap instal ffmpeg terlebih dahulu."; exit 1; }

# Periksa argumen input
if [ "$#" -ne 2 ]; then
    echo "Penggunaan: $0 input.mp3 output_prefix"
    exit 1
fi

input_file="$1"
output_prefix="$2"
durasi=300  # Durasi setiap segmen dalam detik (5 menit)

# Jalankan proses pemotongan
ffmpeg -i "$input_file" -f segment -segment_time "$durasi" -c:a libmp3lame -q:a 2 -map 0 "$output_prefix-%03d.mp3"

echo "Pemotongan selesai: $input_file menjadi $output_prefix-001.mp3, $output_prefix-002.mp3, dll."
