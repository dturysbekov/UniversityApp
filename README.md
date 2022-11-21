# University Application
Application that has 3 pages:
1) Page 1 A list of selected universities
   - In each cell there should be the name of the university
   - Ability to delete from the table
   - When pressed, we get to the next Page 3
   - When pressed '+', we get to the Page 2
2) Page 2 A list of universities from public API:
   - Ability to search university by country
   - When pressed, university will be added to the Page 1, to the list of Selected Universities and 'plus' icon will be changed to 'checkmark', 
   saved to CoreData as long as university in Selected list, you won't be able to add it again, so that we avoid duplicates.
   
2) Page 3 Details on selected university:
   - Ability to see the details of university, as country, domains and etc.
 
## Requirements:
 - Swift
 - The user interface of the application is configured by code using SnapKit
 - UIKit programmatically, SnapKit, CoreData, MVVM, Alamofire

## Installation

1) In root directory of the project run:
```bash
$ pod install
```
2) Open `UniversityApp.xcworkspace` file





https://user-images.githubusercontent.com/71511290/203101418-bcead63f-f34c-44b5-baf8-c1d09dad0b95.mp4

