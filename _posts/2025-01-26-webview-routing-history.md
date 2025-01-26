---
title: WebView 환경에서의 History API와 Routing 삽질기 (feat. Vue)
description: WebView 내에서 효과적인 라우팅 관리 방법을 심화 탐구하고, 안드로이드 백버튼 이벤트 처리 방안을 제시합니다.
author: Ferv0r2
date: 2025-01-26 12:00:00 +0900
categories: [frontend, webview, history,routing, mobile development, vue]
tags: [vue3, vue-router, webview, routing management, history API, frontend development, mobile web]
render_with_liquid: false
image: /assets/img/post/20250126/banner.jpg
---

## **들어가며**

현재 사내 프로젝트에서는 모바일 애플리케이션 개발 시, WebView를 활용하여 웹 콘텐츠를 앱 내에서 표시하고 있습니다.

WebView는 웹 기술을 이용한 **빠른 개발과 플랫폼 간 호환성**을 제공하지만, 네이티브 앱과의 상호작용에서 발생할 수 있는 여러 문제를 동반합니다.

이번 포스팅에선 WebView 환경에서의 **라우팅 관리**와 **안드로이드 백버튼 동작과의 충돌 문제**를 다루었습니다.

이러한 문제를 해결하기 위한 시행착오 공유하고 효과적으로 처리하는 방법을 소개합니다.

## **문제의 배경**

> 새로운 시나리오와 기존 설계의 한계

기존 자사 앱에서는 특정 플로우가 끝날 때마다 항상 홈화면으로 돌아가도록 설계되어 있었습니다.

이를 위해 레거시 코드에서는 `window.history.go(-window.history.length)`를 사용하여 히스토리를 일괄적으로 관리하였습니다.

```js
function goToHome() {
  window.history.go(-window.history.length);
}

// 레거시 로직 예제
```

하지만 새로운 서비스를 추가하고, 리뉴얼하면서 사용자가 홈화면이 아닌 다른 화면으로 이동할 수 있게 되었고,

이로 인해 안드로이드 백버튼을 눌렀을 때 **예상치 못한 동작**이 발생하게 되었습니다.

화면에 있는 뒤로 가기 버튼이 아닌 기기의 백버튼은 `window.back()`으로 `popState`를 호출하고 있었고, 이에 대한 안드로이드 사용자 경험을 지키기 위해 별도 처리가 필요하였습니다.

네이티브에선 아직 `window.history`가 남아있지만 웹뷰에서는 홈 화면을 보여주면서 **이미 완료한 프로세스**로 돌아가 오류를 발생시키던 것이었습니다.

## **문제 해결 방식**

![Desktop View](/assets/img/post/20250126/stack.png){: width="720" .normal}

>  store를 통한 historyStack 관리

- Router Override

  기존 `router`를 `override`하고 `store`를 통해 `historyStack`을 별도로 구축하여 진행하였습니다.


  `override`된 `router.back()`은 원하는 `route.name`을 찾을 때까지 `window.history.go(-n)`를 통해 이동하는 것이었습니다.

  이로 인해 프로세스를 중단하고 예상 시나리오대로 진행되지 않더라도 오류가 발생하지 않도록 진행할 수 있었습니다.


- 안드로이드 백버튼 이벤트 처리의 변화

  기존 접근 방식에서는 안드로이드 백버튼을 눌렀을 때, 네이티브에서 `window.history.go`를 통해 히스토리를 조작하려 했습니다.

  그러나 이제는 백버튼이 눌렸다는 이벤트만을 수신하여 처리하고, 홈 화면인 경우 네이티브에 앱을 종료하려고 한다는 요청을 보냅니다.

  이는 보다 정밀한 히스토리 관리와 예측 가능한 라우팅 동작을 구현하는 데 도움이 됩니다.

## **시행착오**

> window.history.go 동작 방식에 대한 오해

하지만 앞서 공유 드린 방식을 적용했음에도 불구하고 여전히 버그를 포함하고 있었습니다.

A -> B -> C 시나리오에서 C 페이지 내의 백버튼을 눌렀을 때, A 페이지가 아닌 에러 페이지로 라우팅되었습니다.

이는 `window.history.go`의 동작 방식을 오해한 결과였고 실제 `window.history`를 n만큼 `popState`하는 것이 아닌 `index`만 이동하는 것을 확인하였습니다.

즉, history의 length는 동일하며 사용자가 시나리오 내에서 동일한 페이지가 요청되는 경우, 잘못된 라우팅이 발생하는 것입니다.

### window.history.go()의 동작 방식

![Desktop View](/assets/img/post/20250126/routing.png){: width="720" .normal}

> window.history.go(-2) 동작 방식

`window.history.go(-2)`를 호출하면 현재 페이지에서 두 단계 뒤로 이동한다고 생각하기 쉽습니다. 하지만 실제로는 다음과 같이 동작합니다:

- 현재 페이지: C
- 이전 페이지: B
- 그 이전 페이지: A

```
window.history.go(-2);
// 동작 과정: C -> B -> A
```

이를 해결하기 위해 `pushState`, `replaceState`만 사용하여 시나리오를 관리하기 위해 router를 추가적으로 수정하였고, 이를 통해 문제를 해결할 수 있었습니다.

### 아쉬운 점

> history.back의 캐싱

`window.history.go` 나 `window.history.popState`등의 히스토리 메서드를 활용한 히스토리 이동은 브라우저의 캐싱 메커니즘과 연동되어 렌더링 성능에 긍정적인 영향을 미칩니다.

브라우저는 이미 방문한 페이지를 캐싱하고 있기 때문에, 히스토리 이동 시 페이지를 다시 로드하지 않고 캐시된 상태를 활용하여 빠르게 렌더링할 수 있습니다.

하지만 `replaceState`를 사용하여 이동한다면 이를 사용할 수 없어 문제였는데요.

현재 Webview 서비스는 SPA였기 때문에 history들을 따로 캐싱해주어 `replaceState`를 진행해도 데이터를 새로 로드하지 않았습니다.


## **마치며**

WebView 환경에서의 라우팅 관리는 네이티브 앱과의 상호작용을 고려해야 하는 만큼, 단순한 히스토리 조작만으로는 예기치 않은 문제가 발생할 수 있습니다.

이번 글에서는 router를 override하여 백버튼 이벤트를 직접 처리하고, store를 통해 히스토리를 관리하는 방안을 소개했습니다.

가장 중요한 것은 히스토리 스택의 명확한 관리와 네이티브-웹 간의 원활한 통신입니다.

이를 통해 백버튼과 같은 네이티브 동작과 웹 라우팅을 효과적으로 조율할 수 있습니다.

이번 고민을 통해 히스토리 관리의 복잡성을 줄이고 성능과 사용자 경험을 향상시킬 수 있습니다.

WebView를 활용한 애플리케이션 개발 시, 이러한 라우팅 관리 전략을 고려하여 안정적이고 예측 가능한 사용자 경험을 제공하는 것이 중요합니다.

WebView 기반 프로젝트를 진행하는 모든 개발자들에게 이 글이 유익한 참고 자료가 되길 바랍니다. 앞으로도 관련 경험과 노하우를 공유하겠습니다. 🚀

