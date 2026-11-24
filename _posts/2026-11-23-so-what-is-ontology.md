---
title: "그래서 온톨로지가 뭘까?"
description: "철수의 직업이 의사라고 적어 두면, 컴퓨터는 철수가 변호사가 아니라는 걸 알까요? 온톨로지가 무엇인지, 컴퓨터가 읽는 장부에 무엇을 적어야 하는지 그림으로 풀어 봤어요."
author: Ferv0r2
date: 2026-11-23 20:00:00 +0900
categories: [ai, knowledge-graph]
tags: [knowledge-graph, ontology, reasoning, embedding, llm]
image:
  path: /assets/img/post/20261123/cover.jpg
  alt: 펼쳐 놓은 공책 두 권과, 오른쪽 공책에서 화살표로 이어져 떠오르는 점들
render_with_liquid: false
---

친구에게 "철수는 의사야"라고 하면, 친구는 철수가 변호사는 아니라는 걸 바로 알아요. 의사와 변호사가 다른 직업이라는 걸 둘 다 알거든요. 그런데 같은 문장을 컴퓨터가 읽는 장부에 적고 "철수는 변호사야?"라고 물으면, 컴퓨터는 "모른다"고 답해요.

이 글을 다 읽으면 온톨로지가 무엇인지, 컴퓨터가 우리 생각대로 답하게 하려면 장부에 무엇을 적어야 하는지 알게 돼요.

> **이 글에서 깨달은 것**
>
> 1. 이름 붙은 하나하나의 사실은 일기에, "모든 ~는"으로 읽히는 규칙은 사전에 적어요. 온톨로지는 이 사전이에요.
> 2. 장부에 적히지 않은 것은 "아니다"가 아니라 "모른다"예요. "아니다"를 얻으려면 당연한 것까지 적어야 해요.
> 3. 규칙을 세게 적으면 세상의 예외가 모순이 돼요. 같은 규칙으로 OWL은 결론을 내고, SHACL은 검사해요.
> 4. 적을 수 있는 말을 늘리면 따지는 시간이 크게 늘어요. 그래서 일부러 줄여 쓰기도 해요.
> 5. 임베딩은 빈칸을 짐작으로 채워요. 그 짐작은 근거를 갖춘 사실과 규칙으로 걸러요.
{: .prompt-tip }

## 사실은 일기에, 규칙은 사전에 적어요

컴퓨터가 읽는 지식 장부는 사실 하나를 세 칸에 적어요. 누가, 무슨 관계로, 무엇과. "철수의 직업은 의사다"는 철수, 직업, 의사예요. 그림으로 그리면 화살표 하나예요.

<figure class="fig">
<svg viewBox="0 0 420 340" style="max-width:420px" role="img" aria-label="철수에서 의사로 가는 직업 화살표 하나가 기록 하나다. 영희, 철수, 의사, 가나다랩, 서울이 화살표로 이어지면 그래프가 된다">
  <defs><marker id="f1-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker><marker id="f1-ahb" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-blue"/></marker></defs>
  <text x="8" y="24" class="muted">기록 하나</text>
  <rect x="20" y="40" width="96" height="44" rx="22" class="box-blue"/>
  <text x="68" y="68" text-anchor="middle" class="bold">철수</text>
  <path d="M120 62 L294 62" class="line-blue" marker-end="url(#f1-ahb)"/>
  <text x="207" y="52" text-anchor="middle" class="bold blue">직업</text>
  <rect x="300" y="40" width="96" height="44" rx="22" class="box-blue"/>
  <text x="348" y="68" text-anchor="middle" class="bold">의사</text>
  <text x="68" y="112" text-anchor="middle" class="muted">누가</text>
  <text x="207" y="112" text-anchor="middle" class="muted">무슨 관계로</text>
  <text x="348" y="112" text-anchor="middle" class="muted">무엇과</text>
  <line x1="8" y1="134" x2="412" y2="134" class="line dash"/>
  <text x="8" y="160" class="muted">여러 기록이 이어지면</text>
  <rect x="12" y="196" width="76" height="40" rx="20" class="box"/>
  <text x="50" y="222" text-anchor="middle">영희</text>
  <rect x="192" y="196" width="76" height="40" rx="20" class="box-blue"/>
  <text x="230" y="222" text-anchor="middle" class="bold">철수</text>
  <rect x="334" y="196" width="76" height="40" rx="20" class="box-blue"/>
  <text x="372" y="222" text-anchor="middle" class="bold">의사</text>
  <rect x="12" y="286" width="76" height="40" rx="20" class="box"/>
  <text x="50" y="312" text-anchor="middle">서울</text>
  <rect x="176" y="286" width="108" height="40" rx="20" class="box"/>
  <text x="230" y="312" text-anchor="middle">가나다랩</text>
  <path d="M90 216 L186 216" class="line" marker-end="url(#f1-ah)"/>
  <text x="139" y="188" text-anchor="middle" class="muted">자녀가 있다</text>
  <path d="M270 216 L328 216" class="line-blue" marker-end="url(#f1-ahb)"/>
  <text x="300" y="188" text-anchor="middle" class="bold blue">직업</text>
  <path d="M230 238 L230 280" class="line" marker-end="url(#f1-ah)"/>
  <text x="242" y="266" class="muted">다니는 곳</text>
  <path d="M174 306 L94 306" class="line" marker-end="url(#f1-ah)"/>
  <text x="134" y="296" text-anchor="middle" class="muted">있는 곳</text>
  <path d="M50 238 L50 280" class="line" marker-end="url(#f1-ah)"/>
  <text x="62" y="266" class="muted">사는 곳</text>
</svg>
<figcaption>기록 하나는 화살표 하나예요. 이런 화살표가 수없이 이어진 것이 지식그래프예요.</figcaption>
</figure>

이런 세 칸짜리 문장을 트리플(triple)이라고 해요. 검색창에 사람 이름을 넣으면 옆에 출생지, 배우자가 적힌 상자가 뜨죠. 이 상자가 트리플 수억 개를 이은 지식그래프에서 나와요.

