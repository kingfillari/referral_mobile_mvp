import 'package:flutter/material.dart';
import '../models/patient_model.dart';

class PatientCard extends StatelessWidget {

  final PatientModel patient;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PatientCard({
    super.key,
    required this.patient,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  Color _statusColor() {

    if (patient.status == "critical") {
      return Colors.red;
    } else if (patient.status == "stable") {
      return Colors.green;
    } else {
      return Colors.orange;
    }

  }

  Widget _buildInfoRow(String label, String value) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [

          SizedBox(
            width: 90,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          )

        ],
      ),
    );

  }

  Widget _buildActionButton(
      IconData icon,
      Color color,
      VoidCallback? action
      ){

    return IconButton(
      icon: Icon(icon,color: color),
      onPressed: action,
    );

  }

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      child: Padding(

        padding: const EdgeInsets.all(12),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                const CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),

                const SizedBox(width: 10),

                Expanded(

                  child: Text(
                    patient.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),

                Container(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),

                  decoration: BoxDecoration(
                    color: _statusColor(),
                    borderRadius: BorderRadius.circular(6),
                  ),

                  child: Text(
                    patient.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),

                )

              ],

            ),

            const SizedBox(height: 10),

            _buildInfoRow("Age", patient.age.toString()),
            _buildInfoRow("Gender", patient.gender),
            _buildInfoRow("Condition", patient.condition),

            const SizedBox(height: 8),

            Row(

              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                _buildActionButton(
                    Icons.visibility,
                    Colors.blue,
                    onView
                ),

                _buildActionButton(
                    Icons.edit,
                    Colors.orange,
                    onEdit
                ),

                _buildActionButton(
                    Icons.delete,
                    Colors.red,
                    onDelete
                ),

              ],

            )

          ],

        ),

      ),

    );

  }

}