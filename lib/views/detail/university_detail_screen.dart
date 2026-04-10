import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/university.dart';
import 'package:flutter/foundation.dart';

class UniversityDetailScreen extends StatefulWidget {
  final University university;

  const UniversityDetailScreen({super.key, required this.university});

  @override
  State<UniversityDetailScreen> createState() => _UniversityDetailScreenState();
}

class _UniversityDetailScreenState extends State<UniversityDetailScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _studentsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final university = widget.university;

    return Scaffold(
      appBar: AppBar(title: Text(university.name), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Nombre
                Text(
                  university.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // País
                Text(
                  'País: ${university.country}',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Dominios
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dominios:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: university.domains.map((domain) {
                    return Text('• $domain');
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Websites
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Páginas web:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: university.webPages.map((webPage) {
                    return Text('• $webPage');
                  }).toList(),
                ),

                const SizedBox(height: 30),

                // Imagen
                kIsWeb
                    ? (_image != null
                          ? Image.network(_image!.path, height: 150)
                          : const Text("No hay imagen seleccionada"))
                    : (_image != null
                          ? Image.file(_image!, height: 150)
                          : const Text("No hay imagen seleccionada")),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: const Text("Galería"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: const Text("Cámara"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                //Formulario
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _studentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Número de estudiantes",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obligatorio";
                      }

                      final number = int.tryParse(value);
                      if (number == null) {
                        return "Debe ser un número";
                      }

                      if (number <= 0) {
                        return "Debe ser mayor a 0";
                      }

                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Datos guardados correctamente"),
                          ),
                        );
                      }
                    },
                    child: const Text("Guardar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
