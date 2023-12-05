import 'package:dio/dio.dart';
import 'package:notes_app/model/model.dart';
class ApiService{
Dio dio=Dio();

final url="https://656aaff1dac3630cf72739f1.mockapi.io/notes";
Future<List<Model>> fetchApi() async {
  

  try {
    Response response = await dio.get(url);

    if (response.statusCode == 200) {
      var jsonList = response.data as List;
      List<Model> notes = jsonList.map((element) {
        return Model.fromJson(element);
      }).toList();
      return notes;
    } else {
      throw Exception("Failed to fetch data");
    }
  } catch (error) {
    throw Exception("Failed to fetch data: $error");
  }

  
}

 createNotes(Model value)async{
    try {
      await dio.post(url,data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
deleteNotes({required id})async{
  var deleteurl="https://656aaff1dac3630cf72739f1.mockapi.io/notes/$id";
  try{
      await dio.delete(deleteurl);
  }catch(e){
  throw Exception(e);
  }
}

editNotes({required value,required id})async{
  try{
await dio.put("https://656aaff1dac3630cf72739f1.mockapi.io/notes/$id",data:value.toJson());
  }catch(e){
    throw Exception(e);
  }
}

}
