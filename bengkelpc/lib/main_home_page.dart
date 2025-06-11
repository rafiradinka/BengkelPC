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
import 'banner_carousel.dart';

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
//-----------------------------------------------------------------------------------------------------------------------------------------------------
//header
PreferredSizeWidget _buildHomeAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(260), // tambahkan tinggi agar muat
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
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/example1.png'),
                  radius: 26,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Selamat Datang di BengkelPC 👋',
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
                        'Jl. Letjen Sutoyo, Bantul, Yogyakarta',
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Gambar logo kecil agar tidak overflow
                Image.asset(
                  'assets/images/logo2.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                decoration: const InputDecoration(
                  hintText: 'Cari produk terbaik untuk PC kamu...',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );


}

//header
//---------------------------------------------------------------------------------------------------------

  PreferredSizeWidget _buildPageAppBar() {
    if (_selectedIndex == 4) {
      return const PreferredSize(preferredSize: Size.zero, child: SizedBox());
    }

    return PreferredSize(
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
        return ''; 
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
        return _buildPageAppBar(); 
      case 4:
        return null; 
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
            selectedColor: Colors.blue,
          ),

          /// Cart
          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Keranjang"),
            selectedColor: Colors.blue,
          ),

          /// Favorite
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorit"),
            selectedColor: Colors.blue,
          ),

          /// Chat
          SalomonBottomBarItem(
            icon: Icon(Icons.chat),
            title: Text("Chat"),
            selectedColor: Colors.blue,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profil"),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  // Home Page

Widget buildHomePage() {
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

  List<Product> filtered =
      searchQuery.isEmpty
          ? []
          : allProducts
              .where(
                (product) => product.name.toLowerCase().contains(searchQuery),
              )
              .toList();

  if (searchQuery.isNotEmpty) {
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
              height: 260, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 160, 
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

//tampilkan banner carousel
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Banner Carousel bagian atas
        const BannerCarousel(),
        
        // Quick Action Buttons 
        _buildQuickActions(),
        
        // Kategori produk
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

// Widget tambahan
Widget _buildQuickActions() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Layanan Kami',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuickActionItem(
              icon: Icons.build,
              title: 'Build PC',
              color: Colors.blue,
            ),
            _buildQuickActionItem(
              icon: Icons.help_center,
              title: 'Konsultasi',
              color: Colors.green,
            ),
            _buildQuickActionItem(
              icon: Icons.delivery_dining,
              title: 'Antar Gratis',
              color: Colors.orange,
            ),
            _buildQuickActionItem(
              icon: Icons.support_agent,
              title: 'Support 24/7',
              color: Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}

Widget _buildQuickActionItem({
  required IconData icon,
  required String title,
  required Color color,
}) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: color,
          size: 28,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    ],
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
        border: Border.all(color: Colors.blue),
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
                    color: Colors.blue,
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
                      icon: Icon(Icons.add_circle, color: Colors.blue),
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
    List<Product> filteredItems =
        searchQuery.isEmpty
            ? items
            : items
                .where((item) => item.name.toLowerCase().contains(searchQuery))
                .toList();

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
                      border: Border.all(color: Colors.blueAccent),
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
                                  color: Colors.blue,
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
                                      color: Colors.blue,
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

    final Map<String, List<String>> productVariants = {
      'NamaProductX' :['varian1', 'varian2'], 
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
                      color: Colors.blue,
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
                              selectedColor: Colors.blue.shade200,
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
    backgroundColor: const Color(0xFFF5F5F5),
    body: cart.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  'Keranjang kosong',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Mulai belanja sekarang!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              // Header info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[100]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                    SizedBox(width: 8),
                    Text(
                      '${cart.length} item dalam keranjang',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cart.length,
                  itemBuilder: (contextList, index) {
                    var item = cart[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Product Image
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/${item.name.split(' (')[0].toLowerCase().replaceAll(' ', '_')}.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey[400],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                            SizedBox(width: 12),
                            
                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  if (item.selectedVariant != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.orange[200]!,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        'Varian: ${item.selectedVariant}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.orange[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Rp ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[600],
                                        ),
                                      ),
                                      Text(
                                        ' x ${item.quantity}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.red[400],
                                        size: 20,
                                      ),
                                      onPressed: () => removeFromCart(item),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      '${item.quantity}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 36,
                                    height: 36,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.green[400],
                                        size: 20,
                                      ),
                                      onPressed: () => addToCart(item),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Bottom Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Builder(
                    builder: (context) => Column(
                      children: [
                        // Total Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue[100]!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                'Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Payment Button
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: cart.isEmpty
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => buildPaymentPage(),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cart.isEmpty
                                  ? Colors.grey[300]
                                  : Colors.blue[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: cart.isEmpty ? 0 : 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.payment,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Lanjutkan Pembayaran',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
  );
}

  Widget buildFavoritePage() {
  var favorites = [
    ...cpuList,
    ...ramList,
    ...motherboardList,
    ...gpuList,
    ...ssdList,
    ...psuList,
    ...caseList,
    ...coolerList,
  ].where((product) => product.isFavorite).toList();

  return Container(
    color: const Color(0xFFF5F5F5),
    child: favorites.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_outline,
                  size: 80,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  'Belum ada produk favorit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Mulai tambahkan produk ke favorit!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              // Header info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink[100]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.pink[600], size: 20),
                    SizedBox(width: 8),
                    Text(
                      '${favorites.length} produk favorit',
                      style: TextStyle(
                        color: Colors.pink[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    var item = favorites[index];
                    var inCart = cart.firstWhere(
                      (c) =>
                          c.name == item.name &&
                          c.selectedVariant == item.selectedVariant,
                      orElse: () => Product(name: '', price: 0),
                    );

                    int quantityInCart = inCart.name != '' ? inCart.quantity : 0;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Product Image
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/${item.name.toLowerCase().replaceAll(' ', '_')}.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey[400],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            SizedBox(width: 12),

                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  if (item.selectedVariant != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.orange[200]!,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        'Varian: ${item.selectedVariant}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.orange[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Rp ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: quantityInCart > 0 
                                          ? Colors.green[50] 
                                          : Colors.grey[50],
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: quantityInCart > 0 
                                            ? Colors.green[200]! 
                                            : Colors.grey[200]!,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Text(
                                      'Di Keranjang: $quantityInCart item',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: quantityInCart > 0 
                                            ? Colors.green[700] 
                                            : Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              children: [
                                // Favorite Button
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.pink[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.pink[400],
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        item.isFavorite = false;
                                      });
                                    },
                                  ),
                                ),
                                
                                SizedBox(height: 8),
                                
                                // Quantity Controls
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.red[400],
                                            size: 16,
                                          ),
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
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(
                                          '$quantityInCart',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 32,
                                        height: 32,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.green[400],
                                            size: 16,
                                          ),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
    backgroundColor: Colors.grey[50],
    body: ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: contactList.length,
      separatorBuilder: (context, index) => Container(
        height: 1,
        margin: const EdgeInsets.only(left: 72),
        color: Colors.grey[200],
      ),
      itemBuilder: (context, index) {
        final name = contactList[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: _getAvatarColor(name),
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              name[0].toUpperCase() + name.substring(1),
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              widget.role == 'buyer' ? 'Administrator' : 'Pelanggan',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatDetailPage(receiver: name),
                ),
              );
            },
          ),
        );
      },
    ),
  );
}

Color _getAvatarColor(String name) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
    Colors.cyan,
  ];
  
  return colors[name.hashCode % colors.length];
}

