# Webview_sdk_switf3
> Switf3 Webview기반에 tyle sdk를 사용하기 위한 방법

#요구사항
- 스펙
 - Switf3
 - WKWebview
 - WKScriptMessageHandler
- 방식
 - 다양한 모바일OS에 대응
 - 인젝션 방식으로 타일에서는 소스에 변화가 없이 대응

#방법
- `WKWebview` 로 webview 로드
- `WKUserScript` 로 타일웹에 삽입할 javascript 소스 삽입
- `WKWebViewConfiguration` 로 configure 설정
- `userContentController` 메서드에서 타일에서 반환하는 message 결과값 전달 받는다.
- 타일웹에서 `webkit.messageHandlers.xxxx.postMessage(result);` 실행하면 전달됨(xxx는 원하는 이름 지정)
