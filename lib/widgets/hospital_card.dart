import 'package:flutter/material.dart';
import '../models/hospital_model.dart';

class HospitalCard extends StatelessWidget {

  final HospitalModel hospital;
  final VoidCallback? onTap;

  const HospitalCard({
    super.key,
    required this.hospital,
    this.onTap,
  });

  Widget _infoRow(IconData icon,String text){

    return Row(
      children: [

        Icon(icon,size:16,color: Colors.grey),

        const SizedBox(width:6),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize:13),
          ),
        )

      ],
    );

  }

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,

      child: Card(

        elevation:3,

        margin: const EdgeInsets.symmetric(
          horizontal:12,
          vertical:6,
        ),

        child: Padding(

          padding: const EdgeInsets.all(12),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  const CircleAvatar(
                    child: Icon(Icons.local_hospital),
                  ),

                  const SizedBox(width:10),

                  Expanded(

                    child: Text(
                      hospital.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:16,
                      ),
                    ),

                  )

                ],

              ),

              const SizedBox(height:10),

              _infoRow(Icons.location_on,hospital.address),
              _infoRow(Icons.phone,hospital.phone),
              _infoRow(Icons.email,hospital.email),

              const SizedBox(height:8),

              Row(

                mainAxisAlignment: MainAxisAlignment.end,

                children: [

                  TextButton(
                    onPressed: onTap,
                    child: const Text("View Details"),
                  )

                ],

              )

            ],

          ),

        ),

      ),

    );

  }

}