part of 'category-product-bloc.dart';
 
abstract class CategoryProductState{}

class CategoryProductLoadingState extends CategoryProductState{}
class  CategotyProductResponeState extends CategoryProductState {
  Either<String,List<Product>> productsByCategoryId;
  CategotyProductResponeState(this.productsByCategoryId);
}