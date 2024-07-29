---
title: UI 라이브러리로 디자인 시스템을 구축할 수 있나요? (feat. Chakra UI)
description: 디자인 시스템과 UI 라이브러리가 어우러질 때 장단점에 대하여
author: Ferv0r2
date: 2024-07-29 23:02:00 +0900
categories: [ui, chakra ui, design system]
tags: [react, react]
render_with_liquid: false
image: /assets/img/post/20240729/banner.png
---

## 들어가며

회사에 입사하기 전, 개발자들끼리 팀을 이룬 경험은 있었으나 디자이너와의 협업 경험이 부족하였습니다.

이로 인해 저와 같은 개발자는 BootStrap과 같은 **UI 라이브러리를 통해 기본적인 컴포넌트를 커스터마이징**하여 프로덕트를 개발했습니다.

하지만 **커스터마이징에도 한계**가 있었고, 원하는 방향에 부합하지 않은 경우 **직접 개발하거나 일정 부분에 타협**을 보는 경우가 있었습니다.

현재는 비즈니스 로직에 맞춰 컴포넌트를 커스터마이징하고 이를 Storybook을 통해 관리하고 있습니다.

오늘은 프론트엔드 개발자와 디자이너 간의 협업 중 중요한 포인트 **디자인 시스템**을 다룹니다.

커스터마이징하는 비용을 줄이기 위해 UI 라이브러리를 채택한다면 이를 **디자인 시스템과 융화**시킬 수 있을까요?

디자인 시스템에 대해 간략히 정의하면서 Chakra UI와 함께 한 번 살펴보겠습니다.

## 디자인 시스템

![Desktop View](/assets/img/post/20240729/design-system.png){: width="600" .normal}

디자인 시스템은 일관된 디자인 언어를 제공하여 **사용자 경험을 향상**시키고, **개발자와 디자이너 간의 협업을 원활**하게 하는 도구입니다.

이는 **컬러, 텍스트 스타일, 레이아웃, UI 구성요소** 등을 정의하여 **일관성 있는 디자인을 유지하고 효율적인 작업**을 가능하게 합니다.

- 컴포넌트 정의:

  **재사용 가능한 UI 요소**들을 함께 정의하고 구조화합니다.

- 스타일 가이드:

  색상, 타이포그래피, 간격 등의 **디자인 규칙**을 명확히 합니다.

- 반응형 디자인:

  다양한 디바이스에서의 **레이아웃 변화를 협의**합니다.

- 상호작용 패턴:

  애니메이션, 전환 효과 등의 **동적 요소를 정의**합니다.

- 접근성:

  **웹 접근성 기준**을 만족시키기 위한 디자인 요소를 논의합니다.

- 성능 최적화:

  이미지 사용, 로딩 전략 등 **성능을 고려**한 디자인을 협의합니다.

- 버전 관리:

  디자인 시스템의 **업데이트와 변경 사항을 관리**하는 방법을 결정합니다.

디자인 시스템을 통해 **커뮤니케이션 비용을 줄여 자원을 효율적으로 사용**할 수 있고 사용자에게 **일관된 경험**을 제공할 수 있습니다.

이로 인해 프로젝트 전반의 **효율성과 품질이 향상**됩니다.

## Chakra UI

![Desktop View](/assets/img/post/20240729/chakra.png){: width="600" .normal}

Chakra UI는 React 애플리케이션을 위한 접근성 있고 모듈화된 컴포넌트 라이브러리입니다.

**직관적인 API와 뛰어난 유연성** 덕분에 개발자들이 빠르고 효율적으로 UI를 구축할 수 있습니다.

### 컴포넌트 기반:

Chakra UI는 다양한 UI 컴포넌트를 제공하여 **반복적인 UI 작업을 줄입니다.**

버튼, 모달, 입력 폼 등 기본적인 컴포넌트를 바로 사용 가능하며, 필요에 따라 **쉽게 커스터마이징**할 수 있습니다.

```jsx
import { Button } from "@chakra-ui/react";

const PrimaryButton = () => (
  <Button colorScheme="teal" size="md">
    Primary Button
  </Button>
);
```

### 접근성:

Chakra UI는 **웹 접근성 표준을 준수**하여 모든 사용자에게 일관된 경험을 제공합니다.

