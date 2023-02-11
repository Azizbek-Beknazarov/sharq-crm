import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/calendar/widget/album_date_widget.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/calendar/widget/photo_date_widget.dart';
import 'package:sharq_crm/features/customers/presentation/page/manager_part/calendar/widget/video_date_widget.dart';


class CalendarServicePage extends StatefulWidget {
  CalendarServicePage({Key? key, required this.dateTime}) : super(key: key);
  DateTime? dateTime;

  @override
  State<CalendarServicePage> createState() => _CalendarServicePageState();
}

class _CalendarServicePageState extends State<CalendarServicePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    switch (_selectedIndex) {
      case 0:
        child = PhotoDateWidget(
          dateTime: widget.dateTime!,
        );
        break;
      case 1:
        child = FlutterLogo(style: FlutterLogoStyle.horizontal);
        break;
      case 2:
        child = AlbumDateWidget(dateTime: widget.dateTime!,);
        break;
      case 3:
        child = VideoDateWidget(dateTime: widget.dateTime!,);
        break;
    }

    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(child: child),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.cyanAccent,
          onTap: (int index) {
            setState(
              () {
                _selectedIndex = index;
              },
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Photo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_video_outlined),
              label: 'Club',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album_outlined),
              label: 'Album',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_call),
              label: 'Video',
            ),
          ],
        ),
      ),
    );
  }
}
