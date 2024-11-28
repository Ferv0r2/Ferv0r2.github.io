---
title: 모던 CSS 트렌드 - CSS-in-JS, TailwindCSS, 그리고 CSS 전처리기의 공존
description: CSS 스타일링의 최신 트렌드를 비교하고, 테마 관리와 유지보수성을 고려한 접근 방식을 제안합니다.
author: Ferv0r2
date: 2024-11-27 12:00:00 +0900
categories: [frontend, css, tools]
tags: [css-in-js, tailwindcss, sass, frontend development, css trends, design systems]
render_with_liquid: false
image: /assets/img/post/20241127/banner.jpg
---

## **들어가며**

CSS는 단순히 웹 애플리케이션의 스타일을 정의하는 것을 넘어, 팀의 협업 도구와 디자인 시스템의 중심 역할을 맡고 있습니다.

오늘날 CSS는 **디자인 시스템**, **컴포넌트 기반 아키텍처**, **유지보수성** 등 다양한 문제를 해결하는 데 중요한 역할을 하고 있습니다.

특히, 팀 프로젝트나 대규모 애플리케이션에서는 CSS를 작성하는 방법이 스타일링의 일관성, 협업의 효율성, 유지보수성에 직접적인 영향을 미칩니다.

CSS의 대표적인 스타일링 방식은 다음과 같습니다:

- **CSS-in-JS:**

  - JavaScript를 활용해 **컴포넌트 수준의 스타일링** 제공합니다.

- **TailwindCSS:**

  - 유틸리티 클래스를 사용해 **빠르고 일관성 있는 스타일링** 가능합니다.
  
- **CSS 전처리기:**

  - SASS(SCSS) 등을 사용해 전통적이지만 **구조적인 스타일링** 구현합니다.
  - 현재 사내에서는 Vue와 함께 채택하고 있는 도구입니다.

이번 글에서는 CSS 스타일링의 최신 트렌드를 탐구하며, 각 접근 방식의 **장단점을 비교**하고, 프로젝트에 **적합한 선택을 돕는 가이드**를 제공합니다.

## **CSS 스타일링의 과제**

현대 웹 애플리케이션에서 CSS는 다음과 같은 과제들을 해결해야 합니다. 각 문제를 간단한 예제와 함께 살펴보겠습니다.


### 전역 네임스페이스 문제

CSS는 기본적으로 전역 네임스페이스를 사용합니다. 이는 프로젝트 규모가 커질수록 **스타일 충돌**이 발생하고, 관리가 어려워지는 원인이 됩니다.

예를 들어 버튼과 카드 컴포넌트가 각각 `.button`, `.card` 클래스를 사용할 때, 하위 스타일이 충돌하거나 다른 컴포넌트에 영향을 미칠 가능성이 있습니다.

```css
/* 스타일 충돌 */
.button {
  background-color: blue;
  color: white;
  padding: 10px 20px;
  border-radius: 5px;
}

.button {
  background-color: red;
}
```

### 반복적이고 비효율적인 스타일 관리

스타일 요소(예: 색상, 폰트 크기, 간격 등)가 여러 곳에서 **중복 선언**되면서 유지보수가 어려워집니다.

이는 색상 변경 시 모든 CSS 파일을 수정하게 만들고, 팀원마다 스타일 작성 방식이 달라지면서 일관성을 유지할 수 없습니다.

```css
/* 색상 중복 */
.header {
  color: #333;
}

.footer {
  color: #333;
}

/* 반복적인 태그 선언 */
.header > .header-detail {
  display: flex;  
}
.header > .header-detail > img {
  width: 40px;
  height: 40px;
}
.header > .header-detail > img:hover {
  scale: 1.1;
}
```

## **CSS 스타일링 접근 방식의 진화**

### **CSS-in-JS: 컴포넌트 기반 스타일링**

CSS-in-JS는 자바스크립트를 활용해 스타일을 컴포넌트에 캡슐화하여 관리하는 방식입니다.

대표적인 도구로는 `Styled-Components`와 `Emotion` 등이 있으며 다음과 같은 특징을 가집니다.

- **모듈화:**

  - 스타일이 컴포넌트와 함께 관리되어 **유지보수성이 향상**됩니다.

- **동적 스타일링:**

  - Props나 상태(state)를 사용해 실시간으로 스타일 변경 가능합니다.

