---
title: "80%는 누구에 대한 말일까?"
description: "3반의 80%가 안경을 쓰면 철수도 쓸까요? 모임의 비율을 회사 한 곳에 옮겨 쓸 때, 장부를 셀 때, 언어 모델의 확신 0.9를 읽을 때 무엇을 봐야 하는지 그림으로 풀었어요."
author: Ferv0r2
date: 2026-11-25 20:00:00 +0900
categories: [ai, knowledge-graph]
tags: [knowledge-graph, llm, statistics, probability, calibration]
image:
  path: /assets/img/post/20261125/eighty-percent-cover.jpg
  alt: 안경 쓴 학생 얼굴 서른 개 가운데 한 명만 노란 원으로 표시된 모습
render_with_liquid: false
---

3반 학생의 80%가 안경을 쓴대요. 그 말을 들으면 3반 철수도 안경을 쓰겠거니 싶어요. 그런데 이 말만으로는 철수가 안경을 쓰는지 알 수 없어요. 회사 장부의 숫자나 인공지능이 붙여 준 확신을 읽을 때도 같은 일이 생겨요.

이 글을 다 읽으면 비율 하나를 봤을 때 누구를 센 숫자인지, 그 숫자를 한 곳에 옮겨 써도 되는지 가려 볼 수 있어요.

> **이 글에서 깨달은 것**
> 1. 80%는 모임 전체를 두고 한 말이에요. 한 곳의 비율은 닮은 데다 충분히 센 모임에서 빌려 와 짐작해요.
> 2. 엇갈린 두 모임이 겹친 곳의 비율은 0%도 100%도 될 수 있어요. 빈틈없이 나눈 부분을 합칠 때만 두 비율 사이에 와요.
> 3. 장부를 세면 장부의 비율이 나와요. 문 닫은 회사 기록을 지우면 분모도 같이 사라져요.
> 4. 언어 모델이 붙인 "확신 0.9"는 믿음이에요. 같은 숫자를 단 기록을 종류별로 모아 세어야 확인돼요.
> 5. 셋 다 틀렸다고 0으로 읽지 않아요. 믿을 만한 큰 모임 쪽으로 당겨 읽어요.
{: .prompt-tip }

## 80%는 철수가 아니라 3반 이야기예요

<figure class="fig">
<svg viewBox="0 0 420 290" style="max-width:420px" role="img" aria-label="3반 학생 30명을 점 30개로 그렸고 24개가 칠해져 있다. 철수가 어느 점인지는 모른다">
  <defs><marker id="f1-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-red"/></marker></defs>
  <text x="14" y="28" class="bold">3반 30명</text>
  <rect x="14" y="42" width="252" height="200" rx="16" class="box-blue"/>
  <circle cx="50" cy="78" r="12" class="solid-blue"/><circle cx="86" cy="78" r="12" class="solid-blue"/><circle cx="122" cy="78" r="12" class="solid-blue"/><circle cx="158" cy="78" r="12" class="solid-blue"/><circle cx="194" cy="78" r="12" class="line"/><circle cx="230" cy="78" r="12" class="solid-blue"/>
  <circle cx="50" cy="114" r="12" class="solid-blue"/><circle cx="86" cy="114" r="12" class="line"/><circle cx="122" cy="114" r="12" class="solid-blue"/><circle cx="158" cy="114" r="12" class="solid-blue"/><circle cx="194" cy="114" r="12" class="solid-blue"/><circle cx="230" cy="114" r="12" class="solid-blue"/>
  <circle cx="50" cy="150" r="12" class="solid-blue"/><circle cx="86" cy="150" r="12" class="solid-blue"/><circle cx="122" cy="150" r="12" class="solid-blue"/><circle cx="158" cy="150" r="12" class="solid-blue"/><circle cx="194" cy="150" r="12" class="solid-blue"/><circle cx="230" cy="150" r="12" class="line"/>
  <circle cx="50" cy="186" r="12" class="solid-blue"/><circle cx="86" cy="186" r="12" class="solid-blue"/><circle cx="122" cy="186" r="12" class="line"/><circle cx="158" cy="186" r="12" class="solid-blue"/><circle cx="194" cy="186" r="12" class="solid-blue"/><circle cx="230" cy="186" r="12" class="solid-blue"/>
  <circle cx="50" cy="222" r="12" class="line"/><circle cx="86" cy="222" r="12" class="solid-blue"/><circle cx="122" cy="222" r="12" class="solid-blue"/><circle cx="158" cy="222" r="12" class="line"/><circle cx="194" cy="222" r="12" class="solid-blue"/><circle cx="230" cy="222" r="12" class="solid-blue"/>
  <text x="360" y="104" text-anchor="middle" class="bold">철수</text>
  <circle cx="360" cy="142" r="20" class="box-red dash"/>
  <text x="360" y="149" text-anchor="middle" class="lg red">?</text>
  <text x="360" y="192" text-anchor="middle" class="red">어느 점일까</text>
  <path d="M338 142 L274 142" class="line-red dash" marker-end="url(#f1-ah)"/>
  <circle cx="24" cy="266" r="8" class="solid-blue"/>
  <text x="38" y="272">안경 씀</text>
  <circle cx="130" cy="266" r="8" class="line"/>
  <text x="144" y="272">안 씀</text>
</svg>
<figcaption>80%는 서른 개 점 전체의 모양이에요. 철수가 어느 점인지는 알려 주지 않아요.</figcaption>
</figure>

"3반의 80%가 안경을 쓴다"는 3반 서른 명의 모양을 말해요. 스물네 명이 안경을 쓴다는 뜻이지, 철수가 그 스물네 명에 드는지는 말하지 않아요.

"스타트업의 80%는 직원이 30명 이하다"라는 조사도 그래요. 누구를 두고 한 말이냐는 물음에 "스타트업 분포 전체...?"라고 답했는데 맞았어요.

겉보기엔 비슷해도 말하는 대상이 다른 문장들이 있어요.

