import 'package:apple_store/bloc/category/category-event.dart';
import 'package:apple_store/bloc/category/category-state.dart';
import 'package:apple_store/data/repository/category-repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository = locatore.get();

  CategoryBloc() : super(CategoryLoadingState()) {
    on<CategoryRequsetEvent>((event, emit) async {
      var categories = await _categoryRepository.getCategories();
      emit(CategoryResponseState(categories));
    });
  }
}



