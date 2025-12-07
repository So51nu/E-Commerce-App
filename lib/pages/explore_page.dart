import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// NOTE: To run this code, ensure you have 'cached_network_image: ^3.3.1'
// added to your pubspec.yaml file and run 'flutter pub get'.

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  // Placeholder URLs for "live images" (network images)
  static const List<String> _productImageUrls = [
    'https://picsum.photos/id/237/200/200',
    'https://picsum.photos/id/1084/200/200',
    'https://picsum.photos/id/10/200/200',
    'https://picsum.photos/id/1025/200/200',
    'https://picsum.photos/id/165/200/200',
    'https://picsum.photos/id/1004/200/200',
    'https://picsum.photos/id/1012/200/200',
    'https://picsum.photos/id/100/200/200',
    'https://picsum.photos/id/1016/200/200',
    'https://picsum.photos/id/1018/200/200',
    'https://picsum.photos/id/1020/200/200',
    'https://picsum.photos/id/1021/200/200',
  ];

  static const List<String> _bannerImageUrls = [
    'https://picsum.photos/id/888/800/400',
    'https://picsum.photos/id/889/800/400',
    'https://picsum.photos/id/890/800/400',
    'https://picsum.photos/id/891/800/400',
    'https://picsum.photos/id/892/800/400',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Smart Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products, categories, brands...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
                onChanged: (query) {
                  // implement your search suggestions/autocomplete logic here
                },
              ),
            ),

            // 2. Dynamic Banner Section (Carousel) - NOW WITH NETWORK IMAGES
            SizedBox(
              height: 180,
              child: PageView(
                children: [
                  _bannerItem(_bannerImageUrls[0], 'Latest Offers'),
                  _bannerItem(_bannerImageUrls[1], 'Seasonal Sales'),
                  _bannerItem(_bannerImageUrls[2], 'New Arrivals'),
                  _bannerItem(_bannerImageUrls[3], 'Exclusive Collections'),
                  _bannerItem(_bannerImageUrls[4], 'Limited-time Deals'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // **NEW SECTION (A): Deal of the Day**
            _sectionTitle('⏰ Deal of the Day'),
            _dealOfTheDayCard(context),

            // 3. Popular Categories Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text(
                'Popular Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _categoryItem('Fashion', Icons.checkroom),
                  _categoryItem('Electronics', Icons.electrical_services),
                  _categoryItem('Beauty', Icons.brush),
                  _categoryItem('Home', Icons.chair),
                  _categoryItem('Grocery', Icons.local_grocery_store),
                  _categoryItem('Kids', Icons.child_care),
                  _categoryItem('Sports', Icons.sports_soccer),
                  _categoryItem('Fitness', Icons.fitness_center),
                ],
              ),
            ),

            // **NEW SECTION (B): Shop by Style (Color/Material)**
            _sectionTitle('🎨 Shop by Style'),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _styleChip('Red', Colors.red, Icons.circle),
                  _styleChip('Black', Colors.black, Icons.circle),
                  _styleChip('Denim', Colors.blue, Icons.style),
                  _styleChip('Leather', Colors.brown, Icons.work),
                  _styleChip('Gold', Colors.amber, Icons.star),
                  _styleChip('Cotton', Colors.lightBlue.shade100, Icons.check),
                ],
              ),
            ),


            // 4. Trending Products (Horizontal List) - WITH NETWORK IMAGES
            _sectionTitle('🔥 Trending Products'),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: List.generate(6, (index) => _productCard(index)),
              ),
            ),

            // 5. Personalized Recommendations (Horizontal List) - WITH NETWORK IMAGES
            _sectionTitle('🎯 Personalized Recommendations'),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: List.generate(6, (index) => _productCard(index + 6)),
              ),
            ),

            // **NEW SECTION (C): Loyalty & Rewards**
            _sectionTitle('🎁 Your Loyalty Benefits'),
            _loyaltyCard(context),


            // 6. Featured Brands (Grid or Horizontal)
            _sectionTitle('🛍️ Featured Brands'),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: List.generate(5, (index) => _brandTile(index)),
              ),
            ),

            // 7. Best Deals for You (Horizontal List)
            _sectionTitle('⭐ Best Deals for You'),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: List.generate(6, (index) => _dealCard(index)),
              ),
            ),

            // 8. Explore by Themes (Horizontal Chips)
            _sectionTitle('🧭 Explore by Themes'),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _themeChip('Budget Under ₹499'),
                  _themeChip('Work-from-Home Essentials'),
                  _themeChip('Festive Decor'),
                  _themeChip('Summer Must-Haves'),
                  _themeChip('New in Tech'),
                ],
              ),
            ),

            // 9. Continue Shopping
            _sectionTitle('🧩 Continue Shopping'),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: List.generate(4, (index) => _continueShoppingCard(index)),
              ),
            ),

            // 10. More to Explore Section ("More and More" from last time)
            _sectionTitle('➕ More to Explore'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _exploreMoreCard('Top Sellers by State', Icons.location_on, Colors.lightBlue),
                  const SizedBox(height: 10),
                  _exploreMoreCard('Gifting Ideas for Occasions', Icons.card_giftcard, Colors.pinkAccent),
                  const SizedBox(height: 10),
                  _exploreMoreCard('Customer Stories & Reviews', Icons.rate_review, Colors.amber),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- WIDGET IMPLEMENTATIONS ---

  // Banner Item (Uses Network Image)
  Widget _bannerItem(String imageUrl, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.deepPurple.shade100),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(0, 2))],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(String name, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.deepPurple.shade100,
          child: Icon(icon, size: 28, color: Colors.deepPurple),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  // Product Card (Uses Network Image)
  Widget _productCard(int index) {
    final imageUrl = _productImageUrls[index % _productImageUrls.length];

    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 120,
                color: Colors.deepPurple.shade50,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (context, url, error) => Container(
                height: 120,
                color: Colors.red.shade100,
                child: const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Product $index',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '₹${(index + 1) * 150}',
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _brandTile(int index) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      alignment: Alignment.center,
      child: Text(
        'Brand ${index + 1}',
        style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
      ),
    );
  }


  Widget _dealCard(int index) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Center(
              child: Text(
                'Deal ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Save ${(index + 1) * 10}%',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.deepPurple.shade100,
      ),
    );
  }

  // NEW WIDGET: Style Chip (Color/Material)
  Widget _styleChip(String label, Color color, IconData icon) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }


  Widget _continueShoppingCard(int index) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, color: Colors.teal.shade400, size: 30),
          const SizedBox(height: 6),
          Text(
            'Item ${index + 1}',
            style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _exploreMoreCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Implement navigation logic here
        },
      ),
    );
  }

  // NEW WIDGET: Deal of the Day Card
  Widget _dealOfTheDayCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        color: Colors.red.shade50,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: _productImageUrls[4], // A specific product image
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FLAT 50% OFF!',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      'Luxury Watch Collection',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Ends in 03:45:22',
                          style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.red, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  // NEW WIDGET: Loyalty and Rewards Card
  Widget _loyaltyCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.lightGreen.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.lightGreen.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.card_membership, color: Colors.green, size: 36),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Earn 500 Reward Points!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
                  ),
                  Text(
                    'Join our Premium Club today and unlock exclusive benefits.',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Action to join/view loyalty
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: const Text('Join Now', style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}