| 문장 | 누구 이야기 |
|---|---|
| 모든 스타트업은 조직이다 | 한 곳 한 곳, 예외 없이 |
| 스타트업은 대개 30명 이하다 | 한 곳 한 곳, 반대 증거가 나오기 전까지 |
| 스타트업의 80%는 30명 이하다 | 스타트업 모임 전체 |

그래도 한 곳을 두고 짐작해야 할 때가 있어요. 마바사랩은 직원 수를 모르는 핀테크 스타트업이에요. 조사 A는 스타트업의 80%가, 조사 B는 핀테크 스타트업의 40%가 30명 이하라고 해요.

<figure class="fig">
<svg viewBox="0 0 440 330" style="max-width:440px" role="img" aria-label="스타트업 상자 안에 핀테크 상자, 그 안에 마바사랩. 스타트업은 2,000곳을 세어 80%, 핀테크는 10곳을 세어 40%이고 한두 곳만 달라도 20%에서 60%까지 흔들린다">
  <rect x="8" y="8" width="424" height="314" rx="18" class="box"/>
  <text x="28" y="42" class="bold">스타트업</text>
  <text x="104" y="42" class="muted">2,000곳을 셈</text>
  <text x="412" y="42" text-anchor="end" class="bold blue">80%</text>
  <rect x="28" y="56" width="384" height="14" rx="3" class="solid-rule"/>
  <rect x="28" y="56" width="307.2" height="14" rx="3" class="solid-blue"/>
  <rect x="28" y="94" width="384" height="212" rx="14" class="box-blue"/>
  <text x="48" y="126" class="bold">핀테크</text>
  <text x="108" y="126" class="muted">10곳을 셈</text>
  <text x="392" y="126" text-anchor="end" class="bold blue">40%</text>
  <rect x="48" y="140" width="344" height="14" rx="3" class="solid-rule"/>
  <rect x="48" y="140" width="137.6" height="14" rx="3" class="solid-blue"/>
  <path d="M116.8 164 V176 M116.8 170 H254.4 M254.4 164 V176" class="line-red"/>
  <text x="116.8" y="200" class="red">한두 곳만 달라도</text>
  <text x="116.8" y="224" class="red">20%에서 60%까지</text>
  <circle cx="150" cy="268" r="10" class="solid-ink"/>
  <text x="168" y="274" class="bold">마바사랩</text>
  <text x="246" y="274" class="muted">직원 수 모름</text>
</svg>
<figcaption>마바사랩과 더 닮은 모임은 핀테크예요. 하지만 10곳만 셌다면 그 40%는 크게 흔들려요.</figcaption>
</figure>

"40%로 봐야하는거 아닌가 좀 더 세부적으로 분류됐잖아"라는 답이 맞았어요. 좁은 모임일수록 마바사랩과 더 닮은 회사가 모여 있어요. 이렇게 비율을 빌려 오는 모임이 기준 모임(reference class)이에요.

라이헨바흐(Reichenbach)는 1949년에 원칙 하나를 내놓았어요. 한 대상의 가능성은 믿을 만한 통계가 있는 가장 좁은 모임으로 본다는 원칙이에요.

"믿을 만한"이 중요해요. 2,000곳을 센 80%는 한두 곳이 달라도 그대로라서 믿어도 돼요. 10곳을 센 40%는 한두 곳만 달라도 20%에서 60%까지 흔들려요.

모임을 세어 얻은 비율은 통계, 한 곳이 그럴 가능성은 믿음이라고 불러요. 믿음은 사실이 하나 보태지면 바뀌어요. "핀테크"라는 사실 하나에 0.8이 0.4가 됐어요.

> **→ 그래서 실제로는** 조사의 80%를 "스타트업"이라는 종류에 달지 않아요. 그 조사가 센 모임에 기준일, 출처와 함께 달아요. 마바사랩의 0.4는 확인된 사실과 섞지 않고 근거와 기준 모임을 붙여 짐작으로 따로 적어요. 실제 직원 수가 들어오면 그 짐작은 더 쓰지 않아요.
{: .practice }

**80%는 모임을 두고 한 말이라서 한 곳에 옮겨 쓸 땐 닮은 데다 충분히 센 모임을 골라요.**

## 그런데 두 모임이 엇갈리면 겹친 곳은 알 수 없어요

마바사랩은 서울에 있는 회사이기도 해요. 조사 C에 따르면 서울 스타트업의 90%가 30명 이하예요. 이제 핀테크 40%와 서울 90% 가운데 무엇을 빌려 와야 할까요.

