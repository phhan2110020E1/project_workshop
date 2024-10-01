// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workshop_mobi/model/student/workshop_endroll.dart';
import 'package:workshop_mobi/screens/userLayout/component/workshop_enroll/workshop_card.dart';

class MyStudentSchedule extends StatefulWidget {
  final List<workshopEndrollResponses>? workshopList;

  const MyStudentSchedule({Key? key, required this.workshopList})
      : super(key: key);

  @override
  State<MyStudentSchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MyStudentSchedule> {
  DateTime today = DateTime.now();
  late List<DateTime> workshopDates;

  @override
  void initState() {
    super.initState();
    workshopDates = widget.workshopList!
        .map((workshop) => workshop.courseLocations[0]
            .schedule_Date) // Giả sử mỗi workshop có trường date
        .toList();
  }

  List<Event> _getEventsForDay(DateTime day) {
    if (workshopDates.any((workshopDate) => isSameDay(day, workshopDate))) {
      return [Event('Workshop')];
    }
    return [];
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    List<workshopEndrollResponses> workshopsOfDay = widget.workshopList
            ?.where((workshop) =>
                isSameDay(workshop.courseLocations[0].schedule_Date, day))
            .toList() ??
        [];

    if (workshopsOfDay.isNotEmpty) {
      // Xử lý hiển thị danh sách các workshop
      _showWorkshopsDialog(workshopsOfDay);
    }

    setState(() {
      today = day;
    });
  }

  void _showWorkshopsDialog(List<workshopEndrollResponses> workshopsOfDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Workshops on ${DateFormat.yMMMd().format(today)}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.8, // Điều chỉnh chiều rộng
              child: Column(
                children: workshopsOfDay.map((workshop) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.event), // Biểu tượng cho mỗi item
                      title: Text(workshop.name ?? 'Unknown Workshop',
                      style: const TextStyle(fontSize: 11),
                      ),
                     subtitle: Text(
                        'Day :${DateFormat.yMMMd().format(workshop.courseLocations[0].schedule_Date)}\nTime : ${DateFormat.jm().format(workshop.courseLocations[0].schedule_Date)}',
                      ),
                      onTap: () {
                        Navigator.pop(context); // Đóng dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WorkshopEnrolLCard(workshopEndroll: workshop),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Colors
                          .white), // Sử dụng TextStyle để thiết lập màu sắc
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 57, 113, 235), // Màu nền nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Bo góc
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<Event>(
      locale: 'en_US',
      rowHeight: 35,
      headerStyle:
          const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      focusedDay: today,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      onDaySelected: _onDaySelected,
      eventLoader: _getEventsForDay,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          if (workshopDates
              .any((workshopDate) => isSameDay(day, workshopDate))) {
            return Center(
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          return null;
        },
        markerBuilder: (context, date, events) {
          return null;
        },
      ),
    );
  }
}

class Event {
  final String title;
  Event(this.title);
}
