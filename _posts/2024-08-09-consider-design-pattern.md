---
title: 웹과 앱에 다른 디자인 패턴을 적용하게 된 계기
description: 디자인 패턴에 대응하는 건에 대하여
author: Ferv0r2
date: 2024-08-09 23:32:00 +0900
categories: [design pattern, architecture]
tags: [presentational, container, compound]
render_with_liquid: false
image: /assets/img/post/20240809/banner.png
---

## 들어가며

우리는 개발하면서 많은 사항을 고려하게 됩니다.

요구사항에 맞는 비즈니스 로직이 들어가면서 사용자 경험과 기능이 밀접하게 연관되고,

이를 구현 및 유지보수하는 과정에서 여러가지 문제점이 발생할 수 있습니다.

디자인 패턴을 고려하면 재사용성, 확장성, 유지보수성에 대한 이슈를 최소화할 수 있습니다.

특히, 최초로 프로젝트를 생성할 때 룰이 명확하게 설정되어 있는 것이 가장 중요합니다.

- 어떤 케이스로 파일명/폴더명을 작성할지
- 폴더 구조를 어떻게 구성할지
- 변수명을 어떻게 명명할지

이러한 기본적인 규칙이 설정되면 협업 간의 시너지가 발생하고, 더 나은 코드가 작성될 수 있습니다.

이와 같은 배경에서, 사내 웹뷰 프론트엔드 개발을 초기 단계부터 담당하게 되었으며, 그 과정에서 발생한 이슈를 해결한 경험을 공유합니다.

## 환경에 따른 디자인 패턴의 제약사항

기존 웹 서비스에서 반응형으로 진행하면서 **웹/앱을 모두 고려**한 디자인과 달리,

웹뷰는 오직 앱 UI만 제공되도록 구성되어, UX를 **맞춤형**으로 진행하기에 더 적합했습니다.

- 사용자가 한 화면에서 **다양한 기능을 확인하고 사용**할 수 있어야 하며,
- 사용자의 **상호작용(터치)의 횟수를 최소화**하도록 디자인되었습니다.

이로 인해 하나의 뷰에 `BottomSheet`, `Dialog`와 같은 컴포넌트가 `routing` 없이 화면 위에 얹어져 기능을 수행하게 되었습니다.

이러한 구조에서는 `hooks`과 `utils`로 로직을 관리하더라도, `if-else`문으로 인해 `DOM` 영역이 비대해지면서 가독성이 떨어지기 시작했습니다.

따라서 이를 해결하기 위해 웹과 앱의 디자인 패턴을 다르게 가져가기로 논의했습니다.

## Presentational/Container 패턴 소개

![Desktop View](/assets/img/post/20240809/container-presentational-pattern.jpg){: .normal}

