---
title: WebView 환경에서의 History API와 Routing 삽질기 (feat. Vue)
description: WebView 내에서 효과적인 라우팅 관리 방법을 심화 탐구하고, 안드로이드 백버튼 이벤트 처리 방안을 제시합니다.
author: Ferv0r2
date: 2025-01-26 12:00:00 +0900
categories: [frontend, webview, history,routing, mobile development, vue]
tags: [vue3, vue-router, webview, routing management, history API, frontend development, mobile web]
render_with_liquid: false
image: /assets/img/post/20250118/webview-routing-banner.jpg
---

## **들어가며**

현재 사내에서는 모바일 애플리케이션 개발 시, WebView를 활용하여 웹 콘텐츠를 앱 내에서 표시하고 있습니다.

WebView는 웹 기술을 이용한 **빠른 개발과 플랫폼 간 호환성**을 제공하지만, 네이티브 앱과의 상호작용에서 발생할 수 있는 여러 문제를 동반합니다.

이번 포스팅에선 WebView 환경에서의 **라우팅 관리**와 **안드로이드 백버튼 동작과의 충돌 문제**를 다루었습니다.

이러한 문제를 해결하기 위한 시행착오 공유하고 효과적으로 처리하는 방법을 소개합니다.

## **문제의 배경**

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

## 문제 해결 방식

### 전체적인 라우팅 관리 - store를 통해 historyStack 관리

![Desktop View](/assets/img/post/20250126/stack.png){: width="360" .normal}
>  별도 store를 통해 historyStack을 관리

기존 `router`를 `override`하고 `store`를 통해 `historyStack`을 별도로 구축하여 진행하였습니다.


`override`된 `router.back()`은 원하는 `route.name`을 찾을 때까지 `window.history.go(-n)`를 통해 이동하는 것이었습니다.

이로 인해 프로세스를 중단하고 예상 시나리오대로 진행되지 않더라도 오류가 발생하지 않도록 진행하였습니다.


### 안드로이드 백버튼 이벤트 처리의 변화

기존 접근 방식에서는 안드로이드 백버튼을 눌렀을 때, 네이티브에서 `window.history.go`를 통해 히스토리를 조작하려 했습니다.

그러나 이제는 백버튼이 눌렸다는 이벤트만을 수신하여 처리하고, 홈 화면인 경우 네이티브에 앱을 종료하려고 한다는 요청을 보냅니다.

이는 보다 정밀한 히스토리 관리와 예측 가능한 라우팅 동작을 구현하는 데 도움이 됩니다.

## 시행착오

하지만 앞서 공유 드린 방식을 적용했음에도 불구하고 여전히 버그를 포함하고 있었습니다.

A -> B -> C에서 A로 돌아가는 경우 B의 mount 메서드를 호출하였고, 에러 페이지로 라우팅되었습니다.

이는 `window.history.go`의 동작 방식을 오해한 결과였고 실제 `window.history`를 n만큼 `popState`하는 것이 아닌 `index`만 이동하는 것을 확인하였습니다.

### window.history.go(-2)의 동작 방식

![Desktop View](/assets/img/post/20250126/routing.png){: width="360" .normal}

저를 포함한 많은 개발자들이 `window.history.go(-2)`를 호출하면 현재 페이지에서 두 단계 뒤로 바로 이동한다고 생각하지만, 실제 동작 방식은 다릅니다.

예를 들어, 현재 페이지가 C, 이전 페이지가 B, 그 이전 페이지가 A일 때, window.history.go(-2)는 C에서 B로 이동한 후, B에서 A로 이동하는 두 단계의 이동을 수행하게 됩니다. 이 과정에서 중간 페이지인 B의 Mount 이벤트가 트리거됩니다.

```js
// 예제 시나리오
// 현재 페이지: C
// 이전 페이지: B
// 그 이전 페이지: A

window.history.go(-2);
// 실제 동작: C → B (Mount 이벤트 발생) → A (Mount 이벤트 발생)
```

## 캐싱과 렌더링의 강점

`window.history.go`나 `vue-router`의 히스토리 메서드를 활용한 히스토리 이동은 브라우저의 캐싱 메커니즘과 연동되어 렌더링 성능에 긍정적인 영향을 미칩니다.

브라우저는 이미 방문한 페이지를 캐싱하고 있기 때문에, 히스토리 이동 시 페이지를 다시 로드하지 않고 캐시된 상태를 활용하여 빠르게 렌더링할 수 있습니다.

이는 사용자 경험을 향상시키는 중요한 요소입니다.

하지만, 캐싱된 페이지가 예상치 못한 상태로 렌더링되는 것을 방지하기 위해, 페이지의 상태 관리를 철저히 해야 합니다.

Vuex나 Pinia와 같은 상태 관리 라이브러리를 활용하여 페이지의 상태를 중앙에서 관리하는 것도 좋은 방법입니다.

## 라우팅 관리의 최적화 전략

효과적인 라우팅 관리를 위해서는 히스토리 스택의 명확한 관리와 네이티브-웹 간의 원활한 통신이 필수적입니다. 다음은 이를 위한 최적화 전략입니다.

1. vue-router의 기능 활용
vue-router 4는 다양한 기능을 제공하여 라우팅을 효과적으로 관리할 수 있도록 도와줍니다.

예를 들어, 네비게이션 가드(Navigation Guards)를 사용하여 라우팅 전후에 특정 로직을 수행할 수 있습니다.

```js
// router/index.js
router.beforeEach((to, from, next) => {
  // 인증 체크 등
  if (to.meta.requiresAuth && !isAuthenticated()) {
    next({ name: 'Home' });
  } else {
    next();
  }
});
```