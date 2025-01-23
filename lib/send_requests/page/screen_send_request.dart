import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'dart:ui' as ui;

class RequestCreationScreen extends StatefulWidget {
  @override
  _RequestCreationScreenState createState() => _RequestCreationScreenState();
}

class _RequestCreationScreenState extends State<RequestCreationScreen> {
  String selectedButton = 'إجازة';

  // Variables to store the selected dates
  DateTime? startDate;
  DateTime? endDate;

  // Helper to format dates
  String formatDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إنشاء طلب',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: Color(0xff313131),
      ),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Curved background behind the buttons
            Container(
              decoration: BoxDecoration(
                color: Color(0xff313131),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildToggleButton('إجازة'),
                  _buildToggleButton('مأمورية'),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Rest of the UI
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'طلب الإجازة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                            width: 70,
                            child: Divider(color: Color(0xff4A5060))),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'المدير : أحمد أحمد محمد أحمد',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'الإدارة: السويدي',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Container(
                            width: 180,
                            child: Divider(
                              color: Color(0xffEA5455),
                              thickness: 3,
                            )),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          'تفاصيل الطلب',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDateField(context, 'من:', startDate, (date) {
                            setState(() {
                              startDate = date;
                            });
                          }),
                          _buildDateField(context, 'إلى:', endDate, (date) {
                            setState(() {
                              endDate = date;
                            });
                          }),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text('إجازة جزئية'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('النوع: '),
                          DropdownButton<String>(
                            value: 'اعتيادي',
                            items: [
                              DropdownMenuItem(
                                child: Text('اعتيادي'),
                                value: 'اعتيادي',
                              ),
                              DropdownMenuItem(
                                child: Text('عارضة'),
                                value: 'عارضة',
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('البديل: '),
                          DropdownButton<String>(
                            value: 'مازن توفيق',
                            items: [
                              DropdownMenuItem(
                                child: Text('مازن توفيق'),
                                value: 'مازن توفيق',
                              ),
                              DropdownMenuItem(
                                child: Text('اسم آخر'),
                                value: 'اسم آخر',
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'إرسال الطلب',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String buttonLabel) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedButton = buttonLabel;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedButton == buttonLabel
            ? Color(0xFF7C4646)
            : Color(0xFF492323),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, String label,
      DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 4),
                Text(formatDate(selectedDate)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
