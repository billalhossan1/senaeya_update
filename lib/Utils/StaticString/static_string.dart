class AppString {
  ///<====================== These are fro the validation ======================>

  static RegExp passRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.{8,}$)');

  static RegExp urlRegex = RegExp( r'^(http|https):\/\/[a-zA-Z0-9-\.]+\.[a-z]{2,4}(/\S*)?$');

  static RegExp emailRegexp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String fieldCanBeEmpty = "Field cannot be empty'";


  static const String allMemes="All Memes";
  ///<============================ These for the sign in screen =================>

  static const String welCome = "Welcome";
  static const String loginToYourAccount = "Login to your account";
  static const String enterYourEmail = "Enter your email";
  static const String passWord = "Password";
  static const String rememberMe = "Remember me";
  static const String forgotPassword = "Forgot Password?";
  static const String signIn = "Sign in";
  static const String donHaveAnAccount = "Don’t have an account?";
  static const String singUpNow = "Sing up now";
  static const String pleaseConfirmYourClas = "Please confirm your class is completed";
  static const String completeClass = "Complete class";
  static const String courseComplete = "Course completed";
  static const String institute = "Institute";

  ///<============================= These for the sign up screen ==============>
  static const String signUpAsStudent  = "Sign up as student";
  static const String signUpAsFrelancharTeacher  ="Sign up as Frelanchar Teacher";
  static const String signUpAsTeacher  = "Sign up as Teacher";
  static const String createYourAccount = "Create your account";
  static const String offerAndManageYourServices= "Offer and manage your services.";
  static const String userName= "User name";
  static const String contactNumber= "Contact Number";
  static const String password= "Password";
  static const String confirmPassword= "Confirm password";
  static const String iAgreeWith = "I agree with ";
  static const String terms = "terms";
  static const String ofServiceAnd = "of service and";
  static const String policy = "policy";
  static const String register = "Register";
  static const String alreadyHaveAnyAccount = "Already have any account?";
  static const String signUp = "Sign up";
  static const String selectYourChoice = "Select your choice";

  ///<===================== These for the verify otp screen ====================>

  static const String pleaseVerifyYourAccount = "Please verify your account";
  static const String youAreAlmostThere= "You're almost there! We’ve sent a 6-digit code to your email. Please enter the code to verify your email address";
  static const String verify="Verify";
  static const String cantFindTheEmail="Can’t find the email?";
  static const String  resendEmail=" Resend Email.";
  static const String  success="SUCCESS";
  static const String  congratulations="Congratulations! Your account has been successfully created.";
  static const String  Coontinue="Continue";
  static const String  chooseYourLanguage="Choose your language";
  static const String  selectYourPreferred="Select your preferred language";
  static const String  english="English";
  static const String  hebrew="Hebrew/עִברִית";
  static const String  spanish="Spanish/Española";
  static const String  rangeOfStudent="Range of students";

  ///<============== These for the forgot pass screen ==========================>

  static const String  enterYourEmailBelowToReset="Enter your email below to reset your password";
  static const String  submit="Submit";
  static const String  enterThe6digit="Enter the 6-digit code sent to your email.";
  static const String  createNewPassword="Create New Password";
  static const String  bothPasswordsMustMatch="Both passwords must match.";
  static const String  resetPassword="Reset Password";
  static const String  yourNewPasswordMustBeDifferent="Your new password must be different from previous passwords.";

  ///<====================== These for the student part ========================>

  static const String wantToLearn="WANT TO LEARN";
  static const String  joinFreeSeminar="JOIN FREE SEMINAR";
  static const String  ourChoice="OUR CHOICE";
  static const String  viewAll="View all";
  static const String  bestFreelancerExpert="BEST FREELANCER EXPERT";

  ///<====================== These for the search screen =======================>

  static const String searchFilter="Search & Filter";
  static const String englishCourse="English Course";
  static const String gender="Gender :";
  static const String selectDateTime="Select Date & Time:";
  static const String hourlyRate="Hourly Rate:";
  static const String hour="hour";
  static const String apply="Apply";
  static const String englishCourses="English Courses ";
  static const String ourCourse="Our Course";
  static const String freelancerCourse="Freelancer Course";

  ///<======================= This for the notification screen ==================>

  static const String notifications="Notifications";

  ///<=========================== This is for the  course details screen =========>

  static const String courseDetails="Course Details";
  static const String enrolledBy="Enrolled by";
  static const String courseCurriculum="Course Curriculum";
  static const String price="Price";
  static const String buyNow="Buy Now";
  static const String instructorsReviews="Instructor’s Reviews";
  static const String haveAnyOther="Have any other questions?";
  static const String callOn="Call on";
  static const String promoCode="Promo Code";
  static const String writeYourPromoCode="write your promo code";
  static const String writeYourSkill="write your skill";
  static const String freeSeminar="Free Seminar";
  static const String freeSeminarDetails="Free Seminar Details";
  static const String freeSeminarWith="Free Seminar with";
  static const String bookThisSeminar="Book this  Seminar";
  static const String confirmBooking="Confirm Booking";
  static const String youMustHaveAProfile="You must have a profile to confirm the booking of the free seminar";

  ///<================== This is for my course screen ===========================>

  static const String myCourses="My Courses";
  static const String course="Course";
  static const String myCourseDetails="My Course Details";
  static const String shareYourThoughts="Share your thoughts on your teacher";
  static const String feedbackReviews="Feedback & Reviews";
  static const String copy="Copy";
  static const String copyYourClassLink="Copy your class link";
  static const String giveYourRating="Give your Rating";
  static const String writeYourFeedback="Write your Feedback here";
  static const String submitReview="Submit Review";
  static const String instructorsProfile="Instructors profile";
  static const String aboutInstructor="About Instructor";
  static const String Skills="Skills";
  static const String othersInformations="Others informations";
  static const String education="Education";
  static const String skill="Skill";
  static const String dateOfBirth ="Date of Birth ";
  static const String country ="Country";
  static const String instructorCourses ="Instructor Courses";
  static const String myProfile ="My Profile";
  static const String purchasedCourse ="Purchased Course";

  ///<====================== This is for the my profile screen ==================>

  static const String profileUserNAme ="User Name";
  static const String profileNAme ="User Name";
  static const String profileGender ="Gender";

  static const String email ="Email";
  static const String profileEmail ="Email";
  static const String profileContact ="Contact Number";
  static const String profileAddress ="Address";
  static const String profileCardNumber ="Card number";
  static const String saveAndUpdate ="Save & Update";
  static const String profileBanner ="Profile Banner";
  static const String editProfile ="Edit Profile";
  static const String profileEducation ="Education";
  static const String profileDateOfBirth ="Date of Birth";
  static const String profileCountry ="Country";
  static const String profileLocation ="Location";
  static const String profileDesignation ="Designation";
  static const String profileExperience ="Experience";
  //static const String profileGender ="Gender                  :";

  ///<==================== This is for the drware screen =========================>

  static const favoriteProfiles="Favorite Profiles";
  static const settings="Settings";
  static const complainBox="Complain Box";
  static const aboutUs="About Us";
  static const privacyPolicy="Privacy Policy";
  static const termsAndConditions="Terms & Conditions";
  static const fAQ="FAQ";
  static const logOut="Log out";
  static const language="Language";
  static const changePassword="Change password";
  static const deleteAccount="Delete account";
  ///<==================== This is for Change Password screen ====================>

  static const String yourPasswordMustBeAtLeast6="Your password must be at least 6 characters and should include a combination of numbers and letters";
  static const String currentPassword="Current password";
  static const String newPassword="New password";
  static const String reTypeNewPassword="Re-type new password";

  ///<=================== This is for the delete account =========================>

  static const String deleteYourShpitzeAccount="Delete your Shpitze account?";
  static const String pleaseEnterYourPasswordTo="Please enter your password to confirm account removal";
  static const String thisWillDeleteYour="This will delete your personal data permanently from your system. This action can not be undone.";

  ///<====================== This is for the complain box ====================>

  static const String youWantrtoComplain="you want to complain!";
  static const String pleaseEnterYourProblem="Please Enter your problem, Our admin will analyze your comment and appropriate action will be taken.";
  static const String complainOn="Complain on";
  static const String writeYourOpinion="Write your opinion";
  static const String confirmComplain="Confirm Complain";


  ///<======================= This i the Teacher part home screen ================>

  static const String status="Status";
  static const String rating="rating";
  static const String totalRating="Total rating";
  static const String courseStatistics="COURSE STATISTICS";
  static const String totalCourse="total course";
  static const String courseTaker="course taker";

  ///<====================  This is for the my course section =================>

  static const String runningCourse="Running Course";
  static const String mySeminar="My Seminar";
  static const String previousCourse="Previous Course";
  static const String myCoursePlan="My Course Plan";
  static const String selectLectureDate="Select Lecture Date";
  static const String className="Class Name";
  static const String areYouSureYouWantToCancel="Are you sure you want to cancel this Lecture?";
  static const String nO="NO";
  static const String yes="YES";
  static const String hello="Hello";
  static const String yourNewCourseComplete="your new Course Complete";
  static const String isSuccessfullyCompleted="is successfully completed";
  static const String beforeAStudentEnrolls="Before a student enrolls, course editing is available.";
  static const String editCourseDetails="Edit Course Details";
  static const String courseBanner="Course Banner";
  static const String courseName="Course Name";
  static const String completeEnglishCourse ="Complete English course ";
  static const String classTime ="Class time";
  static const String startTime ="Start time";
  static const String endTime ="End time";
  static const String totalLecture ="Total Lecture";
  static const String confirm ="Confirm";
  static const String saveAndChange ="Save & Change";
  static const String create ="Create";
  static const String myStudents ="My Students";

  ///<======================= This for earning screen ==========================>

  static const String earning="EARNING";
  static const String totalEarning="Total Earning";
  static const String monthlyEarning="Monthly Earning";
  static const String pendingEarning="Pending Earning";



  ///<======================== This is for the My Course Plan screen =============>
  static const String createAnewCourse="Create a new Course";
  static const String addCourse="Add Course";
  static const String coursesPlan="Courses Plan";
  static const String home="Home";
  static const String profile="Profile";
  static const String about="About";
  static const String menu="menu";
}
