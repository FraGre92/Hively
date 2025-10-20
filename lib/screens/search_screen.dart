import 'package:flutter/material.dart';
// TODO: Import models quando li crei
// import '../models/product.dart';
// import '../models/user_profile.dart';
// import 'product_detail_screen.dart';

class AppColors {
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color beige = Color(0xFFF5F5DC);
  static const Color lightBeige = Color(0xFFFAF0E6);
  static const Color gold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8B8B8B);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  
  // Modalità ricerca: true = prodotti, false = profili
  bool _isSearchingProducts = true;
  
  // Filtri prodotti (RIMOSSO CAP, spostato in "Dove Comprare")
  String? _selectedSkinType;
  String? _selectedSkinTone;
  String? _selectedPriceRange;
  List<String> _selectedFormulations = [];
  
  // Ordinamento per prodotti
  String _sortBy = 'più recensioni'; // Opzioni: più recensioni, rating, ultimi, primi
  
  // Mostra filtri
  bool _showFilters = false;
  
  // Query ricerca
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isSearchingProducts = _tabController.index == 0;
        _searchQuery = '';
        _searchController.clear();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Ricerca',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              // Tab per switch Prodotti/Profili
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.gold,
                labelColor: AppColors.gold,
                unselectedLabelColor: AppColors.textLight,
                tabs: const [
                  Tab(icon: Icon(Icons.shopping_bag_outlined), text: 'Prodotti'),
                  Tab(icon: Icon(Icons.person_outline), text: 'Profili'),
                ],
              ),
              
              // Barra di ricerca
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: _isSearchingProducts 
                              ? 'Cerca "rossetto rosso", brand...'
                              : 'Cerca profili, influencer...',
                          prefixIcon: Icon(Icons.search, color: AppColors.textLight),
                          filled: true,
                          fillColor: AppColors.lightBeige,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Pulsante filtri (solo per prodotti)
                    if (_isSearchingProducts)
                      IconButton(
                        icon: Icon(
                          _showFilters ? Icons.filter_list : Icons.tune,
                          color: AppColors.gold,
                        ),
                        onPressed: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductsSearch(),
          _buildProfilesSearch(),
        ],
      ),
    );
  }

  // ========================================
  // RICERCA PRODOTTI
  // ========================================
  Widget _buildProductsSearch() {
    return Column(
      children: [
        // Pannello filtri espandibile
        if (_showFilters) _buildFiltersPanel(),
        
        // Ordinamento (sempre visibile quando c'è una ricerca)
        if (_searchQuery.isNotEmpty) _buildSortBar(),
        
        // Sezione "Scopri nuovi stili" (se nessuna ricerca)
        if (_searchQuery.isEmpty)
          _buildDiscoverSection(),
        
        // Risultati ricerca con "Profili più visualizzati" in cima
        Expanded(
          child: _searchQuery.isEmpty
              ? _buildEmptyState()
              : _buildSearchResults(),
        ),
      ],
    );
  }

  // BARRA ORDINAMENTO
  Widget _buildSortBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            'Ordina per:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSortChip('più recensioni'),
                  _buildSortChip('rating'),
                  _buildSortChip('ultimi caricati'),
                  _buildSortChip('primi caricati'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label) {
    final isSelected = _sortBy == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _sortBy = label;
            // TODO: Riordina i risultati in base a _sortBy
          });
        },
        selectedColor: AppColors.gold,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textDark,
          fontSize: 13,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  Widget _buildFiltersPanel() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtri Avanzati',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedSkinType = null;
                    _selectedSkinTone = null;
                    _selectedPriceRange = null;
                    _selectedFormulations.clear();
                  });
                },
                child: Text(
                  'Cancella tutto',
                  style: TextStyle(color: AppColors.gold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Tipo di pelle
          _buildFilterDropdown(
            'Tipo di pelle',
            _selectedSkinType,
            ['Normale', 'Secca', 'Grassa', 'Mista', 'Sensibile'],
            (value) => setState(() => _selectedSkinType = value),
          ),
          
          const SizedBox(height: 12),
          
          // Carnagione
          _buildFilterDropdown(
            'Carnagione',
            _selectedSkinTone,
            ['Molto Chiaro', 'Chiaro', 'Medio', 'Olivastro', 'Scuro', 'Molto Scuro'],
            (value) => setState(() => _selectedSkinTone = value),
          ),
          
          const SizedBox(height: 12),
          
          // Fascia prezzo
          _buildFilterDropdown(
            'Fascia di prezzo',
            _selectedPriceRange,
            ['\$ (0-15€)', '\$\$ (15-40€)', '\$\$\$ (40-80€)', '\$\$\$\$ (80€+)'],
            (value) => setState(() => _selectedPriceRange = value),
          ),
          
          const SizedBox(height: 12),
          
          // Formulazione (chips multiple)
          Text(
            'Formulazione',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Vegan', 'Cruelty Free', 'Senza Profumo', 'Bio', 'Senza Parabeni']
                .map((formulation) {
              final isSelected = _selectedFormulations.contains(formulation);
              return FilterChip(
                label: Text(formulation),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFormulations.add(formulation);
                    } else {
                      _selectedFormulations.remove(formulation);
                    }
                  });
                },
                selectedColor: AppColors.gold,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.lightBeige,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: value,
            hint: Text('Seleziona $label'),
            isExpanded: true,
            underline: Container(),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverSection() {
    return Container(
      height: 200,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '✨ Scopri nuovi stili',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.beige,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.face_retouching_natural, 
                           size: 50, 
                           color: AppColors.gold),
                      const SizedBox(height: 8),
                      Text(
                        'Look ${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: AppColors.textLight),
          const SizedBox(height: 16),
          Text(
            'Cerca prodotti cosmetici',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Prova "rossetto rosso", "fondotinta"\no cerca per brand',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // RISULTATI CON PROFILI PIÙ VISUALIZZATI IN CIMA
  Widget _buildSearchResults() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        // SEZIONE: Profili più visualizzati per questa ricerca
        _buildTopProfilesSection(),
        
        const SizedBox(height: 16),
        
        // SEZIONE: Prodotti con più recensioni (o ordinati secondo _sortBy)
        _buildProductsSection(),
      ],
    );
  }

  Widget _buildTopProfilesSection() {
    final topProfiles = _getMockTopProfiles();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.whatshot, color: AppColors.gold, size: 20),
              const SizedBox(width: 8),
              Text(
                'Profili più visualizzati per "$_searchQuery"',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Lista profili top
          ...topProfiles.map((profile) => _buildMiniProfileCard(profile)),
        ],
      ),
    );
  }

  Widget _buildMiniProfileCard(Map<String, dynamic> profile) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Apertura profilo: ${profile['username']}'),
            backgroundColor: AppColors.gold,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightBeige,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.beige,
              child: Icon(Icons.person, size: 20, color: AppColors.gold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile['username'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    '${profile['type']} · ${profile['views']} visualizzazioni',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsSection() {
    // TODO: In futuro, sostituisci con FutureBuilder che chiama l'API
    // e ordina secondo _sortBy
    final products = _getMockProducts();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            'Prodotti ($_sortBy)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        ...products.map((product) => _buildProductCard(product)),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        // TODO: Naviga alla pagina dettaglio
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProductDetailScreen(product: product),
        //   ),
        // );
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Apertura dettaglio: ${product['name']}'),
            backgroundColor: AppColors.gold,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Immagine prodotto
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.beige,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.shopping_bag,
                size: 40,
                color: AppColors.gold,
              ),
            ),
            
            // Info prodotto
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome + Brand
                    Text(
                      product['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product['brand'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Rating + Numero recensioni
                    Row(
                      children: [
                        ...List.generate(5, (i) {
                          return Icon(
                            i < product['rating'] ? Icons.star : Icons.star_border,
                            size: 16,
                            color: AppColors.gold,
                          );
                        }),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']}.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product['reviewsCount']} recensioni)',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Fascia prezzo + Prezzo reale
                    Row(
                      children: [
                        Text(
                          product['priceRange'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGold,
                          ),
                        ),
                        Text(
                          ' · ',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textLight,
                          ),
                        ),
                        Text(
                          product['actualPrice'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Icona freccia
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================
  // RICERCA PROFILI
  // ========================================
  Widget _buildProfilesSearch() {
    if (_searchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: AppColors.textLight),
            const SizedBox(height: 16),
            Text(
              'Cerca profili',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Trova influencer, make-up artist\ne altri appassionati di beauty',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    // TODO: FutureBuilder con API reale
    final mockProfiles = _getMockProfiles();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockProfiles.length,
      itemBuilder: (context, index) {
        final profile = mockProfiles[index];
        return _buildProfileCard(profile);
      },
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> profile) {
    return InkWell(
      onTap: () {
        // TODO: Naviga al profilo utente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Apertura profilo: ${profile['username']}'),
            backgroundColor: AppColors.gold,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.beige,
              child: Icon(Icons.person, size: 30, color: AppColors.gold),
            ),
            
            const SizedBox(width: 16),
            
            // Info profilo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile['username'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    profile['type'],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.gold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${profile['reviews']} recensioni · ${profile['followers']} follower',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            
            // Pulsante segui
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.gold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: Text(
                'Segui',
                style: TextStyle(color: AppColors.gold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================
  // MOCK DATA (da sostituire con API reale)
  // ========================================
  
  List<Map<String, dynamic>> _getMockTopProfiles() {
    // TODO: API che ritorna profili più visualizzati per la query di ricerca
    return [
      {
        'username': '@giulia_makeup_pro',
        'type': 'Make-up Artist',
        'views': '12.5K',
      },
      {
        'username': '@rossetti_lover',
        'type': 'Influencer',
        'views': '8.3K',
      },
    ];
  }
  
  List<Map<String, dynamic>> _getMockProducts() {
    // TODO: Sostituisci con chiamata API
    // Ordina secondo _sortBy:
    // - 'più recensioni': ordina per reviewsCount DESC
    // - 'rating': ordina per rating DESC
    // - 'ultimi caricati': ordina per createdAt DESC
    // - 'primi caricati': ordina per createdAt ASC
    
    return [
      {
        'id': '1',
        'name': 'Rossetto Matte Long-Lasting',
        'brand': 'Maybelline',
        'rating': 4,
        'priceRange': '\$\

  List<Map<String, dynamic>> _getMockProfiles() {
    // TODO: Sostituisci con chiamata API
    return [
      {
        'id': '1',
        'username': '@makeup_artist_pro',
        'type': 'Make-up Artist',
        'reviews': 156,
        'followers': '12.5K',
        'avatarUrl': '',
      },
      {
        'id': '2',
        'username': '@beauty_influencer',
        'type': 'Influencer',
        'reviews': 89,
        'followers': '45.2K',
        'avatarUrl': '',
      },
      {
        'id': '3',
        'username': '@skincare_lover',
        'type': 'Utente',
        'reviews': 34,
        'followers': '892',
        'avatarUrl': '',
      },
    ];
  }
},
        'actualPrice': '€25.99',
        'imageUrl': '',
        'reviewsCount': 1234,
      },
      {
        'id': '2',
        'name': 'Lip Color Rich Rosso',
        'brand': 'L\'Oréal',
        'rating': 5,
        'priceRange': '\$\

  List<Map<String, dynamic>> _getMockProfiles() {
    // TODO: Sostituisci con chiamata API
    return [
      {
        'id': '1',
        'username': '@makeup_artist_pro',
        'type': 'Make-up Artist',
        'reviews': 156,
        'followers': '12.5K',
        'avatarUrl': '',
      },
      {
        'id': '2',
        'username': '@beauty_influencer',
        'type': 'Influencer',
        'reviews': 89,
        'followers': '45.2K',
        'avatarUrl': '',
      },
      {
        'id': '3',
        'username': '@skincare_lover',
        'type': 'Utente',
        'reviews': 34,
        'followers': '892',
        'avatarUrl': '',
      },
    ];
  }
},
        'actualPrice': '€19.90',
        'imageUrl': '',
        'reviewsCount': 892,
      },
      {
        'id': '3',
        'name': 'Red Lipstick Classic',
        'brand': 'NYX',
        'rating': 4,
        'priceRange': '\

  List<Map<String, dynamic>> _getMockProfiles() {
    // TODO: Sostituisci con chiamata API
    return [
      {
        'id': '1',
        'username': '@makeup_artist_pro',
        'type': 'Make-up Artist',
        'reviews': 156,
        'followers': '12.5K',
        'avatarUrl': '',
      },
      {
        'id': '2',
        'username': '@beauty_influencer',
        'type': 'Influencer',
        'reviews': 89,
        'followers': '45.2K',
        'avatarUrl': '',
      },
      {
        'id': '3',
        'username': '@skincare_lover',
        'type': 'Utente',
        'reviews': 34,
        'followers': '892',
        'avatarUrl': '',
      },
    ];
  }
},
        'actualPrice': '€8.90',
        'imageUrl': '',
        'reviewsCount': 567,
      },
      {
        'id': '4',
        'name': 'Rouge Sensation',
        'brand': 'NARS',
        'rating': 5,
        'priceRange': '\$\$\

  List<Map<String, dynamic>> _getMockProfiles() {
    // TODO: Sostituisci con chiamata API
    return [
      {
        'id': '1',
        'username': '@makeup_artist_pro',
        'type': 'Make-up Artist',
        'reviews': 156,
        'followers': '12.5K',
        'avatarUrl': '',
      },
      {
        'id': '2',
        'username': '@beauty_influencer',
        'type': 'Influencer',
        'reviews': 89,
        'followers': '45.2K',
        'avatarUrl': '',
      },
      {
        'id': '3',
        'username': '@skincare_lover',
        'type': 'Utente',
        'reviews': 34,
        'followers': '892',
        'avatarUrl': '',
      },
    ];
  }
},
        'actualPrice': '€45.00',
        'imageUrl': '',
        'reviewsCount': 445,
      },
    ];
  }

  List<Map<String, dynamic>> _getMockProfiles() {
    // TODO: Sostituisci con chiamata API
    return [
      {
        'id': '1',
        'username': '@makeup_artist_pro',
        'type': 'Make-up Artist',
        'reviews': 156,
        'followers': '12.5K',
        'avatarUrl': '',
      },
      {
        'id': '2',
        'username': '@beauty_influencer',
        'type': 'Influencer',
        'reviews': 89,
        'followers': '45.2K',
        'avatarUrl': '',
      },
      {
        'id': '3',
        'username': '@skincare_lover',
        'type': 'Utente',
        'reviews': 34,
        'followers': '892',
        'avatarUrl': '',
      },
    ];
  }
}
