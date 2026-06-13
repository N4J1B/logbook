#!/bin/bash
#Script untuk mengirim logbook ke Ella Unesa menggunakan data dari CSV dan variabel dari .env

if [[ -f ".env" ]]; then
    set -a
    source ".env"
    set +a
else
    echo "Error: File .env tidak ditemukan!"
    exit 1
fi

: "${ID_PENDAFTARAN:?Error: ID_PENDAFTARAN belum diisi di .env}"
: "${TOKEN:?Error: TOKEN belum diisi di .env}"

if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: File $CSV_FILE tidak ditemukan!"
    exit 1
fi

python3 - "$CSV_FILE" <<'PY' | while IFS=$'\t' read -r nama uraian tanggal waktu file_path; do
import csv
import sys

csv_path = sys.argv[1]

with open(csv_path, newline='', encoding='utf-8-sig') as csv_file:
    reader = csv.reader(csv_file)
    next(reader, None)
    for row in reader:
        if len(row) < 5:
            continue
        print('\t'.join(row[:5]))
PY

    file_path=$(echo "$file_path" | tr -d '\r')

    echo "================================================="
    echo "Mengirim logbook: $nama pada $tanggal"
    
    RESPONSE=$(curl -X POST "https://ella.unesa.ac.id/log-book/store" \
         -c "$COOKIE_JAR" \
         -b "$COOKIE_JAR" \
         -F "_token=$TOKEN" \
         -F "id_pendaftaran=$ID_PENDAFTARAN" \
         -F "nama_kegiatan=$nama" \
         -F "uraian_kegiatan=$uraian" \
         -F "tgl_kegiatan=$tanggal" \
         -F "waktu_kegiatan=$waktu" \
         -F "file_unggahan=@$file_path" \
         -s -w "\n__HTTP_STATUS__%{http_code}")
    
    HTTP_CODE=$(echo "$RESPONSE" | grep "__HTTP_STATUS__" | sed 's/__HTTP_STATUS__//')
    echo "[$( date '+%Y-%m-%d %H:%M:%S')] | $nama | $tanggal | HTTP $HTTP_CODE" >> "$LOG_FILE"

    HTTP_STATUS=$?

    if [ $HTTP_STATUS -eq 0 ]; then
        echo -e "\nBerhasil diproses. Cek response.html jika ada error dari server."
    else
        echo -e "\nGagal mengirim request."
    fi

    sleep 1
done

echo "================================================="
echo "Iterasi selesai!"