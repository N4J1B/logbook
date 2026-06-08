**Konfigurasi singkat**

- Script membutuhkan beberapa variabel environment yang disimpan di file `.env` di root proyek.
- Variabel yang WAJIB diisi:
  - `ID_PENDAFTARAN`: ID pendaftaran akun (string base64 di contoh).
  - `TOKEN`: token form (`_token`) yang dipakai form upload.

Contoh isi `.env`:

```env
ID_PENDAFTARAN="<isi-id-pendaftaran-anda>"
TOKEN="<isi-token-anda>"
LOG_FILE="logbook_result.log"
COOKIE_JAR="ella_cookies.txt"
CSV_FILE="logbook_data.csv"
```

Cara menjalankan (tanpa modifikasi `script.sh`):

```bash
set -a
source .env
set +a
./script.sh
```

Ekspor cookie dari browser (wajib manual)

Gunakan ekstensi Chrome/Edge yang kamu sebutkan (Cookie-Editor):

- Ekstensi: https://chromewebstore.google.com/detail/cclelndahbckbenkjhflpdbgdldlbecc?utm_source=item-share-cb
- Langkah singkat:
  1. Pasang ekstensi dan login ke https://ella.unesa.ac.id.
  2. Buka ekstensi → pilih domain `ella.unesa.ac.id`.
  3. Pilih `Export` → format `Netscape` (atau `curl`) → simpan sebagai `ella_cookies.txt` di folder proyek.
  4. Pastikan `COOKIE_JAR` di `.env` menunjuk ke `ella_cookies.txt`.

Catatan: skrip menggunakan `-c`/`-b` dengan `COOKIE_JAR`, jadi cookie harus ada di file tersebut agar curl mengirimkan sesi dan XSRF cookie.

