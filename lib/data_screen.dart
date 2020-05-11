import 'package:flutter/material.dart';
import 'package:flutter_fetcch_api/category_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  CategoryData category = CategoryData();
  String name;
  String img;
  List<Map<String, String>> dataList = [];
  var petData;
  String type = "pets";

  @override
  void initState() {
    super.initState();
    getapiData();
  }

  void getapiData() async {
    var categoryData = await CategoryData().getpetData();
    print("category data: $categoryData");
    petData = categoryData;
    if (type == "pets") {
      updateData(petData);
    }
  }

  void updateData(dynamic data) {
    setState(() {
      for (int i = 0; i <= 9; i++) {
        name = data[i]['user']['name'];
        img = data[i]['urls']['raw'];
        print("name: $name");
        dataList.add({"name": name, "img": img});
      }
      // print("data:     $dataList");
      // print("name: $name");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
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
        body: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Text("Pets")
              ]),
              dataList.length <= 7
                  ? Center(
                      child: SpinKitDoubleBounce(
                        color: Colors.red,
                        size: 100.0,
                      ),
                    )
                  : Container(
                    height: _screenSize.height * 0.2,
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
                                            )),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              dat['name'],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
