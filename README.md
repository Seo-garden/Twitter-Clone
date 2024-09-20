# 트위터 클론 코딩

[Udemy 트위터 클론 코딩](https://www.udemy.com/course/twitter-ios-clone-swift/?couponCode=OF83024D)


### 🌟 기능 및 구현 내용  
<br/>

<img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/메인탭.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/게시글작성.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/알림.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/유저검색.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/프로필1.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/프로필reply.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/프로필LIKE.PNG" alt="" width="110" height="200">

### 🛠️ 처음 써본 기술
<br/>  
    Firebase 를 활용한 서버 통신 및 인증 (로그인, 회원 등록)  


### 🐚 주요 기능
<br/>

    1. 메인탭
    - 사용자가 팔로우 한 트윗을 가져와서 보여줌
    - refreshControl 을 사용해 업데이트
    - 팔로우한 다른 사용자 트윗에 댓글 게시 기능
    - 프로필 보기 
    - 트윗 상세보기
    
    2. 게시글 작성
    - 사용자가 작성한 게시글을 바로 피드에 보여줌
    
    3. 알림
    - 자신을 팔로우하거나 좋아요, 댓글을 남기면 알림이 전송 (firebase > notifications 에 저장)

    4. 유저 검색
    firebase > users 에 포함된 모든 유저를 표시해주고 검색 기능을 통해 필터링해서 검색이 가능함
    
    5, 5-2, 5-3. 프로필
    5. 사용자가 올린 게시글 표시
    5-2. 사용자가 (본인을 포함한 다른)사용자에게 댓글을 남긴 게시물 표시
    5-3. 사용자가 (본인을 포함한 다른)사용자에게 좋아요를 남긴 게시물 표시


### 🛠️ Framework + Library
<br/>

| 카테고리 | 이름 |  태그   |  
| :--------: | :--------: | :------: | 
|   프레임워크    |   UIKit    | Codebase |
|   Library    |   Firebase    | Database, Auth, Core, Storage | 
|       |   SDWebImage    | Image Caching |


### 📱 앱 구동 화면
<br/>

| 로그인화면 | 회원가입 | 팔로잉, 좋아요, 게시글 | 
| :--------: | :--------: | :------: | :------: |  
| ![로그인화면](https://github.com/Seo-garden/Twitter-Clone/blob/main/image/%EB%A1%9C%EA%B7%B8%EC%9D%B8%ED%99%94%EB%A9%B4.gif) | ![회원가입](https://github.com/Seo-garden/Twitter-Clone/blob/main/image/회원가입.gif) | ![팔로잉, 좋아요, 게시글](https://github.com/Seo-garden/Twitter-Clone/blob/main/image/팔로잉기능,좋아요,게시글작성.gif) |

### 🌟 완성하기까지의 과정 😅
<br/>

<details>
  <summary>⭐️ 배운점</summary>        
  지금까지의 개발 공부를 할 때 프레임워크를 완벽하게 다룰줄 아는 상태에서 개발을 들어가야 한다고 생각했었습니다. 꼼꼼한 재은씨 책을 보며 공부를 할 때도 이럴 땐 이런걸 써야지 하고 외우는 식으로 공부를 진행했었습니다. 하지만 이렇게 외우는 과정은 넓은 범위의 프레임워크를 이해하는데에 있어서 많은 시간을 소비하게 되고, 점점 외워갈수록 외워서 기억하는 양보다 잊어버리는 양이 더 많아지는 상황이 발생했었습니다. 사실 제가 iOS 를 택한 계기도, "내가 직접 앱을 만들어보자" 인데, 앱을 만들기 위해 끝이 어딘지도 모를 공부만 계속 하고있었던 것입니다. 이 강의를 통해 UIKit 의 여러 요소들을 직접 사용해보고, 실시간 데이터베이스인 Firebase 를 직접 사용해보며, 앱의 전체 흐름파악이 된 소중한 경험인 것 같습니다.
</details>

<details>
  <summary>⭐️ cocoapods VS SPM </summary>
  Firebase 와 SDWebImage 와 같은 라이브러리를 이용하기 위해서는 의존성 관리도구를 사용해야 합니다. 이 둘의 장단점에 대해 간략하게 정리하려 합니다.  
  
  cocoapods: 대부분의 라이브러리가 지원하는 의존성 관리도구로, 라이브러리의 의존성을 자동으로 관리해주기 때문에 개발자는 수동으로 다운로드 하고 추가하는 과정을 거치지 않아도 됩니다. 하지만 여러 라이브러리를 사용하게 될 경우 의존성관리를 어렵게 만들 수 있고, 프로젝트에 많은 라이브러리를 추가할 경우 빌드 속도가 느려질 수 있습니다.
  
  SPM: 애플 플랫폼에서 사용하는 Swift 기반의 소프트웨어를 패키지를 관리할 수 있는 도구로, 애플 플랫폼에서만 사용할 수 있는 라이브러리나 프레임워크를 사용할 수 있습니다. SPM 의 경우 빌드 시에 의존성을 체크하는 과정이 없기 때문에 빌드 속도가 빠릅니다. 설치된 라이브러리는 프로젝트에 포함되지 않기 때문에 프로젝트 용량을 줄일 수 있습니다. 단점이라고 꼽자면 SPM 은 애플 플랫폼에서만 사용할 수 있는 라이브러리나 프레임워크를 지원하지 않는 경우에는 선택하는 것에 있어서 제한이 될 수 있습니다.  
</details>