장부에 적는 문장은 두 종류예요. "철수는 영희의 자녀다"처럼 이름 붙은 하나하나의 사실이 있고, "사람인 자녀가 있는 사람은 부모다"처럼 모두에게 들어맞는 규칙이 있어요. 사실을 적는 곳을 일기, 규칙을 적는 곳을 사전이라고 생각하면 쉬워요.

<figure class="fig">
<svg viewBox="0 0 420 372" style="max-width:420px" role="img" aria-label="사전에는 사람인 자녀가 있는 사람은 부모다, 누구든 직업은 최대 하나가 있고, 일기에는 영희와 철수는 사람, 철수는 영희의 자녀, 철수의 직업은 의사가 있다. 둘을 함께 읽으면 영희는 부모다가 나온다">
  <defs><marker id="f2-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker></defs>
  <text x="12" y="26" class="bold blue">사전</text>
  <text x="56" y="26" class="muted">모두에게 맞는 규칙</text>
  <text x="222" y="26" class="bold">일기</text>
  <text x="266" y="26" class="muted">하나하나의 사실</text>
  <rect x="4" y="40" width="202" height="176" rx="12" class="box-blue"/>
  <text x="20" y="76" class="bold">사람인 자녀가 있는</text>
  <text x="20" y="102" class="bold">사람은 부모다</text>
  <line x1="16" y1="124" x2="194" y2="124" class="line dash"/>
  <text x="20" y="156">누구든 직업은</text>
  <text x="20" y="182">최대 하나</text>
  <rect x="214" y="40" width="202" height="176" rx="12" class="box"/>
  <text x="230" y="76" class="bold">영희는 사람</text>
  <text x="230" y="110" class="bold">철수는 사람</text>
  <text x="230" y="144" class="bold">철수는 영희의 자녀</text>
  <text x="230" y="178">철수의 직업은 의사</text>
  <path d="M105 220 C105 252, 168 254, 188 268" class="line" marker-end="url(#f2-ah)"/>
  <path d="M315 220 C315 252, 252 254, 232 268" class="line" marker-end="url(#f2-ah)"/>
  <rect x="90" y="274" width="240" height="56" rx="12" class="box-foil"/>
  <text x="210" y="309" text-anchor="middle" class="lg">영희는 부모다</text>
  <text x="210" y="360" text-anchor="middle" class="muted">아무도 적지 않은 문장이 나와요</text>
</svg>
<figcaption>사전과 일기의 굵은 글씨를 함께 읽으면, 아무도 적지 않은 "영희는 부모다"가 나와요.</figcaption>
</figure>

"영희는 부모다"는 아무도 적지 않았지만 참이에요. 적힌 문장에서 이렇게 새 문장을 끌어내는 프로그램이 추론기예요.

온톨로지는 주로 이 사전을 가리켜요. 원래는 철학에서 "무엇이 있을까"를 묻는 분야의 이름이에요. 컴퓨터 쪽에서는 어떤 종류가 있고 서로 어떻게 이어지는지를 기계가 읽을 수 있게 적어 둔 것을 말해요. 그루버(Gruber)는 1993년에 온톨로지를 "개념화의 명시적 명세"라고 정의했어요. 교재에서는 사전을 TBox, 일기를 ABox라고 불러요.

> 처음엔 이렇게 답했어요
>
> "내가 아는 개체와 관계에서 관계가 TBox, 개체가 ABox구나. 그냥 단순히 아는걸론 TBox는 술어고 ABox는 상수와 함수가 엮인건가"
>
> 술어와 상수로 본 것은 맞았어요. 다만 이 논리에는 함수가 없어요. 나누는 기준도 관계냐 개체냐가 아니었어요. "철수는 영희의 자녀다"는 관계인데도 일기에 들어가요.
{: .answer }

나누는 요령은 간단해요. 이름 붙은 누군가가 나오면 일기, "모든 ~는"으로 읽히면 사전이에요. 이 요령을 보고 저는 "이렇게 보니까이해가 확된다"고 했어요.

> **→ 그래서 실제로는** 언어 모델(LLM)로 문서에서 사실을 뽑을 때, 이름이 든 문장과 "모든 ~는"으로 읽히는 문장을 나눠 받아요. 이름이 든 문장은 일기에 넣고, "모든 ~는" 문장은 사람이 보고 사전에 넣을지 정해요.
{: .practice }

**이름이 나오면 일기, "모든 ~는"으로 읽히면 사전이에요. 온톨로지는 그 사전이에요.**

## 그런데 적지 않은 것은 "아니다"가 아니라 "모른다"예요

처음 장면의 장부에는 "철수의 직업은 의사다" 기록 하나만 있어요. 이것만으로는 철수에게 직업이 하나 더 있을지 알 수 없으니 추론기는 "모른다"고 답해요.

<figure class="fig">
<svg viewBox="0 0 420 350" style="max-width:420px" role="img" aria-label="장부 세 개가 계단처럼 자란다. 철수의 직업은 의사 기록 하나면 모른다, 직업은 최대 하나를 보태도 모른다, 의사와 변호사는 다르다까지 보태면 아니다">
  <text x="210" y="24" text-anchor="middle" class="bold">철수는 변호사야?</text>
  <rect x="6" y="188" width="128" height="70" rx="10" class="box"/>
  <text x="18" y="216">철수의</text>
  <text x="18" y="240">직업은 의사</text>
  <rect x="146" y="128" width="128" height="130" rx="10" class="box"/>
  <text x="158" y="154">철수의</text>
  <text x="158" y="178">직업은 의사</text>
  <line x1="154" y1="192" x2="266" y2="192" class="line"/>
  <text x="158" y="218" class="bold">직업은</text>
  <text x="158" y="242" class="bold">최대 하나</text>
  <rect x="286" y="40" width="128" height="218" rx="10" class="box-blue"/>
  <text x="298" y="66">철수의</text>
  <text x="298" y="90">직업은 의사</text>
  <line x1="294" y1="104" x2="406" y2="104" class="line"/>
  <text x="298" y="130">직업은</text>
  <text x="298" y="154">최대 하나</text>
  <line x1="294" y1="168" x2="406" y2="168" class="line"/>
  <text x="298" y="194" class="bold blue">의사와</text>
  <text x="298" y="218" class="bold blue">변호사는</text>
  <text x="298" y="242" class="bold blue">다르다</text>
  <text x="70" y="292" text-anchor="middle" class="lg">모른다</text>
  <text x="210" y="292" text-anchor="middle" class="lg">모른다</text>
  <text x="350" y="292" text-anchor="middle" class="lg blue">아니다</text>
  <text x="210" y="320" text-anchor="middle" class="muted">둘이 같은</text>
  <text x="210" y="342" text-anchor="middle" class="muted">직업일 수도</text>
