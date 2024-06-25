# Twitter-Clone

Xcode 업데이트 후 xcworkspace 파일 열리지 않는 이슈 해결 -> xcworkspace 지우고 pod install 다시 하면 된다.

오랜만에 클론코딩 앱을 실행해보니까 로그인 및 회원가입이 안되는 케이스가 생겼음,
첫번쨰로, Storage 에서 규칙을 
allow read, write: if request.time < timestamp.date(2024, 4, 27); 에서 allow read, write: if true; 로 수정하고 ".read": true, ".write": true 로 수정했음
