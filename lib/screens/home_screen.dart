import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import 'cart_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Featured';

  final List<Product> featuredProducts = [
    Product(
      id: 'f1',
      name: 'Air Jordan 1 Mid',
      price: 129.99,
      image: 'assets/images/airjordan1mid.jpg',
      category: 'Featured',
    ),
    Product(
      id: 'f2',
      name: 'Jordan Luka 5 PF',
      price: 89.99,
      image: 'assets/images/jordanluka5pf.jpg',
      category: 'Featured',
    ),
    Product(
      id: 'f3',
      name: 'Nike Structure 26',
      price: 79.99,
      image: 'assets/images/nikestructure26.jpg',
      category: 'Featured',
    ),
    Product(
      id: 'f4',
      name: 'Air Jordan 4 Retro OG FC',
      price: 179.99,
      image: 'assets/images/airjordan4retroogfc.jpg',
      category: 'Featured',
    ),
  ];

  final Map<String, List<Product>> categorizedProducts = {
    'Jordan': [
      Product(
        id: 'j1',
        name: 'Air Jordan 1 Mid',
        price: 129.99,
        image: 'assets/images/airjordan1mid.jpg',
        category: 'Jordan',
      ),
      Product(
        id: 'j2',
        name: 'Air Jordan 1 Mid SE',
        price: 199.99,
        image: 'assets/images/airjordan1midse.jpg',
        category: 'Jordan',
      ),
      Product(
        id: 'j3',
        name: 'Air Jordan 4 Retro OG FC',
        price: 179.99,
        image: 'assets/images/airjordan4retroogfc.jpg',
        category: 'Jordan',
      ),
      Product(
        id: 'j4',
        name: 'Air Jordan 5 Retro OG',
        price: 149.99,
        image: 'assets/images/airjordan5retroog.jpg',
        category: 'Jordan',
      ),
    ],
    'Running': [
      Product(
        id: 'r1',
        name: 'Nike Promina',
        price: 89.99,
        image: 'assets/images/nikepromina.jpg',
        category: 'Running',
      ),
      Product(
        id: 'r2',
        name: 'Nike Structure 26',
        price: 99.99,
        image: 'assets/images/nikestructure26.jpg',
        category: 'Running',
      ),
      Product(
        id: 'r3',
        name: 'Nike Air Winflo 12',
        price: 119.99,
        image: 'assets/images/nikeairwinflo12.jpg',
        category: 'Running',
      ),
      Product(
        id: 'r4',
        name: 'Nike Vaporfly Next  4',
        price: 109.99,
        image: 'assets/images/nikevaporflynext4.jpg',
        category: 'Running',
      ),
    ],
    'Lifestyle': [
      Product(
        id: 'l1',
        name: 'Nike Vomero Plus QS',
        price: 79.99,
        image: 'assets/images/nikevomeroplusqs.jpg',
        category: 'Lifestyle',
      ),
      Product(
        id: 'l2',
        name: 'Nike V5 RNR',
        price: 69.99,
        image: 'assets/images/nikev5rnr.jpg',
        category: 'Lifestyle',
      ),
      Product(
        id: 'l3',
        name: 'Nike SB React Leo',
        price: 89.99,
        image: 'assets/images/nikesbreactleo.jpg',
        category: 'Lifestyle',
      ),
      Product(
        id: 'l4',
        name: 'Air Force 1 07 Tech',
        price: 99.99,
        image: 'assets/images/airforce107tech.jpg',
        category: 'Lifestyle',
      ),
    ],
  };

  List<Product> get displayedProducts {
    if (selectedCategory == 'Featured') return featuredProducts;
    return categorizedProducts[selectedCategory]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartPage()),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          cart.itemCount.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // CATEGORIES
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                ['Featured', 'Jordan', 'Running', 'Lifestyle']
                    .map(
                      (cat) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selectedCategory == cat,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = cat;
                            });
                          },
                          selectedColor: Colors.deepPurple,
                          labelStyle: TextStyle(
                            color:
                                selectedCategory == cat
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 10),
          // GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: displayedProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = displayedProducts[index];

                return Card(
                  color: Colors.deepPurple[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} added to cart'),
                              duration: const Duration(milliseconds: 200),
                            ),
                          );
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
