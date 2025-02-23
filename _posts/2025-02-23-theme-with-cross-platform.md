---
title: "D'CENT 앱 리뉴얼: 테마 적용과 크로스 플랫폼 이슈 해결기 (feat. Vue)"
description: "D'CENT 앱 리뉴얼 프로젝트에서 다크 테마 도입 과정과 발생한 크로스 플랫폼 이슈를 해결한 경험을 공유합니다. iOS 호환성 문제를 극복한 과정을 상세히 다룹니다."
author: Ferv0r2
date: 2025-02-23 16:00:00 +0900
categories: [webview, theme, frontend, cross-platform]
tags: [D'CENT, theme, iOS, Safari, compatibility, refactoring, Scss]
render_with_liquid: false
image: https://store.dcentwallet.com/cdn/shop/articles/app-67930e689e231_73f62d71-8db5-4ee8-b181-4dbba2431ec0_1100x.webp?v=1738747206
---

## **들어가며**

2018년 10월에 첫 배포된 자사 앱 D'CENT가 이번에 [대대적인 리뉴얼](https://store-kr.dcentwallet.com/blogs/post/dcent-app-upgrade)을 맞이했습니다.

단순한 UI 개선을 넘어, 사용자 경험 향상을 위한 다크 테마 도입을 결정하게 되었는데요.

이번 글에서는 다크 테마 도입 과정을 비롯해, 그 과정에서 겪은 다양한 이슈와 해결 과정을 자세히 공유해 보겠습니다.

## 다크 테마 지원의 필요성

D'CENT 앱은 **출시 이후 7년** 동안 여러 차례 업데이트를 거쳤지만, 디자인과 테마 측면에서는 시대 변화에 다소 미흡한 부분이 있었습니다.

특히 **다크 테마 부재**는 사용자 경험 개선의 중요한 과제로 떠올랐고, 이번 리뉴얼 프로젝트의 **핵심 목표 중 하나**로 다크 테마 지원을 채택하게 되었습니다.

## Wepin 테마 방식 클론 적용

![Desktop View](https://cdn.prod.website-files.com/65fb84f92f2836e672ac7e8c/66337025fd6cc82651ee0e75_%EC%9C%84%ED%95%80%EC%A7%80%EA%B0%91%20WaaS.webp){: width="720" .normal}
> [Wepin post](https://www.wepin.io/ko/blog/wepin-workspace-launching)

초기에는 자사의 빌트인 SDK 서비스인 Wepin에서 사용 중인 테마 방식을 클론하여 진행했습니다.

이 방식은 앱의 유지보수 비용을 줄이고 구현에 집중하기 위한 선택이었습니다.

Wepin에서는 **커스텀 테마 지원**을 위해 REST API로 테마 데이터를 응답받기 위해 TypeScript로 관리하는 테마 방식을 채택하고 있습니다.

이 방식의 특징은 다음과 같습니다:

- **REST API를 통한 동적 테마 데이터 수신:**

  서버에서 전달하는 테마 정보를 기반으로 앱 내 스타일을 동적으로 구성합니다.

- **TypeScript를 활용한 테마 관리:**

  TS의 타입 시스템을 활용해 테마 데이터의 안정성을 높이고, 컴포넌트 단위로 색상 값을 관리할 수 있도록 구현되었습니다.

- **`useColor` Composable의 도입:**

  Vue 환경에서 TS로 관리되는 테마 값을 DOM에서 직접 사용하기 어려운 문제를 해결하기 위해,
  
  `useColor`라는 composable을 도입해 TS에서 받아온 색상 값을 DOM에 주입했습니다.

  ```ts
  // useColor를 활용한 초기 테마 적용 예시
  const palette = computed(() => {
    // TS에서 관리하는 테마 키를 활용하여 palette 값을 산출
    return themeData.value.palette;
  });

  // DOM에서 var(--color-name) 형태로 활용하도록 연결
  document.documentElement.style.setProperty('--primary-color', palette.value.primary);
  ```

이와 같은 방식은 초기 리뉴얼 단계에서는 큰 문제 없이 작동하는 듯 보였습니다.

## 테마 적용 과정에서의 문제와 해결

### 초기 HTML 로딩 시 테마 불일치

앱 설정에서 다크 테마를 선택했음에도 불구하고,
초기 HTML 로딩 시 라이트 테마가 기본으로 적용되면서 로딩 화면의 테마가 깜빡거리는 문제가 발생했습니다.

이는 동적으로 받아온 테마 데이터가 반영되기 전에 기본값이 먼저 노출되기 때문이었습니다.

이에 대한 해결책으로 다음과 같은 접근을 하였습니다:

- **Query를 활용한 기본 테마 설정:**

  초기 로딩 시 URL query를 참고해 기본 테마를 강제로 설정하도록 변경하였습니다.

  (앱에서는 query 값을 전달하고, Webview에서는 이를 미리 반영하는 방식입니다.)

- **TS 기반에서 SCSS 기반 테마 방식으로 전환:**

  다크 테마 지원이 주목적이었기에, 동적 데이터 대신 빌드 타임에 미리 정의된 CSS 변수(`var(--name)`)를 활용하는 방식으로 전환했습니다.
  
  SCSS 방식은 초기 렌더링 시점에 **정확한 테마를 보장**할 수 있어 **사용자 경험 개선**에 크게 기여했습니다.

  ```scss
  // SCSS를 활용한 테마 변수 설정 예시
  [data-theme="light"] {
    --primary-color: #212225;
    --secondary-color: #5a5c63;
  }

  [data-theme="dark"] {
    --primary-color-dark: #ffffff;
    --secondary-color-dark: #46474c;
  }
  ```

이러한 변경을 통해 초기 HTML 로딩 시에도 올바른 테마가 적용되도록 개선할 수 있었습니다.

## iOS 16 이하에서 발생한 크로스 플랫폼 이슈

SCSS 전환 후, iOS 16 이하 버전에서 또 다른 치명적인 문제가 발생하였습니다.

**특정 메서드의 호환성 문제**로 인해 초기 로딩 과정에서 Exception이 발생해, 다음 단계로 진행할 수 없는 상황이었습니다.

### 문제의 근원: computedStyleMap의 한계

초기 구현에서 legacy 방식인 `useColor`는 TS로 관리하는 테마 키를 기반으로 DOM의 색상 값을 얻기 위해 `computedStyleMap` 메서드를 사용했습니다.

- [MDN - computedStyleMap](https://developer.mozilla.org/en-US/docs/Web/API/Element/computedStyleMap)

```ts
// custom variable을 key-value 형태로 가져오는 예시
function getThemeVariables(themeName) {
  const element = document.createElement('div')
  element.setAttribute('data-theme', themeName)
  document.body.appendChild(element)
  const styleMap = element.computedStyleMap() // this
  const variables = Array.from(styleMap)
    .filter(([key]) => key.startsWith('--'))
    .reduce((acc, [key, [value]]) => {
      acc[key] = value[0]
      return acc
    }, {})

  element.remove()
  return variables
}
```

하지만 iOS 16 이하에서는 `computedStyleMap`을 지원하지 않아, 이 방식이 동작하지 않았습니다.

### 대체 시도와 추가 문제

대안으로 `getComputedStyle`을 사용하려 했지만,
이 메서드는 실제로 적용된 CSS 속성만 반환하여 커스텀 CSS 변수(`--name`)를 누락하는 한계가 있었습니다.

- [MDN - getComputedStyle](https://developer.mozilla.org/ko/docs/Web/API/Window/getComputedStyle)

```ts
// getComputedStyle을 사용한 예시 (커스텀 변수 미노출 문제)
function getThemeVariables(themeName) {
  const element = document.createElement('div')
  element.setAttribute('data-theme', themeName)
  document.body.appendChild(element)
  const styleMap = element.getComputedStyle()
  const variables = Array.from(styleMap)
    .filter(([key]) => key.startsWith('--')) // 결과: []
    .reduce((acc, [key, [value]]) => {
      acc[key] = value[0]
      return acc
    }, {})

  element.remove()
  return variables
}
```

이와 같은 문제로 인해, 기존 `useColor`를 통한 TS 기반의 테마 관리 방식은 **근본적인 해결책이 될 수 없음**을 인식하게 되었습니다.

### 최종 해결: CSS 변수 직접 활용

SCSS 전환 덕분에, 테마의 근원은 TS에서 관리하던 값이 아니라 CSS 변수(`var(--name)`)로 설정할 수 있게 되었습니다.

결국, DOM에 직접 CSS 변수를 설정하여 `useColor` composable에 의존하지 않고, 모든 테마 적용을 CSS 변수로 관리하도록 재구성했습니다.

**AS-IS: `useColor`를 통한 색상 할당**
```vue
<script setup lang="ts">
import { useColor } from "@/composables/useColor"
import { UserIcon } from "@/components/icons"

const { color } = useColor()
</script>
<template>
  <UserIcon :color="color('--primary-color')" />
</template>

```

**TO-BE: CSS 변수 할당**
```vue
<script setup lang="ts">
import { UserIcon } from "@/components/icons"
</script>
<template>
  <UserIcon color="var(--primary-color)" />
</template>

```

이러한 변경을 통해 iOS 16 이하의 호환성 문제를 완벽히 해결할 수 있었으며, 초기 로딩 또한 올바른 테마가 안정적으로 반영되는 결과를 얻었습니다.

## 크로스 플랫폼 이슈에 대한 예방 조치

이번 경험을 통해 얻은 가장 큰 교훈은, 크로스 플랫폼 환경에서 특정 브라우저 API 지원 여부를 **사전에 점검**하는 것의 중요성입니다.

이를 위해 프로젝트에 `eslint-plugin-compat` 플러그인을 추가하여, 사용 중인 API가 특정 브라우저 버전 이상에서만 지원되는지 빌드 단계에서 경고를 발생시키도록 시스템을 구축했습니다.

- [npm - eslint-plugin-compat](https://www.npmjs.com/package/eslint-plugin-compat)

이 플러그인은 다음과 같은 역할을 합니다:

- **브라우저 호환성 검사:**

  특정 API가 어떤 브라우저 버전에서 지원되는지 자동으로 체크합니다.

- **코드 작성 시 경고 제공:**

  지원되지 않는 API를 사용하려 할 때 빌드 단계에서 경고를 발생시켜, 사전 예방할 수 있도록 돕습니다.

이러한 도구를 활용함으로써, 앞으로 유사한 **호환성 문제를 미연에 방지**하고, **보다 안정적인 크로스 플랫폼 앱 개발**이 가능해졌습니다.

## **마치며**

D'CENT 앱 리뉴얼 과정은 단순한 UI/UX 개선을 넘어, 기술적 도전과 혁신적 해결 방안을 모색하는 값진 경험이었습니다.

초기에는 Wepin의 테마 방식을 클론하여 TS 기반의 동적 테마 관리로 시작했으나,

초기 HTML 로딩 시 **테마 불일치 문제**와 **iOS 16 이하 지원 문제** 등 예기치 못한 장애물을 만나게 되었습니다.

그러나 SCSS 기반의 CSS 변수 활용으로 전환하고, legacy composable인 `useColor`를 제거함으로써 문제를 해결할 수 있었으며,

`eslint-plugin-compat`를 통한 사전 예방 조치로 크로스 플랫폼 호환성도 확보할 수 있었습니다.

이번 프로젝트를 통해 얻은 교훈은 기술적 문제 해결뿐만 아니라,
팀과 시스템 전반에 걸친 **전략적 판단의 중요성**을 다시 한 번 깨닫는 계기가 되었습니다.

테마 또한 **각 프로젝트의 성격에 따라 적절한 설정**을 가져가는 것에 대해 인지하게 되었고, 이에 대한 경험은 다음 프로젝트를 진행할 때 큰 도움이 될 것 같습니다.

앞으로도 **지속적인 기술 업데이트와 도구 개선**을 통해, 더욱 **안정적이고 사용자의 기대에 부응하는 앱**을 개발하고 싶습니다.

여러분도 개발 과정에서 발생하는 크로스 플랫폼 이슈에 대비하여, 미리 API 지원 여부를 점검하고, 상황에 맞는 유연한 대안을 모색해 보아요 :)

