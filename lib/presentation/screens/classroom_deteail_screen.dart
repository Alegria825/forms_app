import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:forms_app/domain/entities/classroom.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClassroomDetailScreen extends StatelessWidget {
  final Classroom classroom;

  const ClassroomDetailScreen({super.key, required this.classroom});

  // Función para mostrar el QR (se quitó el parámetro qrData porque el diálogo lo genera solo)
  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _DynamicQrDialog(classroom: classroom),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final displayDate = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "${classroom.grade}-${classroom.group}",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            displayDate,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          
          Expanded(
            child: ListView.builder(
              itemCount: classroom.uidStudents.isEmpty ? 1 : classroom.uidStudents.length,
              itemBuilder: (context, index) {
                if (classroom.uidStudents.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Aún no hay alumnos registrados hoy.",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(classroom.uidStudents[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal[400],
        icon: const Icon(Icons.qr_code_2, color: Colors.white),
        label: const Text("Mostrar QR", style: TextStyle(color: Colors.white)),
        onPressed: () => _showQrDialog(context), // Corregido: ya no pasa qrData
      ),
    );
  }
}

// Widget del Diálogo Dinámico (Stateful para manejar el tiempo)
class _DynamicQrDialog extends StatefulWidget {
  final Classroom classroom;
  const _DynamicQrDialog({required this.classroom});

  @override
  State<_DynamicQrDialog> createState() => _DynamicQrDialogState();
}

class _DynamicQrDialogState extends State<_DynamicQrDialog> {
  Timer? _timer;
  String _qrData = "";

  @override
  void initState() {
    super.initState();
    _generateData();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) setState(() => _generateData());
    });
  }

  void _generateData() {
    final now = DateTime.now();
    final dateString = "${now.day}_${now.month}_${now.year}";
    final timeBlock = (now.millisecondsSinceEpoch ~/ 10000); 
    _qrData = "${widget.classroom.id}|$dateString|$timeBlock";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos un SizedBox para darle dimensiones exactas al contenido del Dialog
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Asistencia Dinámica', textAlign: TextAlign.center),
      content: SizedBox( // <--- Agregamos este SizedBox con ancho definido
        width: 300, 
        child: Column(
          mainAxisSize: MainAxisSize.min, // Importante para que no ocupe toda la pantalla
          children: [
            const Text("Pide a tus alumnos que escaneen el código", textAlign: TextAlign.center),
            const SizedBox(height: 20),
            
            // Envolvemos el QR en un Container con medidas fijas para evitar el error de LayoutBuilder
            Container(
              width: 250,
              height: 250,
              alignment: Alignment.center,
              child: QrImageView(
                data: _qrData,
                version: QrVersions.auto,
                size: 250.0,
                // gapless: true, // Ayuda con la estabilidad visual al cambiar
              ),
            ),
            
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
                ),
                const SizedBox(width: 10),
                Text("Actualizando cada 10s", 
                  style: TextStyle(fontSize: 12, color: Colors.red[700], fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        )
      ],
    );
  }
}