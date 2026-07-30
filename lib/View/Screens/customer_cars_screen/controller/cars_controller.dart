import 'package:Senaeya/View/Screens/customer_cars_screen/repo/customer_cars_repo.dart';
import 'package:Senaeya/View/Screens/customer_cars_screen/model/client_car_list_model.dart';
import 'package:get/get.dart';

class CarsController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<CarModel> cars = <CarModel>[].obs; // reactive list of cars
  String carId = '';

  @override
  void onInit(){
    super.onInit();
    carId = Get.arguments != null && Get.arguments['id'] != null ? Get.arguments['id'] : '';
    getCars();
  }

  Future<void>getCars()async{
    try{
      isLoading.value = true;
      Response response = await CustomerCarsRepo().getCarsWithProvider(queryParam:carId );
      isLoading.value = false;
      if(response.statusCode==200){
        // response.body is expected to be a Map<String, dynamic>
        final parsed = ClientCarListResponse.fromJson(response.body);
        if(parsed.data != null && parsed.data!.result != null){
          cars.value = parsed.data!.result!;
        } else {
          cars.clear();
        }
      } else {
        cars.clear();
      }
    }catch(e){
      isLoading.value = false;
      cars.clear();
      // you may want to log or show an error
      print('Error fetching cars: $e');
    }
  }
}