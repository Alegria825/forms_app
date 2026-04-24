import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isScanCompleted = false;

  void _processQrCode(String code) {
    if (isScanCompleted) return;
    setState(() => isScanCompleted = true);

    // El código viene como: ID_AULA|FECHA|BLOQUE
    final parts = code.split('|');
    
    if (parts.length != 3) {
      _showError("Código QR no válido para asistencia.");
      return;
    }

    final String classId = parts[0];
    final String qrDate = parts[1];
    final int qrBlock = int.tryParse(parts[2]) ?? 0;

    // VALIDACIÓN DE SEGURIDAD (Anti-fotos)
    final now = DateTime.now();
    final int currentBlock = (now.millisecondsSinceEpoch ~/ 10000);
    
    // Permitimos un margen de error de 2 bloques (20 segundos) por retrasos de red
    if ((currentBlock - qrBlock).abs() > 2) {
      _showError("El código ha expirado. Escanea el código actual.");
      return;
    }

    // Si pasa la seguridad, regresamos el classId para registrar asistencia
    context.pop(classId); 
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error de escaneo"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => isScanCompleted = false);
            },
            child: const Text("Reintentar"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escanear Asistencia")),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              _processQrCode(barcode.rawValue!);
            }
          }
        },
      ),
    );
  }
}