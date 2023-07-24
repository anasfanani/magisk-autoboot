##  [English](README.md) | [Bahasa Indonesia](README-id.md)
### Patch AutoBoot untuk Perangkat Android

Repositori ini berisi skrip dan instruksi untuk menerapkan patch AutoBoot pada `boot.img` perangkat Android menggunakan Magisk. Patch AutoBoot memungkinkan perangkat secara otomatis boot ke layar utama setelah koneksi USB terdeteksi.

### Persyaratan

Sebelum menjalankan skrip patch, pastikan Anda telah memenuhi persyaratan berikut:

- Perangkat Android dengan akses root dan telah terpasang Magisk.

### Panduan Langkah-demi-Langkah: AutoPatch

1. Unduh rilis terbaru dari repositori ini.

2. Ekstrak isi rilis ke lokasi yang Anda inginkan, misalnya: `/sdcard/autoboot/`.

3. Reboot perangkat Anda ke dalam mode pemulihan (recovery mode).

4. Buka terminal atau gunakan ADB shell untuk menjalankan perintah berikut:

```bash
sh patch.sh auto
```

5. Proses patching akan dimulai, dan perangkat Anda akan secara otomatis menerapkan patch AutoBoot.

6. Setelah proses patching selesai, periksa apakah patch berfungsi:

   - Cabut kabel USB telepon Anda.
   - Matikan telepon.
   - Sambungkan kembali kabel USB.
   - Telepon seharusnya menyala, kemudian mati, dan akhirnya, secara otomatis boot ke layar utama. Jika ini terjadi, berarti patch berhasil diterapkan.

### Panduan Langkah-demi-Langkah: Patch Manual

1. Cari file `boot.img` pada perangkat Anda.

2. Dump `boot.img` ke direktori pada perangkat Anda.

3. Patch `boot.img` menggunakan MagiskBoot:

```bash
/data/adb/magisk/magiskboot unpack boot.img
/data/adb/magisk/magiskboot cpio ramdisk.cpio \
"mkdir 0700 overlay.d" \
"add 0700 overlay.d/init.custom.rc files/init.custom.rc" \
"mkdir 0700 overlay.d/sbin" \
"add 0700 overlay.d/sbin/custom.sh files/init.custom.sh"
/data/adb/magisk/magiskboot repack boot.img boot_patched_autoboot.img
/data/adb/magisk/magiskboot cleanup
```

4. Flash kembali `boot.img` yang telah dipatch ke partisi boot. Gunakan perintah berikut (sesuaikan dengan lokasi path):

```bash
dd if=/sdcard/autoboot/boot_patched_autoboot.img of=/dev/block/bootdevice/by-name/boot
```

### Catatan Penting

- Proses patching mengubah `boot.img`, yang merupakan komponen penting dari sistem Android. Berhati-hatilah saat menerapkan patch dan pastikan Anda telah melakukan cadangan yang tepat jika terjadi masalah.
- Skrip `init.custom.sh` yang disediakan berisi baris demonstrasi yang menginisiasi restart perangkat. Hindari menggunakan baris ini dalam lingkungan produksi.

### Penyangkalan

Gunakan skrip dan patch yang disediakan dengan risiko Anda sendiri. Pemilik repositori dan kontributor tidak bertanggung jawab atas kerusakan atau masalah yang mungkin timbul akibat penggunaan skrip ini.

### Perangkat yang Telah Diuji

Patch telah berhasil diuji pada perangkat-perangkat berikut:

- Redmi 4X dengan Android 10
- Samsung J3 (2016) dengan Android 7.1.2

### Lisensi

Proyek ini dilisensikan di bawah [Lisensi MIT](LICENSE).

### Pedoman Kontribusi

Kontribusi untuk repositori ini dipersilakan. Jika Anda memiliki perbaikan, perbaikan bug, atau fitur baru untuk diusulkan, jangan ragu untuk membuat *pull request*.

### Informasi Kontak

Untuk pertanyaan atau informasi lebih lanjut, Anda dapat menghubungi pemilik repositori [di sini](mailto:lexaveykov@gmail.com).

---