</svg>
<figcaption>기록을 보탤수록 장부가 자라요. "의사와 변호사는 다르다"까지 적어야 "아니다"가 나와요.</figcaption>
</figure>

"직업은 최대 하나"를 보태도 답은 그대로예요. 의사와 변호사가 다르다는 말이 없으니, 둘이 같은 직업을 부르는 두 이름일 수도 있거든요. 샛별과 금성이 같은 행성인 것처럼요. 장부는 이름이 다르다고 다른 대상으로 보지 않아요.

> 처음엔 이렇게 답했어요
>
> "모른다? 규칙 넣으면 변호사가 아니다"
>
> 앞의 "모른다"는 맞았어요. 그런데 "직업은 최대 하나" 규칙만 넣으면 답은 여전히 "모른다"예요. 위 그림처럼 의사와 변호사가 다르다는 기록이 하나 더 있어야 "아니다"가 나와요.
{: .answer }

이 설명을 듣고 저는 이렇게 말했어요. "그거구나. 확 깨네. 나는 의사와 변호사가 다른걸 알고 있지만 그 개념이 없어서 모른다구나."

비행기 시간표에 9시 제주행이 없으면 우리는 그 편이 없다고 여겨요. 적히지 않은 것을 이렇게 거짓으로 치는 방식을 닫힌 세계라고 해요. 데이터베이스가 이 방식을 따라요. 온톨로지는 세상을 다 적을 수 없다고 보고 "모른다"로 둬요. 이쪽은 열린 세계예요.

그럼 어디까지 적어야 할까요? 답하려는 질문이 정해요. "철수는 변호사야?"에 "아니다"라고 답하려면 "의사와 변호사는 다르다"까지는 적어야 해요. 의사가 몇 년을 공부하는지, 철수가 어느 병원에 다니는지는 이 질문에 필요 없어요.

> **→ 그래서 실제로는** "아니다"라고 답해야 하는 질문이 있으면, "A와 B는 다르다" 같은 당연한 문장까지 장부에 적어요. 실제 온톨로지에 이런 문장이 많이 들어가는 까닭이에요.
{: .practice }

**장부에 적히지 않은 것은 "모른다"예요. "아니다"를 얻으려면 당연한 것까지 적어야 해요.**

## 그렇다고 규칙을 세게 적으면 세상의 예외와 부딪혀요

세 문장을 다 적은 장부에 누군가 "철수의 직업은 변호사다"를 보탰어요. 이번에는 "모른다"도 "아니다"도 아니에요. 모순이에요. 장부에 적힌 기록과 맞는 경우를 점으로 그려 보면 셋의 차이가 보여요.

<figure class="fig">
<svg viewBox="0 0 420 292" style="max-width:420px" role="img" aria-label="직접 적은 기록과 맞는 경우를 점 여섯 개로 그렸다. 모른다는 변호사인 경우와 아닌 경우가 다 남고, 아니다는 아닌 경우만 남고, 모순은 하나도 남지 않는다">
  <text x="276" y="22" text-anchor="middle" class="muted">직접 적은 기록과 맞는 경우</text>
  <text x="8" y="58" class="bold">모른다</text>
  <text x="8" y="82" class="muted">둘 다 남아요</text>
  <circle cx="172" cy="62" r="13" class="solid-foil"/><circle cx="212" cy="62" r="13" class="solid-foil"/><circle cx="252" cy="62" r="13" class="solid-foil"/>
  <circle cx="300" cy="62" r="13" class="solid-blue"/><circle cx="340" cy="62" r="13" class="solid-blue"/><circle cx="380" cy="62" r="13" class="solid-blue"/>
  <text x="8" y="136" class="bold blue">아니다</text>
  <text x="8" y="160" class="muted">한쪽만 남아요</text>
  <circle cx="172" cy="140" r="13" class="line dash"/><circle cx="212" cy="140" r="13" class="line dash"/><circle cx="252" cy="140" r="13" class="line dash"/>
  <circle cx="300" cy="140" r="13" class="solid-blue"/><circle cx="340" cy="140" r="13" class="solid-blue"/><circle cx="380" cy="140" r="13" class="solid-blue"/>
  <text x="8" y="214" class="bold red">모순</text>
  <text x="8" y="238" class="muted">하나도 없어요</text>
  <circle cx="172" cy="218" r="13" class="line dash"/><circle cx="212" cy="218" r="13" class="line dash"/><circle cx="252" cy="218" r="13" class="line dash"/>
  <circle cx="300" cy="218" r="13" class="line dash"/><circle cx="340" cy="218" r="13" class="line dash"/><circle cx="380" cy="218" r="13" class="line dash"/>
  <circle cx="16" cy="276" r="8" class="solid-foil"/>
  <text x="30" y="282">변호사인 경우</text>
  <circle cx="164" cy="276" r="8" class="solid-blue"/>
  <text x="178" y="282">아닌 경우</text>
  <circle cx="272" cy="276" r="8" class="line dash"/>
  <text x="286" y="282">지워진 경우</text>
</svg>
<figcaption>"모른다"는 두 쪽이 다 남은 것, "아니다"는 한쪽만 남은 것, 모순은 하나도 안 남은 거예요.</figcaption>
</figure>

모순은 직접 적은 기록이 한꺼번에 참일 수 없다는 뜻이에요. 모순이 생기면 논리에서는 무엇이든 끌어낼 수 있어서 추론기는 모순부터 알려요. 넷 중 어느 기록을 고쳐야 하는지는 말해 주지 않아요.

