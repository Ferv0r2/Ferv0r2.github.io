---
title: "새는 난다고 적으면 펭귄은 어떻게 될까?"
description: "'새는 난다'처럼 대체로 맞는 말을 지식 장부에 규칙으로 적으면, 펭귄 한 마리 때문에 장부 전체를 쓸 수 없게 돼요. 예외가 있는 말은 어디에 어떻게 적어야 하는지 그림으로 풀어 봤어요."
author: Ferv0r2
date: 2026-11-24 20:00:00 +0900
categories: [ai, knowledge-graph]
tags: [knowledge-graph, ontology, reasoning, nonmonotonic-reasoning, default-logic, shacl]
image:
  path: /assets/img/post/20261124/penguins-cover.jpg
  alt: 장부 위에 선 펭귄이 둥근 상자 안을 나는 새 세 마리를 올려다보는 모습
render_with_liquid: false
---

친구가 "새는 날잖아"라고 하면 아무도 펭귄 이야기를 꺼내지 않아요. 말하는 사람도 듣는 사람도 예외가 있다는 걸 알거든요. 그런데 같은 말을 컴퓨터가 따지는 지식 장부에 적으면, 펭귄 한 마리 때문에 장부 전체를 쓸 수 없게 돼요.

이 글을 다 읽으면 "대체로 맞는 말"을 장부 어디에, 어떻게 적어야 탈이 없는지 알게 돼요.

> **이 글에서 깨달은 것**
>
> 1. "새는 난다"를 규칙으로 적으면 "모든 새가 예외 없이 난다"가 돼요. 펭귄 한 마리가 장부 전체를 망가뜨려요.
> 2. 사람은 더 알게 되면 생각을 바꾸지만 OWL은 보태기만 해요. "대체로"는 기본값 규칙으로 따로 적어요.
> 3. 기본값 규칙은 이름으로만 찾고 못 찾으면 "아니다"로 봐요. 그래서 OWL 추론기를 먼저 돌려요.
> 4. 짐작한 기록은 사실과 따로 담고, 무엇을 보고 짐작했는지 붙여 둬요.
> 5. "대개 30명 이하"를 막는 조건으로 적으면 조용히 틀리거나 거짓 경보를 내요. 살펴볼 신호로 적어요.
{: .prompt-tip }

## "새는 난다"를 규칙으로 적으면 예외가 들어갈 틈이 없어요

컴퓨터가 읽고 따질 수 있게 적어 둔 지식을 온톨로지라고 해요. 여기서는 온톨로지에 적은 문장 전체를 장부라고 부를게요. 문장 세 개로 된 장부 하나가 인공지능 논리 공부에 자주 나와요.

```
새   ⊑ 나는 것
펭귄 ⊑ 새
펭귄 ⊑ ¬나는 것
```

`⊑`는 "왼쪽은 모두 오른쪽 안에 들어간다"는 뜻이고 `¬`는 "아니다"예요. 우리말로 읽으면 "새는 난다, 펭귄은 새다, 펭귄은 못 난다"예요. 일상말로는 셋 다 맞아요.

<figure class="fig">
<svg viewBox="0 0 400 262" style="max-width:400px" role="img" aria-label="나는 것 상자 안에 새 상자, 그 안에 펭귄이 있고, 펭귄은 상자 밖의 못 나는 것에도 있어야 한다">
  <defs><marker id="f1-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-red"/></marker></defs>
  <rect x="12" y="12" width="240" height="238" rx="18" class="box-blue"/>
  <text x="30" y="44" class="bold blue">나는 것</text>
  <rect x="32" y="62" width="200" height="170" rx="14" class="box"/>
  <text x="50" y="92" class="bold">새</text>
  <rect x="54" y="118" width="156" height="88" rx="12" class="box-red dash"/>
  <text x="132" y="168" text-anchor="middle" class="bold red">펭귄?</text>
  <rect x="286" y="104" width="104" height="116" rx="14" class="box-red"/>
  <text x="338" y="156" text-anchor="middle" class="bold red">못 나는</text>
  <text x="338" y="180" text-anchor="middle" class="bold red">것</text>
  <path d="M210 162 L280 162" class="line-red dash" marker-end="url(#f1-ah)"/>
</svg>
<figcaption>펭귄은 새라서 나는 것 안에 들어가는데, 셋째 문장은 펭귄이 그 밖에도 있으라고 해요.</figcaption>
</figure>

장부를 읽고 따지는 프로그램이 추론기예요. OWL 추론기는 첫째 문장과 둘째 문장을 이어 "펭귄은 난다"를 끌어내요. 그런데 셋째 문장은 펭귄이 못 난다고 해요. 날면서 못 나는 것은 없으니 추론기는 "펭귄은 있을 수 없는 종류"라고 답해요. 온톨로지 편집기 프로테제(Protégé)에서 추론기를 돌리면 펭귄이 빨갛게 표시돼요.

회사 규정으로 바꿔 보면 쉬워요. "모든 직원은 9시에 출근한다"와 "야간조 직원은 9시에 출근하지 않는다"가 함께 있으면, 두 규정을 다 지키는 야간조 직원은 있을 수 없어요.

여기까지는 펭귄이라는 종류가 비어 있을 뿐이에요. 펭귄이 한 마리라도 적히면 일이 커져요.