<figure class="fig">
<svg viewBox="0 0 440 330" style="max-width:440px" role="img" aria-label="서울 50곳과 핀테크 20곳이 겹친 그림. 서울은 45곳이 30명 이하라 90%, 핀테크는 8곳이라 40%인데 겹친 서울 핀테크 5곳은 0곳이다">
  <text x="239" y="34" text-anchor="middle" class="bold red">겹친 곳 5곳 중 0곳</text>
  <path d="M239 42 V108" class="line-red"/>
  <rect x="10" y="50" width="262" height="170" rx="16" class="line-blue"/>
  <rect x="206" y="80" width="224" height="170" rx="16" class="line-foil"/>
  <text x="26" y="78" class="bold blue">서울</text>
  <text x="418" y="106" text-anchor="end" class="bold">핀테크</text>
  <circle cx="30" cy="101" r="6" class="solid-ink"/><circle cx="47" cy="101" r="6" class="solid-ink"/><circle cx="64" cy="101" r="6" class="solid-ink"/><circle cx="81" cy="101" r="6" class="solid-ink"/><circle cx="98" cy="101" r="6" class="solid-ink"/><circle cx="115" cy="101" r="6" class="solid-ink"/><circle cx="132" cy="101" r="6" class="solid-ink"/><circle cx="149" cy="101" r="6" class="solid-ink"/><circle cx="166" cy="101" r="6" class="solid-ink"/>
  <circle cx="30" cy="118" r="6" class="solid-ink"/><circle cx="47" cy="118" r="6" class="solid-ink"/><circle cx="64" cy="118" r="6" class="solid-ink"/><circle cx="81" cy="118" r="6" class="solid-ink"/><circle cx="98" cy="118" r="6" class="solid-ink"/><circle cx="115" cy="118" r="6" class="solid-ink"/><circle cx="132" cy="118" r="6" class="solid-ink"/><circle cx="149" cy="118" r="6" class="solid-ink"/><circle cx="166" cy="118" r="6" class="solid-ink"/>
  <circle cx="30" cy="135" r="6" class="solid-ink"/><circle cx="47" cy="135" r="6" class="solid-ink"/><circle cx="64" cy="135" r="6" class="solid-ink"/><circle cx="81" cy="135" r="6" class="solid-ink"/><circle cx="98" cy="135" r="6" class="solid-ink"/><circle cx="115" cy="135" r="6" class="solid-ink"/><circle cx="132" cy="135" r="6" class="solid-ink"/><circle cx="149" cy="135" r="6" class="solid-ink"/><circle cx="166" cy="135" r="6" class="solid-ink"/>
  <circle cx="30" cy="152" r="6" class="solid-ink"/><circle cx="47" cy="152" r="6" class="solid-ink"/><circle cx="64" cy="152" r="6" class="solid-ink"/><circle cx="81" cy="152" r="6" class="solid-ink"/><circle cx="98" cy="152" r="6" class="solid-ink"/><circle cx="115" cy="152" r="6" class="solid-ink"/><circle cx="132" cy="152" r="6" class="solid-ink"/><circle cx="149" cy="152" r="6" class="solid-ink"/><circle cx="166" cy="152" r="6" class="solid-ink"/>
  <circle cx="30" cy="169" r="6" class="solid-ink"/><circle cx="47" cy="169" r="6" class="solid-ink"/><circle cx="64" cy="169" r="6" class="solid-ink"/><circle cx="81" cy="169" r="6" class="solid-ink"/><circle cx="98" cy="169" r="6" class="solid-ink"/><circle cx="115" cy="169" r="6" class="solid-ink"/><circle cx="132" cy="169" r="6" class="solid-ink"/><circle cx="149" cy="169" r="6" class="solid-ink"/><circle cx="166" cy="169" r="6" class="solid-ink"/>
  <circle cx="226" cy="122" r="6" class="line-red"/><circle cx="252" cy="122" r="6" class="line-red"/><circle cx="226" cy="144" r="6" class="line-red"/><circle cx="252" cy="144" r="6" class="line-red"/><circle cx="239" cy="166" r="6" class="line-red"/>
  <circle cx="300" cy="148" r="6" class="solid-ink"/><circle cx="317" cy="148" r="6" class="solid-ink"/><circle cx="334" cy="148" r="6" class="solid-ink"/><circle cx="351" cy="148" r="6" class="line"/><circle cx="368" cy="148" r="6" class="solid-ink"/>
  <circle cx="300" cy="165" r="6" class="line"/><circle cx="317" cy="165" r="6" class="solid-ink"/><circle cx="334" cy="165" r="6" class="solid-ink"/><circle cx="351" cy="165" r="6" class="line"/><circle cx="368" cy="165" r="6" class="line"/>
  <circle cx="300" cy="182" r="6" class="solid-ink"/><circle cx="317" cy="182" r="6" class="line"/><circle cx="334" cy="182" r="6" class="solid-ink"/><circle cx="351" cy="182" r="6" class="line"/><circle cx="368" cy="182" r="6" class="line"/>
  <text x="14" y="246" class="blue">50곳 중 45곳, 90%</text>
  <text x="430" y="276" text-anchor="end">20곳 중 8곳, 40%</text>
  <circle cx="20" cy="312" r="6" class="solid-ink"/>
  <text x="32" y="318">30명 이하</text>
  <circle cx="130" cy="312" r="6" class="line"/>
  <text x="142" y="318">30명 넘음</text>
</svg>
<figcaption>두 조사와 모두 맞는 장부예요. 서울은 90%, 핀테크는 40%인데 둘이 겹친 다섯 곳은 0%예요.</figcaption>
</figure>

어느 쪽도 더 좁지 않아요. 핀테크가 모두 서울에 있지도 않고 서울 회사가 모두 핀테크도 아니에요. 두 모임이 엇갈려 있어요.

철수가 3반이면서 축구부라고 해 볼게요. 3반은 80%가, 축구부는 10%가 안경을 써요. 철수를 짐작하려면 "3반이면서 축구부"인 학생을 따로 세어야 해요.

그래도 서울 핀테크는 40%와 90% 사이쯤 아닐까요?

> 처음엔 이렇게 답했어요
>
> "사이라고 할 수 있지 않나..? 둘 다 속하니까"
>
> 둘 다 속한다는 건 맞았어요. 하지만 사이라고는 말할 수 없어요. 위 그림처럼 0%일 수도 있어요.
{: .answer }

그림의 장부는 두 조사와 모두 맞아요. 서울은 50곳 가운데 45곳, 핀테크는 20곳 가운데 8곳이 30명 이하예요. 그런데 겹친 서울 핀테크 5곳은 0%예요. 다섯 곳을 모두 작은 회사로 바꾸고 나머지를 맞추면 100%도 돼요.

40%와 90%에는 각 모임의 나머지가 섞여 있어서 그래요. 핀테크 40%에는 서울 밖 핀테크가, 서울 90%에는 핀테크가 아닌 서울 회사가 들어 있어요.

하예크(Hájek)는 2007년에 이 고민을 다룬 글에 "기준 모임 문제는 당신의 문제이기도 하다"라는 제목을 붙였어요.

방향을 바꾸면 달라져요. 서울 스타트업의 90%, 서울 밖 스타트업의 70%가 30명 이하라면 전체는 둘 사이에 올까요? 숫자를 넣어 양 끝을 시험해 봤어요. 서울 100곳, 서울 밖 10곳이면 97/110으로 88.2%예요. 거꾸로면 79/110으로 71.8%예요. 그래서 "맞는 것 같아"라고 답했고 실제로 맞았어요.

