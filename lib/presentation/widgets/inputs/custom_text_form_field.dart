import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      //borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(25)
    );


    return TextFormField(
      onChanged: (value) {
        print('Value: $value');
      },

      //*EJEMPLOS DE VALIDADORES
      validator: (value) {
        if (value == null) return 'campo requerido';
        if (value.isEmpty) return 'campo requerido';
        if (value.trim().isEmpty) return 'campo requerido';

        return null;
      },
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary))
      ),
    );
  }
}
