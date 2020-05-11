import 'networking.dart';

const client_id = "VE4aS1vRX7XVBH_svlmYUwNwWmp-zousyy3VGt5Gfiw";
const nature_url = "api.unsplash.com/collections/1580860/photos/";
const pet_url = "api.unsplash.com/collections/139386/photos/";

class CategoryData {
  Future<dynamic> getpetData() async {
    String url = 'https://$pet_url?client_id=$client_id';
    Networking networkData = Networking(url: url);
    var petData = await networkData.getData();
    return petData;
  }

  Future<dynamic> getnatureData() async {
    String url = 'https://$nature_url?client_id=$client_id';
    Networking networking = Networking(url: url);
    var natureData = await networking.getData();
    return natureData;

  }
}