<figure class="fig">
<svg viewBox="0 0 440 340" style="max-width:440px" role="img" aria-label="시소 두 개. 서울 100곳과 서울 밖 10곳을 얹으면 받침점이 88.2%, 서울 10곳과 서울 밖 100곳이면 71.8%. 어느 쪽이든 70%와 90% 사이다">
  <text x="422" y="36" text-anchor="end">서울 100곳</text>
  <rect x="378" y="46" width="44" height="60" class="solid-blue"/>
  <text x="18" y="90">서울 밖 10곳</text>
  <rect x="18" y="100" width="44" height="6" class="solid-foil"/>
  <rect x="18" y="106" width="404" height="6" rx="2" class="solid-ink"/>
  <path d="M367.6 112 L355.6 136 L379.6 136 Z" class="solid-red"/>
  <text x="367.6" y="158" text-anchor="middle" class="bold red">88.2%</text>
  <text x="18" y="156">서울 밖 100곳</text>
  <rect x="18" y="166" width="44" height="60" class="solid-foil"/>
  <text x="422" y="210" text-anchor="end">서울 10곳</text>
  <rect x="378" y="220" width="44" height="6" class="solid-blue"/>
  <rect x="18" y="226" width="404" height="6" rx="2" class="solid-ink"/>
  <path d="M72.4 232 L60.4 256 L84.4 256 Z" class="solid-red"/>
  <text x="72.4" y="278" text-anchor="middle" class="bold red">71.8%</text>
  <rect x="40" y="298" width="360" height="10" rx="5" class="box-blue"/>
  <circle cx="72.4" cy="303" r="5" class="solid-red"/>
  <circle cx="367.6" cy="303" r="5" class="solid-red"/>
  <text x="40" y="332" text-anchor="middle">70%</text>
  <text x="400" y="332" text-anchor="middle">90%</text>
  <text x="220" y="332" text-anchor="middle" class="muted">이 밖으로 못 나가요</text>
</svg>
<figcaption>왼쪽 끝은 서울 밖 70%, 오른쪽 끝은 서울 90%예요. 회사 수만큼 무게를 얹으면 받침점이 전체 비율이에요.</figcaption>
</figure>

시소를 떠올리면 쉬워요. 양 끝에 회사 수만큼 무게를 얹으면 받침점이 전체 비율이에요. 무게를 한쪽으로 아무리 몰아도 받침점은 시소 밖으로 못 나가요. 이렇게 비중을 곱해 더한 값이 가중 평균이에요.

답에 붙인 전제도 맞았어요. "여기의 전제는 서울 밖 스타트업 + 서울이 완전히 전체 표본을 덮어야겠지만". 겹치지 않고 빈틈없이 나눠야 시소가 돼요.

| 사이에 와요 | 사이에 안 와요 |
|---|---|
| 서울과 서울 밖을 합친 전체 | 서울과 핀테크가 겹친 서울 핀테크 |
| 빈틈없이 나눈 조각이라 가중 평균이 돼요 | 두 모임의 나머지가 어떻게 생겼는지 몰라요 |

> **→ 그래서 실제로는** 서울 핀테크를 직접 센 통계가 없으면, 두 짐작을 각 기준 모임과 함께 적고 "정해지지 않음"으로 둬요. 40%와 90% 사이 값을 지어내지 않아요.
{: .practice }

**엇갈린 두 모임이 겹친 곳의 비율은 어디로든 가요. 두 비율 사이에 오는 건 빈틈없이 나눈 부분을 합친 전체뿐이에요.**

## 애초에 장부를 세면 장부의 비율이 나와요

<figure class="fig">
<svg viewBox="0 0 440 340" style="max-width:440px" role="img" aria-label="세상의 스타트업이라는 큰 상자 안에 장부 300곳이라는 작은 상자가 있다. 장부 안에서는 240곳이 30명 이하라 80%지만, 세상 전체의 비율은 모른다">
  <defs><marker id="f5-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-red"/></marker></defs>
  <rect x="8" y="8" width="424" height="324" rx="18" class="box dash"/>
  <text x="28" y="42" class="bold">세상의 스타트업</text>
  <text x="412" y="42" text-anchor="end" class="red">비율은 몰라요</text>
  <circle cx="40" cy="78" r="6" class="line"/><circle cx="78" cy="98" r="6" class="line"/><circle cx="118" cy="74" r="6" class="line"/><circle cx="160" cy="102" r="6" class="line"/><circle cx="200" cy="76" r="6" class="line"/><circle cx="240" cy="100" r="6" class="line"/><circle cx="280" cy="74" r="6" class="line"/><circle cx="318" cy="102" r="6" class="line"/><circle cx="356" cy="78" r="6" class="line"/><circle cx="398" cy="98" r="6" class="line"/>
  <circle cx="190" cy="128" r="6" class="line"/><circle cx="262" cy="126" r="6" class="line"/><circle cx="334" cy="130" r="6" class="line"/><circle cx="400" cy="132" r="6" class="line"/>
  <circle cx="36" cy="268" r="6" class="line"/><circle cx="74" cy="290" r="6" class="line"/><circle cx="112" cy="264" r="6" class="line"/><circle cx="40" cy="310" r="6" class="line"/><circle cx="108" cy="312" r="6" class="line"/>
  <text x="24" y="168" class="red">들어온 방식이</text>
  <text x="24" y="190" class="red">고르지 않아요</text>
  <path d="M100 204 Q 120 226 146 230" class="line-red" marker-end="url(#f5-ah)"/>
  <rect x="150" y="150" width="262" height="162" rx="14" class="box-blue"/>
  <text x="170" y="182" class="bold blue">장부 300곳</text>
  <rect x="170" y="198" width="222" height="16" rx="3" class="solid-rule"/>
  <rect x="170" y="198" width="177.6" height="16" rx="3" class="solid-blue"/>
  <text x="170" y="240">240곳이 30명 이하</text>
  <text x="170" y="290" class="bold">80%는 이 안의 이야기</text>
</svg>
<figcaption>센 것은 파란 상자 안의 300곳이에요. 빈 동그라미는 장부에 없는 회사예요.</figcaption>
</figure>