<figure class="fig">
<svg viewBox="0 0 400 330" style="max-width:400px" role="img" aria-label="문장 세 개만 있는 장부는 펭귄만 빈 종류이고, 펭귄 뽀로로를 적은 장부는 모든 문장이 빨갛게 되어 철수는 변호사냐는 질문에도 예가 나온다">
  <text x="100" y="28" text-anchor="middle" class="bold">문장 세 개만</text>
  <rect x="6" y="44" width="188" height="276" rx="12" class="box"/>
  <text x="22" y="80">새 ⊑ 나는 것</text>
  <text x="22" y="110">펭귄 ⊑ 새</text>
  <text x="22" y="140">펭귄 ⊑ ¬나는 것</text>
  <text x="22" y="170">철수는 사람</text>
  <text x="22" y="200">가나다랩은 회사</text>
  <text x="22" y="230" class="bold red">펭귄만 빈 종류</text>
  <line x1="6" y1="250" x2="194" y2="250" class="line"/>
  <text x="22" y="280" class="muted">철수는 변호사?</text>
  <text x="22" y="306" class="bold">답: 모른다</text>
  <text x="300" y="28" text-anchor="middle" class="bold red">+ 펭귄(뽀로로)</text>
  <rect x="206" y="44" width="188" height="276" rx="12" class="box-red"/>
  <text x="222" y="80" class="red">새 ⊑ 나는 것</text>
  <text x="222" y="110" class="red">펭귄 ⊑ 새</text>
  <text x="222" y="140" class="red">펭귄 ⊑ ¬나는 것</text>
  <text x="222" y="170" class="red">철수는 사람</text>
  <text x="222" y="200" class="red">가나다랩은 회사</text>
  <text x="222" y="230" class="bold red">펭귄(뽀로로)</text>
  <line x1="206" y1="250" x2="394" y2="250" class="line"/>
  <text x="222" y="280" class="muted">철수는 변호사?</text>
  <text x="222" y="306" class="bold red">답: 예</text>
</svg>
<figcaption>펭귄이 빈 종류일 때는 괜찮다가, 뽀로로 한 마리가 적히면 장부 전체가 모순이 되어 상관없는 질문에도 "예"가 나와요.</figcaption>
</figure>

뽀로로가 펭귄이라고 적는 순간, 아무도 들어갈 수 없는 종류에 하나가 들어와요. 이제 장부의 모든 문장이 함께 참일 수 없어요. 논리에서는 모순에서 무엇이든 끌어낼 수 있어서 펭귄과 상관없는 "철수는 변호사야?"에도 "예"가 나와요. 이걸 폭발 원리(principle of explosion)라고 불러요. 그래서 추론기는 장부 전체가 모순이면 다른 질문에 답하지 않고 멈춰요.

> 처음엔 이렇게 답했어요
>
> "OWL은 날지 못해도 새라고 할 수 있는게 되네. 날수도 날지 못할 수도가 되는데 그럼"
>
> 날 수도 있고 못 날 수도 있다는 건 일상말 "새는 난다"의 뜻 그대로예요. 그래서 "OWL은 뭐라고 할까"보다 "어디가 잘못됐을까"에 가까운 답이었어요. OWL은 `⊑`를 그렇게 너그럽게 보지 않아요.
{: .answer }

> **→ 그래서 실제로는** 장부에 "A는 B다"를 규칙으로 넣기 전에, 예외가 하나라도 있는지 먼저 물어요. 있으면 그 예외가 적히는 날 장부 전체가 멈춰요.
{: .practice }

**`⊑`로 적은 문장에는 예외가 없어요. 예외가 하나라도 적히면 장부 전체를 쓸 수 없게 돼요.**

## 그래서 "대체로"는 OWL 밖에 따로 적어요

이 예에 자주 나오는 새 이름이 트위티예요. "트위티는 새야"라는 말을 들으면 우리는 "그럼 날겠네" 해요. 이어서 "트위티는 펭귄이야"를 들으면 "아, 그럼 못 날겠네"로 바뀌어요.

<figure class="fig">
<svg viewBox="0 0 420 284" style="max-width:420px" role="img" aria-label="트위티는 새야, 트위티는 펭귄이야를 차례로 들었을 때 사람은 날겠네를 지우고 못 날겠네로 바꾸고, OWL은 날겠네에 못 난다를 보태 모순이 난다">
  <defs><marker id="f3-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker><marker id="f3-ahb" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-blue"/></marker></defs>
  <text x="8" y="40" class="muted">들은 말</text>
  <rect x="88" y="16" width="134" height="38" rx="19" class="wash"/>
  <text x="155" y="41" text-anchor="middle">트위티는 새야</text>
  <rect x="246" y="16" width="166" height="38" rx="19" class="wash"/>
  <text x="329" y="41" text-anchor="middle">트위티는 펭귄이야</text>
  <path d="M88 68 L404 68" class="line" marker-end="url(#f3-ah)"/>
  <text x="8" y="128" class="bold">사람</text>
  <rect x="88" y="98" width="134" height="50" rx="10" class="box-blue"/>
  <text x="155" y="129" text-anchor="middle" class="bold blue">날겠네</text>
  <path d="M222 123 L242 123" class="line-blue" marker-end="url(#f3-ahb)"/>
  <rect x="246" y="88" width="166" height="72" rx="10" class="box-blue"/>
  <text x="329" y="114" text-anchor="middle" class="muted">날겠네</text>
  <path d="M303 108 L355 108" class="line"/>
  <text x="329" y="146" text-anchor="middle" class="bold blue">못 날겠네</text>
  <text x="8" y="228" class="bold">OWL</text>
  <rect x="88" y="198" width="134" height="50" rx="10" class="box-blue"/>
  <text x="155" y="229" text-anchor="middle" class="bold blue">날겠네</text>
  <path d="M222 223 L242 223" class="line" marker-end="url(#f3-ah)"/>
  <rect x="246" y="176" width="166" height="98" rx="10" class="box-red"/>
  <text x="329" y="202" text-anchor="middle" class="red">날겠네</text>
  <text x="329" y="230" text-anchor="middle" class="red">+ 못 난다</text>
  <text x="329" y="260" text-anchor="middle" class="bold red">= 모순</text>
