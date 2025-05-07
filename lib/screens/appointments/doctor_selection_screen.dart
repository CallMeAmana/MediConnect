import 'package:flutter/material.dart';
import 'package:mediconnect/models/user.dart';
import 'package:mediconnect/models/user_data.dart';
import 'package:mediconnect/screens/appointments/schedule_appointment_screen.dart';
import 'package:mediconnect/utils/theme.dart';

class DoctorSelectionScreen extends StatelessWidget {
  const DoctorSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = UserData.dummyUsers.where((user) => user.type == UserType.doctor).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Doctor'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: doctor.profileImage != null
                    ? NetworkImage(doctor.profileImage!)
                    : null,
                child: doctor.profileImage == null
                    ? Text(
                  doctor.name.substring(0, 1),
                  style: const TextStyle(fontSize: 24),
                )
                    : null,
              ),
              title: Text(
                doctor.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    doctor.specialization ?? 'General Practitioner',
                    style: TextStyle(
                      color: AppTheme.lightColorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (doctor.qualifications != null && doctor.qualifications!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        doctor.qualifications!.join(', '),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ScheduleAppointmentScreen(
                      doctorId: doctor.id,
                      doctorName: doctor.name,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}