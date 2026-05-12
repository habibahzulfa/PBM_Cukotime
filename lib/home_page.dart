import 'package:flutter/material.dart';

import 'api_services.dart';
import 'models.dart';
import 'submit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];

  bool isLoading = false;

  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final descController = TextEditingController();

  Future loadProducts() async {
    products = await ApiService.getProducts();

    setState(() {});
  }

  Future addProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Semua field wajib diisi')));

      return;
    }

    setState(() {
      isLoading = true;
    });

    ProductModel product = ProductModel(
      name: nameController.text,

      price: priceController.text,

      description: descController.text,
    );

    bool success = await ApiService.addProduct(product);

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pop(context);

      nameController.clear();
      priceController.clear();
      descController.clear();

      await loadProducts();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Produk berhasil ditambahkan')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menambahkan produk')));
    }
  }

  @override
  void initState() {
    super.initState();

    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F1E5),

      appBar: AppBar(
        backgroundColor: Color(0xff8B5E3C),

        elevation: 0,

        toolbarHeight: 0,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff8B5E3C),

        child: Icon(Icons.add, color: Colors.white),

        onPressed: () {
          showDialog(
            context: context,

            builder: (_) {
              return AlertDialog(
                backgroundColor: Color(0xffFFFDF8),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),

                title: Text(
                  'Tambah Pempek',

                  style: TextStyle(
                    color: Color(0xff5C3B28),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      TextField(
                        controller: nameController,

                        decoration: InputDecoration(
                          hintText: 'Nama Pempek',

                          filled: true,

                          fillColor: Color(0xffF7F1E5),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      TextField(
                        controller: priceController,

                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          hintText: 'Harga',

                          filled: true,

                          fillColor: Color(0xffF7F1E5),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      TextField(
                        controller: descController,

                        maxLines: 3,

                        decoration: InputDecoration(
                          hintText: 'Deskripsi',

                          filled: true,

                          fillColor: Color(0xffF7F1E5),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: Text('Batal', style: TextStyle(color: Colors.brown)),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8B5E3C),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    onPressed: addProduct,

                    child: isLoading
                        ? SizedBox(
                            height: 18,
                            width: 18,

                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text('Simpan', style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          );
        },
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,

            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),

            decoration: BoxDecoration(
              color: Color(0xff8B5E3C),

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),

                bottomRight: Radius.circular(30),
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  'Daftar Produk Pempek',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  'Kelola katalog pempekmu',

                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              color: Color(0xff8B5E3C),

              onRefresh: loadProducts,

              child: ListView.builder(
                padding: EdgeInsets.all(16),

                itemCount: products.length,

                itemBuilder: (context, index) {
                  final product = products[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 16),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(22),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),

                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),

                      leading: Container(
                        height: 55,
                        width: 55,

                        decoration: BoxDecoration(
                          color: Color(0xffF7E6D5),

                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Icon(
                          Icons.lunch_dining,
                          color: Color(0xff8B5E3C),
                          size: 28,
                        ),
                      ),

                      title: Text(
                        product.name,

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff5C3B28),
                        ),
                      ),

                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),

                        child: Text(
                          product.description,

                          style: TextStyle(color: Colors.brown.shade400),
                        ),
                      ),

                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xff8B5E3C),

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Text(
                          'Rp ${product.price}',

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),

            child: SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5C3B28),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                icon: Icon(Icons.upload, color: Colors.white),

                label: Text(
                  'Submit GitHub',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                onPressed: () {
                  if (products.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tambahkan produk terlebih dahulu'),
                      ),
                    );

                    return;
                  }

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) => SubmitPage(product: products.first),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
