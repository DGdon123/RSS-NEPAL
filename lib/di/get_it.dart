import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/data/cache/auth/auth_local_store_impl.dart';
import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/remote_data_source/email/resent_email_verification_remote_data_source.dart';
import 'package:rss/data/remote_data_source/news/all_news_remote_data_source.dart';
import 'package:rss/data/remote_data_source/news/module_wise_news_remote_data_source.dart';
import 'package:rss/data/remote_data_source/news/news_details_data_source.dart';
import 'package:rss/data/remote_data_source/news/news_modules_remote_data_source.dart';
import 'package:rss/data/remote_data_source/news/recent_news_remote_data_source.dart';
import 'package:rss/data/remote_data_source/registration/org_type_remote_data_source.dart';
import 'package:rss/data/remote_data_source/subscriptions/current_subscription_data_source.dart';
import 'package:rss/data/remote_data_source/subscriptions/subscriptions_datasource.dart';
import 'package:rss/data/remote_data_source/user/me_remote_data_source.dart';
import 'package:rss/data/repo/all_news_repo_impl.dart';
import 'package:rss/data/repo/current_subscription_repo_impl.dart';
import 'package:rss/data/repo/me_repo_impl.dart';
import 'package:rss/data/repo/module_wise_news_repo_impl.dart';
import 'package:rss/data/repo/news_details_repo_impl.dart';
import 'package:rss/data/repo/news_modules_repo_impl.dart';
import 'package:rss/data/repo/org_type__repo_impl.dart';
import 'package:rss/data/repo/recent_news_repo_impl.dart';
import 'package:rss/data/repo/request_subs_repo_impl.dart';
import 'package:rss/data/repo/resent_email_verification_repo_impl.dart';
import 'package:rss/domain/repo/email/resend_email_verification_repo.dart';
import 'package:rss/domain/repo/news/all_news_repo.dart';
import 'package:rss/domain/repo/news/module_wise_news_repo.dart';
import 'package:rss/domain/repo/news/news_details_repo.dart';
import 'package:rss/domain/repo/news/news_modules_repo.dart';
import 'package:rss/domain/repo/news/recent_news_repo.dart';
import 'package:rss/domain/repo/registration/org_type_rep.dart';
import 'package:rss/domain/repo/subscription/current_subscription_repo.dart';
import 'package:rss/domain/repo/subscription/request_subs_repo.dart';
import 'package:rss/domain/repo/user/me_repo.dart';
import 'package:rss/domain/usecases/email/resent_email_verification.dart';
import 'package:rss/domain/usecases/news/get_all_news.dart';
import 'package:rss/domain/usecases/news/get_news_details.dart';
import 'package:rss/domain/usecases/news/get_news_modules.dart';
import 'package:rss/domain/usecases/news/get_recent_news.dart';
import 'package:rss/domain/usecases/news/module_wise_news/get_module_wise_news.dart';
import 'package:rss/domain/usecases/org_types/get_org_types.dart';
import 'package:rss/domain/usecases/subscription/get_current_subscription.dart';
import 'package:rss/domain/usecases/subscription/request_subscription.dart';
import 'package:rss/domain/usecases/user/get_me.dart';
import 'package:rss/presentation/state_management/auth/org_type/org_type_cubit.dart';
import 'package:rss/presentation/state_management/auth/resent_verification_email/cubit/resent_email_verification_cubit.dart';
import 'package:rss/presentation/state_management/news/all_news/cubit/all_news_cubit.dart';
import 'package:rss/presentation/state_management/news/module_wise_news/cubit/module_wise_news_cubit.dart';
import 'package:rss/presentation/state_management/news/news_details/news_details_cubit.dart';
import 'package:rss/presentation/state_management/news/news_modules/news_modules_cubit.dart';
import 'package:rss/presentation/state_management/news/recent_news/cubit/recent_news_cubit.dart';
import 'package:rss/presentation/state_management/subscription/cubit/current_subscription_cubit.dart';
import 'package:rss/presentation/state_management/subscription/cubit/request_subscription_cubit.dart';
import 'package:rss/presentation/state_management/user/me/cubit/me_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  final sharedPrefernces = await SharedPreferences.getInstance();
  getItInstance.registerLazySingleton(() => sharedPrefernces);

  getItInstance.registerLazySingleton<IAuthLocalStore>(
      () => AuthLocalStoreImpl(sharedPrefernces));
  // ! API PROVIDER
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // ! API- FETCH RECENT NEWS
  getItInstance.registerLazySingleton<RecentNewsRemoteDataSource>(
      () => RecentNewsRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<RecentNewsRepo>(
      () => RecentNewsRepoImpl(getItInstance()));
  getItInstance.registerLazySingleton<GetRecentNews>(
      () => GetRecentNews(getItInstance()));

  // ! CUBIT - RECENT NEWS
  getItInstance
      .registerFactory(() => RecentNewsCubit(getRecentNews: getItInstance()));

  // ! API - FETCH NEWS MODULES

  getItInstance.registerLazySingleton<NewModulesRemoteDataSource>(
    () => NewModulesRemoteDataSourceImpl(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<NewsModulesRepo>(
      () => NewsModulesRepoImpl(getItInstance()));
  getItInstance.registerLazySingleton<GetNewsModules>(
      () => GetNewsModules(getItInstance()));

// ! CUBIT -  NEWS Modules
  getItInstance
      .registerFactory(() => NewsModulesCubit(getNewsModules: getItInstance()));

  // ! Api Fetch Org types

  getItInstance.registerLazySingleton<OrgTypeRemoteDataSource>(
    () => OrgTypeRemoteDataSourceImpl(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<OrgTypeRepo>(
      () => OrgTypeRepoImpl(getItInstance()));
  getItInstance
      .registerLazySingleton<GetOrgTypes>(() => GetOrgTypes(getItInstance()));

  // ! API REQUEST SUBSCRIPTION
  getItInstance.registerLazySingleton<SubscriptionDataSource>(
      () => SubscriptionDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<RequestSubsRepo>(
      () => RequestSubsRepoImpl(getItInstance()));
  getItInstance.registerLazySingleton<RequestSubcription>(
      () => RequestSubcription(getItInstance()));

  // ! CUBIT REQUEST SUBS
  getItInstance.registerFactory(
      () => RequestSubscriptionCubit(requestSubcription: getItInstance()));

// ! CUBIT -  Org Types Modules
  getItInstance
      .registerFactory(() => OrgTypeCubit(getOrgTypes: getItInstance()));

  // ! API- FETCH ALL NEWS
  getItInstance.registerLazySingleton<AllNewsRemoteDataSource>(
      () => AllNewsRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<AllNewsRepo>(
      () => AllNewsRepoImpl(getItInstance()));
  getItInstance
      .registerLazySingleton<GetAllNews>(() => GetAllNews(getItInstance()));

  // CUBIT - FETCH ALL NEWS
  getItInstance
      .registerFactory(() => AllNewsCubit(getAllNews: getItInstance()));

  // ! API- FETCH  NEWS DETAILS
  getItInstance.registerLazySingleton<NewsDetailsRemoteDataSource>(
      () => NewsDetailsRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<NewsDetailsRepo>(
      () => NewsDeatilsRepoImpl(getItInstance()));
  getItInstance.registerLazySingleton<GetNewsDetails>(
      () => GetNewsDetails(getItInstance()));

  // CUBIT - FETCH  NEWS DETAILS
  getItInstance
      .registerFactory(() => NewsDetailsCubit(getNewsDetails: getItInstance()));

// ! API- Module Wise News List
  getItInstance.registerLazySingleton<ModuleWiseNewsRemoteDataSource>(
      () => ModuleWiseNewsRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<ModuleWiseNewsRepo>(
      () => ModuleWiseNewsRepoImpl(getItInstance()));

  getItInstance.registerLazySingleton<GetModuleWiseNews>(
      () => GetModuleWiseNews(getItInstance()));

  // CUBIT -  Module Wise News List
  getItInstance.registerFactory(() => ModuleWiseNewsCubit(getItInstance()));

// ! API-ME
  getItInstance.registerLazySingleton<MeRemoteDataSource>(
      () => MeRemoteDataSourceImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<MeRepo>(() => MeRepoImpl(getItInstance()));

  getItInstance.registerLazySingleton<GetMe>(() => GetMe(getItInstance()));
  // ! Cubit -- Me
  getItInstance.registerFactory(() => MeCubit(getItInstance()));

  // ! API-ME
  getItInstance.registerLazySingleton<ResentEmailVerificationRemoteDataSource>(
      () => ResentEmailVerificationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<ResentEmailVerificationRepo>(
      () => ResentEmailVerificationRepoImpl(getItInstance()));

  getItInstance.registerLazySingleton<ResentEmailVerification>(
      () => ResentEmailVerification(getItInstance()));
  // ! Cubit -- Me
  getItInstance.registerFactory(() =>
      ResentEmailVerificationCubit(resentEmailVerification: getItInstance()));

  getItInstance.registerLazySingleton<CurrentSubscriptionDataSource>(
      () => CurrentSubscriptionDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<GetCurrentSubscriptionRepo>(
      () => CurrentSubscriptionRepoImpl(getItInstance()));

  getItInstance.registerLazySingleton<GetCurrentSubscription>(
      () => GetCurrentSubscription(getItInstance()));

  getItInstance.registerFactory(
      () => CurrentSubscriptionCubit(getCurrentSubscription: getItInstance()));
}
