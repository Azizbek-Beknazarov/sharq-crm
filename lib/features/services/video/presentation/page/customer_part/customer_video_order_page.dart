import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/video_entity.dart';
import '../../bloc/video_bloc.dart';

class CustomerVideoOrderPage extends StatefulWidget {
  String customerId;

  CustomerVideoOrderPage({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<CustomerVideoOrderPage> createState() => _CustomerVideoOrderPageState();
}

class _CustomerVideoOrderPageState extends State<CustomerVideoOrderPage> {
  final uuid = Uuid();

  TextEditingController _ordersNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  // TextEditingController _dateTimeOfWeddingController = TextEditingController();

  @override
  void dispose() {
    _ordersNumberController.clear();
    // _dateTimeOfWeddingController.clear();

    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    print(
        "Videoga buyurtma berish page dagi customer ID: ${widget.customerId}");
    return BlocBuilder<VideoBloc, VideoStates>(builder: (context, videoState) {
      if (videoState is VideoLoadingState) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              Text('Loading data...'),
            ],
          ),
        );
      } else if (videoState is VideoErrorState) {
        return Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text(videoState.message),
          ],
        );
      }

      return Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.asset('assets/images/video.gif'),
                          SizedBox(
                            height: 15,
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                              labelText: 'Videoga olish sanasi va vaqti',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Iltimos, sanani kiriting!';
                              }
                              return null;
                            },
                            onDateSelected: (DateTime value) {
                              selectedDate = value;
                              print(value);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Iltimos, sonni kiriting!';
                              }
                              return null;
                            },
                            controller: _ordersNumberController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.add),
                              labelText: 'Zakzlar soni',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Iltimos, manzilni kiriting!';
                              }
                              return null;
                            },
                            controller: _addressController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.add_circle),
                              labelText: 'Manzil',
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            int _ordersNumber =
                                int.tryParse(_ordersNumberController.text) ?? 1;

                            final docId = uuid.v4();
                            String date = selectedDate.toString();

                            VideoEntity addAlbum = VideoEntity(
                                video_id: docId ?? 'docid',
                                dateTimeOfWedding: date,
                                ordersNumber: _ordersNumber,
                                price: 2000000,
                                description: '',
                                address: _addressController.text
                            , isPaid: false);

                            setState(() {
                              context.read<VideoBloc>().add(VideoAddEvent(
                                  addEvent: addAlbum,
                                  customerId: widget.customerId));
                              print('added Video');
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => CustomerHomePage(
                                          customerId: widget.customerId,
                                        )),
                                (route) => false);
                          }
                        },
                        child: Text('Tasdiqlash'))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
