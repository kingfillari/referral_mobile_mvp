import 'package:flutter/material.dart';
import '../../models/appointment_model.dart';
import '../../services/sqlite_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_field.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {

  final SQLiteService _db = SQLiteService();

  final TextEditingController _patientController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  List<AppointmentModel> _appointments = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {

    setState(() {
      _loading = true;
    });

    final data = await _db.getAppointments();

    setState(() {
      _appointments = data;
      _loading = false;
    });

  }

  Future<void> _createAppointment() async {

    final appointment = AppointmentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientName: _patientController.text,
      doctorName: _doctorController.text,
      appointmentDate: _dateController.text,
      notes: _notesController.text,
      createdAt: DateTime.now(),
    );

    await _db.insertAppointment(appointment);

    _patientController.clear();
    _doctorController.clear();
    _dateController.clear();
    _notesController.clear();

    _loadAppointments();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Appointment Scheduled"))
    );

  }

  Widget _appointmentCard(AppointmentModel appointment){

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      child: ListTile(
        leading: const Icon(Icons.calendar_month),
        title: Text(appointment.patientName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Doctor: ${appointment.doctorName}"),
            Text("Date: ${appointment.appointmentDate}"),
            Text("Notes: ${appointment.notes}")
          ],
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Appointments"),
      ),

      body: Column(

        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(

              children: [

                CustomInputField(
                  controller: _patientController,
                  label: "Patient Name",
                ),

                const SizedBox(height: 10),

                CustomInputField(
                  controller: _doctorController,
                  label: "Doctor Name",
                ),

                const SizedBox(height: 10),

                CustomInputField(
                  controller: _dateController,
                  label: "Appointment Date",
                ),

                const SizedBox(height: 10),

                CustomInputField(
                  controller: _notesController,
                  label: "Notes",
                ),

                const SizedBox(height: 10),

                CustomButton(
                  text: "Schedule Appointment",
                  onPressed: _createAppointment,
                )

              ],
            ),
          ),

          const Divider(),

          Expanded(

            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _appointments.length,
                    itemBuilder: (context,index){

                      final appointment = _appointments[index];

                      return _appointmentCard(appointment);

                    },
                  ),

          )

        ],

      ),

    );

  }

}