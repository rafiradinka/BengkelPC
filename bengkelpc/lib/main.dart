import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Model Produk
// Model Produk
class Product {
  final String name;
  final int price;
  final String weight;
  int quantity;
  bool isFavorite;

  Product({
    required this.name,
    required this.price,
    this.weight = '', // <-- default kosong kalau belum diisi
    this.quantity = 0,
    this.isFavorite = false,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  // Tambahkan field baru di dalam _MyAppState

List<Product> makananList = [
  Product(name: 'Taro', price: 2000, weight: '18 gram'),
  Product(name: 'Malkist', price: 10000, weight: '120 gram'),
  Product(name: 'Jetz Stick', price: 2000, weight: '12 gram'),
  Product(name: 'Chitato', price: 8000, weight: '60 gram'),
  Product(name: 'Qtela', price: 7000, weight: '75 gram'),
  Product(name: 'TicTac', price: 5000, weight: '50 gram'),
  Product(name: 'Choki Choki', price: 3000, weight: '40 gram'),
  Product(name: 'Oreo', price: 6000, weight: '90 gram'),
  Product(name: 'Beng Beng', price: 4000, weight: '25 gram'),
  Product(name: 'Good Time', price: 9000, weight: '100 gram'),
];

List<Product> minumanList = [
  Product(name: 'Cap Kaki Tiga', price: 12000, weight: '18 gram'),
  Product(name: 'NutriSari', price: 2000, weight: '18 gram'),
  Product(name: 'Ultra Milk', price: 6000, weight: '200 ml'),
  Product(name: 'Teh Pucuk', price: 4000, weight: '350 ml'),
  Product(name: 'Aqua', price: 3000, weight: '600 ml'),
  Product(name: 'Floridina', price: 5000, weight: '350 ml'),
  Product(name: 'Mizone', price: 7000, weight: '500 ml'),
  Product(name: 'You C 1000', price: 9000, weight: '500 ml'),
  Product(name: 'Fruit Tea', price: 5000, weight: '500 ml'),
  Product(name: 'Teh Botol', price: 5000, weight: '350 ml'),
];

List<Product> sembakoList = [
  Product(name: 'Minyak Goreng', price: 23000, weight: '1 liter'),
  Product(name: 'Tepung Segitiga', price: 15000, weight: '1 kilogram'),
  Product(name: 'Teh Celup Sosro', price: 10000, weight: '30 pcs'),
  Product(name: 'Gula Pasir', price: 14000, weight: '1 kilogram'),
  Product(name: 'Beras Pandan', price: 50000, weight: '5 kilogram'),
  Product(name: 'Kecap ABC', price: 12000, weight: '620 ml'),
  Product(name: 'Garam Dapur', price: 5000, weight: '500 gram'),
  Product(name: 'Susu Bubuk', price: 25000, weight: '400 gram'),
  Product(name: 'Sarden ABC', price: 18000, weight: '425 gram'),
  Product(name: 'Minyak Wijen', price: 30000, weight: '400 ml'),
];

  List<Product> cart = [];
  TextEditingController searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addToCart(Product product) {
    setState(() {
      var found = cart.firstWhere(
          (element) => element.name == product.name,
          orElse: () => Product(name: '', price: 0));
      if (found.name == '') {
        cart.add(Product(name: product.name, price: product.price, quantity: 1));
      } else {
        found.quantity += 1;
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      product.quantity -= 1;
      if (product.quantity <= 0) {
        cart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
  buildHomePage(),
  buildCartPage(),
  buildFavoritePage(),
  buildChatPage(),
  buildProfilePage(),
  buildPaymentPage(),
];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/example.png'), // Gambar profil
                  radius: 30,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Selamat Berbelanja',
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('Mudahnya berbelanja, bahagianya bersama',
                          style: TextStyle(fontSize: 14, color: Colors.white70)),
                      Text('Jl. Letjen Sutoyo, Mojosongo, Kec. Jebres, Kota Surakarta',
                          style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Keranjang',
              ),
               BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chat',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Home Page
Widget buildHomePage() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Cari produk...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        buildCategorySection('Makanan', makananList),
        buildCategorySection('Minuman', minumanList),
        buildCategorySection('Sembako', sembakoList),
      ],
    ),
  );
}

// Helper untuk kategori
// Helper untuk kategori
Widget buildCategorySection(String title, List<Product> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 250, // tinggi untuk scroll horizontal produk
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            var product = items[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector( // <--- Tambahkan GestureDetector disini
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => buildProductDetailPage(product),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purpleAccent),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            image: DecorationImage(
                              image: AssetImage('assets/images/${product.name.toLowerCase().replaceAll(' ', '_')}.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              product.weight,
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              'Rp ${product.price}',
                              style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: product.isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      product.isFavorite = !product.isFavorite;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle, color: Colors.purple),
                                  onPressed: () => addToCart(product),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}


  Widget buildProductDetailPage(Product product) {
  int quantity = 1;
  String selectedVarian = 'Original'; // Default varian
  List<String> varianList = ['Original', 'Strawberry', 'Coklat', 'Keju', 'Anggur'];

  return StatefulBuilder(
    builder: (context, setState) {
      return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/${product.name.toLowerCase().replaceAll(' ', '_')}.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                Text(product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(product.weight, style: TextStyle(color: Colors.grey)),
                Text('Rp ${product.price}', style: TextStyle(fontSize: 20, color: Colors.purple)),
                SizedBox(height: 16),
                DropdownButton<String>(
                  value: selectedVarian,
                  items: varianList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedVarian = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text(quantity.toString(), style: TextStyle(fontSize: 20)),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Total: Rp ${product.price * quantity}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Tambah ke keranjang
                        setState(() {
                          var found = cart.firstWhere(
                            (element) => element.name == product.name && element.weight == product.weight,
                            orElse: () => Product(name: '', price: 0),
                          );
                          if (found.name == '') {
                            cart.add(Product(
                              name: '${product.name} ($selectedVarian)',
                              price: product.price,
                              weight: product.weight,
                              quantity: quantity,
                            ));
                          } else {
                            found.quantity += quantity;
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Tambah ke Keranjang'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Langsung beli logikanya nanti bisa lanjut checkout
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Fitur Beli langsung belum dibuat 😁'),
                        ));
                      },
                      child: Text('Beli'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}



  Widget buildCartPage() {
  int total = 0;
  for (var item in cart) {
    total += item.price * item.quantity;
  }

  return cart.isEmpty
      ? Center(
          child: Text(
            'Keranjang kosong',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (contextList, index) {
                  var item = cart[index];
                  return ListTile(
                    leading: Image.asset(
                      'assets/images/${item.name.split(' (')[0].toLowerCase().replaceAll(' ', '_')}.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.name),
                    subtitle: Text('Rp ${item.price} x ${item.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => removeFromCart(item),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () => addToCart(item),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) => Column(
                  children: [
                    Text(
                      'Total Harga: Rp $total',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: cart.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => buildPaymentPage()),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cart.isEmpty ? Colors.grey : Colors.deepPurple,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Lanjutkan Pembayaran',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
}




  Widget buildFavoritePage() {
  var favorites = [...makananList, ...minumanList, ...sembakoList]
      .where((product) => product.isFavorite)
      .toList();

  return favorites.isEmpty
      ? Center(child: Text('Belum ada produk favorit'))
      : ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            var item = favorites[index];
            var inCart = cart.firstWhere(
                (c) => c.name == item.name,
                orElse: () => Product(name: '', price: 0, weight: ''));
            
            int quantityInCart = inCart.name != '' ? inCart.quantity : 0;

            return ListTile(
              leading: Image.asset(
                'assets/images/${item.name.toLowerCase().replaceAll(' ', '_')}.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rp ${item.price} - ${item.weight}'),
                  Text('Di Keranjang: $quantityInCart item'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        if (inCart.name != '' && inCart.quantity > 0) {
                          inCart.quantity--;
                          if (inCart.quantity == 0) {
                            cart.remove(inCart);
                          }
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        if (inCart.name == '') {
                          cart.add(Product(
                            name: item.name,
                            price: item.price,
                            weight: item.weight,
                            quantity: 1,
                          ));
                        } else {
                          inCart.quantity++;
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        item.isFavorite = false;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
}



  Widget buildChatPage() {
    return Center(
      child: Text('Fitur Chat (Akan Terhubung ke petugas)'),
    );
  }

  Widget buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nama: Khoirunnisa'),
          Text('Role: Customer'),
          Text('Email: khoirunnisa@gmail.com'),
          ElevatedButton(
            onPressed: () {},
            child: Text('Ubah Profil'),
          )
        ],
      ),
    );
  }
  Widget buildPaymentPage() {
  String selectedMethod = 'COD';
  List<String> paymentMethods = ['COD', 'Transfer Bank', 'E-Wallet'];
  int diskon = 5000; // contoh diskon Rp5000
  int totalItems = cart.fold(0, (sum, item) => sum + item.quantity);
  int totalHarga = cart.fold(0, (sum, item) => sum + item.price * item.quantity);
  int totalBayar = totalHarga - diskon;

  return StatefulBuilder(
    builder: (context, setState) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Pembayaran'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Produk yang dipesan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    var item = cart[index];
                    return ListTile(
                      leading: Image.asset(
                        'assets/images/${item.name.toLowerCase().replaceAll(' ', '_')}.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle: Text('${item.quantity} x Rp ${item.price}'),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Text('Metode Pembayaran:', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: selectedMethod,
                isExpanded: true,
                items: paymentMethods.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedMethod = newValue!;
                  });
                },
              ),
              SizedBox(height: 10),
              Text('Diskon: Rp $diskon'),
              Text('Total Pesanan ($totalItems item): Rp $totalHarga'),
              Text('Total Pembayaran: Rp $totalBayar',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => buildSuccessPage(totalBayar, selectedMethod, totalItems, diskon)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50), // tombol full width
                ),
                child: Text('Pesan Sekarang', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      );
    },
  );
}


Widget buildSuccessPage(int totalBayar, String metodePembayaran, int totalItems, int diskon) {
  int kodePesanan = DateTime.now().millisecondsSinceEpoch % 1000000; // kode pesanan acak
  String namaPemesan = 'Khoirunnisa'; // contoh nama

  return Scaffold(
    appBar: AppBar(
      title: Text('Pesanan Berhasil'),
      backgroundColor: Colors.green,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text('Pesanan Anda Berhasil!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Alamat Toko: Jl. Letjen Sutoyo, Mojosongo, Solo'),
            Text('Total Pembayaran: Rp $totalBayar'),
            Text('Metode Pembayaran: $metodePembayaran'),
            Text('Total Pesanan: $totalItems item'),
            Text('Diskon: Rp $diskon'),
            Text('Kode Pesanan: $kodePesanan'),
            Text('Nama Pemesan: $namaPemesan'),
            SizedBox(height: 20),
            Text(
              'Ambil pesanan dalam 24 jam sebelum kode pesanan kadaluarsa!',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}


}
