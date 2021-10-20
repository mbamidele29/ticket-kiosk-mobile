import 'package:ticket_kiosk/core/entities/category.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/features/home/domain/repositories/category_repository.dart';

class CategoryService {
  final ICategoryRepository repository;

  CategoryService(this.repository);

  Future<List<Category>> call() async{
    KioskResponse response=await repository();
    try{
      if(response.data!=null){
        return List.from(response.data).map<Category>((category) => Category.fromJson(category)).toList();
      }
      return [];
    }catch(err){
      return [];
    }
  }
}