> 처음엔 이렇게 답했어요
>
> "그럼 모른다가 되는거 아니야? 근데 철수 직업 X가 두개가 되니 시간이라는 추가 정보가 필요해지겠네? 근데 전제가 직업이 하나라했잖아."
>
> 답은 "모른다"가 아니라 모순이었어요. 그래도 두 가지는 스스로 찾았어요. 직업이 둘이 되는데 전제는 하나라는 충돌, 그리고 시간이 필요하다는 것이요. 철수가 의사를 그만두고 변호사가 된 거라면, 틀린 것은 사실이 아니라 규칙이에요. "직업은 최대 하나"는 "한 시점에 최대 하나"였어야 해요.
{: .answer }

그런데 세 칸짜리 문장에는 시간을 적을 칸이 없어요. 그래서 "취업"이라는 일을 하나 세우고, 거기에 사람, 직업, 기간을 따로 매달아요.

<figure class="fig">
<svg viewBox="0 0 420 300" style="max-width:420px" role="img" aria-label="연도 위에 취업1은 철수가 의사로 2015년부터 2020년까지, 취업2는 변호사로 2021년부터 지금까지 놓여 있다. 2019년이나 2024년에 세로줄을 그으면 하나만 걸린다">
  <defs><marker id="f5-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker></defs>
  <text x="166" y="24" text-anchor="middle" class="muted">2019년</text>
  <text x="332" y="24" text-anchor="middle" class="muted">2024년</text>
  <rect x="30" y="48" width="196" height="48" rx="10" class="box-blue"/>
  <text x="44" y="78" class="bold">취업1</text>
  <text x="218" y="78" text-anchor="end" class="bold blue">의사</text>
  <text x="30" y="122" class="muted">철수, 2015~2020</text>
  <rect x="234" y="138" width="166" height="48" rx="10" class="box-foil"/>
  <text x="248" y="168" class="bold">취업2</text>
  <text x="394" y="168" text-anchor="end" class="bold">변호사</text>
  <text x="234" y="212" class="muted">철수, 2021~</text>
  <path d="M166 34 L166 236" class="line-blue dash"/>
  <path d="M332 34 L332 236" class="line-blue dash"/>
  <circle cx="166" cy="72" r="6" class="solid-blue"/>
  <circle cx="332" cy="162" r="6" class="solid-blue"/>
  <path d="M30 236 L404 236" class="line" marker-end="url(#f5-ah)"/>
  <text x="30" y="262" text-anchor="middle">2015</text>
  <text x="234" y="262" text-anchor="middle">2021</text>
  <text x="388" y="262" text-anchor="middle">지금</text>
  <text x="210" y="292" text-anchor="middle" class="bold blue">어느 해든 직업은 하나만 걸려요</text>
</svg>
<figcaption>직업마다 취업 하나를 세우고 기간을 달면, 어느 해에 세로줄을 그어도 하나만 걸려요.</figcaption>
</figure>

수도도 그래요. 남아프리카공화국은 수도가 셋이고 볼리비아는 둘이에요. 그 도시들이 서로 다르다고 적혀 있으면, "한 나라의 수도는 하나"를 넣는 순간 두 나라의 올바른 기록이 모순이 돼요. 규칙은 세상의 사실이 아니라 우리가 고른 약속이에요.

위키데이터는 "값이 하나여야 한다"는 항목에 값이 둘 들어와도 막지 않고 경고만 띄워요. 왜 그럴까요? 저는 "단정하게 되면 지금처럼 모순이 발생하니까?"라고 답했는데 맞았어요. 편집자가 수만 명이라 충돌은 반드시 생기고, 모순이 하나만 있어도 전체 추론이 멈춰요. 그래서 출생 연도가 자료마다 다르면 출처를 단 두 값을 나란히 남겨요.

> **→ 그래서 실제로는** LLM이 뽑은 기록이 규칙과 부딪혀도 지우지 않아요. 두 값을 출처와 함께 남기고 경고를 띄워요. 직업, 대표, 주소처럼 바뀌는 값은 처음부터 기간을 붙여 적어요.
{: .practice }

**규칙을 세게 적을수록 잘못된 데이터를 잘 잡지만, 세상의 예외도 모순이 돼요.**

## 같은 규칙으로 OWL은 결론을 내고, SHACL은 검사해요

이번에는 "사람은 누구나 직업이 있다"는 규칙을 적었어요. 영희가 사람이라는 기록은 있는데 직업 기록은 없어요. 이 규칙은 온톨로지를 적는 OWL로도, 장부가 조건대로 채워졌는지 검사하는 SHACL로도 적을 수 있어요. 그런데 영희를 만나면 둘이 하는 일이 반대예요.

<figure class="fig">
<svg viewBox="0 0 420 350" style="max-width:420px" role="img" aria-label="직업 기록이 없는 영희를 두고 OWL은 어떤 직업이 있다고 끌어내고, SHACL은 적힌 직업이 0개라 위반이라고 알린다. OWL은 영희에게 직업이 있을까에, SHACL은 영희의 직업을 적어 뒀을까에 답한다">
  <defs><marker id="f6-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-blue"/></marker></defs>
  <text x="105" y="24" text-anchor="middle" class="bold blue">OWL</text>
  <text x="315" y="24" text-anchor="middle" class="bold red">SHACL</text>
  <line x1="210" y1="8" x2="210" y2="232" class="line dash"/>
  <rect x="55" y="40" width="100" height="42" rx="21" class="box"/>
  <text x="105" y="67" text-anchor="middle" class="bold">영희</text>
  <path d="M105 84 L105 136" class="line-blue dash" marker-end="url(#f6-ah)"/>
  <text x="117" y="116" class="blue">직업</text>
  <rect x="45" y="142" width="120" height="42" rx="21" class="box-blue dash"/>
  <text x="105" y="169" text-anchor="middle" class="blue">어떤 직업</text>
  <text x="105" y="218" text-anchor="middle" class="bold blue">있다고 끌어내요</text>
  <rect x="265" y="40" width="100" height="42" rx="21" class="box"/>
  <text x="315" y="67" text-anchor="middle" class="bold">영희</text>
  <text x="315" y="116" text-anchor="middle" class="muted">직업 기록 없음</text>
  <rect x="245" y="142" width="140" height="42" rx="8" class="box-red"/>
  <text x="315" y="169" text-anchor="middle" class="red">적힌 직업 0개</text>
  <text x="315" y="218" text-anchor="middle" class="bold red">위반이라고 알려요</text>
  <rect x="8" y="248" width="194" height="64" rx="12" class="wash"/>
  <text x="105" y="274" text-anchor="middle">영희에게</text>
  <text x="105" y="298" text-anchor="middle">직업이 있을까?</text>
  <rect x="218" y="248" width="194" height="64" rx="12" class="wash"/>
  <text x="315" y="274" text-anchor="middle">영희의 직업을</text>
  <text x="315" y="298" text-anchor="middle">적어 뒀을까?</text>
  <text x="105" y="338" text-anchor="middle" class="muted">세상에 대한 질문</text>
  <text x="315" y="338" text-anchor="middle" class="muted">장부에 대한 질문</text>