스크린 리더를 사용하는 사용자나 키보드만으로 웹을 탐색하는 사용자를 고려한 접근성 기능이 내장되어 있습니다.

### 테마 커스터마이징

Chakra UI의 편리한 점은 컬러 모드를 변경하는 `useColorMode` hook을 제공하고, 이를 `localStorage`에 저장합니다.

근래 라이트/다크 모드는 기본으로 탑재된 서비스가 굉장히 많은데 이를 구축하는데 있어 굉장히 용이합니다.

특히 저와 같은 개발자는 눈의 피로도를 고려하여 웬만한 페이지는 다크 모드로 이용하고 있습니다.

![Desktop View](/assets/img/post/20240729/theme-meme.png){: width="540" .normal}

> 라이트 테마의 공포

## 디자인 시스템과 Chakra UI의 융합

디자인 시스템을 성공적으로 구축하고 유지하려면, **명확한 원칙**과 **일관된 스타일 가이드**가 필요합니다.

또한 이 시스템이 **요구사항에 적합한 UI**를 만들어낼 수 있는지 판단해야 합니다.

일반적인 UI 라이브러리와는 달리 Chakra UI는 스타일 단위를 작게 쪼개놓았기에 **커스터마이징이 용이**합니다.

### 융합의 장점

**1. 컴포넌트 정의와 재사용**

- Chakra UI는 다양한 기본 컴포넌트를 제공하며, 이를 통해 **디자인 시스템의 구성 요소들을 정의하고 재사용**할 수 있습니다.
- 컴포넌트를 Chakra UI의 기본 요소로 시작하여, 비즈니스 로직에 맞게 커스터마이징함으로써 **일관성을 유지**하고 자원을 더욱 효율적으로 사용할 수 있습니다.

```jsx
import { Button } from "@chakra-ui/react";

const PrimaryButton = () => (
  <Button colorScheme="teal" size="md">
    Primary Button
  </Button>
);
```

**2. 스타일 가이드 통합**

- Chakra UI의 **테마 커스터마이징** 기능을 활용하면, 디자인 시스템의 스타일 가이드를 쉽게 적용할 수 있습니다.

```jsx
import { extendTheme } from "@chakra-ui/react";

const theme = extendTheme({
  colors: {
    light: {
      50: "#f5faff",
      100: "#e1f4ff",
      200: "#c2e3ff",
    },
    dark: {
      50: "#0a0f14",
      100: "#131a22",
      200: "#1d2731",
    },
  },
  fonts: {
    heading: "Roboto, sans-serif",
    body: "Roboto, sans-serif",
  },
});
```

**3. 반응형 디자인**

- Chakra UI는 기본적으로 반응형 디자인을 지원하는데요, 굉장히 특이한 방식입니다.
- `theme`에 `breakpoints`를 정의하고 이를 `array`나 `object` 형태의 `props`로 넘겨줍니다. 이 방식은 다른 라이브러리에 비해 훨씬 직관적입니다.

```jsx
// These are the default breakpoints
const breakpoints = {
  base: "0em", // 0px
  sm: "30em", // ~480px. em is a relative unit and is dependant on the font-size.
  md: "48em", // ~768px
  lg: "62em", // ~992px
  xl: "80em", // ~1280px
  "2xl": "96em", // ~1536px
};

// Internally, we transform to this
const breakpoints = ["0em", "30em", "48em", "62em", "80em", "96em"];
```

```jsx
import { Box } from "@chakra-ui/react";

const ResponsiveBox = () => (
  <>
    <Box w={["100%", "75%", "50%", "25%"]} p="4">
      Responsive Box
    </Box>
    <Box
      height={{
        base: "100%", // 0-48em
        md: "50%", // 48em-80em,
        xl: "25%", // 80em+
      }}
      bg="teal.400"
      width={[
        "100%", // 0-30em
        "50%", // 30em-48em
        "25%", // 48em-62em
        "15%", // 62em+
      ]}
    >
      Responsive Box
    </Box>
  </>
);
```

**4. 상호작용 패턴 구현**

- Chakra UI의 애니메이션과 전환 효과를 활용하여, 디자인 시스템의 **상호작용 패턴을 쉽게 구현**할 수 있습니다.
- 이러한 동적 요소들은 **사용자 경험을 향상**시키는 데 중요한 역할을 합니다.

