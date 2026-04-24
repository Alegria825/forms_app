import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importante para el StreamBuilder
import 'package:flutter/material.dart';
import 'package:forms_app/domain/entities/classroom.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClassroomDetailScreen extends StatelessWidget {
  final Classroom classroom;

  const ClassroomDetailScreen({super.key, required this.classroom});

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
    
    // Formato del ID del documento de hoy: DD_MM_YYYY
    final String dateDocId = "${now.day.toString().padLeft(2, '0')}_${now.month.toString().padLeft(2, '0')}_${now.year}";

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
          
          // --- SINCRONIZACIÓN EN TIEMPO REAL ---
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('classrooms')
                  .doc(classroom.id)
                  .collection('attendances')
                  .doc(dateDocId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Si el documento no existe, nadie ha pasado lista hoy
                if (!snapshot.hasData || !snapshot.data!.exists) {
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

                final data = snapshot.data!.data() as Map<String, dynamic>;
                final List<String> presentUids = List<String>.from(data['present_students'] ?? []);

                if (presentUids.isEmpty) {
                  return const Center(child: Text("Lista vacía"));
                }

                return ListView.builder(
                  itemCount: presentUids.length,
                  itemBuilder: (context, index) {
                    final uid = presentUids[index];

                    // Buscamos el nombre del alumno por su UID
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) return const ListTile(title: Text("Cargando..."));
                        
                        final userData = userSnapshot.data!.data() as Map<String, dynamic>?;
                        final String studentName = userData?['name'] ?? 'Usuario Desconocido';

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal[50],
                            child: Icon(Icons.person, color: Colors.teal[400]),
                          ),
                          title: Text(studentName, style: const TextStyle(fontWeight: FontWeight.w500)),
                          trailing: const Icon(Icons.check_circle, color: Colors.green),
                        );
                      },
                    );
                  },
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
        onPressed: () => _showQrDialog(context),
      ),
    );
  }
}

// Widget del Diálogo Dinámico (Sin cambios, manteniendo tus correcciones de Layout)
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
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Asistencia Dinámica', textAlign: TextAlign.center),
      content: SizedBox(
        width: 300, 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Pide a tus alumnos que escaneen el código", textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Container(
              width: 250,
              height: 250,
              alignment: Alignment.center,
              child: QrImageView(
                data: _qrData,
                version: QrVersions.auto,
                size: 250.0,
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