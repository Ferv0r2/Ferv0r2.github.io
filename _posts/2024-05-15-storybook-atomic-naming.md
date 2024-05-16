---
title: Atomic Design과 Component naming
description: Atomic Design의 구성과 Component naming의 특성 그리고 각각 애매한 부분을 살펴보자.
author: Ferv0r2
date: 2024-05-15 22:57:00 +0900
categories: [design system]
tags: [storybook, atomic design, naming rule, component]
render_with_liquid: false
image: /assets/img/post/20240515/banner.png
---

## Atomic Design

Atomic Design은 인터페이스를 작은, 재사용 가능한 구성 요소로 나누고 이를 조합하여 복잡한 디자인을 만드는 방법론이다.

이 방법론은 선형 프로세스가 아닌 **정신적 모델**로 사용자 인터페이스를 응집력 있는 전체이자 동시에 부분의 모음으로 생각할 수 있도록 도와준다.

이로 인해 **코드의 구조를 더 명확하게** 만들어주고 **유지보수를 쉽게** 해주며, 협업 시에도 **효율적인 작업**을 가능하게 해준다.

### 구성

Atomic Design은 다섯 가지의 기본 단계로 구성된다.

![Desktop View](/assets/img/post/20240515/structure.png){: .normal}

> 출처 https://atomicdesign.bradfrost.com/chapter-2/#the-part-and-the-whole

예제로 Github UI와 함께 확인해보자.

- **Atoms(원자):**

  - UI의 기본 빌딩 블록으로서 **가장 작은 구성 요소**
  - 기본 HTML element 태그 혹은 글꼴, 애니메이션, 컬러 팔레트, 레이아웃과 같이 추상적인 요소를 포함
  - ex) `Image`, `Button`, `Input`

    ![Desktop View](/assets/img/post/20240515/atoms.png){: width="360" .normal}

- **Molecules(분자):**

  - 원자들을 조합하여 좀 더 복잡한 구성 요소를 형성
  - SRP(Single Responsibility Principle) 원칙으로 **한 가지 일을 하는 구성 요소**
  - ex) `Form`

    ![Desktop View](/assets/img/post/20240515/molecules.png){: width="360" .normal}

- **Organisms(유기체):**

  - 분자들을 조합하여 **화면의 상당 부분**을 형성
  - 좀 더 복잡하고 서비스에서 표현될 수 있는 명확한 영역과 특정 컨텍스트
  - 상대적으로 낮은 재사용성
  - ex) `Header`, `SideBar`, `Footer`

    ![Desktop View](/assets/img/post/20240515/organisms.png){: width="360" .normal}

- **Templates(템플릿):**

  - 유기체들을 배치하여 페이지 **레이아웃을** 형성
    - 구조를 잡는 와이어 프레임
  - ex) `BasicLayout`, `MasterLayout`

    ![Desktop View](/assets/img/post/20240515/template.png){: width="720" .normal}

- **Pages(페이지):**

  - 템플릿을 채워서 실제 컨텐츠를 가진 **완전한 페이지**를 형성
  - 유저가 볼 수 있는 실제 콘텐츠

    ![Desktop View](/assets/img/post/20240515/page.png){: width="720" .normal}

이러한 단계를 따라가면서 UI를 개발하면, 코드의 재사용성이 증가하고 개발자 간 협업이 효율적으로 이루어진다.

그렇다면 해당 구조에 맞출 때 애매모호한 부분까지 함께 확인해보자.

### 애매모호한 부분

![Desktop View](/assets/img/post/20240515/organisms.png){: width="360" .normal}

> 이 컴포넌트는 Molecules 아닌가요? 왜 Organisms인가요?

실제 구현을 진행하다 보면 Molecules와 Organisms을 구분하는 것은 굉장히 어렵다.

**Molecules**는 Atoms로 구성되었으며 한 가지의 책임을 지고,

**Organisms**는 Atoms, Molecules, Organisms로 구성된다는 내용을 알고 있더라도,

분류하는 것에는 개인의 주관이 들어가고 이를 명확하게 정의하는 것은 여전한 숙제이다.

따라서 **코딩 컨벤션을 명확히**하고 **기준을 서서히 좁혀가는 것**이 중요할 것 같다.

## Component naming

앞의 내용을 통해 분류까지 잘 진행했다면 이제 컴포넌트를 만들고 이름을 지어주어야 한다.

이때, 이름을 막 짓는 것이 아닌 **몇 가지 특성을 고려**하여 지어야 한다.

### 특성

- **명확성**

  - 구성 요소의 이름은 **그 기능을 명확하게 설명**해야 한다.
  - 다른 개발자들이 이름만 보고도 해당 컴포넌트의 역할을 이해할 수 있어야 한다

- **일관성**

  - 비슷한 기능을 가진 구성 요소들은 **일관된 네이밍 패턴**을 따라야 한다.
  - ex) 모든 버튼 컴포넌트는 "Button"으로 시작할 수 있다.

- **의미 있는 구분**

  - 유사한 구성 요소가 있을 때, **이름에 구분자를 사용**하여 명확하게 구별할 수 있어야 한다.
  - ex) `PrimaryButton`과 `SecondaryButton`으로 버튼을 구분할 수 있다.

