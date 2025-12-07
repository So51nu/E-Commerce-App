import 'package:flutter/material.dart';

// --- COLOR EXTENSION (SAFE SHADING) ---
// This extension adds a safe way to get a slightly darker version of any Color object.
extension ColorExtension on Color {
  Color darkerColor([double amount = .1]) {
    final int r = (red * (1.0 - amount)).round();
    final int g = (green * (1.0 - amount)).round();
    final int b = (blue * (1.0 - amount)).round();
    return Color.fromARGB(alpha, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255));
  }
}

// --- CONSTANTS ---
const MaterialColor kPrimaryColor = Colors.deepPurple;
const MaterialColor kSecondaryColor = Colors.amber;
const MaterialColor kGamificationColor = Colors.teal;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // 1. Unique Collapsing Header (SliverAppBar)
          _buildSliverAppBar(context),

          // 2. Main Content (SliverList)
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Quick Metrics Section (Orders, Points, Wishlist)
                _buildMetricCards(),

                // 3. Status & Badges
                _buildSectionTitle('🏅 Your Quantum Status'),
                _buildStatusBadges(),

                const Divider(indent: 16, endIndent: 16, height: 20),

                // 4. Personalized Settings List
                _buildSectionTitle('⚙️ Smart Management'),
                _buildCustomTile(
                  icon: Icons.notifications_active_rounded,
                  title: 'Notification Hub',
                  subtitle: 'Manage alerts and push preferences',
                  color: Colors.pink,
                  onTap: () {},
                ),
                _buildCustomTile(
                  icon: Icons.security_rounded,
                  title: 'Account Security',
                  subtitle: 'Change password & setup 2FA',
                  color: Colors.blue,
                  onTap: () {},
                ),

                // 5. Data & History
                _buildSectionTitle('📊 Data & History'),
                _buildCustomTile(
                  icon: Icons.history_toggle_off_rounded,
                  title: 'Recently Viewed',
                  subtitle: 'Jump back to products you checked',
                  color: Colors.orange,
                  onTap: () {},
                ),
                _buildCustomTile(
                  icon: Icons.cloud_download_rounded,
                  title: 'Export My Data',
                  subtitle: 'Download order history and reviews',
                  color: Colors.green,
                  onTap: () {},
                ),

                const SizedBox(height: 30),

                // 6. Logout Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.power_settings_new_rounded, color: Colors.white),
                    label: const Text(
                      'End Session',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET IMPLEMENTATIONS ---

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: kPrimaryColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text('Quantum User', style: TextStyle(color: Colors.white, fontSize: 18)),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kPrimaryColor.shade800, kPrimaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50), // Space for status bar
              // User Avatar
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.rocket_launch_rounded, size: 50, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),
              const Text(
                'Welcome, Sonu Yadav !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 4),
              // Gamified User Level and Progress
              _buildLevelProgress(context),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_note, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildLevelProgress(BuildContext context) {
    const double progressValue = 0.75; // 75% progress
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Level 5: Star Gazer', style: TextStyle(color: kSecondaryColor.shade100, fontSize: 13)),
              Text('${(progressValue * 100).toInt()}%', style: TextStyle(color: kSecondaryColor.shade100, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: kSecondaryColor.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(kSecondaryColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCards() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _metricCard('12', 'Total Orders', Icons.shopping_bag_rounded, kGamificationColor),
          _metricCard('1,450', 'Loyalty Points', Icons.stars_rounded, kSecondaryColor),
          _metricCard('7', 'Items in Cart', Icons.shopping_cart_rounded, Colors.pink.shade400),
        ],
      ),
    );
  }

  Widget _metricCard(String value, String label, IconData icon, Color color) {
    return Card(
      elevation: 4,
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color.darkerColor(0.2))),
              Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildStatusBadges() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _badgeItem('Free Shipping', Icons.local_shipping_rounded, Colors.indigo),
          _badgeItem('Priority Support', Icons.support_agent_rounded, Colors.green),
          _badgeItem('Birthday Gift', Icons.cake_rounded, Colors.pink),
        ],
      ),
    );
  }

  Widget _badgeItem(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildCustomTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: color),
        onTap: onTap,
      ),
    );
  }
}