헬스장 회원의 80%가 운동을 좋아한다고 해서 사람들의 80%가 운동을 좋아한다고 하진 않아요. 회원에는 운동을 좋아해서 등록한 사람이 많아요. 고르게 뽑힌 사람들이 아니에요.

장부도 그래요. 장부에 스타트업 300곳이 있고, 세어 보니 240곳이 30명 이하였어요. 이걸로 "스타트업의 80%는 30명 이하다"라고 적어도 될까요?

> 처음엔 이렇게 답했어요
>
> "건전해보이는데"
>
> 계산은 맞았어요. 하지만 센 것은 장부의 300곳이고 문장은 세상의 스타트업을 말해요. 센 모임과 말하는 모임이 달라요.
{: .answer }

"장부에 적힌 스타트업 300곳 가운데 80%"까지는 적어도 돼요. "스타트업의 80%"부터는 안 돼요.

장부에 어떻게 들어왔는지에 따라 숫자가 바뀌어요. 뉴스나 투자 공시로 모았다면 투자를 받은 큰 회사가 많아요. 지원 사업 명단으로 모았다면 작은 회사가 많아요. 이렇게 뽑힌 방식 때문에 표본이 전체와 달라지는 일을 선택 편향이라고 해요.

장부를 다루는 방식이 달라도 숫자가 바뀌어요. 장부 A는 문 닫은 회사의 기록을 지우고 장부 B는 끝난 날짜를 달아 닫아 둬요. 2020년에 세운 5곳 가운데 2곳이 문을 닫았다고 해 볼게요.

<figure class="fig">
<svg viewBox="0 0 440 380" style="max-width:440px" role="img" aria-label="장부 A는 닫은 회사 기록 두 개를 지워 3곳 중 3곳, 100%가 나온다. 장부 B는 닫은 기록을 남겨 5곳 중 3곳, 60%가 나온다">
  <text x="14" y="30" class="bold">장부 A</text>
  <text x="14" y="54" class="muted">닫은 기록을 지워요</text>
  <rect x="10" y="72" width="196" height="34" rx="6" class="box-blue"/><text x="24" y="95" class="blue">영업 중</text>
  <rect x="10" y="114" width="196" height="34" rx="6" class="line dash"/><text x="24" y="137" class="muted">지운 기록</text>
  <rect x="10" y="156" width="196" height="34" rx="6" class="box-blue"/><text x="24" y="179" class="blue">영업 중</text>
  <rect x="10" y="198" width="196" height="34" rx="6" class="line dash"/><text x="24" y="221" class="muted">지운 기록</text>
  <rect x="10" y="240" width="196" height="34" rx="6" class="box-blue"/><text x="24" y="263" class="blue">영업 중</text>
  <text x="238" y="30" class="bold">장부 B</text>
  <text x="238" y="54" class="muted">닫아 두고 남겨요</text>
  <rect x="234" y="72" width="196" height="34" rx="6" class="box-blue"/><text x="248" y="95" class="blue">영업 중</text>
  <rect x="234" y="114" width="196" height="34" rx="6" class="box"/><text x="248" y="137" class="muted">2023년 닫음</text>
  <rect x="234" y="156" width="196" height="34" rx="6" class="box-blue"/><text x="248" y="179" class="blue">영업 중</text>
  <rect x="234" y="198" width="196" height="34" rx="6" class="box"/><text x="248" y="221" class="muted">2023년 닫음</text>
  <rect x="234" y="240" width="196" height="34" rx="6" class="box-blue"/><text x="248" y="263" class="blue">영업 중</text>
  <rect x="10" y="294" width="196" height="18" rx="4" class="solid-rule"/>
  <rect x="10" y="294" width="196" height="18" rx="4" class="solid-red"/>
  <text x="14" y="338" class="bold red">3곳 중 3곳, 100%</text>
  <text x="14" y="364" class="muted">분모가 줄었어요</text>
  <rect x="234" y="294" width="196" height="18" rx="4" class="solid-rule"/>
  <rect x="234" y="294" width="117.6" height="18" rx="4" class="solid-blue"/>
  <text x="238" y="338" class="bold blue">5곳 중 3곳, 60%</text>
  <text x="238" y="364" class="muted">닫은 곳도 분모에</text>
</svg>
<figcaption>같은 다섯 회사를 세는데 A는 100%, B는 60%가 나와요. A에서는 닫은 두 곳이 분모에서 빠졌어요.</figcaption>
</figure>

두 장부로 "2020년에 세운 곳 가운데 지금도 영업 중인 비율"을 세면 어떻게 될까요. "A로 하면 100%지 분모를 지워버렸으니까. B는 구분이 될거고"라고 답했는데 A, B 둘 다 맞았어요.

살아남은 것만 보고 내리는 판단을 생존자 편향이라고 불러요. 2차 대전 때 통계학자 왈드(Wald)는 돌아온 폭격기의 총알 자국을 보고 자국이 없는 엔진을 보강하자고 했어요. 엔진을 맞은 비행기는 돌아오지 못했기 때문이에요.

B에도 남는 문제가 있어요. 폐업 소식이 늦게 들어오면 그동안은 살아 있는 것으로 세요. 그래서 언제까지 기록된 장부로 셌는지도 적어요.

> **→ 그래서 실제로는** 무엇을 묻느냐에 따라 센 결과 옆에 적을 것이 달라져요.
{: .practice }

| 답하려는 질문 | 적어야 하는 것 |
|---|---|
| 장부의 스타트업 가운데 몇 %가 30명 이하일까 | 대상은 "장부에 적힌 모임", 기준일, 분모는 "직원 수를 아는 곳만" |
| 2020년에 세운 곳 가운데 몇 %가 살아 있을까 | 지우지 않고 닫아 둔 기록, 닫은 날짜, 언제까지 기록된 장부인지 |

**장부의 비율은 장부에 들어온 회사들의 비율이고, 기록을 지우면 분모도 같이 사라져요.**

## 언어 모델의 확신 0.9도 모아서 세어 봐야 알아요

