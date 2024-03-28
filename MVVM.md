# MVVM

MVVM 패턴 또한 MVC와 마찬가지로 애플리케이션 개발에 주로 사용되는 디자인 패턴이다.  
MVC 와 다르게 Controller 가 아닌 ViewModel 계층을 가지고 있다. ViewModel 또한 Controller 처럼 View 와 Model 의 중간 계층 역할을 하고 있다.  
- Model은 MVC 에서 Model 과 마찬가지로 데이터와 관련된 코드를 담고있다. 데이터를 담아두기 위한 구조체들은 물론, 네트워크 로직, JSON 파싱 코드를 담고 있다.  

-> Model 은 View, ViewModel 계층을 전혀 신경쓰지 않아도 된다. 데이터를 어떻게 가지고 있을 지만 생각하면 되고, 그 이상의 비즈니스 로직이나 View에서 프로퍼티들을 어떻게 보여주는지에 굳이 맞출 필요는 없다.⭐️

- View는 앱의 UI 에 대한 코드를 담고 있는 계층이다. View의 각 컴포넌트에 대한 정보를 담고, 어느 위치에 어떻게 배치될지 작성되어 있다. View 는 디자인적인 요소도 있지만, ViewModel로부터 데이터를 가져와 어떻게 배치할지, 특정 상황에 따라 ViewModel 의 어떤 메서드를 이용할지에 대해서도 가지고 있다. MVC와 마찬가지로 View 는 재사용성이 강조되며, 컴포넌트를 적당히 잘 나누어 중북된 코드를 줄이는 것이 중요하다.  

-> View 는 이런 식으로 재사용할 수 있는 View 를 따로 만들어 같은 코드를 여러번 작성하지 않고 재사용성을 살릴 수 있다. MVVM 패턴에서 View 는 Model 을 직접 소유하지 않아야 한다. ViewModel로 부터 받아와서 View 에 정보를 집어 넣어주는 방식이 일반적이다.

- ViewModel 은 앱의 핵심적인 비즈니스 로직을 담고 있는 코드의 계층이다. MVC 패턴의 Controller와 비슷한 역할을 하고있다. View 와 Model 의 사이에서 View 의 요청에 따라 로직을 실행하고, Model 의 변화에 따라 View 를 refresh 하는 등, 유사한 점이 많다.   

-> Model 에 뭔가 변화가 생기면 View 에게 notification 을 보내주는 역할을 한다. 또한, View 로 부터 전달받는 요청을 해결할 비즈니스 로직들을 담고 있다. ViewModel 은 UI 관련 코드로 부터 완전히 분리되어 있고, 따라서 ViewModel 파일에는 SwiftUI 같은 프레임워크를 import 할 이유 조차 없다.

### iOS 개발이 MVC 에서 MVVM 으로 넘어가는 이유

기존에 많이 사용한 UIKit 은 MVC 패턴을 기반으로 만들어졌다. 일단 ViewController 이름부터 Controller 가 붙어있으니, 하지만 비교적 최근에 나온 애플의 야심작인 SwiftUI는 MVC가 아닌 MVVM 패턴을 기반으로 한다. 이론 상으로 봤을 땐 Controller 계층과 ViewModel 계층이 맡은 역할이 크게 다르지 않아 보이는데, iOS 개발에서는 MVC와 MVVM 에서 어떤 큰 차이를 가지고 있나?  

우선 UIKit 의 MVC 에서는 ViewController 가 거의 모든 역할을 하고 있다. ViewController 단위로 한 화면(Scene) 이 구성되었다. Controller 는 View 계층, Model 계층을 모두 소유하고 있으며, Model 의 notification 도, View 가 유저 상호작용을 전달하는 방식도 모두 Delegation 방식을 통해 VC 가 떠맡고 있었다.  
하지만 SwiftUI 의 MVVM 에서는 View가 ViewModel 을 소유하고, ViewModel 이 Model 을 소유하는 방식이다. Controller 단위로 화면이 구성되는 것이 아닌, 해당 화면을 주도하는 것은 View 이다. 각 View 가 필요한 비즈니스 로직(ViewModel) 들을 가져와 사용하는 구조다.  
-> 따라서 View 와 Model 을 모두 알고 있었어야 하는 Controller 와 달리, ViewModel 은 View 에 대해서는 알고 있을 필요가 없다.

SwiftUI 를 먼저 학습한 후에 다시 다루도록 하자.
[참고한 링크](https://medium.com/hcleedev/ios-swiftui%EC%9D%98-mvvm-%ED%8C%A8%ED%84%B4%EA%B3%BC-mvc%EC%99%80%EC%9D%98-%EB%B9%84%EA%B5%90-8662c96353cc)
