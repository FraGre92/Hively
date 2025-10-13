import 'package:flutter/material.dart';
import 'terms_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _hController;
  late AnimationController _textController;
  late Animation<double> _hAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animazione per H
    _hController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _hAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hController, curve: Curves.easeOutBack),
    );
    
    // Animazione per "ively"
    _textController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
    
    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 25),
    ]).animate(_textController);
    
    // Avvia le animazioni in sequenza
    _hController.forward().then((_) {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _hController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _goToTerms() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const TermsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8D5B7),
              Color(0xFFD4AF7A),
              Color(0xFFC9A865),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // H cliccabile
                  GestureDetector(
                    onTap: _goToTerms,
                    child: ScaleTransition(
                      scale: _hAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'H',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC9A865),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // "ively" con animazione
                  ClipRect(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Colors.white, Colors.white70],
                            ).createShader(bounds),
                            child: const Text(
                              'ively',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