</svg>
<figcaption>사람은 앞의 결론을 지우고 새 결론으로 바꾸지만, OWL은 앞의 결론을 남긴 채 새 결론을 보태서 둘이 부딪혀요.</figcaption>
</figure>

정보를 보탰는데 앞의 결론이 사라졌어요. 사람은 더 알게 되면 생각을 고쳐요. 이런 생각 방식을 비단조 추론(non-monotonic reasoning)이라고 불러요.

OWL은 반대로 단조(monotonic) 방식이에요. 기록을 보태면 결론이 늘기만 하고 앞의 결론은 그대로 남아요. 그래서 "트위티는 펭귄"을 보태면 "못 난다"로 바뀌는 대신, 뽀로로 때처럼 모순이 나요. OWL에서 "날겠네"를 없애려면 그 결론을 낳은 기록을 빼는 수밖에 없어요.

이 문제를 받고 저는 "새가 나는것에 포함되는 전제가 틀렸네 정말."이라고 했어요. 맞는 말이었어요. OWL에서는 "새는 난다"가 틀린 전제예요. 그런데 사람은 그 말을 버리지 않고도 생각을 바꿨어요.

사람은 "새는 난다"를 "반대 증거가 없으면 난다"라는 뜻으로 써요. 못 난다는 말을 찾지 못하면 난다고 봐요. 이렇게 보통은 그렇다고 두는 규칙이 기본값 규칙(default rule)이에요. 1980년에 레이터의 기본 논리와 매카시의 한정이 이 생각을 논리로 다듬었어요.

같은 "A는 B다"라도 실제 뜻은 셋으로 나뉘어요.

| 실제 뜻 | 예 |
|---|---|
| 예외 없이 모두 | 펭귄은 새다 |
| 대체로 | 새는 난다 |
| 숫자 붙은 대체로 | 대개 30명 이하 |

이 표에서 `⊑`로 적어도 되는 건 "예외 없이 모두"뿐이에요. 나머지 둘은 기본값 규칙으로 따로 적어요.

> **→ 그래서 실제로는** 규칙 칸에는 "펭귄은 새다"처럼 예외가 없는 말만 넣어요. 언어 모델(LLM)이 글에서 뽑아 온 "새는 난다" 같은 기록은 기본값 규칙 칸으로 보내요.
{: .practice }

**"대체로"는 `⊑`로 적지 말고 기본값 규칙에 적어요.**

## 그런데 기본값 규칙은 이름으로만 찾아요

기본값 규칙을 장부 옆에 두고 트위티를 다시 넣어 봤어요. 장부에는 "펭귄은 못 난다", "트위티는 새", "트위티는 펭귄"이라는 기록 세 개가 있어요. 규칙은 "트위티는 못 난다"는 기록을 찾아보고 없으면 트위티는 난다고 해요. 규칙의 답은 "난다"였는데 세상에서는 틀린 결론이에요. 급식실 이야기로 보면 까닭이 보여요.

<figure class="fig">
<svg viewBox="0 0 400 318" style="max-width:400px" role="img" aria-label="알레르기 명단에 3반은 모두 땅콩, 영희 우유, 민준 달걀이 있고, 철수라는 이름을 찾으면 없어서 땅콩 반찬을 준다">
  <rect x="12" y="12" width="236" height="188" rx="12" class="box"/>
  <text x="30" y="46" class="bold">알레르기 명단</text>
  <line x1="12" y1="62" x2="248" y2="62" class="line"/>
  <rect x="20" y="74" width="220" height="36" rx="6" class="wash"/>
  <text x="32" y="98">3반은 모두</text>
  <text x="236" y="98" text-anchor="end">땅콩</text>
  <text x="32" y="142">영희</text>
  <text x="236" y="142" text-anchor="end">우유</text>
  <text x="32" y="182">민준</text>
  <text x="236" y="182" text-anchor="end">달걀</text>
  <circle cx="320" cy="92" r="36" class="box-blue"/>
  <text x="320" y="98" text-anchor="middle" class="bold">철수</text>
  <path d="M346 118 L370 142" class="line-blue"/>
  <text x="320" y="176" text-anchor="middle" class="muted">이름 찾기</text>
  <text x="30" y="234" class="muted">철수는 3반이에요</text>
  <rect x="12" y="252" width="376" height="54" rx="12" class="box-red"/>
  <text x="200" y="285" text-anchor="middle" class="bold red">이름이 없으니 땅콩 반찬을 줘요</text>
</svg>
<figcaption>명단에는 3반 전체를 가리키는 말이 있지만 급식 담당은 "철수"라는 이름만 찾아요.</figcaption>
</figure>

급식 담당은 "알레르기 명단에 이름이 없으면 땅콩 반찬을 준다"는 규칙을 따라요. 명단에는 "3반은 모두 땅콩 알레르기"라고 적혀 있고 철수는 3반이에요. 그런데 급식 담당은 명단에서 "철수"라는 이름만 찾아요. 없으니 철수에게 땅콩 반찬을 줘요. 트위티 장부도 똑같아요.