//header profil ------------------------------------------------------------------------------------

Widget buildProfilePage(void Function(int index) onNavigate) {
  bool isNotifikasiOn = true;

  return StatefulBuilder(
    builder: (context, setState) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
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
                        image: AssetImage('assets/images/logo2.png'),
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
          padding: const EdgeInsets.all(16.0),
          children: [
            // Profile Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/example1.png'),
                    radius: 40,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    currentUsername.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // Menu Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuTile(
                    icon: Icons.notifications,
                    title: 'Notifikasi',
                    iconColor: Colors.orange,
                    trailing: Switch(
                      value: isNotifikasiOn,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setState(() {
                          isNotifikasiOn = val;
                        });
                      },
                    ),
                    isFirst: true,
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.person,
                    title: 'Lihat Profil',
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfilePage()),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.favorite,
                    title: 'Suka',
                    iconColor: Colors.red,
                    onTap: () {
                      onNavigate(2); // pindah ke Favorit Page
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.shopping_cart,
                    title: 'Keranjang',
                    iconColor: Colors.green,
                    onTap: () {
                      onNavigate(1); // pindah ke Cart Page
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.help,
                    title: 'Pusat Bantuan',
                    iconColor: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HelpCenterPage()),
                      );
                    },
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildMenuTile({
  required IconData icon,
  required String title,
  required Color iconColor,
  Widget? trailing,
  VoidCallback? onTap,
  bool isFirst = false,
  bool isLast = false,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(15) : Radius.zero,
        bottom: isLast ? const Radius.circular(15) : Radius.zero,
      ),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: trailing ?? 
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.chevron_right,
            size: 18,
            color: Colors.grey,
          ),
        ),
      onTap: onTap,
    ),
  );
}

