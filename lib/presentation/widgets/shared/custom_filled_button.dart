import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  const CustomFilledButton({
    super.key, 
    required this.text, 
    this.onPressed, 
    this.color
  });

  @override
  Widget build(BuildContext context) {
    // Usamos el color verde de tu diseño o el primario del tema
    final buttonColor = color ?? Colors.greenAccent[400];

    return SizedBox(
      width: double.infinity, // Para que ocupe todo el ancho disponible
      height: 60,            // Altura similar a tu diseño
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Bordes redondeados
          ),
          elevation: 4, // Un poco de sombra como en tu imagen
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}