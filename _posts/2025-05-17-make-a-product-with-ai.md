---
title: "AI 서비스를 활용한 1인 게임 개발: Kepler Pop 프로젝트 여정"
description: "프론트엔드 개발자가 AI 도구(Claude, ChatGPT, v0, Cursor)를 활용하여 우주 식물 테마 퍼즐 게임을 혼자 개발한 과정과 경험을 공유합니다."
author: Ferv0r2
date: 2025-05-17 18:00:00 +0900
categories: [Project, Game]
tags: [ai, game-development, mvp, react-native, webview, claude, chatgpt, v0, cursor, solo-project]
render_with_liquid: false
image: /assets/img/post/20250517/banner.png
---

## 들어가며: 우연한 영감과 도전

어느 평범한 출근길, 블루투스 이어폰을 깜빡하고 집에 두고 온 날이 있었습니다. 평소라면 음악에 빠져 주변을 살펴볼 여유도 없이 출근하곤 했지만, 그날만큼은 달랐습니다. 지하철에서 주변을 둘러보니 예상보다 많은 사람들이 OTT를 시청하거나 모바일 게임을 즐기고 있었습니다. 그 순간 문득 떠오른 생각, '내가 좋아하는 컨셉으로 게임을 만들어 볼 수 있지 않을까?'

과거 프로젝트에서 다뤘던 '우주 식물'이라는 컨셉이 머릿속을 맴돌았습니다. 하지만 프론트엔드 개발자인 저에게는 분명한 한계가 있었습니다. 디자인 능력도 부족했고, 백엔드 구축에 대한 깊은 이해도 없었죠. 게임을 좋아했지만 게임을 개발하는 것은 더더욱 생소한 영역이었습니다. 

그럼에도 불구하고 이러한 경계를 넘어 도전할 수 있는 기회는 AI 도구의 발전이었습니다.

## Preview: Kepler Pop 개발 중간 과정

![Desktop View](/assets/img/post/20250517/landing.png){: .normal}
*Kepler Pop 랜딩 페이지*


**Kepler Pop**은 우주 식물들을 테마로 한 퍼즐 게임입니다. 외계 행성에서 발견된 신비로운 식물들이 우주를 탐험하는 여정을 담았습니다. 각 식물 캐릭터는 저마다의 독특한 능력과 매력적인 스토리를 가지고 있으며, 플레이어는 이들을 성장시키고 퍼즐을 풀어나가는 과정에서 새로운 우주 식물들을 발견하게 됩니다.

![Desktop View](/assets/img/post/20250517/preview.png){: .normal}
*Kepler Pop 게임 Preview*

이 게임의 핵심 목표는 단순하지만 중독성 있는 퍼즐 메커니즘과 매력적인 캐릭터들을 통해 출퇴근 시간이나 짧은 휴식 시간에 즐길 수 있는 게임을 제공하는 것입니다. 또한 우주 식물이라는 독특한 테마를 통해 플레이어들에게 신선한 경험을 선사하고자 했습니다.

## AI 서비스를 활용한 MVP 개발 과정

프로젝트를 시작한 2025년 4월 1일, 저는 야심찬 목표를 세웠습니다. 2분기가 끝나는 6월 30일까지 Google Play와 App Store 양대 마켓에 MVP를 출시하는 것이었습니다. 혼자서 모든 것을 처리해야 하는 상황에서, AI 서비스는 저의 가장 강력한 동반자가 되었습니다.

### 기술 스택

```
📱 네이티브: React Native, TypeScript
🌐 웹뷰: Next.js, TypeScript
⚙️ 백엔드: Nest.js, Postgres
🤖 AI 도구: v0, ChatGPT, Claude, Cursor
```

### AI 서비스별 활용 내용

#### 1. v0: 서비스 디자인 담당

프론트엔드 개발자로서 가장 큰 약점 중 하나는 디자인 능력이었습니다. v0.dev는 이 문제를 완벽하게 해결해주었습니다. 간단한 프롬프트만으로 게임의 UI 요소들을 생성할 수 있었고, 이는 개발 속도를 엄청나게 향상시켰습니다.

```
프롬프트 예시: 
"우주 식물 테마의 모바일 Match-3 퍼즐 게임을 개발하려고 해. 
무한 모드를 중점으로 생각하고 있고, 상단에는 점수와 움직임 횟수가 표시되어야 해 
전체적인 색상은 보라색과 파란색 계열로, 우주의 신비로움을 느낄 수 있게 해줘."
```