</svg>
<figcaption>같은 규칙을 OWL은 세상 이야기로 받아들여 직업이 있다고 끌어내고, SHACL은 장부가 지킬 조건으로 보고 위반을 알려요.</figcaption>
</figure>

OWL은 열린 세계를 따르니까 무슨 직업인지는 몰라도 하나는 있다고 끌어내요. 닫힌 세계를 따르는 SHACL은 적힌 직업이 없으니 위반이라고 알려요.

OWL과 SHACL을 이렇게 나란히 놓고 보니 "아하" 싶었어요. 둘이 답하는 질문이 그림 아래처럼 서로 달랐던 거예요. 직업이 있다는 결론과 기록이 빠졌다는 지적은 둘 다 맞을 수 있어요.

> **→ 그래서 실제로는** 장부에 묻기 전에, 알고 싶은 것이 세상 일인지 장부에 적힌 내용인지부터 정해요. 새 기록을 끌어내는 일은 OWL 추론기로, 장부가 제대로 채워졌는지 보는 일은 SHACL 검사로 돌려요.
{: .practice }

**OWL은 세상이 어떤지 결론을 내고, SHACL은 장부가 채워졌는지 검사해요.**

## 적을 수 있는 말을 늘리면 따지는 시간이 크게 늘어요

그럼 당연한 것까지 전부, 최대한 자세히 적을 수 있게 하면 될까요? 적을 수 있는 말이 늘수록 추론기가 따지는 일이 어려워져요.

"또는"이 대표적이에요. "철수는 의사이거나 간호사다"라는 문장을 만나면 추론기는 어느 쪽인지 몰라요. 그래서 "의사라고 치고" 끝까지 따져 보고, 막히면 "간호사라고 치고" 다시 따져요. 이런 문장이 하나 겹칠 때마다 따질 경우가 두 배가 돼요.

<figure class="fig">
<svg viewBox="0 0 420 410" style="max-width:420px" role="img" aria-label="또는이 한 번 겹칠 때마다 따질 경우가 2가지, 4가지, 8가지로 두 배씩 늘고, 30번이면 약 10억 가지다. EL은 도장을 찍기만 하듯 보태기만 한다">
  <text x="8" y="24" class="bold">"또는"이 겹치면</text>
  <text x="366" y="24" text-anchor="middle" class="muted">따질 경우</text>
  <path d="M159 72 L83 100 M159 72 L235 100" class="line"/>
  <path d="M83 132 L45 162 M83 132 L121 162 M235 132 L197 162 M235 132 L273 162" class="line"/>
  <path d="M45 170 L26 214 M45 170 L64 214 M121 170 L102 214 M121 170 L140 214 M197 170 L178 214 M197 170 L216 214 M273 170 L254 214 M273 170 L292 214" class="line"/>
  <rect x="129" y="40" width="60" height="32" rx="16" class="box"/>
  <text x="159" y="62" text-anchor="middle" class="bold">철수</text>
  <rect x="53" y="100" width="60" height="32" rx="16" class="box-blue"/>
  <text x="83" y="122" text-anchor="middle">의사</text>
  <rect x="199" y="100" width="72" height="32" rx="16" class="box-blue"/>
  <text x="235" y="122" text-anchor="middle">간호사</text>
  <circle cx="45" cy="170" r="8" class="solid-ink"/><circle cx="121" cy="170" r="8" class="solid-ink"/><circle cx="197" cy="170" r="8" class="solid-ink"/><circle cx="273" cy="170" r="8" class="solid-ink"/>
  <circle cx="26" cy="222" r="8" class="solid-ink"/><circle cx="64" cy="222" r="8" class="solid-ink"/><circle cx="102" cy="222" r="8" class="solid-ink"/><circle cx="140" cy="222" r="8" class="solid-ink"/><circle cx="178" cy="222" r="8" class="solid-ink"/><circle cx="216" cy="222" r="8" class="solid-ink"/><circle cx="254" cy="222" r="8" class="solid-ink"/><circle cx="292" cy="222" r="8" class="solid-ink"/>
  <text x="366" y="122" text-anchor="middle" class="bold">2가지</text>
  <text x="366" y="176" text-anchor="middle" class="bold">4가지</text>
  <text x="366" y="228" text-anchor="middle" class="bold">8가지</text>
  <text x="8" y="264" class="bold red">30번 겹치면 약 10억 가지</text>
  <line x1="8" y1="284" x2="412" y2="284" class="line dash"/>
  <text x="8" y="316" class="bold blue">EL은 보태기만 해요</text>
  <circle cx="26" cy="354" r="14" class="solid-blue"/><circle cx="62" cy="354" r="14" class="solid-blue"/><circle cx="98" cy="354" r="14" class="solid-blue"/><circle cx="134" cy="354" r="14" class="solid-blue"/><circle cx="170" cy="354" r="14" class="solid-blue"/>
  <circle cx="206" cy="354" r="14" class="line dash"/><circle cx="242" cy="354" r="14" class="line dash"/><circle cx="278" cy="354" r="14" class="line dash"/>
  <text x="362" y="360" text-anchor="middle" class="muted">도장 모으기</text>
  <text x="8" y="400" class="muted">찍기만 하고 지우지 않아요</text>
</svg>
<figcaption>"또는"이 하나 겹칠 때마다 따질 경우가 두 배가 돼요. EL은 "또는"을 빼서 도장 모으듯 보태기만 해요.</figcaption>
</figure>

