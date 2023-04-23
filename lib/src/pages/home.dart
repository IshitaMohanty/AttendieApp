// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:attendie/src/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

import '../splash.dart';
import 'attendence.dart';
import 'global.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  late String name;
  late String regdNo;
  late Student student;
  @override
  void initState() {
    fetchStudentInfo();
    super.initState();
  }

  Uint8List? list;
  void requestImg() async {
    //login this  user and get Cookie and then call image section.
    try {
      final https.Response response = await https.get(
        Uri.parse(
            'http://115.240.101.51:8282/CampusPortalSOA/image/studentPhoto'),
        headers: {
          'Cookie': 'JSESSIONID=${sharedPreferences.getString('cookie')}',
        },
      );
      // print(profileImage);
      setState(() {
        list = response.bodyBytes;
      });
    } catch (e) {}
  }

  fetchStudentInfo() async {
    try {
      var response = await https.post(
          Uri.parse('http://115.240.101.51:8282//CampusPortalSOA/studentinfo'),
          headers: {
            "Cookie": "JSESSIONID=${sharedPreferences.getString('cookie')}"
          });
      print(response.body);
      var decoded = jsonDecode(response.body);
      if (decoded["detail"].isEmpty) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SplashScreen()));
      } else {
        requestImg();
        student = Student(
          name: decoded["detail"][0]["name"] ?? "Not given",
          regdNo: decoded["detail"][0]["enrollmentno"] ?? "Not given",
          dob: decoded["detail"][0]["dateofbirth"] ?? "Not given",
          branch: decoded["detail"][0]["branchdesc"] ?? "Not given",
          sec: decoded["detail"][0]["sectioncode"] ?? "Not given",
          email: decoded["detail"][0]["semailid"] ?? "Not given",
          mName: decoded["detail"][0]["mothersname"] ?? "Not given",
          address: decoded["detail"][0]["paddress2"] ?? "Not given",
          bloodgroup: decoded["detail"][0]["bloodgroup"] ?? "Not given",
          caddress3: decoded["detail"][0]["caddress2"] ?? "Not given",
          maritalstatus: decoded["detail"][0]["maritalstatus"] ?? "Not given",
          nationality: decoded["detail"][0]["nationality"] ?? "Not given",
          pNo: decoded["detail"][0]["scellno"] ?? "Not given",
          parentNumber: decoded["detail"][0]["stelephoneno"] ?? "Not given",
          phoneNo: decoded["detail"][0]["scellno"] ?? "Not given",
          pincode: decoded["detail"][0]["ppin"] ?? "Not given",
        );
      }
      setState(() {
        isLoading = false;
      });

      // setState(() {
      //   isLoading=false
      //   name = decoded["detail"][0]["name"];
      //   regdNo = decoded["detail"][0]["enrollmentno"];
      //   isLoading = false;
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 141, 60, 239),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      list != null
                          ? Align(
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor:
                                    Color.fromARGB(255, 210, 189, 236),
                                child: CircleAvatar(
                                  radius: 52,
                                  backgroundImage: MemoryImage(list!),
                                ),
                              ),
                            )
                          : CircularProgressIndicator(),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 141, 60, 240)),
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          student.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color.fromARGB(255, 240, 234, 109),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 118),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "NAME : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.name!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 127),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "REG NO : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.regdNo!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color.fromARGB(255, 240, 234, 109),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 28),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "BRANCH : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.branch!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 118),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "BLOODGROUP : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.bloodgroup!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color.fromARGB(255, 240, 234, 109),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 127),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "SECTION : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.sec!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 92),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "EMAIL : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.email!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color.fromARGB(255, 240, 234, 109),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 65),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "MOTHER'S NAME : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.mName!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 107),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "MARITAL STATUS : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.maritalstatus!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color.fromARGB(255, 240, 234, 109),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 135),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "DOB : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.dob!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 120),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "NATIONALITY : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.nationality!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color.fromARGB(255, 240, 234, 109),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 120),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "PARENT NO : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.parentNumber!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 159),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "PIN : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                            Text(
                              student.pincode!.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 240, 234, 109),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const Attendencepage()));
                            },
                            child: const Text(
                              'GET YOUR ATTENDENCE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 143, 67, 238)),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
