# Tahap I Proyek Akhir Semester
## Daftar Nama Anggota Kelompok
1. Devandra Reswara Arkananta (2206083552)
2. Dien Fitrianii Azzahra (2206828033)
3. Vincent Suhardi (2206082505)
4. Zaim Aydin Nazif (2206082524)
5. Julian Alex Joshua (2206082606)

## Deskripsi aplikasi (nama dan fungsi aplikasi)

### Deskripsi
Literaphile adalah sebuah _community library_ dimana pengguna dapat meminjam buku dari daftar buku yang sudah ada maupun meminjamkan buku yang dia miliki (hanya yang ada pada daftar buku). Selain itu, pengguna juga dapat memberikan review terhadap buku yang telah Ia kembalikan.

### Manfaat
Dengan adanya Literaphile, kami berharap tingkat literasi yang ada di Indonesia akan meningkat sedikit demi sedikit. Literaphile juga mengatasi permasalahan bagi seseorang yang tidak memiliki cukup dan auntuk membaca sebuah buku sekaligus menghindari penyesalan yang akan didapatkan jika buku yang dibelinya tidak sesuai harapannya. Aplikasi kami yang mendukung upaya untuk saling berbagi dapat memberikan motivasi bagi para pengguna untuk berkomunikasi dan menemukan suatu komunitas di dalam Literaphile. Kami berharap bahwa pengguna aplikasi dapat meningkatkan minat baca mereka dan menjadikan Literaphile sebagai ruangan perkembangan penalaran dan ilmu dalam diri.

## Daftar modul yang diimplementasikan beserta pembagian kerja per anggota
1. **Autentikasi** (semua) \
User dapat melakukan _sign-up_ akun baru, login dengan akun yang telah terdaftara, dan juga melakukan logout dari akun tersebut.
2. **Landing Page** (Devandra) \
User dapat melakukan pencarian buku berdasarkan judulnya, dan melihat buku apa saja yang tersedia di aplikasi. Selain itu, tombol untuk user menambahkan suatu buku ke dalam _wishlist_ juga berada di bagian ini.
3. **User Dashboard** (Julian) \
User dapat melihat informasi akunnya, serta list-list buku yang pernah/sedang ia pinjam, dan list buku yang ia pinjamkan ke aplikasi.
4. **Detail Buku** (Zaim) \
User dapat melihat informasi detail mengenai buku, status ketersediaan buku dan terdapat 2 button yakni meminjam buku dan meminjamkan buku ke aplikasi. User juga mendapatkan kesempatan untuk melakukan diskusi pada kolom diskusi/komentar di bawah detail buku.
5. **Wishlist** (Dien) \
User dapat memasukkan buku yang tidak berada di dalam katalog buku ke dalam bagian ini agar dapat melakukan _request_ terhadap admin untuk menambahkan buku baru ke dalam katalog buku.
6. **Admin Page** (Vincent) \
Admin dapat mengakses bagian ini, untuk melakukan penambahan terhadap buku yang dapat dilakukan pinjam-meminjam dan memenuhi _request_ buku yang berada di dalam _wishlist_ user.

## Peran atau aktor pengguna aplikasi

#### Admin
Admin diibaratkan seperti pengurus perpustakaan yang bertugas untuk memanajemen buku. Admin adalah user yang dapat melihat seluruh wishlist yang telah ditambahkan member. Kemudian, wishlist tersebut dapat diterima oleh admin dan menambahkannya ke katalog buku. User admin telah ditentukan oleh developer sehingga form register khusus diperuntukkan membuat member baru.

#### Member
Member dibuat melalui page register. Member dapat melihat halaman utama yang berisi katalog buku. Member dapat meminjam maupun mendonasikan buku yang ada pada katalog. Member juga dapat memberikan komentar pada sebuah buku ketika mengembalikan buku maupun ketika melihat detil buku. Member dapat membuat wishlist buku yang belum terdaftar pada katalog sehingga nantinya akan ditambahkan oleh admin.

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester
Untuk mengintegrasikan aplikasi web yang telah dibuat pada Proyek Tengah Semester dengan web service, beberapa langkah penting harus dilakukan. Pertama, diperlukan integrasi modul autentikasi agar aplikasi mobile dapat mengimplementasikan sistem login, logout, dan pengelolaan pengguna yang sudah ada pada proyek tengah semester yang telah di-deploy menggunakan PaaS PBP CSUI. Langkah berikutnya adalah pembuatan model kustom untuk setiap modul yang ada dalam proyek tersebut, memastikan konsistensi dan kesesuaian dalam mengambil dan mengelola data. Selanjutnya, proses fetch data dari deployment menjadi kunci untuk mendapatkan data-data dari setiap modul dalam bentuk JSON, memungkinkan integrasi yang mulus antara aplikasi web dengan web service yang dibutuhkan. Dengan langkah-langkah ini, integrasi antara aplikasi web yang ada dengan web service dapat terjadi dengan efisien dan efektif, mendukung konektivitas yang diperlukan untuk memperluas fungsionalitas serta akses data pada proyek tengah semester.

## BERITA ACARA
https://docs.google.com/spreadsheets/d/1GOokC0-ydu3lmMzPidkrL5I0xRv3lGDx/edit?usp=drive_web&ouid=108171361872174081173&rtpof=true