표현이 가장 풍부한 표준 언어(OWL 2 DL)는 최악의 경우 따지는 시간이 지수의 지수로 늘어요.

반대쪽을 고른 곳도 있어요. 개념이 30만 개쯤인 의학 용어집 SNOMED CT는 "또는", "아니다", "모든"을 뺀 가벼운 언어(OWL 2 EL)를 써요. 의학 용어는 대부분 "폐렴은 부위가 폐인 염증이다" 같은 모양이라 이걸로 충분해요. 추론기는 경우를 나누지 않고 보태기만 해서 SNOMED CT 전체를 몇 초 안팎에 분류해요.

> **→ 그래서 실제로는** 규칙을 적기 전에 "또는"이나 "아니다"가 꼭 필요한지 물어요. 없어도 되면 빼고 가벼운 언어 안에 머물러요. 무엇을 적을 수 있게 할지 정하는 일은 무엇을 포기할지 정하는 일이에요.
{: .practice }

**적을 수 있는 말을 늘릴수록 따지는 시간이 늘어요. 그래서 필요한 만큼만 골라 써요.**

## 적힌 기록으로 채울 수 없는 빈칸은 임베딩이 짐작해요

적어 둔 사실과 규칙으로 답이 안 나오면 어떻게 할까요?

```
(서울, 수도이다, 대한민국)
(도쿄, 수도이다, 일본)
(파리, 수도이다, ?)
```

이 빈칸을 채울 수 있느냐는 문제에 저는 "못 채운다? 파리가 프랑스에 있다는 사실이 필요하다 이건 추론할 수 없는 정보니까"라고 답했고, "못 채운다"는 맞았어요. 추론기는 적힌 기록을 이어 붙일 뿐, 없는 사실을 새로 만들지 못해요. 다만 필요한 사실은 고쳐야 했어요. 파리가 프랑스에 있다는 것만으로는 부족해요. 리옹도 프랑스에 있거든요.

다른 방법이 있어요. 그래프의 대상은 모두 좌표 위의 점으로, 관계는 화살표로 바꿔요. 이어서 적힌 기록마다 주어에서 관계 화살표를 따라가면 목적어 가까이에 오도록 점을 조금씩 옮겨요. 그러면 "수도이다"는 수도에서 나라로 가는 같은 화살표가 돼요.


이제 파리에서 그 화살표를 따라가 도착한 곳 가까이에 있는 나라를 후보로 꼽아요. 이런 방법을 임베딩(embedding)이라고 해요. 보르데스(Bordes) 등이 2013년에 내놓은 TransE가 이 방식이에요.

이 방법이 "시드니는 호주의 수도다"에 높은 점수를 줬다고 해 볼게요. 호주의 수도는 캔버라예요. 왜 그랬을까요?

> 처음엔 이렇게 답했어요
>
> "주어 술어 목적어 구조가 맞아서"
>
> 절반 맞았어요. 시드니는 도시, 호주는 나라라 들어갈 종류는 맞아요. 그런데 그것만이라면 멜버른이나 퍼스도 똑같이 높아야 해요.
{: .answer }

임베딩은 수도의 뜻을 몰라요. 수도인 도시들이 그래프에서 어떤 모습으로 이어져 있는지만 봐요. 대부분의 나라에서 수도는 가장 큰 도시라 본사, 공항, 대학 같은 기록이 많아요. 시드니는 그 모습에 꼭 들어맞지만 캔버라는 기록이 적은 작은 도시라 그 무리에서 떨어져 있어요.

<figure class="fig">
<svg viewBox="0 0 420 380" style="max-width:420px" role="img" aria-label="서울, 도쿄, 파리, 시드니가 큰 도시 무리로 모여 있고, 같은 수도이다 화살표가 대한민국, 일본, 프랑스로 닿는다. 시드니에서 따라간 화살표도 호주 가까이 닿아 높은 점수를 받는다. 캔버라는 무리 밖에 떨어져 있다">
  <defs><marker id="f8-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-blue"/></marker><marker id="f8-ahr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-red"/></marker></defs>
  <rect x="2" y="2" width="416" height="376" rx="14" class="box"/>
  <rect x="22" y="48" width="150" height="246" rx="14" class="wash"/>
  <text x="34" y="36" class="sm muted">큰 도시 무리</text>
  <path d="M148 78 L284 42" class="line-blue" marker-end="url(#f8-ah)"/>
  <text x="214" y="50" text-anchor="middle" class="bold blue">수도이다</text>
  <path d="M148 138 L284 102" class="line-blue" marker-end="url(#f8-ah)"/>
  <path d="M148 198 L284 162" class="line-blue dash" marker-end="url(#f8-ah)"/>
  <path d="M148 258 L284 222" class="line-red dash" marker-end="url(#f8-ahr)"/>
  <circle cx="140" cy="80" r="7" class="solid-ink"/>
  <text x="126" y="86" text-anchor="end">서울</text>
  <circle cx="140" cy="140" r="7" class="solid-ink"/>
  <text x="126" y="146" text-anchor="end">도쿄</text>
  <circle cx="140" cy="200" r="7" class="solid-ink"/>
  <text x="126" y="206" text-anchor="end">파리</text>
  <circle cx="140" cy="260" r="7" class="solid-ink"/>
  <text x="126" y="266" text-anchor="end" class="bold red">시드니</text>
  <circle cx="298" cy="38" r="7" class="solid-blue"/>
  <text x="312" y="44">대한민국</text>
  <circle cx="298" cy="98" r="7" class="solid-blue"/>
  <text x="312" y="104">일본</text>
  <circle cx="298" cy="160" r="18" class="line-blue dash"/>
  <circle cx="300" cy="160" r="7" class="solid-blue"/>
  <text x="324" y="166">프랑스</text>
  <circle cx="292" cy="224" r="20" class="line-red dash"/>
  <circle cx="300" cy="228" r="7" class="solid-blue"/>
  <text x="324" y="234">호주</text>
  <text x="324" y="258" class="bold red">높은 점수</text>
  <circle cx="70" cy="334" r="7" class="solid-ink"/>
  <text x="86" y="340">캔버라</text>
  <text x="86" y="362" class="sm muted">기록이 적은 작은 도시</text>
