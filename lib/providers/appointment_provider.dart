import 'package:flutter/foundation.dart';
import 'package:mediconnect/models/appointment.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  Future<bool> scheduleAppointment(Appointment appointment) async {
    try {
      // TODO: Implement API call
      _appointments.add(appointment);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error scheduling appointment: $e');
      return false;
    }
  }

  Future<bool> updateAppointmentStatus(String appointmentId, AppointmentStatus status) async {
    try {
      final index = _appointments.indexWhere((a) => a.id == appointmentId);
      if (index != -1) {
        _appointments[index] = _appointments[index].copyWith(
          status: status,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating appointment status: $e');
      return false;
    }
  }

  List<Appointment> getAppointmentsForUser(String userId) {
    return _appointments.where((a) =>
    a.patientId == userId || a.doctorId == userId
    ).toList();
  }
}