언어 모델로 회사 문서에서 사실을 뽑아 장부에 넣는다고 해 볼게요. 모델은 기록마다 "확신 0.9" 같은 숫자를 달아 줘요. 이 숫자를 믿어도 되는지는 같은 숫자를 단 기록을 모아 세어 봐야 알아요.

<figure class="fig">
<svg viewBox="0 0 440 400" style="max-width:440px" role="img" aria-label="보정 그림. 모델이 0.5에서 0.6을 단 기록은 55%가 맞아 대각선 위에 있고, 0.7에서 0.8은 62%, 0.9에서 1.0은 71%가 맞아 대각선 아래로 떨어진다">
  <text x="90" y="24" class="muted">실제로 맞은 비율</text>
  <path d="M90 40 V340 H410" class="line"/>
  <text x="80" y="346" text-anchor="end">50%</text>
  <text x="80" y="226" text-anchor="end">70%</text>
  <text x="80" y="106" text-anchor="end">90%</text>
  <text x="90" y="364" text-anchor="middle">0.5</text>
  <text x="218" y="364" text-anchor="middle">0.7</text>
  <text x="346" y="364" text-anchor="middle">0.9</text>
  <text x="250" y="392" text-anchor="middle" class="muted">모델이 단 확신</text>
  <path d="M90 340 L410 40" class="line dash"/>
  <text x="334" y="100" text-anchor="end" class="muted">말한 만큼 맞는 선</text>
  <path d="M250 190 V259" class="line-red dash"/>
  <path d="M378 70 V198" class="line-red dash"/>
  <text x="390" y="145" class="bold red">과신</text>
  <circle cx="122" cy="310" r="7" class="solid-blue"/>
  <circle cx="250" cy="268" r="8.7" class="solid-blue"/>
  <circle cx="378" cy="214" r="15.8" class="solid-blue"/>
  <text x="136" y="318">55%</text>
  <text x="264" y="276">62%</text>
  <text x="378" y="254" text-anchor="middle">71%</text>
</svg>
<figcaption>점 크기는 기록 수예요. 대각선 아래로 떨어진 만큼 모델이 자신만만해요.</figcaption>
</figure>

일기예보로 생각하면 쉬워요. "비 올 확률 70%"였는데 비가 안 왔다고 그 예보가 틀린 건 아니에요. 70%라고 한 날을 모두 모아 열 번에 일곱 번쯤 비가 왔다면 믿을 만한 예보예요.

0.9는 통계일까요, 믿음일까요. "믿음의 문장 처럼 느껴지긴 해"라는 답이 맞았어요. 기록 하나가 맞을 가능성을 말하는 숫자예요. 세상을 세어 얻은 숫자가 아니에요. 모델이 글자로 쓴 확신은 높은 쪽에 몰린다는 보고도 있어요(Xiong 외, 2024).

믿음 하나는 확인할 수 없어요. "0.9"가 붙은 기록을 고르게 1,000개 뽑아 등기부 같은 바깥 근거와 맞춰 봐요. 900개 안팎이 맞으면 이 모델의 0.9는 믿을 만해요. 답에서 짚은 "분모"가 바로 이 1,000개예요. "0.9라고 한 것 가운데 90%가 맞는다"는 성질을 보정(calibration)이라고 해요.

위 그림의 모델은 0.9~1.0을 단 기록이 71%만 맞았어요. 높은 쪽에서 실제보다 자신만만해요. GPT-4 기술 보고서(2023)에도 비슷한 이야기가 나와요. 객관식 문제에서 사전 학습만 마친 모델의 확률은 실제 정답률과 잘 맞았는데 후속 학습 뒤에는 덜 맞았어요.

다른 모델은 0.9를 단 기록 1,000개 가운데 900개가 맞았어요. 잘 보정된 것 같지만 직원 수 기록 200개만 따로 보니 120개, 60%만 맞았어요.

<figure class="fig">
<svg viewBox="0 0 440 390" style="max-width:440px" role="img" aria-label="폭이 기록 수, 칠한 높이가 맞은 비율인 막대. 직원 수 기록 200개는 60%, 나머지 800개는 97.5%이고, 합치면 1,000개 중 900개로 90%가 되어 직원 수의 60%가 안 보인다">
  <defs><marker id="f8-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head"/></marker></defs>
  <rect x="20" y="40" width="80" height="110" class="solid-rule"/>
  <rect x="20" y="84" width="80" height="66" class="solid-red"/>
  <rect x="100" y="40" width="320" height="110" class="solid-rule"/>
  <rect x="100" y="42.75" width="320" height="107.25" class="solid-blue"/>
  <path d="M100 40 V150" class="line"/>
  <text x="60" y="138" text-anchor="middle" class="bold on-solid">60%</text>
  <text x="260" y="104" text-anchor="middle" class="bold on-solid">97.5%</text>
  <text x="60" y="174" text-anchor="middle">직원 수</text>
  <text x="60" y="196" text-anchor="middle" class="muted">기록 200개</text>
  <text x="260" y="174" text-anchor="middle">나머지</text>
  <text x="260" y="196" text-anchor="middle" class="muted">기록 800개</text>
  <path d="M220 206 V232" class="line" marker-end="url(#f8-ah)"/>
  <text x="232" y="226" class="muted">합치면</text>
  <rect x="20" y="240" width="400" height="110" class="solid-rule"/>
  <rect x="20" y="251" width="400" height="99" class="solid-blue"/>
  <rect x="20" y="240" width="80" height="110" class="line-red dash"/>
  <text x="250" y="306" text-anchor="middle" class="bold on-solid">기록 1,000개 중 900개, 90%</text>
  <text x="20" y="376" class="red">직원 수 60%가 섞여 안 보여요</text>
</svg>
<figcaption>막대 폭은 기록 수, 칠한 높이는 맞은 비율이에요. 넓은 파란 막대가 좁은 빨간 막대를 덮어요.</figcaption>
</figure>

> 처음엔 이렇게 답했어요
>
> "맞는 문장이 늘어나면서 전체적으로 맞다고 봐서 그런걸까?"
>
> 이게 답이었어요. 다만 이 일은 모델 안이 아니라 우리 검수에서 일어났어요. 잘 맞는 나머지 기록 800개가 직원 수 기록 200개의 60%를 가렸어요.
{: .answer }