| 급식실 | 트위티 장부 |
|---|---|
| 3반은 모두 땅콩 | 펭귄은 못 난다 |
| 철수는 3반 | 트위티는 펭귄 |
| "철수" 찾기 | "트위티는 못 난다" 찾기 |
| 없으니 땅콩 반찬 | 없으니 "난다" |

"펭귄은 못 난다"는 펭귄이라는 종류 전체를 가리키는 말이에요. 트위티 이름이 든 기록이 아니에요. 트위티가 못 난다는 건 두 기록을 이어야 나오는데 규칙은 잇지 않아요. "찾지 못함"은 그 모양의 기록을 찾아봤는데 없었다는 뜻이지, 아니라고 밝혀졌다는 뜻이 아니에요.

> 처음엔 이렇게 답했어요
>
> "나는것 줄을 찾지 못했다는게 첫번째 줄을 못 찾았다는거 아니야? 그럼 난다고 할거아니야. 찾지 못했다는 전제가 잘 이해가 안돼"
>
> 규칙이 트위티를 난다고 한다는 건 맞았어요. 헷갈린 건 "찾지 못함"이 무엇을 찾는 일인지였어요. 첫째 문장은 장부에 있지만 규칙은 트위티 이름이 든 기록만 찾아요.
{: .answer }

급식실 이야기를 듣고 저는 "아아 급식실 이야기로 보니까 확 와닿네."라고 했어요.

여기서 눈여겨볼 점이 있어요. 규칙은 끝까지 따라가지 못했는데 결과는 "모른다"가 아니라 "난다"였어요. 출석부로 보면 이래요.

<figure class="fig">
<svg viewBox="0 0 400 304" style="max-width:400px" role="img" aria-label="글씨를 못 알아본 학생을 열린 세계 출석부는 확인 못 함으로, 닫힌 세계 출석부는 결석으로 적는다">
  <text x="100" y="26" text-anchor="middle" class="bold blue">열린 세계</text>
  <rect x="6" y="40" width="188" height="152" rx="12" class="box"/>
  <text x="22" y="76">가은</text>
  <text x="178" y="76" text-anchor="end">출석</text>
  <text x="22" y="112">나래</text>
  <text x="178" y="112" text-anchor="end">출석</text>
  <rect x="12" y="126" width="176" height="36" rx="6" class="wash"/>
  <path d="M22 146 q6 -12 12 0 t12 0 t12 0 t12 0" class="line"/>
  <text x="178" y="150" text-anchor="end" class="bold">확인 못 함</text>
  <text x="100" y="226" text-anchor="middle" class="bold">빠뜨렸을 뿐</text>
  <text x="100" y="252" text-anchor="middle" class="muted">틀린 말 없음</text>
  <text x="300" y="26" text-anchor="middle" class="bold red">닫힌 세계</text>
  <rect x="206" y="40" width="188" height="152" rx="12" class="box"/>
  <text x="222" y="76">가은</text>
  <text x="378" y="76" text-anchor="end">출석</text>
  <text x="222" y="112">나래</text>
  <text x="378" y="112" text-anchor="end">출석</text>
  <rect x="212" y="126" width="176" height="36" rx="6" class="box-red"/>
  <path d="M222 146 q6 -12 12 0 t12 0 t12 0 t12 0" class="line"/>
  <text x="378" y="150" text-anchor="end" class="bold red">결석</text>
  <text x="300" y="226" text-anchor="middle" class="bold red">거짓 결석</text>
  <text x="300" y="252" text-anchor="middle" class="muted">틀린 말 하나</text>
  <line x1="40" y1="270" x2="360" y2="270" class="line dash"/>
  <text x="200" y="294" text-anchor="middle" class="muted">글씨를 못 알아본 건 같아요</text>
</svg>
<figcaption>못 알아본 건 같아도 "확인 못 함"으로 적으면 빠뜨릴 뿐이고, "결석"으로 적으면 틀린 말이 돼요.</figcaption>
</figure>

OWL은 못 찾은 것을 "모른다"로 둬요. 이걸 열린 세계라고 해요. 기본값 규칙은 못 찾은 것을 "아니다"로 봐요. 프롤로그 같은 도구가 이렇게 보는데, 이걸 닫힌 세계라고 해요. 그래서 기본값 규칙이 다 알지 못한 채로 돌면 "모른다" 대신 틀린 답이 나와요.

추론기를 평가하는 낱말이 둘 있어요. 전제가 맞으면 결론도 맞게 내는 것을 건전함, 끌어낼 수 있는 걸 다 끌어내는 것을 완전함이라고 해요. 러셀과 노빅의 인공지능 교재도 7장에서 추론 규칙을 이 두 낱말로 평가해요.

| 낱말 | 경보로 치면 |
|---|---|
| 건전함(sound) | 거짓 경보가 없음 |
| 완전함(complete) | 놓치는 게 없음 |

열린 세계에서는 완전하지 않아도 결론이 빠질 뿐이에요. 닫힌 세계에서는 완전하지 않으면 건전하지도 않게 돼요. 출석부의 거짓 결석이 바로 그런 경우예요.

그럼 규칙 앞에 무엇을 둬야 할까요? 급식실이라면 점심 전에 "3반은 모두"를 3반 학생 이름으로 풀어 명단에 적어 두면 돼요.

