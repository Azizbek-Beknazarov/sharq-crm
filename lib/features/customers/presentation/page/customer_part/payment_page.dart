
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharq_crm/features/customers/presentation/page/customer_part/customer_home_page.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({Key? key, required this.totalPrice,required this.customerId}) : super(key: key);
  final double totalPrice;
  final String customerId;

  TextEditingController _cardController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment Page'),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(9),
              width: double.infinity,
              child: Image.asset(
                'assets/images/plastk.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _cardController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, karta raqamini kiriting!';
                  }
                  if(value.length<15){
                    return 'Noto\'g\'ri kiritildi';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "0000 0000 0000 0000",
                    labelText: 'Karta raqami',
                    icon: Icon(Icons.add_card)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green.shade100)),
                  onPressed: () async{
                    if (_formKey.currentState!.validate()){
                      showDialog(context: context, builder: (_){
                        return  AlertDialog(
                          actions: [
                            OutlinedButton(onPressed: (){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                return CustomerHomePage(customerId: customerId);
                              }), (route) => false);
                            }, child: Text('Bosh sahifaga...'))
                          ],
                          title: Text("To\'lov omadli yakunlandi"),
                        );

                      });

                    }

                    print(totalPrice.toString());
                  },
                  child: Text('${totalPrice.toString()} so\'m || Tasdiqlash')),
            )
          ],
        ),
      ),
    );
  }
}