</svg>
<figcaption>수도인 큰 도시들은 좌표에서 한데 모여요. 시드니도 그 무리와 닮아서 "수도이다" 화살표를 따라가면 호주 가까이로 가요. 캔버라는 무리에서 떨어져 있어요.</figcaption>
</figure>

운동복을 입은 키 큰 학생을 보고 농구부라고 짐작하는 것과 같아요. 대개 맞지만 배구부일 수도 있어요. 점수만 보고는 왜 높은지 알 수 없어요.

시드니 기록을 걸러 내려면 무엇이 있어야 하느냐는 문제에 저는 "일단 수도의 개념이 바뀌지 않는 이상 수도는 최대 하나이고 시드니와 캔버라는 다르고 인건가?"라고 답했어요. 둘 다 맞았어요. 하지만 빠진 기록이 하나 있어요. 캔버라가 호주의 수도라는 기록이에요. 이 기록이 없으면 시드니가 그 하나뿐인 수도일 수도 있어요. 같은 답에서 "일단 확실히 이해한건 임베딩은 분포에 따른 추론인거네?"라고도 했는데 이것도 맞았어요. 비슷한 이웃과 함께 나오면 뜻도 비슷하다고 보는 거예요.

| | 규칙 추론 | 임베딩 |
|---|---|---|
| 결과 | 전제가 참이면 반드시 참 | 점수가 붙은 짐작 |
| 빈칸 | 못 채워요 | 짐작해 채워요 |
| 틀리면 | 어느 기록 탓인지 보여요 | 왜 틀렸는지 안 보여요 |

그래서 임베딩이 후보를 내고 규칙이 걸러 내도록 둘을 함께 쓰기도 해요. 이런 연구를 신경·기호 결합이라고 불러요.

> **→ 그래서 실제로는** LLM이나 임베딩이 낸 기록은 장부에 바로 넣지 않고, 적어 둔 규칙과 사실에 부딪히는지 먼저 걸러요. 그러려면 "캔버라가 호주의 수도" 같은 기록이 장부에 먼저 있어야 해요.
{: .practice }

**규칙은 적힌 것에서만 끌어내고, 임베딩은 빈칸을 짐작으로 채워요. 짐작은 규칙으로 걸러요.**

## 적어 둔 기록의 근거는 셋 중 한 곳에서 멈춰요

여기서 제가 물었어요. "대부분 이렇게 말하니까 이거더라 -> 임베드 라고 했잖아. 그렇다면 1등급 원장을 만들 수 있기 위해선 어떻게 하는거지?" 임베딩이 "많이들 그렇게 말한다"에서 배운다면, 믿을 수 있는 장부는 어떻게 만들까요?

근거는 사실의 종류마다 달라요. 캔버라가 수도인 건 사람들이 그렇게 말해서가 아니에요. 1908년 호주 의회가 연방 수도를 야스·캔버라 지역에 두기로 법으로 정했고 그곳에 지은 도시가 캔버라예요. 글 천 편이 시드니라고 해도 법령 한 줄이 이겨요.

"왜 그게 참이야?"를 계속 물으면 끝없이 이어지거나, 빙빙 돌거나, 어딘가에서 멈춰요. 장부에서 멈추는 곳은 셋이에요.

<figure class="fig">
<svg viewBox="0 0 420 280" style="max-width:420px" role="img" aria-label="캔버라는 호주의 수도는 1908년 법으로 정했다에서, 오늘 서울은 3도는 온도계를 봤다에서, 직원은 국민연금 가입자는 우리가 그렇게 부르기로 했다에서 근거가 멈춘다">
  <defs><marker id="f10-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker></defs>
  <rect x="4" y="12" width="184" height="60" rx="12" class="box"/>
  <text x="96" y="38" text-anchor="middle">캔버라는</text>
  <text x="96" y="62" text-anchor="middle">호주의 수도</text>
  <path d="M190 42 L246 42" class="line" marker-end="url(#f10-ah)"/>
  <text x="218" y="32" text-anchor="middle" class="muted">왜?</text>
  <rect x="252" y="12" width="164" height="60" rx="12" class="solid-blue"/>
  <text x="334" y="38" text-anchor="middle" class="bold on-solid">정했다</text>
  <text x="334" y="62" text-anchor="middle" class="on-solid">1908년 법으로</text>
  <rect x="4" y="108" width="184" height="60" rx="12" class="box"/>
  <text x="96" y="134" text-anchor="middle">오늘 서울은</text>
  <text x="96" y="158" text-anchor="middle">3도</text>
  <path d="M190 138 L246 138" class="line" marker-end="url(#f10-ah)"/>
  <text x="218" y="128" text-anchor="middle" class="muted">왜?</text>
  <rect x="252" y="108" width="164" height="60" rx="12" class="solid-blue"/>
  <text x="334" y="134" text-anchor="middle" class="bold on-solid">봤다</text>
  <text x="334" y="158" text-anchor="middle" class="on-solid">온도계를 봤어요</text>
  <rect x="4" y="204" width="184" height="60" rx="12" class="box"/>
  <text x="96" y="230" text-anchor="middle">직원은</text>
  <text x="96" y="254" text-anchor="middle">국민연금 가입자</text>
  <path d="M190 234 L246 234" class="line" marker-end="url(#f10-ah)"/>
  <text x="218" y="224" text-anchor="middle" class="muted">왜?</text>
  <rect x="252" y="204" width="164" height="60" rx="12" class="solid-blue"/>
  <text x="334" y="230" text-anchor="middle" class="bold on-solid">부르기로 했다</text>
  <text x="334" y="254" text-anchor="middle" class="on-solid">우리가 정한 뜻</text>
</svg>
<figcaption>"왜 참이야?"를 따라가면 장부의 근거는 정했다, 봤다, 부르기로 했다 가운데 한 곳에서 멈춰요.</figcaption>
</figure>

글에서 읽은 "시드니가 수도"는 그 글이 그렇게 말했다는 것까지만 근거가 돼요. 맞는지는 따로 확인해요.

마지막 문제는 이거였어요. 가나다랩의 "직원 수는 120명"을 장부에 넣으려는데, 채용 사이트, 회사 소개 페이지, 국민연금 가입자 수가 다 달라요. 무엇을 먼저 정해야 할까요?