- **전역 스타일 충돌 방지:**

  - 고유한 클래스 이름을 자동 생성하여 **중복 스타일 문제를 해결**합니다.


|장점|단점|
|---|---|
|컴포넌트 기반으로 모듈화 가능|	런타임 성능에 영향 가능성|
|동적 스타일링 지원|어려운 디버깅|
|전역 스타일 충돌 방지|초기 학습 곡선 존재|


```tsx
import styled from 'styled-components';

const Button = styled.button<{ primary?: boolean }>`
  background: ${(props) => (props.primary ? 'blue' : 'white')};
  color: ${(props) => (props.primary ? 'white' : 'blue')};
  border: 2px solid blue;
  padding: 10px 20px;
  border-radius: 5px;

  &:hover {
    background: ${(props) => (props.primary ? 'darkblue' : 'lightblue')};
  }
`;

export default function App() {
  return (
    <div>
      <Button primary>Primary Button</Button>
      <Button>Secondary Button</Button>
    </div>
  );
}

// styled-component 사용 예제
```

### **TailwindCSS: 유틸리티 클래스 중심의 스타일링**

TailwindCSS는 CSS 속성을 미리 정의된 **유틸리티 클래스로 제공**하여 HTML과 JSX에서 직접 스타일을 작성하는 방식입니다.

최근 **가장 인기있는** CSS 프레임워크라고 할 수 있으며 다음과 같은 특징을 가집니다.

- **빠른 스타일링:**

  - CSS를 별도로 작성하지 않고 HTML 코드 안에서 바로 스타일 적용이 가능합니다.

- **일관성 유지:**

  - 중앙 설정 파일을 사용해 디자인 시스템과 통합합니다.

- **최적화:**

  - PurgeCSS로 사용하지 않는 CSS를 제거하여 **번들 크기를 최소화**합니다.


|장점|단점|
|---|---|
|빠른 프로토타이핑 가능|비대한 클래스 네이밍|
|PurgeCSS로 성능 최적화|제한적인 동적 스타일링|
|일관된 디자인 시스템|제한적인 커스터마이징|

```tsx
export default function App() {
  return (
    <div className="flex flex-col items-center p-4">
      <button className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-700">
        Primary Button
      </button>
      <button className="bg-gray-200 text-blue-500 px-4 py-2 rounded hover:bg-gray-300">
        Secondary Button
      </button>
    </div>
  );
}

// tailwindcss 사용 예제
```

### **CSS 전처리기: 효율적인 스타일 관리**

CSS 전처리기(SASS/SCSS)는 CSS에 변수, 중첩, mixin 등의 기능을 추가하여 **스타일을 구조적으로 작성**할 수 있도록 도와줍니다.


- **변수와 mixin:**

  - 반복 작업을 최소화하고, 재사용성을 높입니다.

- **중첩(Nesting):**

  - 계층 구조를 간결하고 직관적으로 작성할 수 있습니다.

- **전통적 CSS와의 호환성:**

  - 브라우저에서 CSS로 변환되어 동작합니다.


|장점|단점|
|---|---|
|변수와 믹스인으로 인한 높은 재사용성|어려운 런타임 동적 스타일|
|중첩 구조로 높은 가독성|컴파일러 의존성|
|CSS와의 높은 호환성|복잡한 초기 설정|

```scss
$primary-color: blue;
$secondary-color: gray;

.button {
  background: $primary-color;
  color: white;
  padding: 10px 20px;
  border-radius: 5px;

  &:hover {
    background: darken($primary-color, 10%);
  }

  &.secondary {
    background: $secondary-color;
    color: blue;
  }
}

// scss 사용 예제
```

## CSS 스타일링 접근 방식 비교

다양한 스타일링 접근 방식의 특징을 정리한 표는 다음과 같습니다.

각각의 **장단점**을 파악하는 것이 중요하며 **경우에 따른 선택**을 아래에 첨언합니다.

|특성|CSS-in-JS|TailwindCSS|CSS 전처리기|
|러닝 커브|중간|낮음|낮음|
|유지보수성|높음|중간|높음|
|생산성|중간|높음|중간|
|성능|중간(런타임 계산)|높음|높음|
|유연성|높음|중간|높음|
|초기 설정 난이도|낮음|높음|중간|


### CSS-in-JS

