import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/util/constants.dart';
import 'calendar_service_page.dart';

class CalendarForManagerPage extends StatefulWidget {
  const CalendarForManagerPage({Key? key}) : super(key: key);

  @override
  State<CalendarForManagerPage> createState() => _CalendarForManagerPageState();
}

class _CalendarForManagerPageState extends State<CalendarForManagerPage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: apbarBackground,
        title: Text("Kalendar",style:  TextStyle(color: iconAndText),),
      ),
      body: Container(
        decoration: BoxDecoration(color: apbarBackground),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Sanani tanlash',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Iltimos, sanani kiriting!';
                    }
                    return null;
                  },
                  onDateSelected: (DateTime value) {
                    selectedDate = value;

                  },
                ),
                ElevatedButton(
                    onPressed: () {


                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      CalendarServicePage(dateTime: selectedDate,)
                      ));
                    },
                    child: Text("Davom etish"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