계산은 앞의 시소와 같아요. 0.2 × 60% + 0.8 × 97.5% = 90%예요. 직원 수는 기준일, 법인과 사업장, 자회사를 넣는지에 따라 문서마다 다르게 적혀요. 모델은 그걸 모르고 똑같이 0.9를 달아요.

"0.9가 붙은 기록은 90%가 맞았다"고는 말해도 돼요. 하지만 거기서 "그러니 직원 수 기록도 90% 맞는다"로 넘어가면 안 돼요.

> **→ 그래서 실제로는** 모델의 0.9를 그대로 등급으로 쓰지 않아요. 기록 종류별 보정표로 바꿔 읽고 어느 보정표로 언제 검수했는지 함께 적어요.
{: .practice }

| 기록 종류 | 0.9를 바꿔 읽는 값 |
|---|---|
| 직원 수 | 0.6 |
| 나머지 | 0.975 |

**확신 0.9는 같은 숫자를 단 기록을 종류별로 모아 세어 봐야 무슨 뜻인지 알 수 있어요.**

## 그렇다고 셋 다 틀린 곳을 0으로 읽지는 않아요

직원 수 기록 200개 가운데 해외 법인 기록은 3개뿐이었고 3개 모두 틀렸어요. 해외 법인 기록의 0.9는 0으로 바꿔 읽어야 할까요?

<figure class="fig">
<svg viewBox="0 0 440 290" style="max-width:440px" role="img" aria-label="실제로 맞을 가능성별로 기록 세 개가 모두 틀릴 확률. 0.6이면 6.4%, 0.5인 동전이면 12.5%, 0.3이면 34%, 0이면 100%">
  <text x="20" y="26" class="muted">맞을 가능성</text>
  <text x="150" y="26" class="muted">셋 다 틀릴 확률</text>
  <text x="20" y="66" class="bold">0.6</text>
  <text x="20" y="88" class="muted">직원 수 전체</text>
  <rect x="150" y="50" width="260" height="22" rx="4" class="solid-rule"/>
  <rect x="150" y="50" width="16.6" height="22" rx="4" class="solid-blue"/>
  <text x="174.6" y="67">6.4%</text>
  <text x="20" y="128" class="bold">0.5</text>
  <text x="20" y="150" class="muted">멀쩡한 동전</text>
  <rect x="150" y="112" width="260" height="22" rx="4" class="solid-rule"/>
  <rect x="150" y="112" width="32.5" height="22" rx="4" class="solid-blue"/>
  <text x="190.5" y="129">12.5%</text>
  <text x="20" y="190" class="bold">0.3</text>
  <rect x="150" y="174" width="260" height="22" rx="4" class="solid-rule"/>
  <rect x="150" y="174" width="89.2" height="22" rx="4" class="solid-blue"/>
  <text x="247.2" y="191">34%</text>
  <text x="20" y="252" class="bold red">0</text>
  <text x="20" y="274" class="muted">기록 3개만 믿으면</text>
  <rect x="150" y="236" width="260" height="22" rx="4" class="solid-red"/>
  <text x="402" y="253" text-anchor="end" class="bold on-solid">100%</text>
</svg>
<figcaption>셋 다 틀리는 일은 맞을 가능성이 0.6이어도, 0.3이어도 일어나요. 기록 3개로는 어느 쪽인지 가려낼 수 없어요.</figcaption>
</figure>

멀쩡한 동전을 세 번 던져 세 번 다 뒷면이 나올 확률은 12.5%, 여덟 번에 한 번꼴이에요. 그렇다고 이 동전은 앞면이 안 나온다고 하지 않아요.

해외 법인 기록도 같아요. 실제로 맞을 가능성이 0.6이어도 셋 다 틀릴 확률이 6.4%, 0.3이면 34%예요. 3개로는 어느 쪽인지 가려낼 수 없어요.

> 처음엔 이렇게 답했어요
>
> "0으로 바꾸는게 맞아보여"
>
> 방향은 맞았어요. 더 좁은 모임이고 0.6보다 나쁠 수 있다는 신호예요. 하지만 0은 너무 세요. 3개는 믿을 만한 통계가 아니에요.
{: .answer }

0은 특히 위험해요. "절대 맞지 않는다"는 뜻이라, 뒤에 맞는 기록이 아무리 나와도 새 증거로 믿음을 고치는 계산으로는 0에서 올라가지 않아요.

통계학자 린들리(Lindley)는 경험으로 아는 일에 0이나 1을 주지 말라는 원칙을 크롬웰의 규칙이라고 불렀어요. 1650년 크롬웰이 스코틀랜드 교회에 보낸 편지의 한 구절, "그리스도의 자비를 걸고 간청하니, 그대들이 틀렸을 수도 있다고 생각해 보라"에서 따온 이름이에요.

그럼 어떻게 읽을까요. 믿을 만한 큰 모임 쪽으로 당겨요.

