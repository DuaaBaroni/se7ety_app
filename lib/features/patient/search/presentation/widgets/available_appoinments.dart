// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  // final CollectionReference doctors =
  //     FirebaseFirestore.instance.collection('doctors');

  Future<List<int>> getAvailableAppointments(
      DateTime selectedDate, String start, String end) async {
    int startHour = int.parse(start);
    int endHour = int.parse(end);
    // DateTime startDateTime = DateTime(
    //   selectedDate.year,
    //   selectedDate.month,
    //   selectedDate.day,
    //   startHour,
    // );
    // DateTime endDateTime = DateTime(
    //   selectedDate.year,
    //   selectedDate.month,
    //   selectedDate.day,
    //   endHour,
    // );

    List<int> hours = [];
    for (int i = startHour; i < endHour; i++) {
      DateTime candidateTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, i);
          if(candidateTime.hour > DateTime.now().hour &&
              candidateTime.day == DateTime.now().day &&
               candidateTime.month == DateTime.now().month ){
                hours.add(candidateTime.hour);
               }
               if(candidateTime.day != DateTime.now().day){
                  hours.add(candidateTime.hour);
               }
          

      
    }

    return hours;
  }
}
