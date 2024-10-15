import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'iniciar_sesion.dart';

class Start extends StatefulWidget {
  Start({super.key});

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  // Controlador para el PageView
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Lista de elementos para el carrusel
  final List<Widget> _pages = [
    CarouselItem(
        title: 'Bienvenido a Mi Mejor Ser',
        description: 'Tu guía para mejorar cada día.',
        w1: ClipRRect(
          borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
          child: SizedBox(
            width: 250, // Ancho deseado
            height: 250, // Altura deseada
            child: Image.asset(
              'assets/img_3.jpeg',
              fit:
                  BoxFit.cover, // Asegura que la imagen se ajuste al contenedor
            ),
          ),
        )),
    CarouselItem(
        title: 'Establece Metas',
        description: 'Planifica y alcanza tus metas de manera efectiva.',
        w1: ClipRRect(
          borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
          child: SizedBox(
            width: 250, // Ancho deseado
            height: 250, // Altura deseada
            child: Image.asset(
              'assets/img_2.jpeg',
              fit:
                  BoxFit.cover, // Asegura que la imagen se ajuste al contenedor
            ),
          ),
        )),
    CarouselItem(
      title: 'Progreso Diario',
      description: 'Haz seguimiento de tus avances y sigue mejorando.',
      w1: ClipRRect(
        borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
        child: SizedBox(
          width: 250, // Ancho deseado
          height: 250, // Altura deseada
          child: Image.asset(
            'assets/img_1.jpeg',
            fit: BoxFit.cover, // Asegura que la imagen se ajuste al contenedor
          ),
        ),
      ),
      w2: ElevatedButton(
        onPressed: () {
          Get.to(const LoginScreen(email: 'blank', password: 'blank'));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, // Color del botón
          foregroundColor: Colors.white, // Color del texto del botón
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 50.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text('Iniciar'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4A5FF),Color(0xFFA5E6FF)]

        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 5,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: _pages,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _currentPage > 0
                            ? () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple, // Color del botón
                          foregroundColor:
                              Colors.white, // Color del texto del botón
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _currentPage < _pages.length - 1
                            ? () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple, // Color del botón
                          foregroundColor:
                              Colors.white, // Color del texto del botón
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Icon(Icons.arrow_forward_rounded,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ));
  }
}

class CarouselItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget? w1; // Imagen opcional
  final Widget? w2; // Botón opcional

  const CarouselItem({
    Key? key,
    required this.title,
    required this.description,
    this.w1, // Parámetro opcional para la imagen
    this.w2, // Parámetro opcional para el botón
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        if (w1 != null) w1!,
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        if (w2 != null) w2!, // Si w2 no es nulo, se muestra
      ],
    );
  }
}
