import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:screen_send_request/send_requests/Provider/send_request_provider.dart';
import 'package:screen_send_request/send_requests/widgets/dialog_alert.dart';

class RequestCreationScreen extends StatefulWidget {
  @override
  _RequestCreationScreenState createState() => _RequestCreationScreenState();
}

class _RequestCreationScreenState extends State<RequestCreationScreen> {
  // Variables to store the selected dates
  DateTime? startDate;
  DateTime? endDate;

  // Helper to format dates
  String formatDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  final Map<String, String> buttonMapping = {
    'إجازة': 'Leave',
    'مأمورية': 'Mission',
  };
  final Map<String, String> transactionVacationType = {
    'عارضة': 'CasualLeave',
    'اعتيادية': 'RegularLeave',
    'غياب بأذن': 'ExcusedAbsent',
    'غياب بدون بأذن': 'UnexcusedAbsent',
    'نصف يوم': 'HalfDay',
    'ربع يوم': 'QuarterDay',
  };

  String selectedVacationType = 'اعتيادية'; // Default displayed value;
  String mappedVacationType = 'RegularLeave'; // Default mapped value
  String selectedButton = 'إجازة'; // Default selected button
  String? selectedEmployeeName; // Selected substitute employee name
  int? substituteEmployeeId; // Substitute employee ID

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedButton = buttonMapping['إجازة']!;
    });
    // Fetch employee data on screen initialization
    Future.microtask(() =>
        Provider.of<SendRequestProvider>(context, listen: false).employees);
  }

  Widget build(BuildContext context) {
    final sendRequestProvider = Provider.of<SendRequestProvider>(context);
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
      body: Consumer<SendRequestProvider>(
        builder: (context, provider, child) {
          return Directionality(
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
                              _buildDateField(context, 'من:', startDate,
                                  (date) {
                                setState(() {
                                  startDate = date;
                                  print(formatDate(startDate));
                                });
                              }),
                              _buildDateField(context, 'إلى:', endDate, (date) {
                                setState(() {
                                  endDate = date;
                                  print(formatDate(endDate));
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
                                value: selectedVacationType,
                                items: transactionVacationType.keys
                                    .map((String key) {
                                  return DropdownMenuItem(
                                    value: key,
                                    child: Text(key),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedVacationType = value!;
                                    mappedVacationType =
                                        transactionVacationType[value]!;
                                    print(
                                        'Selected Arabic value: $selectedVacationType');
                                    print(
                                        'Mapped English value: $mappedVacationType');
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text('البديل: '),
                              DropdownButton<String>(
                                value: selectedEmployeeName,
                                hint: Text('اختر اسم الموظف'),
                                items: provider.employees.map((employee) {
                                  return DropdownMenuItem(
                                    value: employee.employeeName,
                                    child: Text("${employee.employeeName}"),
                                    onTap: () {
                                      substituteEmployeeId =
                                          employee.employeeId;
                                      print(
                                          'Selected Employee ID: $substituteEmployeeId');
                                    },
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedEmployeeName = value!;
                                    print('Selected Employee: $value');
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 64),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (startDate == null || endDate == null) {
                          DialogHelper.show(context, 'خطأ',
                              'يرجى إدخال تاريخ البدء و الانتهاء', Colors.red);
                          return;
                        }
                        sendRequestProvider.sendRequestProv(
                          context,
                          selectedButton,
                          mappedVacationType,
                          startDate,
                          endDate,
                          substituteEmployeeId, // SubstituteEmployeeId
                          1007, // Employee ID from token
                          selectedButton == "مأمورية" ? ['', ''] : null,
                        );
                      },
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
          );
        },
      ),
    );
  }

  Widget _buildToggleButton(String buttonLabel) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedButton = buttonMapping[buttonLabel] ?? 'إجازة';
          print('Selected button: $selectedButton');
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedButton == buttonMapping[buttonLabel]
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
            } else {
              DialogHelper.show(
                context,
                'خطأ',
                'يرجى إدخال تاريخ $label',
                Colors.red,
              );
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
                Icon(Icons.calendar_month, size: 16),
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
