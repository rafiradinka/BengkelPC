import 'package:flutter/material.dart';
import 'main.dart';
import 'models/product.dart';
import 'data/product_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'chat_detail_page.dart';
import 'help_center_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'edit_profile_page.dart';

class MainHomePage extends StatefulWidget {
  final String role;
  const MainHomePage({super.key, required this.role});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  List<Product> cart = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addToCart(Product product) {
    setState(() {
      var found = cart.firstWhere(
        (element) => element.name == product.name,
        orElse: () => Product(name: '', price: 0),
      );
      if (found.name == '') {
        cart.add(
          Product(
            name: product.name,
            price: product.price,
            quantity: 1,
          ),
        );
      } else {
        found.quantity += 1;
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      product.quantity -= 1;
      if (product.quantity <= 0) {
        cart.removeWhere((item) => item.name == product.name);
      }
    });
  }

 PreferredSizeWidget _buildHomeAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(220),
    child: Container(
      padding: const EdgeInsets.all(16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tulisan Bengkel PC
            const Text(
              'Bengkel PC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/example1.png'),
                  radius: 26,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Penuhi kebutuhan PC-mu di sini!',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Jl. Letjen Sutoyo, Mojosongo, Solo',
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // aksi keranjang
                  },
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Search Bar mewah
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari produk terbaik untuk PC kamu...',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  PreferredSizeWidget _buildPageAppBar() {
    if (_selectedIndex == 4) {
      return const PreferredSize(preferredSize: Size.zero, child: SizedBox());
    }

    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
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
            alignment: Alignment.center,
            children: [
              // Tombol kembali di kiri
              Positioned(
                left: 10,
                top: 15,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0; // ke Favorit misalnya
                    }); // Atau atur _selectedIndex = 0
                  },
                ),
              ),

              // Judul di tengah
              Positioned(
                top: 25,
                child: Center(
                  child: Text(
                    _getTitleByIndex(_selectedIndex),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Logo di kanan
              Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  String _getTitleByIndex(int index) {
    switch (index) {
      case 1:
        return 'Keranjang';
      case 2:
        return 'Favorit';
      case 3:
        return 'Chat';
      case 4:
        return ''; // kosong karena pakai AppBar khusus
      default:
        return '';
    }
  }

  PreferredSizeWidget? _buildAppBarByIndex(int index) {
    switch (index) {
      case 0:
        return _buildHomeAppBar();
      case 1:
      case 2:
      case 3:
        return _buildPageAppBar(); // Gunakan gradient + title di tengah
      case 4:
        return null; // Profil punya AppBar sendiri di widgetnya
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      buildHomePage(),
      buildCartPage(),
      buildFavoritePage(),
      buildChatPage(),
      buildProfilePage((index) => setState(() => _selectedIndex = index)),
    ];

    return Scaffold(
      appBar: _buildAppBarByIndex(_selectedIndex),
      body: pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.pink,
          ),

          /// Cart
          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Keranjang"),
            selectedColor: Colors.pinkAccent,
          ),

          /// Favorite
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorit"),
            selectedColor: Colors.purpleAccent,
          ),

          /// Chat
          SalomonBottomBarItem(
            icon: Icon(Icons.chat),
            title: Text("Chat"),
            selectedColor: Colors.purple,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profil"),
            selectedColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  // Home Page
  Widget buildHomePage() {
    // Gabungkan semua produk jadi satu list
    List<Product> allProducts = [
      ...cpuList,
      ...ramList,
      ...motherboardList,
      ...gpuList,
      ...ssdList,
      ...psuList,
      ...caseList,
      ...coolerList,
    ];

    // Filter berdasarkan search query
    List<Product> filtered =
        searchQuery.isEmpty
            ? []
            : allProducts
                .where(
                  (product) => product.name.toLowerCase().contains(searchQuery),
                )
                .toList();

    if (searchQuery.isNotEmpty) {
      // Jika user sedang mencari sesuatu
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hasil pencarian untuk: \"$searchQuery\"",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Produk tidak ditemukan."),
              )
            else
              SizedBox(
                height: 260, // Samakan dengan tinggi card di homepage
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 160, // Samakan dengan homepage
                        child: buildProductCard(filtered[index]),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    }
    // Kalau tidak sedang mencari → tampilkan kategori biasa
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCategorySection('CPU', cpuList),
          buildCategorySection('RAM', ramList),
          buildCategorySection('Motherboard', motherboardList),
          buildCategorySection('GPU', gpuList),
          buildCategorySection('SSD', ssdList),
          buildCategorySection('PSU', psuList),
          buildCategorySection('Case', caseList),
          buildCategorySection('Cooler', coolerList),
        ],
      ),
    );
  }

  Widget buildProductGrid(List<Product> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var product = items[index];
        return buildProductCard(product);
      },
    );
  }

  Widget buildProductCard(Product product) {
    return Container(
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
                  image: AssetImage(
                    'assets/images/${product.name.split(' (')[0].toLowerCase().replaceAll(' ', '_')}.png',
                  ),
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
                ),
                Text(
                  'Rp ${product.price}',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk kategori
  Widget buildCategorySection(String title, List<Product> items) {
    // Tambahkan filter berdasarkan searchQuery
    List<Product> filteredItems =
        searchQuery.isEmpty
            ? items
            : items
                .where((item) => item.name.toLowerCase().contains(searchQuery))
                .toList();

    // Jika hasil pencarian kosong untuk kategori ini, sembunyikan
    if (filteredItems.isEmpty) return SizedBox.shrink();

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
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              var product = filteredItems[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
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
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/${product.name.toLowerCase().replaceAll(' ', '_')}.png',
                                ),
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
                                'Rp ${product.price}',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      product.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          product.isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        product.isFavorite =
                                            !product.isFavorite;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Colors.purple,
                                    ),
                                    onPressed: () => addToCart(product),
                                  ),
                                ],
                              ),
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
    int quantity = product.quantity > 0 ? product.quantity : 1;

    // Map varian berdasarkan produk
    final Map<String, List<String>> productVariants = {
      // 🍟 Makanan
      'Taro': ['Seaweed', 'Barbeque'],
      'Malkist': ['Keju', 'Coklat'],
      'Jetz Stick': ['Chocolate', 'Strawberry'],
      'Chitato': ['Sapi Panggang', 'Keju'],
      'Qtela': ['Singkong Asin', 'Balado'],
      'TicTac': ['Jagung Manis', 'Keju'],
      'Choki Choki': ['Coklat Original', 'Kacang'],
      'Oreo': ['Original', 'Vanilla Cream'],
      'Beng Beng': ['Original', 'Extra Crunch'],
      'Good Time': ['Coklat Chip', 'Kacang'],

      // 🥤 Minuman
      'Cap Kaki Tiga': ['Original', 'Jambu'],
      'NutriSari': ['Jeruk', 'Mangga', 'Leci'],
      'Ultra Milk': ['Coklat', 'Strawberry', 'Plain'],
      'Teh Pucuk': ['Original', 'Jasmine'],
      'Aqua': [], // air mineral, tidak ada varian
      'Floridina': ['Jeruk', 'Lemon'],
      'Mizone': ['Lychee Lemon', 'Strawberry'],
      'You C 1000': ['Lemon', 'Orange'],
      'Fruit Tea': ['Apel', 'Blackcurrant'],
      'Teh Botol': ['Original', 'Less Sugar'],

      // 🍚 Sembako
      'Minyak Goreng': [],
      'Tepung Segitiga': [],
      'Teh Celup Sosro': ['Original', 'Jasmine'],
      'Gula Pasir': [],
      'Beras Pandan': ['Pulen', 'Aromatik'],
      'Kecap ABC': ['Manis', 'Asin'],
      'Garam Dapur': [],
      'Susu Bubuk': ['Full Cream', 'Coklat'],
      'Sarden ABC': ['Original', 'Pedas'],
      'Minyak Wijen': ['Original', 'Roasted'],
    };

    List<String> variants = productVariants[product.name] ?? [];
    String selectedVariant =
        product.selectedVariant ??
        (variants.isNotEmpty ? variants[0] : 'Original');

    return StatefulBuilder(
      builder: (context, setState) {
        int totalHarga = product.price * quantity;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Detail Produk',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/images/logo.png',
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto produk
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/${product.name.toLowerCase().replaceAll(" ", "_")}.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Nama produk dan tombol love
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            product.isFavorite = !product.isFavorite;
                          });
                        },
                      ),
                    ],
                  ),

                  

                  const SizedBox(height: 12),

                  Text(
                    'Rp ${product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Varian (jika ada)
                  if (variants.isNotEmpty) ...[
                    const Text(
                      "Pilih Varian:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 10,
                      children:
                          variants.map((variant) {
                            bool selected = selectedVariant == variant;
                            return ChoiceChip(
                              label: Text(variant),
                              selected: selected,
                              selectedColor: Colors.purple.shade200,
                              onSelected: (value) {
                                setState(() {
                                  selectedVariant = variant;
                                });
                              },
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Kuantitas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Jumlah:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Total Harga: Rp $totalHarga",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tombol Tambah ke Keranjang
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          product.selectedVariant = selectedVariant;
                          product.quantity = quantity;
                        });

                        bool found = false;
                        for (var item in cart) {
                          if (item.name == product.name &&
                              item.selectedVariant == selectedVariant) {
                            item.quantity += quantity;
                            found = true;
                            break;
                          }
                        }
                        if (!found) {
                          cart.add(
                            Product(
                              name: product.name,
                              price: product.price,
                              quantity: quantity,
                              isFavorite: product.isFavorite,
                              selectedVariant: selectedVariant,
                            ),
                          );
                        }

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Tambah ke Keranjang",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
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

    return Scaffold(
      body:
          cart.isEmpty
              ? Center(
                child: Text(
                  'Keranjang kosong',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cart.length,
                      separatorBuilder:
                          (_, __) => Divider(), // <== Tambah garis
                      itemBuilder: (contextList, index) {
                        var item = cart[index];
                        return ListTile(
                          leading: Image.asset(
                            'assets/images/${item.name.split(' (')[0].toLowerCase().replaceAll(' ', '_')}.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.selectedVariant != null)
                                Text('Varian: ${item.selectedVariant}'),
                              Text('Rp ${item.price} x ${item.quantity}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => removeFromCart(item),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ),
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
                      builder:
                          (context) => Column(
                            children: [
                              Text(
                                'Total Harga: Rp $total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed:
                                    cart.isEmpty
                                        ? null
                                        : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      buildPaymentPage(),
                                            ),
                                          );
                                        },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      cart.isEmpty
                                          ? const Color.fromARGB(
                                            255,
                                            255,
                                            255,
                                            255,
                                          )
                                          : Colors.deepPurple,
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Lanjutkan Pembayaran',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),
                ],
              ),
    );
  }

  Widget buildFavoritePage() {
    var favorites =
        [
          ...cpuList,
      ...ramList,
      ...motherboardList,
      ...gpuList,
      ...ssdList,
      ...psuList,
      ...caseList,
      ...coolerList,
        ].where((product) => product.isFavorite).toList();

    return favorites.isEmpty
        ? Center(child: Text('Belum ada produk favorit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
        : ListView.separated(
          itemCount: favorites.length,
          separatorBuilder: (_, __) => Divider(), // <== Tambah garis
          itemBuilder: (context, index) {
            var item = favorites[index];
            var inCart = cart.firstWhere(
              (c) =>
                  c.name == item.name &&
                  c.selectedVariant == item.selectedVariant,
              orElse: () => Product(name: '', price: 0),
            );

            int quantityInCart = inCart.name != '' ? inCart.quantity : 0;

            return ListTile(
              leading: Image.asset(
                'assets/images/${item.name.toLowerCase().replaceAll(' ', '_')}.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.selectedVariant != null)
                    Text('Varian: ${item.selectedVariant}'),
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
                          cart.add(
                            Product(
                              name: item.name,
                              price: item.price,
                              quantity: 1,
                              selectedVariant:
                                  item.selectedVariant ?? 'Original',
                            ),
                          );
                        } else {
                          inCart.quantity++;
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
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

  Future<List<Map<String, dynamic>>> getChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('chat_history');
    if (jsonString != null) {
      return List<Map<String, dynamic>>.from(json.decode(jsonString));
    }
    return [];
  }

  Future<void> saveChatHistory(List<Map<String, dynamic>> messages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_history', json.encode(messages));
  }

  Widget buildChatPage() {
    List<String> contactList;

    if (widget.role == 'buyer') {
      contactList = ['admin'];
    } else {
      contactList = [
        'nisa',
        'fajar',
        'nurul',
        'ahmad',
        'beni',
        'caca',
        'denis',
        'erlangga',
        'faiz',
      ];
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.separated(
        itemCount: contactList.length,
        separatorBuilder:
            (context, index) => const Divider(
              height: 1,
              thickness: 1,
              indent: 16,
              endIndent: 16,
              color: Colors.grey,
            ),
        itemBuilder: (context, index) {
          final name = contactList[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            title: Text(
              name[0].toUpperCase() + name.substring(1),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatDetailPage(receiver: name),
                ),
              );
            },
          );
        },
      ),
    );
  }
Widget buildProfilePage(void Function(int index) onNavigate) {
  bool isNotifikasiOn = true;

  return StatefulBuilder(
    builder: (context, setState) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.pinkAccent],
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "PROFIL",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
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
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Foto profil dan username
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/example1.png'),
                  radius: 30,
                ),
                const SizedBox(width: 12),
                Text(
                  currentUsername.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Menu List
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.pink),
              title: const Text('Notifikasi'),
              trailing: Switch(
                value: isNotifikasiOn,
                activeColor: Colors.pinkAccent,
                onChanged: (val) {
                  setState(() {
                    isNotifikasiOn = val;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.orange),
              title: const Text('Lihat Profil'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.deepOrange),
              title: const Text('Suka'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                onNavigate(2); // pindah ke Favorit Page
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.amber),
              title: const Text('Keranjang'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                onNavigate(1); // pindah ke Cart Page
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.yellow[800]),
              title: const Text('Pusat Bantuan'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HelpCenterPage()),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}


  Widget buildPaymentPage() {
    String selectedMethod = 'COD';
    List<String> paymentMethods = ['COD', 'Transfer Bank', 'E-Wallet'];
    int diskon = 0; // contoh diskon 0
    int totalItems = cart.fold(0, (sum, item) => sum + item.quantity);
    int totalHarga = cart.fold(
      0,
      (sum, item) => sum + item.price * item.quantity,
    );
    int totalBayar = totalHarga - diskon;

    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
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
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      // Judul di tengah
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Pembayaran',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Logo di kanan
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Image.asset(
                      //     'assets/images/logo.png',
                      //     height: 120,
                      //     width: 120,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Produk yang dipesan:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      var item = cart[index];
                      return ListTile(
                        leading: Image.asset(
                          'assets/images/${item.name.toLowerCase().replaceAll(' ', '_')}.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.selectedVariant != null)
                              Text('Varian: ${item.selectedVariant}'),
                            Text('Rp ${item.price} x ${item.quantity}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Metode Pembayaran:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedMethod,
                  isExpanded: true,
                  items:
                      paymentMethods.map((String value) {
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
                Text(
                  'Total Pembayaran: Rp $totalBayar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => buildSuccessPage(
                              totalBayar,
                              selectedMethod,
                              totalItems,
                              diskon,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: Size(double.infinity, 50), // tombol full width
                  ),
                  child: Text(
                    'Pesan Sekarang',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSuccessPage(
    int totalBayar,
    String metodePembayaran,
    int totalItems,
    int diskon,
  ) {
    int kodePesanan =
        DateTime.now().millisecondsSinceEpoch % 1000000; // kode pesanan acak
    String namaPemesan = currentUsername.toUpperCase(); // contoh nama

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 23, 126, 0),
                Color.fromARGB(255, 2, 167, 84),
              ],
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
                      'Pesanan Berhasil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 100),
              SizedBox(height: 20),
              Text(
                'Pesanan Anda Berhasil!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
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
              Text(
                'Bila pesanan ingin diantar, silahkan konfirmasi melalui chat!',
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