Widget _buildDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.only(left: 72),
    color: Colors.grey[100],
  );
}

//isi profil----------------------

Widget buildPaymentPage() {
  String selectedMethod = 'COD';
  List<String> paymentMethods = ['COD', 'Transfer Bank', 'E-Wallet'];
  int diskon = 0; 
  int totalItems = cart.fold(0, (sum, item) => sum + item.quantity);
  int totalHarga = cart.fold(
    0,
    (sum, item) => sum + item.price * item.quantity,
  );
  int totalBayar = totalHarga - diskon;

  return StatefulBuilder(
    builder: (context, setState) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
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
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order 
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.shopping_bag, color: Colors.blue[600], size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Ringkasan Pesanan ($totalItems item)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Products List
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cart.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Colors.grey[200],
                        ),
                        itemBuilder: (context, index) {
                          var item = cart[index];
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Product Image
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/${item.name.toLowerCase().replaceAll(' ', '_')}.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[200],
                                          child: Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey[400],
                                            size: 20,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(width: 12),

                                // Product Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      if (item.selectedVariant != null)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.orange[50],
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(
                                              color: Colors.orange[200]!,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Text(
                                            'Varian: ${item.selectedVariant}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.orange[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            'Rp ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[600],
                                            ),
                                          ),
                                          Text(
                                            ' x ${item.quantity}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Item Total
                                Text(
                                  'Rp ${(item.price * item.quantity).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20),

                    // Payment Method
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.payment, color: Colors.green[600], size: 24),
                              SizedBox(width: 12),
                              Text(
                                'Metode Pembayaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<String>(
                              value: selectedMethod,
                              isExpanded: true,
                              underline: SizedBox(),
                              items: paymentMethods.map((String value) {
                                IconData icon;
                                Color color;
                                switch (value) {
                                  case 'COD':
                                    icon = Icons.local_shipping;
                                    color = Colors.orange;
                                    break;
                                  case 'Transfer Bank':
                                    icon = Icons.account_balance;
                                    color = Colors.blue;
                                    break;
                                  case 'E-Wallet':
                                    icon = Icons.wallet;
                                    color = Colors.green;
                                    break;
                                  default:
                                    icon = Icons.payment;
                                    color = Colors.grey;
                                }
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Icon(icon, size: 20, color: color),
                                      SizedBox(width: 12),
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedMethod = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Price 
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.receipt_long, color: Colors.purple[600], size: 24),
                              SizedBox(width: 12),
                              Text(
                                'Rincian Pembayaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal ($totalItems item)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                'Rp ${totalHarga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Diskon',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '- Rp ${diskon.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[600],
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[300], height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                'Rp ${totalBayar.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom Payment Button
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => buildSuccessPage(
                            totalBayar,
                            selectedMethod,
                            totalItems,
                            diskon,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_checkout,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Pesan Sekarang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2196F3),
                Color(0xFF0D47A1),
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
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle, 
                  color: Colors.green, 
                  size: 100
                ),
              ),
              
              const SizedBox(height: 30),
              
              Text(
                'Pesanan Anda Berhasil!',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Detail Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Alamat Toko', 'Jl. Letjen Sutoyo, Bantul, Yogyakarta'),
                    _buildDetailRow('Total Pembayaran', 'Rp $totalBayar'),
                    _buildDetailRow('Metode Pembayaran', metodePembayaran),
                    _buildDetailRow('Total Pesanan', '$totalItems item'),
                    _buildDetailRow('Diskon', 'Rp $diskon'),
                    _buildDetailRow('Kode Pesanan', '$kodePesanan'),
                    _buildDetailRow('Nama Pemesan', namaPemesan),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Warning Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'Ambil pesanan dalam 24 jam sebelum kode pesanan kadaluarsa!',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bila pesanan ingin diantar, silahkan konfirmasi melalui chat!',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}