import 'package:flutter/material.dart';

class TodoFormPage extends StatelessWidget {
  const TodoFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE9E5FF), Color(0xFFDDE5FF)],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              Positioned(
                top: -60,
                left: -60,
                child: ClipOval(
                  child: Container(
                    width: 220,
                    height: 180,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Partie gauche : bouton et textes
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE3E8FF),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF172B4D),
                              size: 30,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'Nouvelle tâche',
                          style: TextStyle(
                            color: Color(0xFF172B4D),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Organise tes idées et planifie tes journées.',
                          style: TextStyle(
                            color: Color(0xFF7A869A),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Partie droite : illustration
                  SizedBox(
                    width: 120,
                    height: 140,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF4F5FF), Color(0xFFE5E8FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.checklist_rounded,
                              size: 65,
                              color: Color(0xFF536DFE),
                            ),
                          ),

                          Positioned(
                            right: 8,
                            bottom: 20,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Color(0xFF536DFE),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
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