> 처음엔 이렇게 답했어요
>
> "우선순위를 정해야겠지? 국민연금가입자가 가장 정확할거고"
>
> 우선순위를 정해야 한다는 건 맞았어요. 다만 그보다 먼저 "직원"에 누구를 넣을지 정해야 해요. 세 숫자가 서로 다른 사람들을 셌을 수 있거든요.
{: .answer }

<figure class="fig">
<svg viewBox="0 0 420 346" style="max-width:420px" role="img" aria-label="세 출처가 세는 사람을 표로 그렸다. 국민연금 가입자는 정규직을 세고, 짧게 일하는 사람은 셀 수도 뺄 수도 있고, 만 60세 이상은 원칙적으로 빼고, 해외 지사는 모른다. 회사 소개는 정규직을 세고 해외 지사는 셀 수도 있고 나머지는 모른다. 채용 사이트는 모두 모른다">
  <text x="200" y="24" text-anchor="middle" class="bold">국민연금</text>
  <text x="200" y="46" text-anchor="middle" class="bold">가입자</text>
  <text x="290" y="24" text-anchor="middle" class="bold">회사</text>
  <text x="290" y="46" text-anchor="middle" class="bold">소개</text>
  <text x="376" y="24" text-anchor="middle" class="bold">채용</text>
  <text x="376" y="46" text-anchor="middle" class="bold">사이트</text>
  <line x1="8" y1="62" x2="412" y2="62" class="line"/>
  <text x="8" y="98">정규직</text>
  <circle cx="200" cy="92" r="11" class="solid-blue"/>
  <circle cx="290" cy="92" r="11" class="solid-blue"/>
  <text x="376" y="99" text-anchor="middle" class="lg muted">?</text>
  <text x="8" y="146">짧게 일함</text>
  <circle cx="200" cy="140" r="11" class="line-blue dash"/>
  <text x="290" y="147" text-anchor="middle" class="lg muted">?</text>
  <text x="376" y="147" text-anchor="middle" class="lg muted">?</text>
  <text x="8" y="194">만 60세 이상</text>
  <path d="M192 180 L208 196 M208 180 L192 196" class="line-red"/>
  <text x="290" y="195" text-anchor="middle" class="lg muted">?</text>
  <text x="376" y="195" text-anchor="middle" class="lg muted">?</text>
  <text x="8" y="242">해외 지사</text>
  <text x="200" y="243" text-anchor="middle" class="lg muted">?</text>
  <circle cx="290" cy="236" r="11" class="line-blue dash"/>
  <text x="376" y="243" text-anchor="middle" class="lg muted">?</text>
  <line x1="8" y1="264" x2="412" y2="264" class="line"/>
  <circle cx="16" cy="290" r="8" class="solid-blue"/>
  <text x="30" y="296">세요</text>
  <path d="M94 284 L106 296 M106 284 L94 296" class="line-red"/>
  <text x="116" y="296">원칙적으로 빼요</text>
  <text x="268" y="298" text-anchor="middle" class="lg muted">?</text>
  <text x="282" y="296">몰라요</text>
  <circle cx="16" cy="324" r="8" class="line-blue dash"/>
  <text x="30" y="330">셀 수도, 뺄 수도 있어요</text>
</svg>
<figcaption>같은 "직원"이라도 출처마다 세는 사람이 다를 수 있어요. 채용 사이트의 숫자는 누구를 셌는지부터 몰라요.</figcaption>
</figure>

국민연금 사업장 가입자는 원칙적으로 만 60세 미만이 대상이에요. 일하는 시간이 짧으면 빠질 수 있고 대표자가 들어가기도 해요. 회사 소개의 숫자에는 계약직이나 해외 지사가 들어 있을 수 있어요. 채용 사이트의 숫자는 누가 그렇다고 전한 말이에요.

정의를 정하면 볼 출처가 따라 나와요. 어느 정의를 고를지는 이 장부로 무엇에 답하려는지가 정해요.

| "직원"을 이렇게 정하면 | 볼 출처 |
|---|---|
| 국민연금 사업장 가입자 | 국민연금 자료 |
| 이 회사에서 일하는 모든 사람 | 한 자료로는 모자라요 |

> **→ 그래서 실제로는** LLM에게 "직원 수를 찾아 줘"라고만 시키지 않아요. "국민연금 사업장 가입자 수를 기준일, 출처와 함께"처럼 "직원"의 뜻을 풀어서 시켜요. 기록마다 근거가 어디서 멈추는지도 함께 적어요.
{: .practice }

**믿을 수 있는 장부는 늘 참인 장부가 아니에요. 기록마다 근거가 어디서 멈추는지 적혀 있어서 누구든 다시 확인할 수 있는 장부예요.**

## 결국 장부는 적지 않은 것을 몰라요

장부에 기록을 하나 넣기 전에 이렇게 물어보면 돼요.

1. 이름이 나오는 사실이에요, "모든 ~는" 규칙이에요?
2. "아니다"가 필요하면 "다르다"까지 적었어요?
3. 바뀌는 값이면 기간을 붙였어요?
4. 세상에 대해 묻나요, 장부에 대해 묻나요?
5. 짐작으로 나온 기록이면, 걸러 낼 사실과 근거가 있어요?

말하지 않아도 아는 건 같은 것을 당연하게 여기는 사이에서만 통해요. 처음 장면의 친구가 그랬어요. 사람이 아는 것과 장부에 적힌 것은 달라요. 친구는 철수가 변호사가 아니라는 걸 알았지만 장부는 몰랐어요. "의사와 변호사는 다르다"라는 기록 하나를 적기 전까지는요.

---

**더 읽을 것**

- Gruber (1993), *A Translation Approach to Portable Ontology Specifications*. 온톨로지를 "개념화의 명시적 명세"라고 정의한 글
- Bordes 외 (2013), *Translating Embeddings for Modeling Multi-relational Data*. 주어에서 관계 화살표를 따라가면 목적어에 닿게 하는 방식(TransE)을 내놓은 논문
- Hogan 외 (2021), *Knowledge Graphs*. 지식그래프 전반을 정리한 글
