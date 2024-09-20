# 트위터 클론 코딩

[Udemy 트위터 클론 코딩](https://www.udemy.com/course/twitter-ios-clone-swift/?couponCode=OF83024D)


### 🌟 기능 및 구현 내용  
<hr>

<img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/메인탭.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/게시글작성.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/알림.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/유저검색.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/프로필1.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/프로필reply.PNG" alt="" width="110" height="200">  <img src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/프로필LIKE.PNG" alt="" width="110" height="200">

### - 🛠️ 처음 써본 기술
<hr>  
    - Firebase 를 활용한 서버 통신 및 인증 (로그인, 회원 등록)  


### 🐚 주요 기능
<hr>

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
<hr>

| 카테고리 | 이름 |  태그   |  
| :--------: | :--------: | :------: | 
|   프레임워크    |   UIKit    | Codebase |
|   Library    |   Firebase    | Database, Authentication | 
|       |   SDWebImage    | Image Caching |


### 앱 구동 화면
<hr>

| 로그인화면 | 회원가입 | 좋아요 알림 |  팔로잉, 좋아요, 게시글 | 
| :--------: | :--------: | :------: | :------: |  
| <img width="225" src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/로그인화면.gif> | <img width="225" src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/회원가입.gif> | <img width="225" src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/좋아요알림.gif> | <img width="225" src="https://github.com/Seo-garden/Twitter-Clone/blob/main/image/팔로잉기능, 좋아요, 게시글작성.gif> |  

