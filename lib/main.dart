import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/profile_setup_screen.dart';

// COLORI TEMA
class AppColors {
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color beige = Color(0xFFF5F5DC);
  static const Color lightBeige = Color(0xFFFAF0E6);
  static const Color gold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8B8B8B);
}

void main() {
  runApp(const HivelyApp());
}

class HivelyApp extends StatelessWidget {
  const HivelyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hively',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.gold,
        scaffoldBackgroundColor: AppColors.ivory,
        colorScheme: ColorScheme.light(
          primary: AppColors.gold,
          secondary: AppColors.darkGold,
        ),
      ),
      
      // PARTE DAL FLOW COMPLETO DI AUTENTICAZIONE
      home: const SplashScreen(),
      
      // ROUTES per la navigazione
      routes: {
        '/terms': (context) => const TermsScreen(),
        '/auth': (context) => const AuthScreen(),
        '/setup': (context) => const ProfileSetupScreen(),
        '/main': (context) => const MainNavigationScreen(),
      },
    );
  }
}

// ========================================
// NAVIGAZIONE PRINCIPALE (Bottom Nav)
// ========================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Lista di tutte le pagine principali
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AddContentScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
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
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.gold,
          unselectedItemColor: AppColors.textLight,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Cerca',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              activeIcon: Icon(Icons.add_box),
              label: 'Crea',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Notifiche',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profilo',
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// SCREEN PLACEHOLDER (da sostituire con i tuoi veri screen)
// ========================================

// HOME - Feed di makeup e recensioni
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'HIVELY',
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildFeedPost(index);
        },
      ),
    );
  }

  Widget _buildFeedPost(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header post
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.beige,
              child: Icon(Icons.person, color: AppColors.gold),
            ),
            title: Text(
              'Username $index',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('2 ore fa'),
            trailing: const Icon(Icons.more_vert),
          ),
          
          // Immagine makeup
          Container(
            height: 400,
            color: AppColors.beige,
            child: Center(
              child: Icon(
                Icons.face_retouching_natural,
                size: 100,
                color: AppColors.gold.withOpacity(0.3),
              ),
            ),
          ),
          
          // Azioni
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: AppColors.textDark),
                const SizedBox(width: 16),
                Icon(Icons.chat_bubble_outline, color: AppColors.textDark),
                const SizedBox(width: 16),
                Icon(Icons.share_outlined, color: AppColors.textDark),
                const Spacer(),
                Icon(Icons.bookmark_border, color: AppColors.textDark),
              ],
            ),
          ),
          
          // Descrizione
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1,234 likes',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: AppColors.textDark),
                    children: [
                      TextSpan(
                        text: 'username$index ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: 'Nuovo makeup tutorial! 💄✨',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Vedi tutti i 45 commenti',
                  style: TextStyle(color: AppColors.textLight),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// SEARCH - Ricerca prodotti e utenti
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cerca prodotti, utenti, makeup...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: AppColors.textLight),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Container(
            color: AppColors.beige,
            child: Center(
              child: Icon(
                Icons.face_retouching_natural,
                size: 40,
                color: AppColors.gold.withOpacity(0.3),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ADD CONTENT - Crea makeup o recensione
class AddContentScreen extends StatelessWidget {
  const AddContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Crea Contenuto',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCreateOption(
              context,
              Icons.face_retouching_natural,
              'Carica Makeup',
              'Condividi il tuo look',
            ),
            const SizedBox(height: 20),
            _buildCreateOption(
              context,
              Icons.rate_review,
              'Scrivi Recensione',
              'Recensisci un prodotto',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateOption(BuildContext context, IconData icon, String title, String subtitle) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title - Coming soon!')),
        );
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.beige),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

// NOTIFICATIONS - Notifiche e attività
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notifiche',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.beige,
              child: Icon(Icons.person, color: AppColors.gold),
            ),
            title: RichText(
              text: TextSpan(
                style: TextStyle(color: AppColors.textDark),
                children: [
                  TextSpan(
                    text: 'username$index ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: 'ha messo mi piace al tuo post'),
                ],
              ),
            ),
            subtitle: Text(
              '2 ore fa',
              style: TextStyle(color: AppColors.textLight, fontSize: 12),
            ),
            trailing: Container(
              width: 50,
              height: 50,
              color: AppColors.beige,
              child: Icon(Icons.face_retouching_natural, color: AppColors.gold),
            ),
          );
        },
      ),
    );
  }
}