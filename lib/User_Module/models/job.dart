class Job {
  String company;
  String logoUrl;
  bool isMark;
  String title;
  String location;
  String time;  
  List<String> req;
  Job(this.company, this.logoUrl, this.isMark, this.title, this.location,
      this.time, this.req);
  static List<Job> generateJobs() {
    return [
      Job(
        'Google LLC',
        'assets/images/google.png',
        false,
        'Software Engineer',
        'Rajkot,India',
        'Full time',
        [
          'very Good Company',
          'Provide High Salary',
          'sdjgnsdjgn',
          'ahvbavjavnas'
        ],
      ),
      Job(
        'Meta LLC',
        'assets/images/google.png',
        false,
        'Software Engineer',
        'Rajkot,India',
        'Full time',
        [
          'very Good Company',
          'Provide High Salary',
          'sdjgnsdjgn',
          'ahvbavjavnas'
        ],
      ),
      Job(
        'Meta LLC',
        'assets/images/google.png',
        false,
        'Software Engineer',
        'Rajkot,India',
        'Full time',
        [
          'very Good Company',
          'Provide High Salary',
          'sdjgnsdjgn',
          'ahvbavjavnas'
        ],
      ),
      Job(
        'Meta LLC',
        'assets/images/google.png',
        false,
        'Software Engineer',
        'Rajkot,India',
        'Full time',
        [
          'very Good Company',
          'Provide High Salary',
          'sdjgnsdjgn',
          'ahvbavjavnas'
        ],
      ),
      Job(
        'Meta LLC',
        'assets/images/google.png',
        false,
        'Software Engineer',
        'Rajkot,India',
        'Full time',
        [
          'very Good Company',
          'Provide High Salary',
          'sdjgnsdjgn',
          'ahvbavjavnas'
        ],
      ),
      Job(
        'Meta LLC',
        'assets/images/google.png',
        false,
        'Software Engineer',
        'Rajkot,India',
        'Full time',
        [
          'very Good Company',
          'Provide High Salary',
          'sdjgnsdjgn',
          'ahvbavjavnas'
        ],
      ),
    ];
  }
}