```jsx
import { Button } from "@chakra-ui/react";

const AnimatedButton = () => (
  <Button
    colorScheme="teal"
    size="md"
    _hover={{ transform: "scale(1.1)", transition: "0.2s" }}
  >
    Hover Me
  </Button>
);
```

### 융합의 단점

**1. 코드 복잡성 증가**

커스터마이징이 자유롭다는 것은 그만큼 **설정할 옵션이 많다**는 것을 의미하며, 이는 **높은 코드 복잡성**을 만들어냅니다.

![Desktop View](/assets/img/post/20240729/custom.png){: .normal}

> 커스터마이징 가용성 & 코드의 복잡성

이는 **유지보수와 디버깅에 추가적인 비용**이 들게 하며, **개발 속도를 저하**시킬 수 있습니다.

```jsx
const ComplexComponent = () => (
  <Box
    bg="white"
    p={4}
    borderRadius="md"
    boxShadow="md"
    _hover={{ bg: "gray.100" }}
    transition="background-color 0.2s"
    // ... 기타 스타일 props
  >
    This is a complex component
  </Box>
);
```

**2. 중복 스타일에 대한 과한 추상화**

1번 문제와 같이 스타일 `props`가 너무 과한 경우 스타일 객체 형태로 관리할 수 있을 것입니다.

```jsx
const boxStyle1 = {
  bg: "teal.500",
  color: "white",
  p: 4,
  borderRadius: "md", // 공통 부분
  borderColor: "gray.200", // 공통 부분
};

const boxStyle2 = {
  bg: "teal.600",
  color: "teal.200",
  p: 2,
  borderRadius: "md", // 공통 부분
  borderColor: "gray.200", // 공통 부분
};

const ComponentOne = () => <Box {...boxStyle1}>Component One</Box>;
const ComponentTwo = () => <Box {...boxStyle2}>Component Two</Box>;
```

이로 인해 어느정도 복잡성은 개선하였지만 공통 부분의 중복 제거를 위해 `border`에 관한 객체를 별도로 분리해 보겠습니다.

```jsx
const borderStyle = {
  borderRadius: "md",
  borderColor: "gray.200",
};

const boxStyle1 = {
  ...borderStyle,
  bg: "teal.500",
  color: "white",
  p: 4,
};

const boxStyle2 = {
  ...borderStyle,
  bg: "teal.600",
  color: "teal.200",
  p: 2,
};

const ComponentOne = () => <Box {...boxStyle1}>Component One</Box>;
const ComponentTwo = () => <Box {...boxStyle2}>Component Two</Box>;
```

`borderStyle`이라는 객체를 분리하여 중복성을 줄였습니다.

하지만 이와 같이 객체를 추상화하는 과정이 많아진다면 코드의 복잡성이 높아져 유지보수성이 떨어질 우려가 있습니다.

## 마치며

디자인 시스템을 성공적으로 구축하고 유지하려면, **명확한 원칙과 일관된 스타일 가이드**가 필요합니다.

Chakra UI는 이러한 디자인 시스템을 효율적으로 구축하고 유지할 수 있는 강력한 도구를 제공하고 있습니다.

컴포넌트 정의와 재사용, 스타일 가이드 통합, 반응형 디자인 지원, 상호작용 패턴 구현 등의 기능을 통해, Chakra UI는 **디자인 시스템과의 융합에 큰 장점**을 제공합니다.

그러나, 이와 동시에 **코드의 복잡성이 증가하는 단점**도 존재합니다. 이는 프로젝트의 규모와 복잡도에 따라 적절히 조절해야 하는 부분입니다.

결국, UI 라이브러리와 디자인 시스템의 융합은 팀의 요구사항과 목표에 따라 다릅니다.

Chakra UI와 같은 유연한 도구를 활용하여, 디자인 시스템을 효율적으로 구축하고 유지할 수 있는 방법을 찾아보는 것이 중요합니다.

디자인 시스템과 UI 라이브러리의 융합을 통해, 개발자와 디자이너 간의 협업을 강화하고, 일관된 사용자 경험을 제공할 수 있습니다.

이를 통해, 더 나은 프로덕트를 더 빠르고 효율적으로 개발할 수 있을 것입니다 :)
