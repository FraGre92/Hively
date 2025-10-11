import 'package:flutter/material.dart';

void main() {
  runApp(const HivelyApp());
}

class HivelyApp extends StatelessWidget {
  const HivelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hively',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeTab = 'per-te';
  Set<int> likedPosts = {};
  Set<int> bookmarkedPosts = {};

  void toggleLike(int id) {
    setState(() {
      if (likedPosts.contains(id)) {
        likedPosts.remove(id);
      } else {
        likedPosts.add(id);
      }
    });
  }

  void toggleBookmark(int id) {
    setState(() {
      if (bookmarkedPosts.contains(id)) {
        bookmarkedPosts.remove(id);
      } else {
        bookmarkedPosts.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Notifications
            _buildNotifications(),
            // Tabs
            _buildTabs(),
            // Feed
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: _getFeedData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.red],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'H',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.orange, Colors.red],
                ).createShader(bounds),
                child: const Text(
                  'Hively',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.search, color: Colors.black87),
              const SizedBox(width: 16),
              Stack(
                children: [
                  const Icon(Icons.notifications_outlined, color: Colors.black87),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const Icon(Icons.person_outline, color: Colors.black87),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotifications() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildNotificationCard(
            icon: Icons.star,
            text: '3 nuove recensioni per Rare Beauty che segui',
            color: Colors.orange,
          ),
          const SizedBox(height: 8),
          _buildNotificationCard(
            icon: Icons.auto_awesome,
            text: 'Consigliato: Maybelline BB Cream - Simile a L\'Oréal Skin Tint che hai valutato 4/5',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[50]!, Colors.red[50]!],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          _buildTab('per-te', 'Per Te', Icons.auto_awesome),
          _buildTab('nuovi-arrivi', 'Nuovi', Icons.access_time),
          _buildTab('trending', 'Trending', Icons.trending_up),
        ],
      ),
    );
  }

  Widget _buildTab(String id, String label, IconData icon) {
    final isActive = activeTab == id;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => activeTab = id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? Colors.orange : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? Colors.orange : Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.orange : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getFeedData() {
    if (activeTab == 'per-te') {
      return [
        _buildPostCard(
          id: 1,
          user: 'BeautyAI',
          avatar: '🤖',
          time: '2h',
          title: 'Prodotti "Likewise" per te',
          content: 'Dato che hai amato Charlotte Tilbury Liquid Blush (5⭐), potresti amare anche:',
          products: [
            {'name': 'NYX Sweet Cheeks', 'price': '€12', 'match': '94%', 'rating': 4.3},
            {'name': 'Glossier Cloud Paint', 'price': '€20', 'match': '87%', 'rating': 4.5},
          ],
          likes: 24,
          comments: 8,
        ),
        _buildPostCard(
          id: 2,
          user: 'giulia_makeup',
          avatar: '👩🏻',
          time: '4h',
          verified: true,
          title: 'Tutorial: Look naturale per tutti i giorni',
          content: 'Perfetto per pelle mista come la tua! Prodotti usati:',
          products: [
            {'name': 'L\'Oréal Skin Tint', 'tag': 'Nel tuo "Loved"'},
            {'name': 'Rare Beauty Blush', 'tag': 'Nella tua wishlist'},
          ],
          isTutorial: true,
          duration: '8:30',
          likes: 342,
          comments: 67,
        ),
        _buildPostCard(
          id: 3,
          user: 'Discover Mix',
          avatar: '🔮',
          time: '6h',
          title: 'Esci dalla tua comfort zone',
          content: 'Stili diversi dal tuo solito "natural glam" - ispirati alle tendenze coreane:',
          styles: ['Glass Skin', 'Gradient Lips', 'Straight Brows'],
          likes: 89,
          comments: 23,
        ),
      ];
    } else if (activeTab == 'nuovi-arrivi') {
      return [
        _buildPostCard(
          id: 4,
          user: 'Sephora Italia',
          avatar: '🛍️',
          time: '1h',
          title: 'Novità Fenty Beauty',
          content: 'Nuova collezione Soft\'Lit Foundation - 50 tonalità',
          productRating: 4.2,
          price: '€34',
          likes: 156,
          comments: 34,
        ),
      ];
    } else {
      return [
        _buildPostCard(
          id: 5,
          user: 'TikTok Viral',
          avatar: '📱',
          time: '12h',
          title: '#GlossyLids trend',
          content: 'Il look glossy sulle palpebre sta spopolando! Tutorial più visti:',
          views: '2.3M',
          participation: '+340% questa settimana',
          likes: 1200,
          comments: 234,
        ),
      ];
    }
  }

  Widget _buildPostCard({
    required int id,
    required String user,
    required String avatar,
    required String time,
    String? title,
    String? content,
    List<Map<String, dynamic>>? products,
    List<String>? styles,
    bool verified = false,
    bool isTutorial = false,
    String? duration,
    double? productRating,
    String? price,
    String? views,
    String? participation,
    required int likes,
    required int comments,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.red],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      avatar,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          if (verified) ...[
                            const SizedBox(width: 4),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.notifications_outlined, color: Colors.grey),
              ],
            ),
          ),
          // Content
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          if (content != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Text(
                content,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ),
              ),
            ),
          // Products
          if (products != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: products.map((product) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              if (product['price'] != null)
                                Text(
                                  product['price'] as String,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (product['match'] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Match: ${product['match']}',
                              style: TextStyle(
                                color: Colors.orange[900],
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (product['rating'] != null && product['rating'] is double)
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                product['rating'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        if (product['tag'] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product['tag'] as String,
                              style: TextStyle(
                                color: Colors.orange[900],
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          // Tutorial
          if (isTutorial && duration != null)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[50]!, Colors.red[50]!],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('🎥', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Video Tutorial',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        duration,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Styles
          if (styles != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Wrap(
                spacing: 8,
                children: styles.map((style) {
                  return Chip(
                    label: Text('#$style'),
                    backgroundColor: Colors.orange[100],
                    labelStyle: TextStyle(
                      color: Colors.orange[900],
                      fontSize: 12,
                    ),
                    padding: EdgeInsets.zero,
                  );
                }).toList(),
              ),
            ),
          // Trending stats
          if (views != null && participation != null)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[50]!, Colors.red[50]!],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$views visualizzazioni',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    participation,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          // Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[100]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => toggleLike(id),
                      child: Row(
                        children: [
                          Icon(
                            likedPosts.contains(id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: likedPosts.contains(id)
                                ? Colors.orange
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${likes + (likedPosts.contains(id) ? 1 : 0)}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            color: Colors.grey[600], size: 20),
                        const SizedBox(width: 4),
                        Text('$comments', style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Icon(Icons.share_outlined, color: Colors.grey[600], size: 20),
                  ],
                ),
                InkWell(
                  onTap: () => toggleBookmark(id),
                  child: Icon(
                    bookmarkedPosts.contains(id)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: bookmarkedPosts.contains(id)
                        ? Colors.orange
                        : Colors.grey,
                    size: 20,
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