<figure class="fig">
<svg viewBox="0 0 400 374" style="max-width:400px" role="img" aria-label="3반은 모두 땅콩을 철수, 수아, 하준 이름으로 풀어 적은 명단에서 철수를 찾으면 있어서 땅콩 반찬을 뺀다">
  <rect x="12" y="12" width="236" height="282" rx="12" class="box"/>
  <text x="30" y="46" class="bold">알레르기 명단</text>
  <line x1="12" y1="62" x2="248" y2="62" class="line"/>
  <text x="32" y="96" class="muted">3반은 모두</text>
  <text x="236" y="96" text-anchor="end" class="muted">땅콩</text>
  <rect x="20" y="110" width="220" height="104" rx="6" class="box-blue"/>
  <text x="32" y="138" class="bold">철수</text>
  <text x="236" y="138" text-anchor="end">땅콩</text>
  <text x="32" y="170">수아</text>
  <text x="236" y="170" text-anchor="end">땅콩</text>
  <text x="32" y="202">하준</text>
  <text x="236" y="202" text-anchor="end">땅콩</text>
  <text x="32" y="246">영희</text>
  <text x="236" y="246" text-anchor="end">우유</text>
  <text x="32" y="278">민준</text>
  <text x="236" y="278" text-anchor="end">달걀</text>
  <path d="M258 112 L268 112 L268 212 L258 212" class="line-blue"/>
  <text x="280" y="156" class="bold blue">① 이름으로</text>
  <text x="280" y="180" class="bold blue">풀어 적기</text>
  <text x="322" y="228" text-anchor="middle" class="bold blue">② 찾기</text>
  <circle cx="322" cy="268" r="28" class="box-blue"/>
  <text x="322" y="274" text-anchor="middle" class="bold">철수</text>
  <path d="M342 288 L364 308" class="line-blue"/>
  <rect x="12" y="314" width="376" height="50" rx="12" class="box-blue"/>
  <text x="200" y="345" text-anchor="middle" class="bold blue">철수가 있으니 땅콩 반찬을 빼요</text>
</svg>
<figcaption>"3반은 모두"를 이름으로 먼저 풀어 적어 두면, 이름만 찾는 급식 담당도 철수를 찾아요.</figcaption>
</figure>

장부에서는 이 풀어 적기를 OWL 추론기가 해요. 그러니 OWL 추론을 끝까지 먼저 돌리고 기본값 규칙은 그다음에 돌려요.

- **OWL 추론기는 여기까지**: "트위티는 펭귄"과 "펭귄은 못 난다"를 이어 "트위티는 못 난다"를 적어 둬요.
- **기본값 규칙은 여기부터**: 적어 둔 기록을 찾아보고 없을 때만 "난다"를 붙여요.

> **→ 그래서 실제로는** "없으면 아니다"로 보는 규칙이나 검사는 OWL 추론을 끝까지 돌린 장부에만 돌려요.
{: .practice }

**못 찾으면 "아니다"로 보는 규칙 앞에는 끝까지 따라가는 추론을 먼저 둬요.**

## 순서를 지켜도 짐작은 따로 담아야 해요

순서를 지켜도 문제가 하나 남아요. 기본값 규칙이 낸 짐작을 어디에 적느냐예요. 장부의 기록은 어디서 왔는지에 따라 셋으로 나눠 담아요.

<figure class="fig">
<svg viewBox="0 0 420 432" style="max-width:420px" role="img" aria-label="직접 적은 기록에서 OWL 추론기로 끌어낸 기록, 기본값 규칙으로 짐작한 기록이 나오고, 짐작한 기록은 직접 적은 기록으로 되돌려 넣지 않으며 근거 꼬리표를 단다">
  <defs><marker id="f7-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker><marker id="f7-ahr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-red"/></marker></defs>
  <rect x="20" y="12" width="200" height="66" rx="12" class="box"/>
  <text x="38" y="40" class="bold">직접 적은 기록</text>
  <text x="38" y="66" class="muted">사람이 출처를 보고</text>
  <path d="M120 78 L120 124" class="line" marker-end="url(#f7-ah)"/>
  <text x="136" y="108" class="bold blue">OWL 추론기</text>
  <rect x="20" y="130" width="200" height="66" rx="12" class="box-blue"/>
  <text x="38" y="158" class="bold blue">끌어낸 기록</text>
  <text x="38" y="184" class="muted">늘기만 해요</text>
  <path d="M120 196 L120 242" class="line" marker-end="url(#f7-ah)"/>
  <text x="136" y="226" class="bold">기본값 규칙</text>
  <rect x="20" y="248" width="200" height="66" rx="12" class="box-foil"/>
  <text x="38" y="276" class="bold">짐작한 기록</text>
  <text x="38" y="302" class="muted">사라질 수 있어요</text>
  <path d="M120 314 L120 332" class="line"/>
  <rect x="20" y="332" width="250" height="92" rx="10" class="box dash"/>
  <text x="36" y="358" class="bold">짐작#7</text>
  <text x="110" y="358" class="bold">뽀삐는 난다</text>
  <text x="36" y="384" class="muted">근거</text>
  <text x="110" y="384">뽀삐는 새</text>
  <text x="36" y="410" class="muted">못 찾음</text>
  <text x="110" y="410">뽀삐는 못 난다</text>
  <path d="M220 281 C300 281, 300 45, 228 45" class="line-red dash" marker-end="url(#f7-ahr)"/>
  <circle cx="281" cy="163" r="13" class="box-red"/>
  <path d="M275 157 L287 169 M287 157 L275 169" class="line-red"/>
  <text x="304" y="156" class="bold red">되돌려</text>
  <text x="304" y="180" class="bold red">넣지 않아요</text>
