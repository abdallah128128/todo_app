abstract class AppStates{}
class AppInitialState extends AppStates{}
class CreateDatabaseState extends AppStates{}
class InsertToDatabaseState extends AppStates{}
//---------------------------------------------------------------
//GET
class GetFromDatabaseLoadingState extends AppStates {}
class GetFromDatabaseSuccessState extends AppStates{}
//---------------------------------------------------------------
//UPDATE
class UpdateStatusInDataBaseSuccessState extends AppStates{}
class UpdateIsFavoriteInDataBaseSuccessState extends AppStates{}
//---------------------------------------------------------------
//DELETE
class DeleteItemFromDataBaseSuccessState extends AppStates{}
class ChangeColorIndexState extends AppStates{}
class ChangeSelectedDaySuccessState extends AppStates{}
class FilteredTasksBasedOnDateSuccessState extends AppStates{}
class GetTodayTasksSuccessState extends AppStates{}
class ChangeAppModeState extends AppStates{}





