import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fetcch_api/category_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  CategoryData category = CategoryData();
  String name;
  String img;
  List<Map<String, String>> dataList = [];

  final String type = "pets";

  @override
  void initState() {
    super.initState();
    getapiData();
  }

  void getapiData() async {
    var categoryData = await CategoryData().getpetData();
    print("category data: $categoryData");
    var petData = categoryData;
    updateData(petData);
  }

  void getapinatureData() async {
    var categoryData = await CategoryData().getnatureData();
    print("category data: $categoryData");
    var natureData = categoryData;
    updateData(natureData);
  }

  void toggle2() {
    getapinatureData();
    //return Container();
  }

  void toggle1() {
    getapiData();
    // return Container();
  }

  void updateData(dynamic data) {
    dataList.clear();
    setState(() {
      for (int i = 0; i <= 9; i++) {
        name = data[i]['user']['name'];
        // name = data[i]['description'];
        //img = data[i]['urls']['raw'];
        img = data[i]['urls']['regular'];
        print("$i. name: $name");
        dataList.add({"name": name, "img": img});
      }
      // print("data:     $dataList");
      // print("name: $name");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          'Pet and Nature',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: dataList.length == 0
          ? Container(
              child: Center(
                child: SpinKitDoubleBounce(
                  color: Colors.red,
                  size: 100.0,
                ),
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ToggleSwitch(
                        minWidth: 90.0,
                        cornerRadius: 20,
                        activeTextColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveTextColor: Colors.white,
                        labels: ['Pets', 'Nature'],
                        activeColors: [Colors.green, Colors.pink],
                        onToggle: (index) {
                          if (index == 0) {
                            toggle1();
                          } else {
                            toggle2();
                          }
                        }),
                  ],
                )),
                Expanded(
                  flex: 2,
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: dataList
                        .map((dat) => InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                color: Colors.black12,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(dat['img']),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "User- ${dat['name']}",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