<figure class="fig">
<svg viewBox="0 0 440 380" style="max-width:440px" role="img" aria-label="해외 법인 기록 3칸은 모두 틀림. 라플라스 평활은 2칸을 보태 5칸 중 1칸으로 0.2, 큰 모임 쪽으로 당기면 0.6짜리 10칸을 보태 13칸 중 6칸으로 약 0.46. 수직선 위에 0, 0.2, 0.46, 0.6이 있다">
  <defs><marker id="f10-ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0,0 L10,5 L0,10 z" class="arrow-head-blue"/></marker></defs>
  <text x="20" y="26" class="bold">라플라스 평활</text>
  <text x="134" y="26" class="muted">2칸을 보태요</text>
  <rect x="20" y="40" width="26" height="26" rx="4" class="box-red"/><rect x="50" y="40" width="26" height="26" rx="4" class="box-red"/><rect x="80" y="40" width="26" height="26" rx="4" class="box-red"/>
  <rect x="122" y="40" width="26" height="26" rx="4" class="solid-blue"/><rect x="152" y="40" width="26" height="26" rx="4" class="line"/>
  <text x="196" y="60">5칸 중 1칸, 0.2</text>
  <text x="20" y="106" class="bold">큰 모임 쪽으로</text>
  <text x="146" y="106" class="muted">0.6짜리 10칸을 보태요</text>
  <rect x="20" y="120" width="26" height="26" rx="4" class="box-red"/><rect x="50" y="120" width="26" height="26" rx="4" class="box-red"/><rect x="80" y="120" width="26" height="26" rx="4" class="box-red"/>
  <rect x="122" y="120" width="26" height="26" rx="4" class="solid-blue"/><rect x="152" y="120" width="26" height="26" rx="4" class="solid-blue"/><rect x="182" y="120" width="26" height="26" rx="4" class="solid-blue"/><rect x="212" y="120" width="26" height="26" rx="4" class="solid-blue"/><rect x="242" y="120" width="26" height="26" rx="4" class="solid-blue"/><rect x="272" y="120" width="26" height="26" rx="4" class="solid-blue"/><rect x="302" y="120" width="26" height="26" rx="4" class="line"/><rect x="332" y="120" width="26" height="26" rx="4" class="line"/><rect x="362" y="120" width="26" height="26" rx="4" class="line"/><rect x="392" y="120" width="26" height="26" rx="4" class="line"/>
  <text x="20" y="176">13칸 중 6칸, 약 0.46</text>
  <rect x="20" y="198" width="18" height="18" rx="3" class="box-red"/>
  <text x="44" y="213">해외 법인 기록</text>
  <rect x="170" y="198" width="18" height="18" rx="3" class="solid-blue"/>
  <text x="194" y="213">맞음</text>
  <rect x="250" y="198" width="18" height="18" rx="3" class="line"/>
  <text x="274" y="213">틀림</text>
  <path d="M38 288 Q 140 236 238 288" class="line-blue" marker-end="url(#f10-ah)"/>
  <text x="139" y="252" text-anchor="middle" class="blue">0.6 쪽으로 당겨요</text>
  <path d="M30 300 H410" class="line"/>
  <circle cx="30" cy="300" r="7" class="solid-red"/>
  <circle cx="125" cy="300" r="6" class="solid-ink"/>
  <circle cx="248.5" cy="300" r="8" class="solid-blue"/>
  <circle cx="315" cy="300" r="6" class="solid-ink"/>
  <text x="30" y="328" text-anchor="middle" class="bold red">0</text>
  <text x="125" y="328" text-anchor="middle" class="bold">0.2</text>
  <text x="248.5" y="328" text-anchor="middle" class="bold blue">0.46</text>
  <text x="315" y="328" text-anchor="middle" class="bold">0.6</text>
  <text x="22" y="350" class="red">기록</text>
  <text x="22" y="370" class="red">3개만 보면</text>
  <text x="125" y="350" text-anchor="middle">라플라스</text>
  <text x="248.5" y="350" text-anchor="middle" class="blue">당겨</text>
  <text x="248.5" y="370" text-anchor="middle" class="blue">읽은 값</text>
  <text x="315" y="350" text-anchor="middle">직원 수</text>
  <text x="315" y="370" text-anchor="middle">전체</text>
</svg>
<figcaption>빨간 칸은 셋 다 틀린 해외 법인 기록이에요. 큰 모임에서 빌린 칸을 보태면 0이 0.46으로 당겨져요.</figcaption>
</figure>

직원 수 전체의 0.6을 기록 10개 분량만큼 보태서 함께 세요. 13칸 가운데 6칸이 맞음이라 약 0.46이 나와요. 교재에 나오는 라플라스 평활은 맞음 1칸, 틀림 1칸을 보태 0.2가 돼요. 해외 법인 기록이 쌓일수록 값은 그 기록들의 결과 쪽으로 옮겨 가요. 이런 방법을 줄여 잡기(shrinkage)라고 불러요.

기록 3개로도 "해외 법인 기록은 0.6보다 나쁠 수 있다"고는 말할 수 있어요. 그렇다고 "해외 법인 기록은 절대 맞지 않는다"고 하면 안 돼요.

> **→ 그래서 실제로는** 장부에 쓰는 값 0.46과 함께 표본(3개, 맞음 0)과 방법(0.6 쪽으로 당김, 기록 10개 분량)을 적어요. 3개는 결론이 아니라 검수를 더 해 볼 신호예요.
{: .practice }

**적게 센 모임은 0이나 1로 읽지 않고, 믿을 만한 큰 모임 쪽으로 당겨 읽어요.**

## 숫자 옆에는 누구를 셌는지 적어요

비율 하나를 만나면 이렇게 물어보면 돼요.

1. 모임의 숫자예요, 한 곳의 숫자예요?
2. 빌려 온 모임은 이 한 곳과 닮았고, 충분히 셌어요?
3. 엇갈린 두 모임의 비율로 겹친 곳을 짐작하고 있진 않아요?
4. 장부에 어떻게 들어오고 나갔어요? 지운 기록은 없어요?
5. 같은 숫자를 단 기록을 종류별로 모아 셌어요? 적게 센 종류는 당겨 읽었어요?

그래서 장부의 숫자 옆에는 늘 무엇을 셌는지, 언제 기준인지, 몇 개를 셌는지, 어떻게 셌는지를 적어요.

3반의 80%는 거짓말을 하지 않아요. 철수 이야기를 하지 않을 뿐이에요.

---

**더 읽을 것**

- Reichenbach (1949), *The Theory of Probability*. 가장 좁은 기준 모임을 고르라는 원칙
- Hájek (2007), *The Reference Class Problem is Your Problem Too*. 기준 모임 문제가 왜 어려운지 다룬 글
- Guo 외 (2017), *On Calibration of Modern Neural Networks*. 신경망의 과신과 온도 조정으로 바로잡는 방법
- Xiong 외 (2024), *Can LLMs Express Their Uncertainty?* 언어 모델이 말로 낸 확신이 높은 쪽에 몰린다는 보고
