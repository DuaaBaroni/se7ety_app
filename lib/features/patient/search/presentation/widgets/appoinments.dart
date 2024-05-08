import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
 
  final CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

  Future<List<DateTime>> getAvailableAppointments(
      DateTime selectedDate, String start, String end) async {
   
    int startHour = int.parse(start);
    int endHour = int.parse(end);
    DateTime startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startHour,
    );
    DateTime endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endHour,
    );

 
    List<DateTime> availableAppointments = [];
    for (int i = startHour; i < endHour; i++) {
      DateTime candidateTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, i);

      availableAppointments.add(candidateTime);
      
    }

    return availableAppointments;
  }
}