하지만 v0가 완벽했던 것은 아닙니다. 특히 모바일 게임의 특성상 필요한 특정 UI 요소들은 여러 번의 프롬프트 조정이 필요했습니다. 때로는 수십 번의 생성 시도 끝에 원하는 결과물을 얻기도 했습니다.

![Desktop View](/assets/img/post/20250517/v0.png){: .normal}
*v0: 랜딩 페이지 개발 디자인 프롬프트 과정*

#### 2. ChatGPT: 캐릭터 디자인 담당

게임의 핵심인 우주 식물 캐릭터들은 ChatGPT의 DALL-E 모델을 통해 탄생했습니다. 캐릭터 디자인은 게임의 정체성을 결정짓는 중요한 요소였기에, 이 부분에서는 정말 많은 시간을 투자했습니다.

초기에는 원하는 톤앤매너를 정확히 전달하기가 어려웠습니다. "귀엽지만 우주적인", "식물이지만 캐릭터 같은"과 같은 모호한 표현으로는 만족스러운 결과를 얻기 힘들었죠. 결국 100번 이상의 생성 시도 끝에 원하는 캐릭터 컨셉 디자인을 얻을 수 있었습니다.

마음에 드는 하나의 이미지가 생성되면 그 이미지를 첨부하고 톤앤매너에 맞는 이미지를 생성했습니다. 같은 프롬프트라도 결과물은 항상 달랐기 때문에 또 다시 수백번 프롬프트를 요청해야 했습니다.

![Desktop View](/assets/img/post/20250517/chatgpt.png){: .normal}
*ChatGPT: 캐릭터 생성 프롬프트 과정*

#### 3. Claude: 제품 기획 및 분석 담당

Claude는 게임의 기획과 시나리오 작성에서 빛을 발했습니다. 혼자서 레퍼런스를 구상하고 큰 틀을 정해 놓더라도 상세한 기획을 명시하지 않으면 뼈대만 있는 상황이었습니다.

인기 있던 게임인 '뱀파이어 서바이벌', '궁수의 전설' 등은 특성을 주제로 세 가지 선택지를 제안하는 게임 모델이 가장 매력적이었다고 생각했고, 이를 퍼즐게임에 반영하기 위해 여러 아이디에이션을 고민하였습니다.

또한, 이 제품을 명확히 전달하기 위해선 누구나 이해할 수 있는 언어로 풀어내고, 수치적 데이터를 구상할 수 있어야 하는데 이러한 분야의 전문성이 떨어져 막히는 상황에 있었습니다.

하지만 Claude가 이러한 내용을 작성하고 정리하는데 큰 도움을 주었습니다. 특히 피치덱 작성에서 시장 분석, 수익화 모델, 개발 로드맵 등의 비즈니스 측면을 체계적으로 정리할 수 있었습니다.

![Desktop View](/assets/img/post/20250517/claude.png){: .normal}
*Claude: 제품 상세 기획 및 분석 프롬프트 과정*


#### 4. Cursor: 개발 지원 담당

Cursor는 실제 개발 과정에서 가장 많은 시간을 함께한 도구였습니다. 코드 자동 완성은 물론, 복잡한 로직 구현이나 버그 해결에도 큰 도움이 되었습니다.

하지만 여기서도 한계는 분명했습니다. 특히 게임의 핵심 로직인 퍼즐 매칭 알고리즘에서는 AI가 제안한 코드가 실제로 동작하지 않는 경우가 많았습니다.

퍼즐에서 연쇄 매칭이 발생하는 경우 애니메이션과 함께 정확하게 동작해야 했으나, 이러한 복잡한 로직에서 번번히 에러를 발생시켰습니다.

결국 이 부분은 직접 코드를 분석하고 수정하는 과정을 거쳐야 했습니다.

하지만 Cursor가 제안한 코드는 좋은 출발점이 되었고, 디버깅 과정에서도 많은 도움을 받을 수 있었습니다.

![Desktop View](/assets/img/post/20250517/cursor.png){: .normal}
*Cursor: 개발 지원 프롬프트 과정*

## AI 서비스 활용의 한계와 깨달음

AI 서비스는 분명 제품 개발 속도를 획기적으로 높여주었지만, 그 과정에서 많은 한계와 교훈도 얻을 수 있었습니다.

### 1. 디자인의 일관성 문제

v0와 ChatGPT로 생성한 디자인 요소들은 개별적으로는 훌륭했지만, 전체적인 일관성을 유지하는 것은 여전히 어려웠습니다. 특히 다양한 화면 간의 디자인 언어를 통일하는 과정에서 많은 수작업이 필요했습니다.

