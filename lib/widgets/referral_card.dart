import 'package:flutter/material.dart';
import '../models/referral_model.dart';

class ReferralCard extends StatelessWidget {

  final ReferralModel referral;
  final VoidCallback? onView;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const ReferralCard({
    super.key,
    required this.referral,
    this.onView,
    this.onAccept,
    this.onReject,
  });

  Color _statusColor(){

    switch(referral.status){

      case "pending":
        return Colors.orange;

      case "accepted":
        return Colors.green;

      case "rejected":
        return Colors.red;

      default:
        return Colors.grey;

    }

  }

  Widget _buildRow(String label,String value){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical:2),
      child: Row(
        children: [

          SizedBox(
            width:100,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(child: Text(value))

        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal:12,
        vertical:6,
      ),

      elevation:3,

      child: Padding(

        padding: const EdgeInsets.all(12),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                const Icon(Icons.medical_services),

                const SizedBox(width:8),

                Expanded(
                  child: Text(
                    referral.patientName,
                    style: const TextStyle(
                      fontSize:16,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                ),

                Container(

                  padding: const EdgeInsets.symmetric(
                    horizontal:8,
                    vertical:4,
                  ),

                  decoration: BoxDecoration(
                    color: _statusColor(),
                    borderRadius: BorderRadius.circular(6),
                  ),

                  child: Text(
                    referral.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize:12,
                    ),
                  ),

                )

              ],

            ),

            const SizedBox(height:10),

            _buildRow("From",referral.fromHospital),
            _buildRow("To",referral.toHospital),
            _buildRow("Reason",referral.reason),

            const SizedBox(height:10),

            Row(

              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                TextButton(
                  onPressed: onView,
                  child: const Text("View"),
                ),

                const SizedBox(width:6),

                ElevatedButton(
                  onPressed: onAccept,
                  child: const Text("Accept"),
                ),

                const SizedBox(width:6),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: onReject,
                  child: const Text("Reject"),
                )

              ],

            )

          ],

        ),

      ),

    );

  }

}