</svg>
<figcaption>짐작한 기록은 근거를 붙여 따로 담고 사실 쪽으로 되돌려 넣지 않아요.</figcaption>
</figure>

짐작한 기록을 사실 쪽에 되돌려 넣으면 어떻게 될까요? 장부에 "뽀삐는 새"만 있었어요. 기본값 규칙이 "뽀삐는 난다"를 끌어내 장부에 그대로 적었어요. 다음 날 "뽀삐는 펭귄"이 들어와 OWL 추론기를 다시 돌렸어요.

그러면 규칙이 적은 "뽀삐는 난다"와 추론기가 끌어낸 "뽀삐는 못 난다"가 함께 있으니 장부 전체가 모순이 되어 추론기가 멈춰요. 그런데 세상에는 모순이 없어요. 뽀삐는 그냥 못 나는 펭귄이에요. 모순은 짐작을 사실처럼 적어서 생겼어요.

> 처음엔 이렇게 답했어요
>
> "모순이 나겠네. 규칙이 낸 줄은 이어서 적어야지..?"
>
> 모순은 맞았어요. 이어서 적기는 세상이 바뀌었을 때 옛 기록을 닫고 새 기록을 잇는 방법이에요. 뽀삐는 난 적이 없어요. 세상은 그대로인데 짐작이 틀렸어요.
{: .answer }

그래서 짐작한 기록은 따로 담고 새 기록이 들어올 때마다 다시 계산해요. 근거도 붙여 둬요. 그림의 짐작#7에는 "뽀삐는 새"를 근거로, "뽀삐는 못 난다"를 찾지 못해서 나왔다고 적혀 있어요. "뽀삐는 못 난다"가 생기면 짐작#7을 거둬들이면 돼요.

결론과 근거를 이어 두고 근거가 무너지면 결론도 거둬들이는 장치가 진리 유지 시스템(truth maintenance system)이에요. 도일이 1979년에 내놓았어요.

> **→ 그래서 실제로는** LLM이나 규칙이 짐작한 기록에는 짐작이라는 표시와 근거 기록을 달아 따로 담아요. 근거가 사라지면 그 짐작도 거둬들여요.
{: .practice }

**짐작은 사실 칸에 넣지 않고, 무엇을 보고 짐작했는지 함께 적어요.**

## 숫자로 온 "대개"는 살펴볼 신호로만 적어요

"대체로"는 숫자로도 들어와요. LLM이 기사에서 "스타트업은 대개 직원이 30명 이하다"를 읽고 기록 하나를 뽑았어요. 누군가 이 기록을 "스타트업의 직원은 많아야 30명"이라는 규칙으로 장부에 넣었어요. 장부에는 스타트업 가나다랩과 그 직원 31명이 이름으로 적혀 있어요.

