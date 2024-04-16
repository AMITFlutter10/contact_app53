import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../shared/cache_helper.dart';
import '../../utilities/enums.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  static ThemeCubit get(context)=> BlocProvider.of(context);
  
 bool isDark = false;
 
 void changeTheme(){
   isDark = !isDark;
   emit(ChangeThemeState());
   MyCache.putBoolean(key: MyCacheKeys.isDarkTheme, value: isDark);
 }
  getTheme(){
  return MyCache.getBoolean(key: MyCacheKeys.isDarkTheme);
 }

}
