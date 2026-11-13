// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'HomeBook';

  @override
  String get navHome => '首页';

  @override
  String get navBookings => '订单';

  @override
  String get navProfile => '我的';

  @override
  String get language => '语言';

  @override
  String get languageSystem => '跟随系统';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get searchServicesHint => '搜索服务…';

  @override
  String get categories => '分类';

  @override
  String get categoryAll => '全部';

  @override
  String get categoryCleaning => '家政';

  @override
  String get categoryRepair => '维修';

  @override
  String get categoryRenovation => '装修';

  @override
  String get categoryMoving => '搬家';

  @override
  String get allServices => '全部服务';

  @override
  String servicesCountPayOnSite(int count) {
    return '$count 项 · 到付结算';
  }

  @override
  String get noMatchingServices => '没有匹配的服务';

  @override
  String get serviceDetailTitle => '服务详情';

  @override
  String get serviceMissing => '服务不存在';

  @override
  String get payOnSite => '到付';

  @override
  String durationPricePayOnSite(String duration, String price) {
    return '$duration · $price · 到付';
  }

  @override
  String get serviceIncludes => '服务内容';

  @override
  String get provider => '服务者';

  @override
  String get providerMissing => '暂无服务者信息';

  @override
  String bookNow(String price) {
    return '立即预约 · $price';
  }

  @override
  String get bookTitle => '预约下单';

  @override
  String get selectDate => '选择日期';

  @override
  String selectTime(String date) {
    return '选择时间 · $date';
  }

  @override
  String get visitAddress => '上门地址';

  @override
  String get addressHint => '请输入上门地址';

  @override
  String get defaultAddressHint => '昆明市五华区示范路 88 号';

  @override
  String get notesOptional => '备注（可选）';

  @override
  String get notesHint => '门禁、联系人等';

  @override
  String get slotNotSelected => '未选时段';

  @override
  String bookingSummary(String price, String slot) {
    return '合计 $price · $slot · 到付';
  }

  @override
  String get submitting => '提交中…';

  @override
  String confirmBooking(String price) {
    return '确认预约 · $price';
  }

  @override
  String get selectTimeSlot => '请选择预约时段';

  @override
  String get enterAddress => '请填写上门地址';

  @override
  String get slotUnavailable => '该时段不可选，请换一个时间';

  @override
  String get myBookings => '我的订单';

  @override
  String get bookingsEmpty => '暂无订单';

  @override
  String get filterAll => '全部';

  @override
  String get statusPending => '待确认';

  @override
  String get statusAccepted => '已接单';

  @override
  String get statusInProgress => '进行中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusCancelled => '已取消';

  @override
  String get bookingDetailTitle => '订单详情';

  @override
  String get bookingMissing => '订单不存在';

  @override
  String get statusTracking => '状态跟踪';

  @override
  String get bookingCancelledBanner => '订单已取消';

  @override
  String get labelTime => '时间';

  @override
  String get labelAddress => '地址';

  @override
  String get labelNotes => '备注';

  @override
  String get labelPayment => '结算';

  @override
  String get labelMyReview => '我的评价';

  @override
  String reviewStars(int rating) {
    return '$rating 星';
  }

  @override
  String get contactProvider => '联系服务者';

  @override
  String get contactUnavailable => '暂不支持站内联系。';

  @override
  String durationDays(int count) {
    return '$count天';
  }

  @override
  String durationHours(int count) {
    return '$count小时';
  }

  @override
  String durationMinutesLabel(int count) {
    return '$count分钟';
  }

  @override
  String get writeReview => '去评价';

  @override
  String get cancelBooking => '取消订单';

  @override
  String get cancelBookingTitle => '取消订单？';

  @override
  String get cancelBookingBody => '取消后状态变为已取消，且不可恢复。';

  @override
  String get back => '返回';

  @override
  String get confirmCancel => '确认取消';

  @override
  String get bookingCancelledSnack => '订单已取消';

  @override
  String get reviewTitle => '评价';

  @override
  String get reviewServiceTitle => '评价服务';

  @override
  String get reviewAlreadySubmitted => '该订单已评价';

  @override
  String get rating => '评分';

  @override
  String get commentOptional => '评论（可选）';

  @override
  String get commentHint => '服务体验如何？';

  @override
  String get submitReview => '提交评价';

  @override
  String get reviewSubmitted => '评价已提交';

  @override
  String get providerHomeTitle => '服务者工作台';

  @override
  String get switchToProviderRole => '切换到服务者角色';

  @override
  String get providerProfile => '服务者资料';

  @override
  String inProgressCompletedCount(int active, int completed) {
    return '进行中 $active · 已完成 $completed';
  }

  @override
  String get newBookings => '新订单';

  @override
  String get noPendingBookings => '暂无待接订单';

  @override
  String get reject => '拒绝';

  @override
  String get accept => '接单';

  @override
  String get myActive => '我的进行中';

  @override
  String get noActiveBookings => '暂无进行中订单';

  @override
  String get startService => '开始服务';

  @override
  String get complete => '完成';

  @override
  String get availableHours => '可预约时段';

  @override
  String get details => '详情';

  @override
  String get profileTitle => '我的';

  @override
  String get account => '账号';

  @override
  String get signInOrSignUp => '登录 / 注册';

  @override
  String get signInToSaveBookings => '登录后可保存订单';

  @override
  String get signedIn => '已登录';

  @override
  String get guestSession => '游客会话';

  @override
  String get syncNow => '立即同步';

  @override
  String get syncRefreshed => '订单与评价已刷新。';

  @override
  String get signOut => '退出登录';

  @override
  String get currentRole => '当前角色';

  @override
  String get roleUser => '用户';

  @override
  String get roleProvider => '服务者';

  @override
  String get roleHint => '可在本应用内切换为服务者接单。';

  @override
  String get providerWorkbench => '服务者工作台';

  @override
  String get providerWorkbenchSubtitle => '接单 / 推进订单';

  @override
  String get switchToProvider => '切换到「服务者」';

  @override
  String get switchToProviderHint => '即可进入接单工作台';

  @override
  String get payment => '支付';

  @override
  String get paymentPayOnSite => '到付 / 现金';

  @override
  String get signIn => '登录';

  @override
  String get signInTitle => '登录';

  @override
  String get welcomeTitle => '欢迎使用 HomeBook';

  @override
  String get signInSubtitle => '登录后可同步订单与评价。';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get signingIn => '登录中…';

  @override
  String get noAccountSignUp => '没有账号？注册';

  @override
  String get signUp => '注册';

  @override
  String get signUpTitle => '注册';

  @override
  String get joinTitle => '加入 HomeBook';

  @override
  String get signUpSubtitle => '注册后可保存订单与评价。';

  @override
  String get creatingAccount => '注册中…';

  @override
  String get haveAccountSignIn => '已有账号？登录';

  @override
  String get authEmailRequired => '请输入邮箱。';

  @override
  String get authEmailInvalid => '请输入有效的邮箱地址。';

  @override
  String get authPasswordRequired => '请输入密码。';

  @override
  String authPasswordTooShort(int min) {
    return '密码至少需要 $min 个字符。';
  }
}
