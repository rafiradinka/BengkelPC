# 🖥️ BengkelPC

## 📋 Deskripsi Singkat

BengkelPC adalah platform e-commerce yang memudahkan pengguna untuk membeli komponen PC dan mengakses layanan jasa rakit komputer custom. Kami menyediakan komponen berkualitas dengan harga kompetitif dan layanan rakit oleh teknisi berpengalaman.

## ✨ Fitur Utama

- 🛒 Belanja komponen PC (Processor, Motherboard, RAM, dll)
- 🔧 Layanan jasa rakit PC custom
- 👤 Manajemen akun pengguna
- 📦 Pelacakan pengiriman
- 💬 Konsultasi spesifikasi PC
- 🛡️ Garansi produk dan layanan
- 💳 Berbagai metode pembayaran

## 🛠️ Teknologi yang Digunakan

- **Frontend**: React
- **Backend**: Node.js
- **Database**: MongoDB/MySQL
- **Authentication**: JWT
- **Payment Gateway**: stripe
- **Deployment**: Docker

## 📁 Struktur Project

```
BengkelPC/
├── client/                 # Frontend React
│   ├── public/
│   └── src/
├── server/                 # Backend Node.js
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   └── config/
├── docs/                   # Dokumentasi
├── .gitignore
├── docker-compose.yml
└── README.md
```

## 🚀 Cara Instalasi

1. Clone repositori
   ```bash
   git clone https://github.com/username/BengkelPC.git
   cd BengkelPC
   ```

2. Instalasi dependencies frontend
   ```bash
   cd client
   npm install
   ```

3. Instalasi dependencies backend
   ```bash
   cd server
   npm install
   ```

4. Setup environment variables
   ```bash
   cp .env.example .env
   # Edit file .env sesuai kebutuhan
   ```

5. Jalankan aplikasi
   ```bash
   # Terminal 1 (Backend)
   cd server
   npm run dev
   
   # Terminal 2 (Frontend)
   cd client
   npm start
   ```

## 📱 Panduan Penggunaan

*Panduan penggunaan lengkap akan ditambahkan setelah aplikasi mencapai tahap MVP*

## 📈 Status Project

Saat ini project berada dalam tahap **perencanaan**. Kami sedang merancang arsitektur sistem dan fitur-fitur utama yang akan diimplementasikan.

## 🗺️ Roadmap

- [ ] **Q2 2025**: Desain UI/UX dan pembuatan wireframe
- [ ] **Q3 2025**: Pengembangan backend dan database
- [ ] **Q3 2025**: Implementasi frontend untuk katalog produk dan keranjang belanja
- [ ] **Q4 2025**: Integrasi sistem pembayaran dan manajemen pesanan
- [ ] **Q1 2026**: Peluncuran versi beta dan pengujian
- [ ] **Q2 2026**: Peluncuran resmi

## 👥 Tim Pengembang

- Radinka Rafi - Project Manager 
- Azza - Developer
- Diva Ahmad P - UI/UX Designer
- Fauzan ZF - Maintener

## 🤝 Kontribusi

Saat ini, project hanya terbuka untuk anggota tim. Panduan kontribusi untuk kolaborator eksternal akan ditambahkan pada tahap yang lebih lanjut.

### Aturan Branching

- `main` - branch produksi
- `development` - branch utama pengembangan
- `feature/nama-fitur` - branch untuk pengembangan fitur baru
- `bugfix/nama-bug` - branch untuk perbaikan bug

## 📄 Lisensi

Project ini dilisensikan di bawah [MIT License](LICENSE).

## 📞 Kontak

Untuk pertanyaan atau kerjasama, silakan hubungi:
- Email: [joinbengkelpc@bengkelpc.com]
- Website: [www.bengkelpc.com]