> [출처 - Patterns](https://patterns-dev-kr.github.io/)

먼저, 기존 웹 서비스 개발에서 사용하던 **Presentational/Container** 패턴을 소개합니다.

이 패턴은 비즈니스 로직과 UI를 철저하게 구분하는 것을 목표로 합니다.

예를 들어 `Modal`의 X 버튼을 눌렀을 때

- **Presentational Component**은 해당 이벤트만 **Container Component**로 전달합니다.

  - 실제로 닫히는 동작을 수행하지 않습니다.

- **Container Component**에서 해당 이벤트에 맞는 동작을 수행합니다.
  - `Modal`이 닫히거나 그 외의 동작도 수행할 수 있습니다.

### Presentational Component

**Presentational Component**는 UI를 표시하는 데 집중하며, **상태나 비즈니스 로직에 관여하지 않습니다.**

- 역할:

  - 사용자에게 보여지는 UI를 담당합니다.

- 특징:

  - 스타일링과 레이아웃 관련된 코드가 포함됩니다.
  - 데이터를 `props`로 받아서 표시합니다.
  - 상태를 가지지 않거나, 있더라도 **UI에 한정**된 상태만 가집니다.

```jsx
const Button = ({ label, onClick }) => (
  <button onClick={onClick}>{label}</button>
);
```

### Container Component

**Container Component**는 **비즈니스 로직과 상태 관리**를 담당합니다.

- 역할:

  - 데이터를 가져오거나 변형하고, 그 데이터를 **Presentational Component**에 전달합니다.

- 특징:

  - 상태와 생명주기 메서드를 가질 수 있습니다.
  - **Presentational Component**를 감싸고, **필요한 데이터를 주입**합니다.

```jsx
import React, { useState, useEffect } from "react";
import Button from "./Button";

const ButtonContainer = () => {
  const [label, setLabel] = useState("Click me");

  const handleClick = () => {
    setLabel("Clicked!");
  };

  return <Button label={label} onClick={handleClick} />;
};
```

## 새로운 디자인 패턴

웹뷰 환경에서는 기존의 **Presentational/Container** 패턴이 항상 최선의 선택이 아니었습니다. 웹뷰는 앱과 달리 다양한 사용자 상호작용을 최소화하고, 특정 기능을 집중적으로 제공하는 UX를 목표로 하므로, 컴포넌트에 비즈니스 로직을 포함하는 것이 불가피했습니다. 이로 인해 **Compound Component** 패턴을 도입하게 되었습니다.

### Compound Component 패턴

![Desktop View](/assets/img/post/20240809/compound-pattern.jpg){: .normal}

> [출처 - Patterns](https://patterns-dev-kr.github.io/)

**Compound Component** 패턴은 UI와 비즈니스 로직을 모두 포함하는 컴포넌트를 사용하여, 개발 속도를 높이고 관리 복잡성을 줄이는 패턴입니다.

- 역할:

  - 개별 컴포넌트가 UI와 로직을 모두 포함하며, 서로 유기적으로 작동합니다.

- 특징:

  - 상태와 로직을 가지며, 특정 기능에 집중된 UI를 제공합니다.
  - 컴포넌트를 재사용하기 용이하게 설계되었지만, 보다 구체적인 기능에 특화된 경우가 많습니다.

예를 들어, `BottomSheet`에서 리스트를 선택할 때, 해당 리스트를 포함한 컴포넌트를 별도로 생성하고, 이 컴포넌트를 다른 곳에서 `import`하여 사용하는 방식입니다.

```jsx
import React, { useState } from "react";

const ListWithSelection = ({ items, onSelect }) => {
  const [selectedItem, setSelectedItem] = useState(null);

  const handleSelection = (item) => {
    setSelectedItem(item);
    onSelect(item);
  };

  return (
    <div>
      {items.map((item) => (
        <button key={item} onClick={() => handleSelection(item)}>
          {item}
        </button>
      ))}
    </div>
  );
};
```

이렇게 **Compound Component** 패턴을 도입함으로써, 웹뷰 환경에서 유연하고 효율적인 개발이 가능해졌습니다.

## 스파게티 코드는 혜성처럼 등장하지 않는다

![Desktop View](/assets/img/post/20240809/spaghetti.png){: .normal}

> [출처 - reddit](https://www.reddit.com/r/ProgrammerHumor/comments/82gvzc/another/)

1. 철수님이 고양이 갤러리라는 제품을 만듭니다.
2. 반년 동안 영희님이 고양이 갤러리의 이슈를 수정합니다.
3. 민수님이 고양이 갤러리에 사용자 거래 기능을 추가 개발합니다.

이러한 히스토리가 쌓일수록 다음과 같은 이슈들이 발생합니다.

- **코드 복잡성 증가:**

  - 초기에는 단순했던 코드가 점점 복잡해지면서, 수정하기 어려운 구조로 변합니다.

- **책임의 분산:**

  - 특정 기능이 어디에서 처리되는지 명확하지 않아, 유지보수 시에 혼란이 발생할 수 있습니다.

- **기능 통합의 어려움:**

  - 새로운 기능을 추가하거나 기존 기능을 수정할 때, 여러 컴포넌트에 걸쳐 수정이 필요할 수 있습니다.

스파게티 코드는 어느 날 갑자기 등장하지 않습니다. 코드가 점진적으로 복잡해지고, 초기의 설계 원칙에서 벗어나면서 발생하는 문제입니다.

이를 방지하기 위해서는 **지속적인 코드 리뷰**와 **디자인 패턴에 대한 엄격한 준수**가 필요합니다.

## 마치며

디자인 패턴은 단순히 코드를 구성하는 방식이 아니라, 코드의 유지보수성과 확장성을 고려한 중요한 원칙입니다.

웹과 앱의 요구사항이 다르기 때문에, 이를 반영하여 적절한 패턴을 선택하고 적용하는 것이 중요합니다. 프로젝트의 성공은 이러한 세심한 설계와 규칙 준수에서 시작된다고 할 수 있습니다.

앞으로도 프로젝트의 특성에 맞는 최적의 디자인 패턴을 찾아 적용하고, 코드의 복잡성을 관리하며, 유지보수성을 높이는 노력을 지속해야 할 것입니다.

## 레퍼런스

- [Patterns - Container/Presentational pattern](https://patterns-dev-kr.github.io/design-patterns/container-presentational-pattern/)
- [Patterns - Compound pattern](https://patterns-dev-kr.github.io/design-patterns/compound-pattern/)