<figure class="fig">
<svg viewBox="0 0 400 262" style="max-width:400px" role="img" aria-label="많아야 30명 네모 안에 직원 점 31개를 넣을 때, OWL은 두 점을 한 사람으로 겹치고 SHACL은 네모 밖 한 점에 위반 경보를 울린다">
  <text x="102" y="22" text-anchor="middle" class="bold">OWL</text>
  <text x="33" y="52" class="muted">많아야 30명</text>
  <rect x="33" y="62" width="138" height="128" rx="8" class="line-foil dash"/>
  <circle cx="47" cy="80" r="7" class="solid-ink"/><circle cx="69" cy="80" r="7" class="solid-ink"/><circle cx="91" cy="80" r="7" class="solid-ink"/><circle cx="113" cy="80" r="7" class="solid-ink"/><circle cx="135" cy="80" r="7" class="solid-ink"/><circle cx="157" cy="80" r="7" class="solid-ink"/>
  <circle cx="47" cy="104" r="7" class="solid-ink"/><circle cx="69" cy="104" r="7" class="solid-ink"/><circle cx="91" cy="104" r="7" class="solid-ink"/><circle cx="113" cy="104" r="7" class="solid-ink"/><circle cx="135" cy="104" r="7" class="solid-ink"/><circle cx="157" cy="104" r="7" class="solid-ink"/>
  <circle cx="47" cy="128" r="7" class="solid-ink"/><circle cx="69" cy="128" r="7" class="solid-ink"/><circle cx="91" cy="128" r="7" class="solid-ink"/><circle cx="113" cy="128" r="7" class="solid-ink"/><circle cx="135" cy="128" r="7" class="solid-ink"/><circle cx="157" cy="128" r="7" class="solid-ink"/>
  <circle cx="47" cy="152" r="7" class="solid-ink"/><circle cx="69" cy="152" r="7" class="solid-ink"/><circle cx="91" cy="152" r="7" class="solid-ink"/><circle cx="113" cy="152" r="7" class="solid-ink"/><circle cx="135" cy="152" r="7" class="solid-ink"/><circle cx="157" cy="152" r="7" class="solid-ink"/>
  <circle cx="47" cy="176" r="7" class="solid-ink"/><circle cx="69" cy="176" r="7" class="solid-ink"/><circle cx="91" cy="176" r="7" class="solid-ink"/><circle cx="113" cy="176" r="7" class="solid-ink"/><circle cx="135" cy="176" r="7" class="solid-ink"/><circle cx="152" cy="176" r="7" class="solid-red"/><circle cx="162" cy="176" r="7" class="solid-red"/>
  <text x="102" y="222" text-anchor="middle">어느 둘을 한 사람으로</text>
  <text x="102" y="248" text-anchor="middle" class="muted">경보 없음</text>
  <text x="300" y="22" text-anchor="middle" class="bold">SHACL</text>
  <text x="214" y="52" class="muted">많아야 30명</text>
  <rect x="214" y="62" width="138" height="128" rx="8" class="line-foil dash"/>
  <circle cx="228" cy="80" r="7" class="solid-ink"/><circle cx="250" cy="80" r="7" class="solid-ink"/><circle cx="272" cy="80" r="7" class="solid-ink"/><circle cx="294" cy="80" r="7" class="solid-ink"/><circle cx="316" cy="80" r="7" class="solid-ink"/><circle cx="338" cy="80" r="7" class="solid-ink"/>
  <circle cx="228" cy="104" r="7" class="solid-ink"/><circle cx="250" cy="104" r="7" class="solid-ink"/><circle cx="272" cy="104" r="7" class="solid-ink"/><circle cx="294" cy="104" r="7" class="solid-ink"/><circle cx="316" cy="104" r="7" class="solid-ink"/><circle cx="338" cy="104" r="7" class="solid-ink"/>
  <circle cx="228" cy="128" r="7" class="solid-ink"/><circle cx="250" cy="128" r="7" class="solid-ink"/><circle cx="272" cy="128" r="7" class="solid-ink"/><circle cx="294" cy="128" r="7" class="solid-ink"/><circle cx="316" cy="128" r="7" class="solid-ink"/><circle cx="338" cy="128" r="7" class="solid-ink"/>
  <circle cx="228" cy="152" r="7" class="solid-ink"/><circle cx="250" cy="152" r="7" class="solid-ink"/><circle cx="272" cy="152" r="7" class="solid-ink"/><circle cx="294" cy="152" r="7" class="solid-ink"/><circle cx="316" cy="152" r="7" class="solid-ink"/><circle cx="338" cy="152" r="7" class="solid-ink"/>
  <circle cx="228" cy="176" r="7" class="solid-ink"/><circle cx="250" cy="176" r="7" class="solid-ink"/><circle cx="272" cy="176" r="7" class="solid-ink"/><circle cx="294" cy="176" r="7" class="solid-ink"/><circle cx="316" cy="176" r="7" class="solid-ink"/><circle cx="338" cy="176" r="7" class="solid-ink"/>
  <circle cx="378" cy="176" r="7" class="solid-red"/>
  <text x="300" y="222" text-anchor="middle" class="bold red">위반: 31개, 최대 30</text>
  <text x="300" y="248" text-anchor="middle" class="red">경보가 울려요</text>
</svg>
<figcaption>같은 31명을 두고 OWL은 어느 둘을 한 사람으로 보고, SHACL은 위반 경보를 울려요.</figcaption>
</figure>

OWL은 이름이 다르다고 다른 사람이라고 보지 않아요. 이름이 다르면 다른 대상이라고 보는 것을 유일 이름 가정(unique name assumption)이라고 하는데, OWL은 이 가정을 두지 않아요.

그래서 31개 이름이 30명 이하를 가리키려면 적어도 두 이름은 같은 사람이어야 한다고 끌어내요. 어느 둘인지는 몰라요. 틀린 결론이 경보 없이 조용히 남아요. 31명이 모두 서로 다르다는 기록까지 있었다면 장부 전체가 모순이 되어 멈췄을 거예요.

> 처음엔 이렇게 답했어요
>
> "모른다 아니다라곤 안한댔으니"
>
> 열린 세계를 떠올린 건 맞았어요. OWL은 "위반"이나 "아니다"를 내지 않아요. 다만 "모른다"에서 끝나지 않고 "누군가는 같은 사람"을 끌어냈어요.
{: .answer }

장부가 조건대로 채워졌는지 검사하는 SHACL로 보면 반대가 돼요. SHACL은 적힌 것이 전부라고 보고, 이름이 다르면 다르게 세요. 그래서 "직원이 31명인데 최대 30명"이라는 위반을 알려요. 새 기록을 만들지는 않고 알리기만 해요.

그 경보는 믿을 만할까요? 31명이 정말 서로 다른 사람이라면 그냥 직원이 31명인 스타트업이에요. 아무 문제 없는데 경보가 울렸으니 거짓 경보예요. 같은 사람이 두 번 적힌 기록이 섞였다면 경보는 울렸어도 까닭이 틀렸어요. 문제는 "대개"를 어긴 게 아니라 겹친 기록이에요.

문제의 뿌리는 펭귄 때와 같아요. "대개"를 "최대 30"이라는 조건으로 바꿔 적었어요. 그래도 "대개"를 검사에 쓰고 싶다면 무게를 낮춰요.

