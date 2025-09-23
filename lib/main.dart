import 'package:elevatorweb/routs/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(ElevatorApp());
}

class ElevatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Saudi First Elevators',
      initialRoute: '/tabbar',
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en'), Locale('ar')],
      locale: const Locale('ar'), // Default to Arabic, can be changed
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      translations: AppTranslations(),
    );
  }
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'customer_reviews': 'Customer reviews',
      'home': 'Home',
      'about': 'About',
      'contact': 'Contact',
      'careers': 'Careers',
      'gallery': 'Gallery',
      'products': 'Products',
      'previous_work': 'Previous Work',
      'articles': 'Articles',
      // Home page
      'saudi_first_elevators': 'Saudi First Elevators',
      'welcome_subtitle':
          'We seek to be the best choice for our customers in the field of elevators and to extend our branches beyond the boundaries of the local market to reach all markets in the Middle East.',
      'more_about_us': 'More about us',
      'our_services': 'Our Services',
      'contact_us': 'Contact Us',
      'intro_desc':
          'Saudi First Elevators Company is honored in the field of supplying, installing, maintaining and modernizing elevators and escalators of all types of electric elevators, including: Elevators that work with a two-speed system, elevators that work with a variable speed system, hydraulic elevators. Food elevators (for villas and restaurants) (VVVF) service elevators in buildings. Cargo elevators. Patient elevators (bed elevator) Elevators without a machine room. Escalators. Mobile walkers outdoor elevators with the construction of all types of outdoor towers',
      // About us section
      'why_us': 'Why us?',
      'the_most_important_thing_about_us': 'THE MOST IMPORTANT THING ABOUT US',
      'full_engineering_supervision': 'FULL ENGINEERING SUPERVISION',
      'full_engineering_supervision_desc':
          'A specialized team of engineers and technicians with the highest degrees of efficiency and specialization performs installation, modernization and maintenance work for all types of elevators and escalators, which gives high accuracy in the implementation of works.',
      'five_year_warranty': '5-YEAR WARRANTY',
      'five_year_warranty_desc':
          'The company gives its customers a 3-year warranty on all types of elevators and escalators it offers against manufacturing defects and installation defects.',
      'after_sales_service': 'AFTER SALES SERVICE',
      'after_sales_service_desc':
          'The company performs regular monthly maintenance by specialized technicians with the highest degree of skill and speed and under the supervision of engineers with a high degree of specialization and competence in maintenance work.',
      'wide_variety_of_products': 'WIDE VARIETY OF PRODUCTS',
      'wide_variety_of_products_desc':
          'The wide variety of First Saudi products gives customers a lot of options that add to the beauty of the decorative form of the building and give a state of harmony and integration between them and the rest of the building components.',
      // Footer
      'sfe': 'SFE',
      'saudi_first_elevators_caps': 'SAUDI FIRST ELEVATORS',
      'company_desc':
          'Saudi First Elevators in the field of supply, installation, maintenance and modernization of elevators and escalators of all kinds. Electric elevators include: Elevators that work with a two-speed system, elevators that work with a variable speed system (VVVF), hydraulic elevators. Food elevators (for villas and restaurants), service elevators in buildings. Cargo elevators. Patient elevators (bed elevator).',
      'important_links': 'IMPORTANT LINKS',
      'home': 'Home',
      'about_company': 'About Company',
      'products_and_solutions': 'Products and Solutions',
      'studio': 'Studio',
      'articles': 'Articles',
      'careers': 'Careers',
      'contact_us_caps': 'Contact us',
      'products_caps': 'PRODUCTS',
      'elevators': 'Elevators',
      'headings': 'HEADINGS',
      'main_branch':
          'The main branch: Nasr City _ 50 Ali Amin Street (Mustafa El Nahas Extension)',
      'october_branch':
          'October branch: Building 421 Omar Ibn Al-Khattab Street, 6th of October City First Floor',
      'mansoura_branch':
          'Mansoura Branch: Suez Canal Street next to Al Ajami Pharmacy in Badr Tower',
      'links': 'LINKS',
      'branches': 'BRANCHES',
      'main_branch_short': 'Main: Nasr City, 50 Ali Amin Street',
      'october_branch_short': 'October: Building 421, 6th of October City',
      'mansoura_branch_short': 'Mansoura: Suez Canal Street, Badr Tower',
      // Customer Reviews
      'review_1':
          'The truth is decent people in everything. Commitment to appointments on the day and continuous response to any inquiry and very polite and tasteful in addition to professionalism and excellent craftsmanship, excellence in prices and speed of implementation, the elevator was completed in three months despite external obstacles, God willing, we renew dealing with them in other projects soon... Greetings.',
      'reviewer_1': 'Nasser Al-Sayed',
      'source_1': 'Facebook',
      'review_2':
          'Excellent service and professional team. The installation was completed on time and the quality is outstanding. Highly recommend for anyone looking for reliable elevator solutions.',
      'reviewer_2': 'Ahmed Hassan',
      'source_2': 'Google',
      'review_3':
          'Outstanding customer service and technical expertise. The maintenance team is always responsive and thorough. Our building\'s elevators have never run better.',
      'reviewer_3': 'Sarah Mohamed',
      'source_3': 'Facebook',
      'review_4':
          'Professional installation and excellent after-sales service. The team was punctual, clean, and efficient. The elevators are working perfectly.',
      'reviewer_4': 'Mohammed Al-Rashid',
      'source_4': 'Google',
      'review_5':
          'First Saudi Elevator Company carried out our work in Al Rehab in our building about a year ago, one of more than 100 pipes in Al Rehab... Although my opinion is just one of hundreds of customers in Al Rehab praising their work and professionalism, I would like to thank them very much.',
      'reviewer_5': 'Lydia Emil',
      'source_5': 'Google',
      'review_6':
          'Great experience from consultation to installation. The team was knowledgeable and provided excellent recommendations. Very satisfied with the final result.',
      'reviewer_6': 'Fatima Al-Zahra',
      'source_6': 'Facebook',
      'review_7':
          'Reliable company with skilled technicians. They handled our modernization project professionally and completed it ahead of schedule. Highly recommended.',
      'reviewer_7': 'Omar Abdullah',
      'source_7': 'Google',
      'review_8':
          'Excellent workmanship and attention to detail. The elevators are running smoothly and the maintenance service is top-notch. Thank you for your professionalism.',
      'reviewer_8': 'Aisha Khalid',
      'source_8': 'Facebook',
    },
    'ar': {
      'customer_reviews': 'آراء العملاء',
      'home': 'الرئيسية',
      'about': 'عن الشركة',
      'contact': 'اتصل بنا',
      'careers': 'الوظائف',
      'gallery': 'المعرض',
      'products': 'المنتجات',
      'previous_work': 'الأعمال السابقة',
      'articles': 'المقالات',
      // Home page
      'saudi_first_elevators': 'مصاعد السعودية الأولى',
      'welcome_subtitle':
          'نسعى لأن نكون الخيار الأفضل لعملائنا في مجال المصاعد وأن نمد فروعنا خارج حدود السوق المحلي لنصل إلى جميع أسواق الشرق الأوسط.',
      'more_about_us': 'المزيد عنا',
      'our_services': 'خدماتنا',
      'contact_us': 'اتصل بنا',
      'intro_desc':
          'تتشرف شركة مصاعد السعودية الأولى في مجال توريد وتركيب وصيانة وتحديث المصاعد والسلالم الكهربائية من جميع أنواع المصاعد الكهربائية، بما في ذلك: المصاعد التي تعمل بنظام السرعتين، المصاعد التي تعمل بنظام السرعة المتغيرة، المصاعد الهيدروليكية. مصاعد الطعام (للفلل والمطاعم) مصاعد الخدمة (VVVF) في المباني. مصاعد البضائع. مصاعد المرضى (مصعد سرير) مصاعد بدون غرفة ماكينات. السلالم الكهربائية. المشايات المتحركة المصاعد الخارجية مع إنشاء جميع أنواع الأبراج الخارجية.',
      // About us section
      'why_us': 'لماذا نحن؟',
      'the_most_important_thing_about_us': 'أهم ما يميزنا',
      'full_engineering_supervision': 'إشراف هندسي كامل',
      'full_engineering_supervision_desc':
          'يقوم فريق متخصص من المهندسين والفنيين ذوي أعلى درجات الكفاءة والتخصص بأعمال التركيب والتحديث والصيانة لجميع أنواع المصاعد والسلالم الكهربائية، مما يعطي دقة عالية في تنفيذ الأعمال.',
      'five_year_warranty': 'ضمان 5 سنوات',
      'five_year_warranty_desc':
          'تمنح الشركة عملاءها ضمانًا لمدة 3 سنوات على جميع أنواع المصاعد والسلالم الكهربائية التي تقدمها ضد عيوب التصنيع وعيوب التركيب.',
      'after_sales_service': 'خدمة ما بعد البيع',
      'after_sales_service_desc':
          'تقوم الشركة بأعمال الصيانة الشهرية الدورية بواسطة فنيين متخصصين على أعلى درجة من المهارة والسرعة وتحت إشراف مهندسين على درجة عالية من التخصص والكفاءة في أعمال الصيانة.',
      'wide_variety_of_products': 'تنوع كبير في المنتجات',
      'wide_variety_of_products_desc':
          'يمنح التنوع الكبير في منتجات السعودية الأولى العملاء الكثير من الخيارات التي تضيف إلى جمال الشكل الديكوري للمبنى وتعطي حالة من الانسجام والتكامل بينها وبين باقي مكونات المبنى.',
      // Footer
      'sfe': 'س.ف.إ',
      'saudi_first_elevators_caps': 'مصاعد السعودية الأولى',
      'company_desc':
          'مصاعد السعودية الأولى في مجال التوريد والتركيب والصيانة وتحديث المصاعد والسلالم الكهربائية من جميع الأنواع. تشمل المصاعد الكهربائية: المصاعد التي تعمل بنظام السرعتين، المصاعد التي تعمل بنظام السرعة المتغيرة (VVVF)، المصاعد الهيدروليكية. مصاعد الطعام (للفلل والمطاعم)، مصاعد الخدمة في المباني. مصاعد البضائع. مصاعد المرضى (مصعد سرير).',
      'important_links': 'روابط هامة',
      'home': 'الرئيسية',
      'about_company': 'عن الشركة',
      'products_and_solutions': 'المنتجات والحلول',
      'studio': 'استوديو',
      'articles': 'المقالات',
      'careers': 'الوظائف',
      'contact_us_caps': 'اتصل بنا',
      'products_caps': 'المنتجات',
      'elevators': 'مصاعد',
      'headings': 'العناوين',
      'main_branch':
          'الفرع الرئيسي: مدينة نصر _ 50 شارع علي أمين (امتداد مصطفى النحاس)',
      'october_branch':
          'فرع أكتوبر: مبنى 421 شارع عمر بن الخطاب، مدينة 6 أكتوبر، الدور الأول',
      'mansoura_branch':
          'فرع المنصورة: شارع قناة السويس بجوار صيدلية العجمي في برج بدر',
      'links': 'روابط',
      'branches': 'الفروع',
      'main_branch_short': 'الرئيسي: مدينة نصر، 50 شارع علي أمين',
      'october_branch_short': 'أكتوبر: مبنى 421، مدينة 6 أكتوبر',
      'mansoura_branch_short': 'المنصورة: شارع قناة السويس، برج بدر',
      // Customer Reviews
      'review_1':
          'الحقيقة ناس محترمين في كل شيء. التزام بالمواعيد في اليوم واستجابة مستمرة لأي استفسار وغاية في الأدب والذوق بالإضافة إلى الاحترافية والحرفية الممتازة، تميز في الأسعار وسرعة التنفيذ، تم الانتهاء من المصعد في ثلاثة أشهر رغم العقبات الخارجية، ما شاء الله، نجدد التعامل معهم في مشاريع أخرى قريبًا... تحياتي.',
      'reviewer_1': 'ناصر السيد',
      'source_1': 'فيسبوك',
      'review_2':
          'خدمة ممتازة وفريق محترف. تم الانتهاء من التركيب في الوقت المحدد والجودة رائعة. أنصح به لأي شخص يبحث عن حلول مصاعد موثوقة.',
      'reviewer_2': 'أحمد حسن',
      'source_2': 'جوجل',
      'review_3':
          'خدمة عملاء رائعة وخبرة فنية عالية. فريق الصيانة دائمًا متجاوب ودقيق. لم تعمل مصاعد المبنى لدينا بهذا الشكل من قبل.',
      'reviewer_3': 'سارة محمد',
      'source_3': 'فيسبوك',
      'review_4':
          'تركيب احترافي وخدمة ما بعد البيع ممتازة. الفريق كان دقيقًا ونظيفًا وفعالًا. المصاعد تعمل بشكل مثالي.',
      'reviewer_4': 'محمد الراشد',
      'source_4': 'جوجل',
      'review_5':
          'قامت شركة مصاعد السعودية الأولى بأعمالنا في الرحاب في مبنانا منذ حوالي عام، أحد أكثر من 100 عميل في الرحاب... رغم أن رأيي مجرد واحد من مئات العملاء في الرحاب الذين يثنون على عملهم واحترافيتهم، أود أن أشكرهم جدًا.',
      'reviewer_5': 'ليديا إميل',
      'source_5': 'جوجل',
      'review_6':
          'تجربة رائعة من الاستشارة إلى التركيب. الفريق كان على دراية وقدم توصيات ممتازة. راضٍ جدًا عن النتيجة النهائية.',
      'reviewer_6': 'فاطمة الزهراء',
      'source_6': 'فيسبوك',
      'review_7':
          'شركة موثوقة وفنيون مهرة. تعاملوا مع مشروع التحديث لدينا باحترافية وأكملوه قبل الموعد المحدد. أنصح بهم بشدة.',
      'reviewer_7': 'عمر عبد الله',
      'source_7': 'جوجل',
      'review_8':
          'جودة عمل ممتازة واهتمام بالتفاصيل. المصاعد تعمل بسلاسة وخدمة الصيانة من الدرجة الأولى. شكرًا لاحترافيتكم.',
      'reviewer_8': 'عائشة خالد',
      'source_8': 'فيسبوك',
    },
  };
}
