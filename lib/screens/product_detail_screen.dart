// lib/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
// TODO: Uncomment quando crei i models
// import '../models/product.dart';
// import '../models/review.dart';

class AppColors {
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color beige = Color(0xFFF5F5DC);
  static const Color lightBeige = Color(0xFFFAF0E6);
  static const Color gold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8B8B8B);
}

class ProductDetailScreen extends StatefulWidget {
  // final Product product; // TODO: Uncomment
  final Map<String, dynamic> product; // Temporary mock
  
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSaved = false;
  String? _selectedPostalCode;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: CustomScrollView(
        slivers: [
          // AppBar con immagine prodotto
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back, color: AppColors.textDark),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: _isSaved ? AppColors.gold : AppColors.textDark,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isSaved = !_isSaved;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isSaved ? 'Prodotto salvato!' : 'Rimosso dai salvati'),
                      backgroundColor: AppColors.gold,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(Icons.share, color: AppColors.textDark),
                ),
                onPressed: () {
                  // TODO: Implementa condivisione
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.beige,
                child: Center(
                  child: Icon(
                    Icons.shopping_bag,
                    size: 100,
                    color: AppColors.gold.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          
          // Contenuto principale
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info prodotto principale
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand
                        Text(
                          widget.product['brand'],
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                        // Nome prodotto
                        Text(
                          widget.product['name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Rating e recensioni
                        Row(
                          children: [
                            ...List.generate(5, (i) {
                              return Icon(
                                i < widget.product['rating'] 
                                    ? Icons.star 
                                    : Icons.star_border,
                                size: 20,
                                color: AppColors.gold,
                              );
                            }),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.product['rating']}.0',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${_getMockReviews().length} recensioni)',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Fascia prezzo + Prezzo reale
                        Row(
                          children: [
                            Text(
                              widget.product['priceRange'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGold,
                              ),
                            ),
                            Text(
                              ' · ',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textLight,
                              ),
                            ),
                            Text(
                              widget.product['actualPrice'] ?? '€25.99',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Tags (Vegan, Cruelty-free, ecc.)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ['Vegan', 'Cruelty Free', 'Dermatologicamente testato']
                              .map((tag) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBeige,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: AppColors.beige),
                                    ),
                                    child: Text(
                                      tag,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textDark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  
                  const Divider(height: 1),
                  
                  // Tab bar
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.gold,
                    labelColor: AppColors.gold,
                    unselectedLabelColor: AppColors.textLight,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'Dove Comprare'),
                      Tab(text: 'Recensioni'),
                      Tab(text: 'Simili'),
                      Tab(text: 'Chi lo usa'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Tab content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWhereTooBuyTab(),
                _buildReviewsTab(),
                _buildSimilarProductsTab(),
                _buildWhoUsesItTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // TAB 1: DOVE COMPRARE
  Widget _buildWhereTooBuyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input CAP
          TextField(
            decoration: InputDecoration(
              labelText: 'Inserisci il tuo CAP',
              hintText: 'es. 20900',
              prefixIcon: Icon(Icons.location_on, color: AppColors.gold),
              filled: true,
              fillColor: AppColors.lightBeige,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _selectedPostalCode = value;
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          // Negozi online
          Text(
            '🛒 Acquista Online',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          
          ..._getMockOnlineStores().map((store) => _buildStoreCard(store, isOnline: true)),
          
          const SizedBox(height: 24),
          
          // Negozi fisici
          Text(
            '🏪 Negozi Vicini',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedPostalCode != null && _selectedPostalCode!.length >= 5
                ? 'Trovati ${_getMockPhysicalStores().length} negozi vicino a te'
                : 'Inserisci il CAP per vedere i negozi vicini',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 12),
          
          if (_selectedPostalCode != null && _selectedPostalCode!.length >= 5)
            ..._getMockPhysicalStores().map((store) => _buildStoreCard(store, isOnline: false)),
        ],
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store, {required bool isOnline}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isOnline ? Icons.shopping_cart : Icons.store,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                if (!isOnline) ...[
                  Text(
                    '${store['distance']} · ${store['address']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
                Text(
                  store['price'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGold,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 2: RECENSIONI
  Widget _buildReviewsTab() {
    final reviews = _getMockReviews();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header recensione
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.beige,
                    child: Icon(Icons.person, color: AppColors.gold, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          review['date'],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Rating
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        i < review['rating'] ? Icons.star : Icons.star_border,
                        size: 16,
                        color: AppColors.gold,
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Testo recensione
              Text(
                review['content'],
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                  height: 1.5,
                ),
              ),
              
              // Foto recensione (se presenti)
              if (review['hasPhotos']) ...[
                const SizedBox(height: 12),
                Row(
                  children: List.generate(3, (i) {
                    return Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.beige,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.image, color: AppColors.gold),
                    );
                  }),
                ),
              ],
              
              const SizedBox(height: 12),
              
              // Azioni
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_up_outlined, size: 16, color: AppColors.textLight),
                    label: Text(
                      'Utile (${review['likes']})',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.reply, size: 16, color: AppColors.textLight),
                    label: Text(
                      'Rispondi',
                      style: TextStyle(color: AppColors.textLight),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // TAB 3: PRODOTTI SIMILI (DUPES) - RAGGRUPPATI PER FASCIA
  Widget _buildSimilarProductsTab() {
    final similarProducts = _getMockSimilarProducts();
    
    // Raggruppa per fascia di prezzo
    final Map<String, List<Map<String, dynamic>>> groupedByPrice = {
      '\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4.0,
        'priceRange': '\

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
    };
    
    for (var product in similarProducts) {
      final priceRange = product['priceRange'];
      if (groupedByPrice.containsKey(priceRange)) {
        groupedByPrice[priceRange]!.add(product);
      }
    }
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          '💰 Alternative per Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prodotti simili organizzati per fascia di prezzo',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 24),
        
        // Sezione $ (ECONOMICI)
        if (groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'ECONOMICI (0-15€)'),
          ...groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $ (MEDI)
        if (groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'MEDI (15-40€)'),
          ...groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (PREMIUM)
        if (groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'PREMIUM (40-80€)'),
          ...groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (LUSSO)
        if (groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'LUSSO (80€+)'),
          ...groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
        ],
      ],
    );
  }

  Widget _buildPriceGroupHeader(String symbol, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(Map<String, dynamic> product) {
    final isCurrentProduct = product['id'] == widget.product['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentProduct ? AppColors.gold.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentProduct ? AppColors.gold : AppColors.beige,
          width: isCurrentProduct ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Immagine
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: AppColors.gold.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product['brand'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'QUESTO',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.gold),
                    const SizedBox(width: 2),
                    Text(
                      '${product['rating']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['actualPrice'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (!isCurrentProduct)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
},
        'actualPrice': '€4.99',
      },
      {
        'id': '102',
        'name': 'Velvet Matte Lipstick',
        'brand': 'Kiko',
        'rating': 4.5,
        'priceRange': '\

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
    };
    
    for (var product in similarProducts) {
      final priceRange = product['priceRange'];
      if (groupedByPrice.containsKey(priceRange)) {
        groupedByPrice[priceRange]!.add(product);
      }
    }
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          '💰 Alternative per Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prodotti simili organizzati per fascia di prezzo',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 24),
        
        // Sezione $ (ECONOMICI)
        if (groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'ECONOMICI (0-15€)'),
          ...groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $ (MEDI)
        if (groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'MEDI (15-40€)'),
          ...groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (PREMIUM)
        if (groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'PREMIUM (40-80€)'),
          ...groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (LUSSO)
        if (groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'LUSSO (80€+)'),
          ...groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
        ],
      ],
    );
  }

  Widget _buildPriceGroupHeader(String symbol, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(Map<String, dynamic> product) {
    final isCurrentProduct = product['id'] == widget.product['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentProduct ? AppColors.gold.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentProduct ? AppColors.gold : AppColors.beige,
          width: isCurrentProduct ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Immagine
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: AppColors.gold.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product['brand'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'QUESTO',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.gold),
                    const SizedBox(width: 2),
                    Text(
                      '${product['rating']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['actualPrice'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (!isCurrentProduct)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
},
        'actualPrice': '€8.90',
      },
      {
        'id': '1', // Stesso ID del prodotto corrente
        'name': widget.product['name'],
        'brand': widget.product['brand'],
        'rating': widget.product['rating'].toDouble(),
        'priceRange': '\$\

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
    };
    
    for (var product in similarProducts) {
      final priceRange = product['priceRange'];
      if (groupedByPrice.containsKey(priceRange)) {
        groupedByPrice[priceRange]!.add(product);
      }
    }
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          '💰 Alternative per Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prodotti simili organizzati per fascia di prezzo',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 24),
        
        // Sezione $ (ECONOMICI)
        if (groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'ECONOMICI (0-15€)'),
          ...groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $ (MEDI)
        if (groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'MEDI (15-40€)'),
          ...groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (PREMIUM)
        if (groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'PREMIUM (40-80€)'),
          ...groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (LUSSO)
        if (groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'LUSSO (80€+)'),
          ...groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
        ],
      ],
    );
  }

  Widget _buildPriceGroupHeader(String symbol, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(Map<String, dynamic> product) {
    final isCurrentProduct = product['id'] == widget.product['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentProduct ? AppColors.gold.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentProduct ? AppColors.gold : AppColors.beige,
          width: isCurrentProduct ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Immagine
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: AppColors.gold.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product['brand'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'QUESTO',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.gold),
                    const SizedBox(width: 2),
                    Text(
                      '${product['rating']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['actualPrice'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (!isCurrentProduct)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
},
        'actualPrice': widget.product['actualPrice'] ?? '€25.99',
      },
      {
        'id': '103',
        'name': 'Rouge Rich Color',
        'brand': 'L\'Oréal',
        'rating': 4.2,
        'priceRange': '\$\

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
    };
    
    for (var product in similarProducts) {
      final priceRange = product['priceRange'];
      if (groupedByPrice.containsKey(priceRange)) {
        groupedByPrice[priceRange]!.add(product);
      }
    }
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          '💰 Alternative per Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prodotti simili organizzati per fascia di prezzo',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 24),
        
        // Sezione $ (ECONOMICI)
        if (groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'ECONOMICI (0-15€)'),
          ...groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $ (MEDI)
        if (groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'MEDI (15-40€)'),
          ...groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (PREMIUM)
        if (groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'PREMIUM (40-80€)'),
          ...groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (LUSSO)
        if (groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'LUSSO (80€+)'),
          ...groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
        ],
      ],
    );
  }

  Widget _buildPriceGroupHeader(String symbol, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(Map<String, dynamic> product) {
    final isCurrentProduct = product['id'] == widget.product['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentProduct ? AppColors.gold.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentProduct ? AppColors.gold : AppColors.beige,
          width: isCurrentProduct ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Immagine
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: AppColors.gold.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product['brand'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'QUESTO',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.gold),
                    const SizedBox(width: 2),
                    Text(
                      '${product['rating']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['actualPrice'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (!isCurrentProduct)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
},
        'actualPrice': '€19.90',
      },
      {
        'id': '104',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5.0,
        'priceRange': '\$\$\

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
    };
    
    for (var product in similarProducts) {
      final priceRange = product['priceRange'];
      if (groupedByPrice.containsKey(priceRange)) {
        groupedByPrice[priceRange]!.add(product);
      }
    }
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          '💰 Alternative per Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prodotti simili organizzati per fascia di prezzo',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 24),
        
        // Sezione $ (ECONOMICI)
        if (groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'ECONOMICI (0-15€)'),
          ...groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $ (MEDI)
        if (groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'MEDI (15-40€)'),
          ...groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (PREMIUM)
        if (groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'PREMIUM (40-80€)'),
          ...groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (LUSSO)
        if (groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'LUSSO (80€+)'),
          ...groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
        ],
      ],
    );
  }

  Widget _buildPriceGroupHeader(String symbol, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(Map<String, dynamic> product) {
    final isCurrentProduct = product['id'] == widget.product['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentProduct ? AppColors.gold.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentProduct ? AppColors.gold : AppColors.beige,
          width: isCurrentProduct ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Immagine
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: AppColors.gold.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product['brand'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'QUESTO',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.gold),
                    const SizedBox(width: 2),
                    Text(
                      '${product['rating']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['actualPrice'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (!isCurrentProduct)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
},
        'actualPrice': '€45.00',
      },
      {
        'id': '105',
        'name': 'Rouge Allure',
        'brand': 'Chanel',
        'rating': 5.0,
        'priceRange': '\$\$\$\

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
    };
    
    for (var product in similarProducts) {
      final priceRange = product['priceRange'];
      if (groupedByPrice.containsKey(priceRange)) {
        groupedByPrice[priceRange]!.add(product);
      }
    }
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          '💰 Alternative per Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prodotti simili organizzati per fascia di prezzo',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 24),
        
        // Sezione $ (ECONOMICI)
        if (groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'ECONOMICI (0-15€)'),
          ...groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $ (MEDI)
        if (groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'MEDI (15-40€)'),
          ...groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (PREMIUM)
        if (groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'PREMIUM (40-80€)'),
          ...groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (LUSSO)
        if (groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'LUSSO (80€+)'),
          ...groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
        ],
      ],
    );
  }

  Widget _buildPriceGroupHeader(String symbol, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(Map<String, dynamic> product) {
    final isCurrentProduct = product['id'] == widget.product['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentProduct ? AppColors.gold.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentProduct ? AppColors.gold : AppColors.beige,
          width: isCurrentProduct ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Immagine
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: AppColors.gold.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product['brand'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'QUESTO',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.gold),
                    const SizedBox(width: 2),
                    Text(
                      '${product['rating']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['actualPrice'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (!isCurrentProduct)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
},
        'actualPrice': '€85.00',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
      '\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}: [],
    };
    
    for (var product in similarProducts) {
      final priceRange = product['priceRange'];
      if (groupedByPrice.containsKey(priceRange)) {
        groupedByPrice[priceRange]!.add(product);
      }
    }
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Text(
          '💰 Alternative per Budget',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Prodotti simili organizzati per fascia di prezzo',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 24),
        
        // Sezione $ (ECONOMICI)
        if (groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'ECONOMICI (0-15€)'),
          ...groupedByPrice['\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $ (MEDI)
        if (groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'MEDI (15-40€)'),
          ...groupedByPrice['\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (PREMIUM)
        if (groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'PREMIUM (40-80€)'),
          ...groupedByPrice['\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
          const SizedBox(height: 16),
        ],
        
        // Sezione $$ (LUSSO)
        if (groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.isNotEmpty) ...[
          _buildPriceGroupHeader('\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}, 'LUSSO (80€+)'),
          ...groupedByPrice['\$\$\$\

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}]!.map((p) => _buildSimilarProductCard(p)),
        ],
      ],
    );
  }

  Widget _buildPriceGroupHeader(String symbol, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.beige),
      ),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(Map<String, dynamic> product) {
    final isCurrentProduct = product['id'] == widget.product['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentProduct ? AppColors.gold.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentProduct ? AppColors.gold : AppColors.beige,
          width: isCurrentProduct ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Immagine
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 30,
              color: AppColors.gold.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 12),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product['brand'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'QUESTO',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.gold),
                    const SizedBox(width: 2),
                    Text(
                      '${product['rating']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['actualPrice'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (!isCurrentProduct)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
        ],
      ),
    );
  }

  // TAB 4: CHI LO USA
  Widget _buildWhoUsesItTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getMockUsersWhoUse().length,
      itemBuilder: (context, index) {
        final user = _getMockUsersWhoUse()[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.beige,
                child: Icon(Icons.person, color: AppColors.gold, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      user['type'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Vedi Profilo',
                  style: TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom bar con azioni
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Aggiungi al carrello
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Prodotto aggiunto al carrello!'),
                    backgroundColor: AppColors.gold,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Aggiungi al carrello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // TODO: Scrivi recensione
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.rate_review, color: AppColors.gold),
          ),
        ],
      ),
    );
  }

  // ========================================
  // MOCK DATA
  // ========================================
  
  List<Map<String, dynamic>> _getMockOnlineStores() {
    return [
      {'name': 'Amazon', 'price': '€24.99', 'url': ''},
      {'name': 'Sephora', 'price': '€26.50', 'url': ''},
      {'name': 'Douglas', 'price': '€25.90', 'url': ''},
    ];
  }

  List<Map<String, dynamic>> _getMockPhysicalStores() {
    return [
      {
        'name': 'Profumeria Limoni',
        'distance': '1.2 km',
        'address': 'Via Roma 15',
        'price': '€26.00',
      },
      {
        'name': 'Sephora Centro Commerciale',
        'distance': '3.5 km',
        'address': 'Corso Italia 89',
        'price': '€26.50',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockReviews() {
    return [
      {
        'username': '@makeup_lover',
        'date': '2 giorni fa',
        'rating': 5,
        'content': 'Prodotto fantastico! La tenuta è incredibile e il colore è esattamente come in foto. Lo consiglio assolutamente!',
        'hasPhotos': true,
        'likes': 24,
      },
      {
        'username': '@beauty_guru',
        'date': '1 settimana fa',
        'rating': 4,
        'content': 'Molto buono ma un po\' troppo costoso per quello che è. Comunque soddisfatta dell\'acquisto.',
        'hasPhotos': false,
        'likes': 12,
      },
      {
        'username': '@skincare_addict',
        'date': '2 settimane fa',
        'rating': 5,
        'content': 'Perfetto per la mia pelle sensibile! Non irrita e dura tutto il giorno. Texture leggera e facile da applicare.',
        'hasPhotos': true,
        'likes': 18,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockSimilarProducts() {
    return [
      {
        'id': '101',
        'name': 'Rossetto Simile Budget',
        'brand': 'Essence',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
      {
        'id': '102',
        'name': 'Dupe Lusso',
        'brand': 'MAC',
        'rating': 5,
        'priceRange': '\$\$\$ (40-80€)',
      },
      {
        'id': '103',
        'name': 'Alternative Vegana',
        'brand': 'Kiko',
        'rating': 4,
        'priceRange': '\$\$ (15-40€)',
      },
      {
        'id': '104',
        'name': 'Simile Long-Lasting',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\$ (0-15€)',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUsersWhoUse() {
    return [
      {
        'username': '@giulia_makeup',
        'type': 'Influencer',
        'followers': '45.2K',
      },
      {
        'username': '@mua_professional',
        'type': 'Make-up Artist',
        'followers': '12.5K',
      },
      {
        'username': '@beauty_enthusiast',
        'type': 'Utente',
        'followers': '892',
      },
    ];
  }
}
