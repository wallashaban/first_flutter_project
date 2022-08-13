abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavbarState extends ShopStates {}

class ShopGetHomeDataSuccessState extends ShopStates {}

class ShopGetHomeDataLoadingState extends ShopStates {}

class ShopGetHomeDataErrorState extends ShopStates {
  final String error;
  ShopGetHomeDataErrorState({
    required this.error,
  });
}
