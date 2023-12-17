import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/data/repository/category-product-repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';


part 'category-product-event.dart';
part 'category-product-state.dart';

class CategoryProductBloc
    extends Bloc<CategotyProductEvent, CategoryProductState> {
  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    final ICategoryProductRepository _repository = locatore.get();
    on<CategoryProductRequestEvent>((event, emit) async {
      var response =
          await _repository.getProductsByCategoryId(event.categoryId);

      emit(CategotyProductResponeState(response));
    });
  }
}
