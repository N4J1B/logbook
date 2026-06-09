## Data Requirement
1. Pastikan Format CSV data Logbook sama dengan contoh
2. Pastikan File path pada data logbook pada CSV valid

    Contoh:
    | nama_kegiatan | uraian_kegiatan | tgl_kegiatan | waktu_kegiatan | file_unggahan |
    | -------- | -------- | -------- | :--------: | -------- |
    Observasi Sekolah | Melakukan observasi sekolah | 2026-02-10 | 70 | file/1.png
    
    Notes: format tanggal harus sesuai, waktu kegiatan berupa menit dan file unggahan merupakan path ke lokasi file
  

## Sebelum Menjalankan Script
1. Pastikan sudah membuat file `.env` sesuai dengan copy dari file `.env.example`
2. pastikan isian `.env` valid semua
3. pastikan sudah melakukan export cookies dari web `ella.unesa.ac.id` 

## Cara Export Cookie
Gunakan ekstensi Chrome:
- Ekstensi: https://chromewebstore.google.com/detail/cclelndahbckbenkjhflpdbgdldlbecc
- Langkah singkat:
  1. Pasang ekstensi dan login ke https://ella.unesa.ac.id.
  2. Buka ekstensi → pilih domain `ella.unesa.ac.id`.
  3. Pilih `Export` → format `Netscape` (atau `curl`) → simpan sebagai `ella_cookies.txt` di folder proyek.
  4. Pastikan `COOKIE_JAR` di `.env` menunjuk ke `ella_cookies.txt`.

## Cara Menjalankan Script

jalankan script dengan command:
```
./script.sh
```