> 복잡한 대시보드 UI에서 테이블의 행(row)마다 **조건에 따라 스타일을 다르게 적용**해야 하는 경우

CSS-in-JS는 동적 스타일링과 컴포넌트 중심의 스타일 관리가 필요한 경우 매우 적합합니다.

아래와 같은 경우에 유용합니다.

- 상태(state)나 Props에 따라 **스타일을 유연하게 조정**해야 하는 경우


```tsx
const Row = styled.tr<{ isActive: boolean }>`
  background-color: ${(props) => (props.isActive ? 'lightgreen' : 'white')};
  color: ${(props) => (props.isActive ? 'darkgreen' : 'black')};
`;
```

### TailwindCSS

> 커머스 웹사이트에서 상품 목록 페이지를 빠르게 구성해야 하는 경우

TailwindCSS는 **빠른 개발과 디자인 시스템의 일관성을 유지**하는 데 최적화되어 있습니다.

- **프로토타이핑 속도**가 중요한 경우
- **명확한 디자인 시스템**을 구축하고 팀 전반에서 **스타일 일관성을 유지**하고 싶은 경우


```tsx
<div class="grid grid-cols-3 gap-4">
  <div class="p-4 border rounded">Item 1</div>
  <div class="p-4 border rounded">Item 2</div>
  <div class="p-4 border rounded">Item 3</div>
</div>
```

### CSS 전처리기

> 글로벌 기업의 다국어 웹사이트에서 지역별로 약간씩 다른 스타일을 적용하려는 경우

- 브라우저 네이티브 기능과의 **호환성이 필수적**인 경우
- 디자인 시스템에서 **반복적인 스타일 요소**(예: 색상, 간격, 폰트 크기)를 **효율적으로 관리**하고 싶은 경우
- 전통적인 HTML/CSS 기반의 프로젝트에서 **확장된 기능**이 필요한 경우

```scss
@mixin theme($bg-color, $text-color) {
  background-color: $bg-color;
  color: $text-color;
}

.button {
  @include theme(blue, white);

  &.secondary {
    @include theme(gray, blue);
  }
}
```

## 사내에서 CSS 전처리기를 사용하는 이유

앞서 언급했듯이, 사내에서는 **CSS 전처리기**를 사용하고 있습니다.

이는 단순히 전통적인 CSS의 한계를 보완하기 위해서만이 아니라, 프로젝트의 **특성과 요구사항에 최적화된 장점** 때문입니다.

변수 기반의 디자인 시스템을 효율적으로 구축할 수 있게 해주며 이를 통해 색상, 간격, 폰트 크기 등 **핵심 스타일을 체계적으로 관리**할 수 있습니다.

디자인 토큰처럼 변수를 활용해 프로젝트 **전체 스타일을 일관되게 유지**하고, 하나의 변수만 변경하면 관련된 모든 스타일이 **자동으로 업데이트**됩니다.

또한 계층 구조가 명확해져 **직관적인 코드**로 인해 가독성이 향상되며 이는 새로운 팀원이 합류하더라도 **러닝 커브를 낮춰** 생산성을 빠르게 확보하는 데 유리합니다.

```scss
// colors.scss
$primary-color: #007bff;
$secondary-color: #6c757d;
$danger-color: #dc3545;

// buttons.scss
.button {
  background-color: $primary-color;
  color: white;
  padding: 10px 20px;

  &.secondary {
    background-color: $secondary-color;
  }

  &.danger {
    background-color: $danger-color;
  }
}
```

## 마치며

CSS는 단순한 스타일 언어를 넘어, 현대 웹 애플리케이션의 중요한 핵심 도구로 자리 잡았습니다.

CSS 스타일링의 최신 트렌드는 프로젝트의 요구사항에 맞춰 **다양한 선택지를 제공**합니다.

최고의 스타일링 도구는 팀과 프로젝트에 가장 잘 맞는 도구입니다.

따라서 단순히 기능의 비교를 넘어, 팀의 기술 스택, 프로젝트 특성, 그리고 협업 방식을 고려한 **전략적 판단**이 필요합니다.

지금도 CSS는 끊임없이 발전하고 있습니다. CSS 스타일링의 최신 트렌드와 함께, **더 나은 사용자 경험과 생산성**을 위한 CSS 전략을 고민해보세요. 🎨