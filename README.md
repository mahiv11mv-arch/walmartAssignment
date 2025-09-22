
# Countries SOLID (UIKit) 

**Build & Run** (⌘R). You should see the Countries list after it fetches.

Based on requirement The coutries json list is decoded and country name region and capital is displayed according to requirement. I have followed Solid design principle here. Data , Domain and presentation layers. The viewcontroller has a tableview which is created in a storyboard and the cell template in a xib. 
    Seperation of concerns , dependency injection are implemented.


## Notes

- **Dependency Injection** at `AppCoordinator` is the composition root. DI and coordination class "AppCoordinator" class does all initialization and step by step dependency injections.

- **Dynamic Type** and accessible labels supported. In Domain we have seperation like Model , Repository and UseCases. There are two use cases , 1. Fetch countries from api  2. Filter based on Country or capital city. The presentation layer also contains different states 1. empty or initial state of the search or filter. 2. Error state of the filter when a random non existent country or state is typed. Model contains the json format in which the data is received . like name , region , code and capital.

- **Rotation/iPad** works via self-sizing table cells. Autolayout is achieved programatically in setup() function. It allows the cells to adjust in portrait or landscape. 

- **Search** filters by *name* or *capital* per keystroke. Search bar is implemented which filters the by city or capital. 