<figure class="fig">
<svg viewBox="0 0 400 228" style="max-width:400px" role="img" aria-label="SHACL 결과의 무게는 위반이 가장 무겁고, 주의, 참고 순으로 가볍다. 대개 30명 이하는 참고에 단다">
  <defs><marker id="f9-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-blue"/></marker></defs>
  <text x="8" y="46" class="bold red">위반</text>
  <rect x="60" y="20" width="320" height="40" rx="6" class="solid-red"/>
  <text x="76" y="46" class="mono on-solid">sh:Violation</text>
  <text x="8" y="106" class="bold">주의</text>
  <rect x="60" y="80" width="216" height="40" rx="6" class="box"/>
  <text x="76" y="106" class="mono">sh:Warning</text>
  <text x="8" y="166" class="bold">참고</text>
  <rect x="60" y="140" width="120" height="40" rx="6" class="box-foil"/>
  <text x="76" y="166" class="mono">sh:Info</text>
  <path d="M238 206 C214 206, 196 196, 188 184" class="line-blue" marker-end="url(#f9-ah)"/>
  <text x="244" y="212" class="bold blue">대개 30명 이하</text>
</svg>
<figcaption>SHACL은 검사 결과마다 무게를 달 수 있고 "대개 30명 이하"는 가장 가벼운 참고로 달아요.</figcaption>
</figure>

"대개 30명 이하"는 참고 정도가 맞아요. 평소와 다르니 사람이 살펴볼 후보를 고르는 신호예요.

- **여기까지는 돼요**: 직원이 31명인 가나다랩을 사람이 살펴볼 후보로 올리기
- **여기부터는 아니에요**: 가나다랩을 위반으로 막기, 두 직원을 한 사람으로 합치기

> **→ 그래서 실제로는** LLM이 뽑은 기록의 근거 문장에 "대개", "보통", "흔히"가 있으면 규칙으로 넣지 않아요. 검사에 쓰더라도 `sh:Info`로만 달아요.
{: .practice }

**"대개"를 막는 조건으로 적으면 조용히 틀리거나 거짓 경보를 내요. 살펴볼 신호로 적어요.**

## 결국 예외가 있는 말은 짐작으로 적어요

<figure class="fig">
<svg viewBox="0 0 420 290" style="max-width:420px" role="img" aria-label="펭귄은 새다는 OWL 규칙으로, 새는 대체로 난다는 기본값 규칙으로, 대개 30명 이하는 SHACL 참고로 적는다">
  <defs><marker id="f10-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker><marker id="f10-ahb" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-blue"/></marker></defs>
  <text x="95" y="24" text-anchor="middle" class="muted">적고 싶은 말</text>
  <text x="319" y="24" text-anchor="middle" class="muted">적는 곳</text>
  <rect x="6" y="40" width="178" height="64" rx="10" class="box"/>
  <text x="95" y="68" text-anchor="middle" class="bold">펭귄은 새다</text>
  <text x="95" y="93" text-anchor="middle" class="muted">예외 없음</text>
  <path d="M186 72 L218 72" class="line" marker-end="url(#f10-ah)"/>
  <rect x="224" y="40" width="190" height="64" rx="10" class="box-blue"/>
  <text x="319" y="68" text-anchor="middle" class="bold blue">OWL 규칙</text>
  <text x="319" y="93" text-anchor="middle" class="muted">추론기가 먼저</text>
  <path d="M319 104 L319 124" class="line-blue" marker-end="url(#f10-ahb)"/>
  <rect x="6" y="128" width="178" height="64" rx="10" class="box"/>
  <text x="95" y="156" text-anchor="middle" class="bold">새는 대체로 난다</text>
  <text x="95" y="181" text-anchor="middle" class="muted">예외 있음</text>
  <path d="M186 160 L218 160" class="line" marker-end="url(#f10-ah)"/>
  <rect x="224" y="128" width="190" height="64" rx="10" class="box-foil"/>
  <text x="319" y="156" text-anchor="middle" class="bold">기본값 규칙</text>
  <text x="319" y="181" text-anchor="middle" class="muted">근거 붙여 따로</text>
  <rect x="6" y="216" width="178" height="64" rx="10" class="box"/>
  <text x="95" y="244" text-anchor="middle" class="bold">대개 30명 이하</text>
  <text x="95" y="269" text-anchor="middle" class="muted">숫자가 붙은 대체로</text>
  <path d="M186 248 L218 248" class="line" marker-end="url(#f10-ah)"/>
  <rect x="224" y="216" width="190" height="64" rx="10" class="box"/>
  <text x="319" y="244" text-anchor="middle" class="bold">SHACL 참고</text>
  <text x="319" y="269" text-anchor="middle" class="muted">살펴볼 신호</text>
</svg>
<figcaption>말에 붙은 "모두", "대체로", "대개"가 적을 곳을 정하고, OWL 추론은 기본값 규칙보다 먼저 돌려요.</figcaption>
</figure>

흔히 예외 없는 규칙은 없다고 해요. 장부에서는 반대였어요. `⊑`로 적은 문장에는 예외가 없었어요. 그러니 예외가 있는 말은 규칙이 아니라 짐작으로 적어요.

처음 세 문장으로 돌아가 보면 고칠 곳은 첫 문장 하나였어요. "새는 난다"를 버릴 필요는 없었어요. 친구가 "새는 날잖아"라고 할 때처럼, 장부에도 "대체로"라고 표시해 두면 돼요.

---

**더 읽을 것**

- Reiter (1980), *A Logic for Default Reasoning*. "반대 증거가 없으면"을 논리로 다듬은 기본 논리를 내놓은 글
- Doyle (1979), *A Truth Maintenance System*. 근거가 무너지면 결론도 거둬들이는 진리 유지 시스템을 내놓은 글
- Russell, Norvig, *Artificial Intelligence: A Modern Approach*. 7장에서 건전함과 완전함을, 지식 표현 장에서 기본값 추론과 진리 유지 시스템을 다뤄요
