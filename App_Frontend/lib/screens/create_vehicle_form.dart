// lib/screens/create_vehicle_form.dart

import 'package:flutter/material.dart';
import 'package:app_frontend/data/services/api_service.dart';
import 'package:app_frontend/widgets/primary_button.dart';

class CreateVehicleForm extends StatefulWidget {
  const CreateVehicleForm({Key? key}) : super(key: key);
  @override
  State<CreateVehicleForm> createState() => _CreateVehicleFormState();
}

class _CreateVehicleFormState extends State<CreateVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _plateCtrl        = TextEditingController();
  final _yearCtrl         = TextEditingController();
  final _brandCtrl        = TextEditingController();
  final _modelCtrl        = TextEditingController();
  final _displacementCtrl = TextEditingController();
  final _weightCtrl       = TextEditingController();
  final _powerCtrl        = TextEditingController();
  final _torqueCtrl       = TextEditingController();
  final _userIdCtrl       = TextEditingController();
  final _idTypeCtrl       = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    for (final c in [
      _plateCtrl, _yearCtrl, _brandCtrl, _modelCtrl,
      _displacementCtrl, _weightCtrl, _powerCtrl, _torqueCtrl,
      _userIdCtrl, _idTypeCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final payload = {
      'id_user':    int.tryParse(_userIdCtrl.text)    ?? 0,
      'id_type':    int.tryParse(_idTypeCtrl.text)    ?? 0,
      'plate':      _plateCtrl.text,
      'year':       int.tryParse(_yearCtrl.text)      ?? 0,
      'brand':      _brandCtrl.text,
      'model':      _modelCtrl.text,
      'displacement': int.tryParse(_displacementCtrl.text) ?? 0,
      'weight':     int.tryParse(_weightCtrl.text)     ?? 0,
      'power':      double.tryParse(_powerCtrl.text)   ?? 0.0,
      'torque':     double.tryParse(_torqueCtrl.text)  ?? 0.0,
    };

    try {
      final data = await ApiService.createVehicle(payload);
      Navigator.pop(context, data);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildField(String label, TextEditingController ctrl,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (v) =>
            (v == null || v.isEmpty) ? 'Este campo es obligatorio' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Vehículo'),
        backgroundColor: const Color(0xFF64A3A3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField('ID Usuario', _userIdCtrl,
                  type: TextInputType.number),
              _buildField('Tipo ID (id_type)', _idTypeCtrl,
                  type: TextInputType.number),
              _buildField('Placa', _plateCtrl),
              _buildField('Año', _yearCtrl, type: TextInputType.number),
              _buildField('Marca', _brandCtrl),
              _buildField('Modelo', _modelCtrl),
              _buildField('Cilindraje (cc)', _displacementCtrl,
                  type: TextInputType.number),
              _buildField('Peso (kg)', _weightCtrl,
                  type: TextInputType.number),
              _buildField('Potencia (HP)', _powerCtrl,
                  type: TextInputType.number),
              _buildField('Torque (Nm)', _torqueCtrl,
                  type: TextInputType.number),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(
                      label: 'Registrar',
                      icon: Icons.check,
                      onPressed: _submit,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
