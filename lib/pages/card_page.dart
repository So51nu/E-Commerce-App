// card_page.dart - Complete E-Commerce Mixed Card Page (Grid + List + Horizontal)
// All features mixed: Catalog Grid + Cart List + Recommended Horizontal Cards

import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int cartCount = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          'Shop',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: Colors.deepPurple,
          tabs: const [
            Tab(text: 'Catalog'),
            Tab(text: 'Cart'),
            Tab(text: 'Recommended'),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => _tabController.animateTo(1),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _CatalogGrid(), // Grid layout
          _CartList(),    // Vertical list with image left
          _RecommendedHorizontal(), // Horizontal scroll
        ],
      ),
    );
  }
}

// 1. CATALOG GRID (2-column product grid)
class _CatalogGrid extends StatelessWidget {
  const _CatalogGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _catalogProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = _catalogProducts[index];
        return _GridProductCard(product: product);
      },
    );
  }
}

class _GridProductCard extends StatefulWidget {
  final Product product;
  const _GridProductCard({required this.product});

  @override
  State<_GridProductCard> createState() => _GridProductCardState();
}

class _GridProductCardState extends State<_GridProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return GestureDetector(
      onTap: () {
        // Navigate to product details
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('View ${p.name}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
                  ),
                  if (p.discountPercent != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${p.discountPercent}% OFF',
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 24,
                      ),
                      onPressed: () => setState(() => isFavorite = !isFavorite),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14), maxLines: 2),
                  const SizedBox(height: 4),
                  Text(p.brand, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('₹${p.price}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                      const SizedBox(width: 8),
                      Text('₹${p.oldPrice}', style: TextStyle(color: Colors.grey.shade500, decoration: TextDecoration.lineThrough)),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' ${p.rating}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${p.name} added to cart'))),
                      child: const Text('Add to Cart', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. CART LIST (Vertical list - image left, details right, qty +/-, delete)
class _CartList extends StatefulWidget {
  const _CartList();

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _cartItems.length,
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return _CartItemTile(item: item);
      },
    );
  }
}

class _CartItemTile extends StatefulWidget {
  final CartItem item;
  const _CartItemTile({required this.item});

  @override
  State<_CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<_CartItemTile> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.shopping_bag, size: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Text(item.brand, style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 8),
                  Text('₹${(item.price * quantity).toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // Quantity
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                            ),
                            Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () => setState(() => quantity++),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Delete
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Item removed from cart')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. RECOMMENDED HORIZONTAL SCROLL
class _RecommendedHorizontal extends StatelessWidget {
  const _RecommendedHorizontal();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Recommended for you',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _recommendedProducts.length,
            itemBuilder: (context, index) {
              final product = _recommendedProducts[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 16),
                child: _HorizontalProductCard(product: product),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HorizontalProductCard extends StatelessWidget {
  final Product product;
  const _HorizontalProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600), maxLines: 1),
                Text('₹${product.price}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                    onPressed: () {},
                    child: const Text('Quick Add', style: TextStyle(fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// DATA MODELS
class Product {
  final String name, brand, imageUrl;
  final double price, oldPrice, rating;
  final int? discountPercent;

  Product({
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.rating,
    this.discountPercent,
  });
}

class CartItem {
  final String name, brand, imageUrl;
  final double price;

  CartItem({required this.name, required this.brand, required this.imageUrl, required this.price});
}

// SAMPLE DATA
final List<Product> _catalogProducts = [
  Product(name: 'AirPods Pro', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300', price: 24900, oldPrice: 29900, rating: 4.8, discountPercent: 17),
  Product(name: 'iPhone 15 Pro', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1695906323540-a814279a4581?w=300', price: 99900, oldPrice: 119900, rating: 4.9),
  Product(name: 'MacBook Air M2', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', price: 112900, oldPrice: 129900, rating: 4.7),
  Product(name: 'Samsung Galaxy S24', brand: 'Samsung', imageUrl: 'https://images.unsplash.com/photo-1701643663251-640570a61e52?w=300', price: 79900, oldPrice: 89900, rating: 4.6),
  Product(name: 'Sony WH-1000XM5', brand: 'Sony', imageUrl: 'https://images.unsplash.com/photo-1613427160424-83864886e907?w=300', price: 34900, oldPrice: 39900, rating: 4.8),
  Product(name: 'Nike Air Max', brand: 'Nike', imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300', price: 12900, oldPrice: 15900, rating: 4.5),
];

final List<CartItem> _cartItems = [
  CartItem(name: 'AirPods Pro', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=80', price: 24900),
  CartItem(name: 'iPhone 15 Pro', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1695906323540-a814279a4581?w=80', price: 99900),
  CartItem(name: 'MacBook Air M2', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=80', price: 112900),
];

final List<Product> _recommendedProducts = [
  Product(name: 'Apple Watch Ultra', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1664881156498-b5aa14a5290f?w=200', price: 79900, oldPrice: 89900, rating: 4.7),
  Product(name: 'iPad Air M2', brand: 'Apple', imageUrl: 'https://images.unsplash.com/photo-1721040706757-4fa4f443c4f5?w=200', price: 59900, oldPrice: 69900, rating: 4.8),
];
