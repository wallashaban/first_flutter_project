abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsChangeBottomNavbarState extends NewsStates {}

class NewsGetBuisnessSuccessState extends NewsStates {}

class NewsGetBuisnessLoadingState extends NewsStates {}

class NewsGetBuisnessErrorState extends NewsStates {
  final String error;
  NewsGetBuisnessErrorState({
    required this.error,
  });
}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;
  NewsGetScienceErrorState({
    required this.error,
  });
}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;
  NewsGetSportsErrorState({
    required this.error,
  });
}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;
  NewsGetSearchErrorState({
    required this.error,
  });
}

class NewsChangeAppTheme extends NewsStates{}