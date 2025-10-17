import 'package:flutter/material.dart';

// COLORI TEMA BEIGE/GOLD/IVORY
class AppColors {
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color beige = Color(0xFFF5F5DC);
  static const Color lightBeige = Color(0xFFFAF0E6);
  static const Color gold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8B8B8B);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // DATI UTENTE (poi verranno da database)
  String _userName = 'Maria Rossi';
  String _username = '@mariarossi';
  String _bio = 'Beauty enthusiast 💄 | Skincare lover 🌸';
  int _postsCount = 24;
  int _followersCount = 1234;
  int _followingCount = 567;
  
  // IMPOSTAZIONI PRIVACY
  bool _savedPublic = true; // Salvati pubblici o privati
  bool _skinInfoPublic = true; // Info pelle pubbliche o private
  
  // INFO PELLE
  String _skinType = 'Mista';
  String _skinTone = 'Medio';
  String _undertone = 'Caldo';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: AppColors.ivory,
              elevation: 0,
              pinned: true,
              floating: true,
              expandedHeight: 380,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildProfileHeader(),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.menu, color: AppColors.textDark),
                  onPressed: () => _showMenuBottomSheet(context),
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.gold,
                  labelColor: AppColors.darkGold,
                  unselectedLabelColor: AppColors.textLight,
                  tabs: const [
                    Tab(icon: Icon(Icons.grid_on), text: 'MAKEUP'),
                    Tab(icon: Icon(Icons.star_border), text: 'RECENSIONI'),
                    Tab(icon: Icon(Icons.bookmark_border), text: 'SALVATI'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildMakeupGrid(),
            _buildReviewsGrid(),
            _buildSavedGrid(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Mostra opzioni: carica makeup, scrivi recensione
          _showAddContentSheet(context);
        },
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: AppColors.ivory,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 60),
          
          // FOTO PROFILO
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.beige,
                  child: Icon(Icons.person, size: 50, color: AppColors.gold),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Cambia foto profilo
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.ivory, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // NOME E USERNAME
          Text(
            _userName,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          Text(
            _username,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // BIO
          Text(
            _bio,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // INFO PELLE (se pubbliche)
          if (_skinInfoPublic) _buildSkinInfo(),
          
          const SizedBox(height: 16),
          
          // STATISTICHE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(_postsCount.toString(), 'Post'),
              Container(width: 1, height: 30, color: AppColors.beige),
              _buildStatItem(_followersCount.toString(), 'Follower'),
              Container(width: 1, height: 30, color: AppColors.beige),
              _buildStatItem(_followingCount.toString(), 'Seguiti'),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // PULSANTI AZIONE
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _editProfile(context),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Modifica Profilo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // Apri chat
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.beige,
                  foregroundColor: AppColors.textDark,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.chat_bubble_outline),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // Apri carrello
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.beige,
                  foregroundColor: AppColors.textDark,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkinInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBeige,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.beige, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSkinInfoItem(Icons.face, _skinType),
          Container(width: 1, height: 30, color: AppColors.beige),
          _buildSkinInfoItem(Icons.palette, _skinTone),
          Container(width: 1, height: 30, color: AppColors.beige),
          _buildSkinInfoItem(Icons.brush, _undertone),
        ],
      ),
    );
  }

  Widget _buildSkinInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.gold),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }

  // TAB 1: MAKEUP GRID
  Widget _buildMakeupGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 24,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Apri dettaglio makeup con prodotti taggati
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.beige,
              border: Border.all(color: AppColors.lightBeige, width: 0.5),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(Icons.face_retouching_natural, 
                     size: 40, 
                     color: AppColors.textLight.withOpacity(0.3)),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.local_offer, size: 10, color: Colors.white),
                        SizedBox(width: 2),
                        Text('5', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // TAB 2: RECENSIONI GRID
  Widget _buildReviewsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Apri recensione completa
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.beige, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.beige.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Foto prodotto o swatch
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightBeige,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 50,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
                ),
                // Info recensione
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome Prodotto',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            ...List.generate(5, (i) => Icon(
                              i < 4 ? Icons.star : Icons.star_border,
                              size: 14,
                              color: AppColors.gold,
                            )),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Review preview text...',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // TAB 3: SALVATI GRID
  Widget _buildSavedGrid() {
    // Controlla privacy
    if (!_savedPublic) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 60, color: AppColors.textLight),
            const SizedBox(height: 16),
            Text(
              'Salvati privati',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Solo tu puoi vedere questi contenuti',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.beige, width: 1),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBeige,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Icon(Icons.bookmark, size: 40, color: AppColors.gold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Prodotto Salvato',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.ivory,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.beige,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Modifica Profilo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 24),
                
                // FORM MODIFICA
                _buildEditField('Nome', _userName),
                _buildEditField('Username', _username),
                _buildEditField('Bio', _bio, maxLines: 3),
                
                const SizedBox(height: 24),
                Text(
                  'Info Pelle',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                _buildEditField('Tipo di pelle', _skinType),
                _buildEditField('Incarnato', _skinTone),
                _buildEditField('Sottotono', _undertone),
                
                const SizedBox(height: 24),
                Text(
                  'Privacy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                
                SwitchListTile(
                  title: const Text('Info pelle pubbliche'),
                  subtitle: const Text('Mostra tipo di pelle, incarnato e sottotono'),
                  value: _skinInfoPublic,
                  activeColor: AppColors.gold,
                  onChanged: (value) {
                    setState(() => _skinInfoPublic = value);
                  },
                ),
                
                SwitchListTile(
                  title: const Text('Salvati pubblici'),
                  subtitle: const Text('Gli altri possono vedere i tuoi prodotti salvati'),
                  value: _savedPublic,
                  activeColor: AppColors.gold,
                  onChanged: (value) {
                    setState(() => _savedPublic = value);
                  },
                ),
                
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Profilo aggiornato!'),
                          backgroundColor: AppColors.gold,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Salva Modifiche', 
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditField(String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: TextEditingController(text: value),
        maxLines: maxLines,
        style: TextStyle(color: AppColors.textDark),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.textLight),
          filled: true,
          fillColor: AppColors.lightBeige,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.gold, width: 2),
          ),
        ),
      ),
    );
  }

  void _showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.ivory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(Icons.settings, 'Impostazioni', () {}),
            _buildMenuItem(Icons.qr_code, 'QR Code', () {}),
            _buildMenuItem(Icons.archive, 'Archivio', () {}),
            _buildMenuItem(Icons.history, 'Cronologia', () {}),
            const Divider(),
            _buildMenuItem(Icons.logout, 'Logout', () {}, isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : AppColors.textDark),
      title: Text(
        label,
        style: TextStyle(
          color: isDestructive ? Colors.red : AppColors.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showAddContentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.ivory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cosa vuoi aggiungere?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 20),
            _buildAddOption(
              Icons.face_retouching_natural,
              'Carica Makeup',
              'Condividi il tuo look con i prodotti usati',
              () {},
            ),
            const SizedBox(height: 12),
            _buildAddOption(
              Icons.rate_review,
              'Scrivi Recensione',
              'Recensisci un prodotto che hai provato',
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.lightBeige,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.beige),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

// Helper per TabBar sticky
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.ivory,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
