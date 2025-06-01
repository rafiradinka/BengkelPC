import 'package:flutter/material.dart';
import 'chat_detail_page.dart';
// import 'main.dart';

class HelpCenterPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    // {"question":"","answer":""},
    {"question":"Apa itu aplikasi MartDoora?","answer":"aplikasi MartDoora adalah platform digital untuk mempermudah pengelolaan penjualan,stok dan transaksi di toko kelontong atau toko madura."},
    {"question": "Bagaimana cara belanja?", "answer": "Pilih Produk, klik keranjang, lalu lakukan checkout"},
    {"question": "Apakah aplikasi ini mendukung pembayaran digital?", "answer": "saat ini belum tersedia fitur pembayaran digital seperti kartu kredit, debit, dan e-wallet, tetapi pembeli dapat melakukan pemesanan terlebih dahulu lalu membayar secara COD di toko secara offline."},
    {"question":"Bagaimana jika saya lupa password?","answer":"Anda bisa menghubungi admin melalui fitur chat atau bertanya langsung dengan penjual secara offline"},
    {"question":"Bagaimana cara menghubungi customer service?","answer":"Anda dapat menghubungi melalui fitur chat atau melalui fitur chat dengan admin menggunakan tombol dibawah halaman ini"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(100),
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
        child: Stack(
          children: [
            // Tombol kembali di kiri
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // Judul di tengah
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Pusat Bantuan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Logo di kanan
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/logo2.png',
                height: 120,
                width: 120,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("FAQ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ...faqs.map((item) => ExpansionTile(
                title: Text(item['question']!),
                children: [Padding(padding: EdgeInsets.all(12), child: Text(item['answer']!))],
              )),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatDetailPage(receiver: 'admin')),
              );
            },
            icon: Icon(Icons.chat, color: Colors.white,),
            label: Text("Hubungi Admin",style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          )
        ],
      ),
    );
  }
}