이름을 짓는 것이 이 얼마나 힘든 일인가.

게임 속 내 캐릭터의 닉네임을 지정하는 것도 한참을 고민하는데, 특성까지 고려하려니 쉽지 않다.

물론, 이는 우리만 그런 것이 아니다. 2013년 자료지만 여전히 먹히는 것 같은 통계를 보자.

### 개발자가 가장 어려워 하는 것

![Desktop View](/assets/img/post/20240515/statistics.png){: width="480" .normal}

> 출처: [Article - Don’t go into programming if you don’t have a good thesaurus](https://www.computerworld.com/article/1604256/don-t-go-into-programming-if-you-don-t-have-a-good-thesaurus.html)

개발자가 어려워하는 부분의 통계에서 **Naming things(이름 짓기)**가 **49%**만큼 투표되었다.

모두가 어려워하는 만큼 어느정도 룰을 잡고가면 좋지 않을까?

예를 들어, "`InputButton`, `ItemButton` 등과 같이 `XX버튼`의 형태로 통일한다"면 앞에서 언급한 특성을 모두 만족할 수 있다.

그렇다면 무조건 이 룰을 따르면 되는 것일까? 꼭 그렇지만은 않다.

아래 컴포넌트를 보자.

![Desktop View](/assets/img/post/20240515/button.png){: .normal}

> 이 버튼은 `IconButton`인가, `ButtonIcon`인가?

필자는 `IconButton`과 `ButtonIcon` 두 가지 선택지만 있다면 `IconButton`으로 진행할 것이다.

왜냐하면 `XX버튼` 형태로 버튼 간의 일관성을 유지하는 룰을 따랐기 때문이다.

그렇다면 이 컴포넌트는 무엇인가?

![Desktop View](/assets/img/post/20240515/icon.png){: .normal}

> 이 버튼은 `IconButton`인가, `ButtonIcon`인가?

... 그렇다. 굉장히 애매하다.

언뜻보면 두 컴포넌트는 동일해보이지만 실제 두 컴포넌트는 `background-color`와 `padding` 값이 다르다.

그렇다면 **하나의 컴포넌트로 하되 type으로 분기할 것**인가, 혹은 **별도의 컴포넌트로 구분할 것**인가?

이처럼 애매모호한 부분은 여전히 존재한다.

### 애매모호한 부분

![Desktop View](/assets/img/post/20240515/popup_header.png){: width="400" .normal}

이 컴포넌트는 어떻게 이름을 지어주면 될까? `PopupHeader`? `HeaderPopup`?

앞서 언급한 `XX버튼` 룰과 동일하게 `PopupHeader`로 진행하려고 한다.

`PopupHeader`를 `Organisms`로 결정했을 때, 다음 분류 중에서 어떻게 지정할 것인가?

1. `ORGANISMS/Popup/PopupHeader`
2. `ORGANISMS/Popup/HeaderPopup`
3. `ORGANISMS/Header/PopupHeader`
4. `ORGANISMS/Header/HeaderPopup`

필자는 `Popup`이지만 `Header`이기에 3번으로 분류할 것이다.

`Popup`의 `Header`를 오리너구리에 빗대어 보자.

![Desktop View](/assets/img/post/20240515/platypus.png)

- 오리는 조류, 너구리는 포유류이다.
- 누군가는 오리너구리가 알을 낳기 때문에 **조류**로 분류했고, 다른 누군가는 젖샘과 털이 있기에 **포유류**로 분류하였다.
- 최종적으로 오리너구리는 **포유류**로 판명되었지만 누군가 너스레 **조류**로 밝혀졌다고 해도 그럴싸해 보인다.

다시 `PopupHeader`로 돌아와보자.

- 누군가는 `PopupHeader`를 `Popup`으로 분류했고, 다른 누군가는 `PopupHeader`를 `Header`로 분류하였다.
- 최종적으로 `PopupHeader`는 룰에 따라 `Header`로 결정되었지만 누군가 너스레 "팝업에 종속되니 `Popup`으로 구분해야 한다"해도 그럴싸해 보인다.

이처럼 완벽한 정답은 없고 어떠한 기준을 따라 **구조를 명확히** 하는 것이 중요하다.

이는 Atomic Design에서 언급된 것과 동일하게 **팀 내의 룰이 필요**하고, 그 룰의 주관적인 부분을 최대한 좁히기 위해 **지속적인 커뮤니케이션**이 필요한 것이다.

최종적으로 **룰을 정하고** 이를 **문서화**하는 것이 향후 **뛰어난 가독성**과 **높은 유지보수성**을 가진 Atomic Design의 장점을 최대한 이끌어낼 것이라 생각한다 ^\_\_^

## 레퍼런스

- [kakao FE 기술블로그 - 아토믹 디자인을 활용한 디자인 시스템 도입기](https://fe-developers.kakaoent.com/2022/220505-how-page-part-use-atomic-design-system/)
- [Article - Don’t go into programming if you don’t have a good thesaurus](https://www.computerworld.com/article/1604256/don-t-go-into-programming-if-you-don-t-have-a-good-thesaurus.html)
