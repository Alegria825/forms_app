import 'package:flutter/material.dart';

class CustomFilledAuthButton extends StatelessWidget {

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const CustomFilledAuthButton({
    super.key, 
    required this.text, 
    this.onPressed, 
    this.icon
    });

@override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton.icon( // <--- Cambiamos a .icon
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF66D36E), // El verde de tu logo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: icon != null ? Icon(icon, color: Colors.white) : const SizedBox(),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}