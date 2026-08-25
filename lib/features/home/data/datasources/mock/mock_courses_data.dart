import 'package:edulab_b2b/widget_imports.dart';

CategoryModel _category(int id, String title) =>
    CategoryModel(id: id, title: title);

MediaDTO _thumbnail(String seed) => MediaDTO(
  src: '',
  originalName: '$seed.jpg',
  url: 'https://picsum.photos/seed/$seed/300/200',
  fileSizeStr: '',
  originalUrl: 'https://picsum.photos/seed/$seed/300/200',
  thumbUrl: 'https://picsum.photos/seed/$seed/300/200',
  fileSize: 0,
  extension: 'jpg',
);

CourseShortInfo _course({
  required int id,
  required String title,
  required String shortDescription,
  required CategoryModel category,
  required String rating,
  required int learnersCount,
  int progress = 0,
}) {
  return CourseShortInfo(
    id: id,
    title: title,
    description: [shortDescription],
    short_description: shortDescription,
    authors: const [],
    co_authors: const [],
    showPrice: false,
    thumbnail: _thumbnail('course$id'),
    category: category,
    progess: progress,
    rating: rating,
    learnersCount: learnersCount,
  );
}

final _financeCategory = _category(1, 'Finance');
final _itCategory = _category(2, 'IT');
final _riskManagementCategory = _category(3, 'Risk Management');
final _depositsCategory = _category(4, 'Deposits and Accounts');
final _businessServicesCategory = _category(5, 'Business Services');

/// Temporary placeholder data for design work while the backend
/// (leti.slash.uz) is unreachable. Remove once real data is available again.
final List<CourseShortInfo> mockCourses = [
  _course(
    id: 1,
    title: 'Feedback Loops: How to Give & Receive High-Quality Feedback',
    shortDescription:
        'Learners will use the embodied voice to engage and connect with an audience.',
    category: _businessServicesCategory,
    rating: '4.8',
    learnersCount: 1240,
  ),
  _course(
    id: 2,
    title: 'Mastering Your Industry: Competitors, Products, & Suppliers',
    shortDescription:
        'A detailed plan to discovering competitors, products, suppliers in your industry to help grow your business.',
    category: _businessServicesCategory,
    rating: '4.6',
    learnersCount: 860,
  ),
  _course(
    id: 3,
    title: 'Finding Your Professional Voice: Confidence & Impact',
    shortDescription:
        'Learners will use the embodied voice to engage and connect with an audience.',
    category: _businessServicesCategory,
    rating: '4.9',
    learnersCount: 2010,
  ),
  _course(
    id: 4,
    title: 'Introduction to Personal Finance',
    shortDescription:
        'Build the fundamentals of budgeting, saving, and planning for the future.',
    category: _financeCategory,
    rating: '4.7',
    learnersCount: 1530,
  ),
  _course(
    id: 5,
    title: 'Investment Fundamentals',
    shortDescription:
        'Understand the basics of stocks, bonds, and portfolio diversification.',
    category: _financeCategory,
    rating: '4.5',
    learnersCount: 940,
  ),
  _course(
    id: 6,
    title: 'Cloud Computing Basics',
    shortDescription:
        'Get familiar with core cloud concepts, services, and deployment models.',
    category: _itCategory,
    rating: '4.6',
    learnersCount: 1180,
  ),
  _course(
    id: 7,
    title: 'Cybersecurity Essentials',
    shortDescription:
        'Learn how to identify and defend against common security threats.',
    category: _itCategory,
    rating: '4.8',
    learnersCount: 1670,
  ),
  _course(
    id: 8,
    title: 'Enterprise Risk Assessment',
    shortDescription:
        'Learn frameworks for identifying and mitigating organizational risk.',
    category: _riskManagementCategory,
    rating: '4.4',
    learnersCount: 610,
  ),
  _course(
    id: 9,
    title: 'Fraud Prevention Strategies',
    shortDescription:
        'Explore common fraud patterns and how to build safeguards against them.',
    category: _riskManagementCategory,
    rating: '4.7',
    learnersCount: 790,
  ),
  _course(
    id: 10,
    title: 'Understanding Deposit Accounts',
    shortDescription:
        'A practical overview of deposit account types and how they work.',
    category: _depositsCategory,
    rating: '4.5',
    learnersCount: 520,
  ),
  _course(
    id: 11,
    title: 'Digital Banking Essentials',
    shortDescription:
        'Learn how digital banking products are designed and delivered to customers.',
    category: _depositsCategory,
    rating: '4.6',
    learnersCount: 1050,
  ),
];