여전히 제품 전체를 하나의 디자인처럼 만드는 것은 부족한 상태지만 지속적으로 개선해보려고 합니다. 특히 색상 팔레트와 디자인 시스템을 체계화하는 작업이 추가로 필요할 것으로 보입니다.

![Desktop View](/assets/img/post/20250517/charaters.png){: width="480" .normal}
*Kepler Pop 캐릭터들*

### 2. 기술적 정확성의 한계

Cursor와 같은 코딩 AI는 기본적인 코드 생성에는 탁월했지만, 성능 최적화나 플랫폼별 특성을 고려한 코드 작성에서는 AI의 제안을 그대로 사용하기 어려웠습니다. 

특히 React Native 환경에서는 작은 환경 변화에도 빌드가 실패하는 경우가 많았고, 이러한 문제를 해결하기 위해서는 결국 개발자의 경험과 판단이 필요했습니다.

또한 게임 로직의 경우, 단순한 기능 구현은 AI의 도움으로 쉽게 해결할 수 있었지만, 복잡한 상태 관리나 애니메이션 처리, 최적화 작업은 여전히 개발자의 전문성이 요구되는 영역이었습니다.

### 3. 견문을 넓히는 과정

AI를 활용하면서 가장 크게 느낀 점은 다양한 분야에 대한 견문을 넓힐 수 있었다는 것입니다. 게임 개발이라는 새로운 영역에 도전하면서 게임 디자인, 백엔드 아키텍처, UX 설계 등 평소에는 깊이 들여다보지 못했던 분야들을 탐색할 수 있었습니다.

AI가 제공하는 다양한 제안과 솔루션을 검토하고 적용하는 과정에서 자연스럽게 여러 분야의 지식을 습득할 수 있었고, 이는 개발자로서 저의 시야를 넓히는 값진 경험이 되었습니다. 특히 게임 디자인 원칙, 사용자 몰입 요소, 수익화 모델 등에 대한 이해는 앞으로의 프로젝트에서도 큰 자산이 될 것입니다.

## 마치며: AI 시대의 MVP 개발

![Desktop View](/assets/img/post/20250517/game_banner.png){: width="480" .normal}
*Kepler Pop 게임 배너*

Kepler Pop 프로젝트를 통해 AI 서비스를 활용한 MVP 개발의 가능성과 한계를 모두 경험할 수 있었습니다. 혼자서는 결코 해낼 수 없었을 프로젝트를 AI의 도움으로 실현할 수 있었다는 점은 큰 성취감을 주었습니다.

하지만 동시에 AI는 만능이 아니라는 사실도 분명해졌습니다. AI는 개발자의 생산성을 높이고 부족한 영역을 보완해주는 강력한 도구이지만, 결국 그것을 효과적으로 활용하는 것은 인간의 판단과 경험에 달려 있습니다.

이제 MVP 출시를 앞두고 있는 Kepler Pop은 AI의 도움으로 시작되었지만, 앞으로의 성장과 발전은 실제 사용자들의 피드백과 그에 따른 인간의 판단에 의해 결정될 것입니다. AI는 시작점을 제공했지만, 진정한 가치는 그것을 활용하는 인간의 창의성과 판단력에서 비롯된다는 것이 이번 프로젝트의 가장 큰 교훈이었습니다.

AI 시대의 MVP 개발은 우리에게 다양한 분야에 도전할 수 있는 자신감을 주었습니다. 한 분야의 전문가가 아니더라도, AI의 도움으로 다양한 영역을 탐험하고 자신의 견문을 넓힐 수 있게 되었습니다. 이 과정에서 우리는 더 다양한 시각과 아이디어를 접하게 되고, 이는 결국 더 창의적인 결과물로 이어집니다.

여러분도 평소 도전하고 싶었지만 전문성 부족으로 망설였던 프로젝트가 있다면, AI의 도움을 받아 한번 시작해보는 것은 어떨까요? 그 과정에서 분명 많은 것을 배우고, 성장할 수 있을 것입니다. 실패하더라도 그 경험 자체가 여러분의 역량을 한 단계 높이는 값진 자산이 될 것입니다.


## AI 도구 링크

- [v0](https://v0.dev/)
- [ChatGPT](https://chatgpt.com/)
- [Claude](https://claude.ai/)
- [Cursor](https://www.cursor.com/)

---

Kepler Pop 프로젝트는 현재 개발 중이며, 6월 말 출시를 목표로 하고 있습니다.
"우주 식물"과 "퍼즐 게임" 두 키워드를 바탕으로 1.5개월의 진행 과정을 녹여 보았습니다. :)