import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int currentStep = 0;
  String? selectedSkinType;
  List<String> selectedConcerns = [];
  String? selectedBudget;
  List<String> selectedCategories = [];

  final skinTypes = ['Normale', 'Secca', 'Grassa', 'Mista', 'Sensibile'];
  final concerns = [
    'Acne',
    'Rughe',
    'Macchie',
    'Pori dilatati',
    'Disidratazione',
    'Rossori'
  ];
  final budgets = ['Low (€0-20)', 'Mid (€20-50)', 'High (€50+)', 'Lusso'];
  final categories = [
    '💄 Makeup',
    '🧴 Skincare',
    '💅 Unghie',
    '💇 Capelli',
    '🧖 Corpo',
    '👃 Profumi'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: (currentStep + 1) / 4,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (currentStep > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => setState(() => currentStep--),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Passo ${currentStep + 1} di 4',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getStepTitle(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _skipToHome,
                    child: const Text(
                      'Salta',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: _buildStepContent(),
            ),
            // Continue button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _canContinue() ? _continue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    currentStep == 3 ? 'Inizia' : 'Continua',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _canContinue() ? Colors.white : Colors.grey[500],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 0:
        return 'Tipo di pelle';
      case 1:
        return 'Problematiche';
      case 2:
        return 'Budget preferito';
      case 3:
        return 'Interessi';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildSkinTypeStep();
      case 1:
        return _buildConcernsStep();
      case 2:
        return _buildBudgetStep();
      case 3:
        return _buildCategoriesStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildSkinTypeStep() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Text(
          'Seleziona il tuo tipo di pelle per ricevere consigli personalizzati',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        ...skinTypes.map((type) => _buildOptionCard(
              title: type,
              isSelected: selectedSkinType == type,
              onTap: () => setState(() => selectedSkinType = type),
            )),
      ],
    );
  }

  Widget _buildConcernsStep() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Text(
          'Seleziona una o più problematiche (opzionale)',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: concerns.map((concern) {
            final isSelected = selectedConcerns.contains(concern);
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedConcerns.remove(concern);
                  } else {
                    selectedConcerns.add(concern);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.orange : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  concern,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
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
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Text(
          'Seleziona la tua fascia di prezzo preferita',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        ...budgets.map((budget) => _buildOptionCard(
              title: budget,
              isSelected: selectedBudget == budget,
              onTap: () => setState(() => selectedBudget = budget),
            )),
      ],
    );
  }

  Widget _buildCategoriesStep() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        Text(
          'Seleziona le categorie che ti interessano',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            final isSelected = selectedCategories.contains(category);
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedCategories.remove(category);
                  } else {
                    selectedCategories.add(category);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? Colors.orange : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange[50] : Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.orange : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.orange[900] : Colors.black87,
                  ),
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: Colors.orange, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  bool _canContinue() {
    switch (currentStep) {
      case 0:
        return selectedSkinType != null;
      case 1:
        return true; // Le problematiche sono opzionali
      case 2:
        return selectedBudget != null;
      case 3:
        return selectedCategories.isNotEmpty;
      default:
        return false;
    }
  }

  void _continue() {
    if (currentStep < 3) {
      setState(() => currentStep++);
    } else {
      _goToHome();
    }
  }

  void _skipToHome() {
    _goToHome();
  }

  void _goToHome() {
    // TODO: Navigare alla home screen
    // Per ora mostriamo un dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Setup completato!'),
        content: const Text('Il profilo è stato configurato con successo.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
