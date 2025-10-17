import 'package:flutter/material.dart';

class AppColors {
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color beige = Color(0xFFF5F5DC);
  static const Color lightBeige = Color(0xFFFAF0E6);
  static const Color gold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8B8B8B);
}

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _currentStep = 0;
  
  // Dati del profilo
  String _selectedSkinType = '';
  String _selectedSkinTone = '';
  String _selectedUndertone = '';
  List<String> _selectedConcerns = [];
  String _selectedBudget = '';
  
  final List<String> _skinTypes = ['Normale', 'Secca', 'Grassa', 'Mista', 'Sensibile'];
  final List<String> _skinTones = ['Molto Chiaro', 'Chiaro', 'Medio', 'Olivastro', 'Scuro', 'Molto Scuro'];
  final List<String> _undertones = ['Freddo', 'Neutro', 'Caldo'];
  final List<String> _concerns = [
    'Acne',
    'Rughe',
    'Macchie',
    'Pori dilatati',
    'Rossori',
    'Occhiaie',
    'Secchezza',
    'Lucidità'
  ];
  final List<String> _budgets = ['Low Cost', 'Medio', 'Premium', 'Lusso'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Setup Profilo',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                    height: 4,
                    decoration: BoxDecoration(
                      color: index <= _currentStep ? AppColors.gold : AppColors.beige,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildCurrentStep(),
            ),
          ),
          
          // Pulsanti navigazione
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: AppColors.gold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Indietro',
                        style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: _currentStep > 0 ? 1 : 1,
                  child: ElevatedButton(
                    onPressed: _canProceed() ? _handleNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: AppColors.beige,
                    ),
                    child: Text(
                      _currentStep == 3 ? 'Completa' : 'Avanti',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildSkinTypeStep();
      case 1:
        return _buildSkinToneStep();
      case 2:
        return _buildConcernsStep();
      case 3:
        return _buildBudgetStep();
      default:
        return Container();
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedSkinType.isNotEmpty;
      case 1:
        return _selectedSkinTone.isNotEmpty && _selectedUndertone.isNotEmpty;
      case 2:
        return _selectedConcerns.isNotEmpty;
      case 3:
        return _selectedBudget.isNotEmpty;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (_currentStep == 3) {
      // ULTIMO STEP - NAVIGA ALL'APP PRINCIPALE (con profilo)
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  Widget _buildSkinTypeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💧 Che tipo di pelle hai?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Aiutaci a consigliarti i prodotti più adatti',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 32),
        ..._skinTypes.map((type) {
          final isSelected = _selectedSkinType == type;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedSkinType = type;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.gold : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.gold : AppColors.beige,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isSelected ? Colors.white : AppColors.textLight,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSkinToneStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🎨 Qual è il tuo incarnato?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 32),
        
        Text(
          'Tonalità della pelle',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _skinTones.map((tone) {
            final isSelected = _selectedSkinTone == tone;
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedSkinTone = tone;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.gold : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.gold : AppColors.beige,
                  ),
                ),
                child: Text(
                  tone,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 32),
        
        Text(
          'Sottotono',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: _undertones.map((undertone) {
            final isSelected = _selectedUndertone == undertone;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedUndertone = undertone;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.gold : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.gold : AppColors.beige,
                      ),
                    ),
                    child: Text(
                      undertone,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConcernsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '✨ Quali sono le tue esigenze?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Seleziona tutti quelli che ti interessano',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _concerns.map((concern) {
            final isSelected = _selectedConcerns.contains(concern);
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedConcerns.remove(concern);
                  } else {
                    _selectedConcerns.add(concern);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.gold : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.gold : AppColors.beige,
                  ),
                ),
                child: Text(
                  concern,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBudgetStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💰 Qual è il tuo budget?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Ti aiuteremo a trovare i prodotti nella tua fascia di prezzo',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 32),
        ..._budgets.map((budget) {
          final isSelected = _selectedBudget == budget;
          String description = '';
          switch (budget) {
            case 'Low Cost':
              description = 'Fino a 15€ per prodotto';
              break;
            case 'Medio':
              description = '15€ - 40€ per prodotto';
              break;
            case 'Premium':
              description = '40€ - 80€ per prodotto';
              break;
            case 'Lusso':
              description = 'Oltre 80€ per prodotto';
              break;
          }
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedBudget = budget;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.gold : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.gold : AppColors.beige,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isSelected ? Colors.white : AppColors.textLight,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            budget,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.textDark,
                            ),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected 
                                  ? Colors.white.withOpacity(0.9) 
                                  : AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
