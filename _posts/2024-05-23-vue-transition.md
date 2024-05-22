---
title: Vue - Transition을 활용한 센스있는 Animation 처리 방법
description: Transition의 hooks와 활용도를 예제와 함께 살펴보자.
author: Ferv0r2
date: 2024-05-23 02:57:00 +0900
categories: [vue, animation]
tags: [transition, component, typing animation]
render_with_liquid: false
image: /assets/img/post/20240523/banner.png
---

## Transition Component

`Transition`은 내장 컴포넌트로 `<slot>`을 통해 전달된 요소나 컴포넌트에 `enter` 또는 `leave` 애니메이션을 적용하는 데 사용한다.

`enter` 또는 `leave`의 트리거는 다음과 같다:

- `v-if`를 통한 조건부 렌더링
- `v-show`를 통한 조건부 표시
- `<component>` 특수 요소를 통한 동적 컴포넌트 전환
- 특수 `key` 속성 변경

![Desktop View](/assets/img/post/20240523/classes.png){: .normal}

위 이미지처럼 **Enter**와 **Leave**에 각각 `state`가 있어 원하는 시기에 맞춰 스타일을 적용할 수 있다.

또한, `name` props를 통해 특정한 `Transition`마다 애니메이션을 달리 적용할 수 있다.

```vue
<template>
  <Transition> ... </Transition>
  <Transition name="fade"> ... </Transition>
</template>
<style scope>
.v-enter-from {
  transform: scale(1);
}
.fade-enter-from {
  opacity: 0;
}

.v-enter-to {
  transform: scale(1.2);
}
.fade-enter-to {
  opacity: 1;
}

.v-enter-active {
  transition: transform 1s ease;
}
.fade-enter-active {
  transition: opacity 1s ease;
}
</style>
```

### 왜 굳이 사용해야 할까?

> DOM이 생성되고 제거될 때 **1초 동안** 점점 투명해지면서 사라지는 애니메이션을 주고 싶다

그렇다면 DOM이 그 **1초 동안** 생성 및 제거가 되지 않고 **대기**해야 한다.

만약, 기다려주지 않는다면 어떻게 될까? 아래 짤을 잠시 보고 가자

![Desktop View](/assets/img/post/20240523/failed.gif){: width="360" .normal}

> 합체 변신 중에 방해를 받아 합체를 할 수 없어졌다.

이처럼 애니메이션 중에 **DOM이 사라져 애니메이션이 중단**되는 등 원하지 않는 이슈가 발생할 수 있다.

## Transition의 Javascript Hooks

`Transition`은 여러 Javascript Hooks를 가지고 있다.

```html
<Transition
  @before-enter="onBeforeEnter"
  @enter="onEnter"
  @after-enter="onAfterEnter"
  @enter-cancelled="onEnterCancelled"
  @before-leave="onBeforeLeave"
  @leave="onLeave"
  @after-leave="onAfterLeave"
  @leave-cancelled="onLeaveCancelled"
/>
```

이러한 Hooks를 통해 원하는 조건에 따른 애니메이션 중지, 변수 처리 등이 가능하다.

설명을 덧붙이자면 이렇다.

### Enter Hooks

- `onBeforeEnter(el)` : DOM에 태그가 추가 되기 전에 호출
- `onEnter(el, done)` : Enter 애니메이션이 시작되는 순간 호출, `done` 메서드를 통한 애니메이션 중지 가능
- `onAfterEnter(el)` : Enter 애니메이션이 끝나면 호출
- `onEnterCancelled(el)` : Enter 애니메이션이 끝나기도 전에 애니메이션이 멈추는 경우 호출

### Leave Hooks

- `onBeforeLeave(el)` : DOM에 태그가 제거 되기 전에 호출
- `onLeave(el, done)` : Leave 애니메이션이 시작되는 순간 호출, `done` 메서드를 통한 애니메이션 중지 가능
- `onAfterLeave(el)` : Leave 애니메이션이 끝나면 호출
- `onLeaveCancelled(el)` : Leave 애니메이션이 끝나기도 전에 애니메이션이 멈추는 경우 호출

### Example

```vue
<script setup lang="ts">
import { ref } from "vue";

const show = ref(false);
</script>
<template>
  <main>
    <button type="button" @click="show = true">Click</button>
    <Transition
      mode="out-in"
      @before-enter="() => console.log('Enter 애니메이션 시작 전')"
      @enter="() => console.log('Enter 애니메이션 시작')"
      @after-enter="
        () => {
          console.log('Enter 애니메이션 종료');
          show = false;
        }
      "
      @before-leave="() => console.log('Leave 애니메이션 시작 전')"
      @leave="() => console.log('Leave 애니메이션 시작')"
      @after-leave="() => console.log('Leave 애니메이션 종료')"
    >
      <div v-if="show" class="item" />
    </Transition>
  </main>
</template>
<style scoped>
/* ... */
</style>
```

![Desktop View](/assets/img/post/20240523/hooks.gif){: .normal}

## 까다로운 사용

그렇다면 아래 조건에 맞는 애니메이션을 만들어 보자.

> 대화형 메세지 박스를 **순차적으로** 두 개 보낸다.
>
> 메세지는 텍스트가 **하나씩 타이핑**되도록 한다.

따라서 첫 번째 메세지의 **타이핑 완료 타이밍**을 알아야 한다.

### 접근 방식

먼저, 첫 번째 `message-box-wrapper`의 `opacity` 애니메이션이 종료되었을 때, 두 번째 메세지를 호출해 보자.

#### After Appear hook 사용

```vue
<script setup lang="ts">
import { ref } from "vue";

const firstDone = ref<boolean>(false);
const onShowMessage = () => {
  firstDone.value = true;
};
</script>

<template>
  <main>
    <h1>Example</h1>
    <section class="box-container">
      <Transition name="box" appear @after-appear="onShowMessage">
        <div class="message-box-wrapper">
          <span>Hello, World!</span>
        </div>
      </Transition>
      <Transition name="box">
        <div v-if="firstDone" class="message-box-wrapper">
          <span>Welcome to the Example message.</span>
        </div>
      </Transition>
    </section>
  </main>
</template>

<style scoped>
.box-enter-from {
  opacity: 0;
  transform: translateY(8px);
}
.box-enter-to {
  opacity: 1;
  transform: translateY(0);
}
.box-enter-active {
  transition: all 0.5s ease;
}
</style>
```

![Desktop View](/assets/img/post/20240523/issue.gif){: .normal}

첫 번째 메세지 이후, 두 번째 메세지나 표현되는 것은 성공했지만

메세지의 타이핑 완료 시점이 아니기 때문에 `@after-appear` hook은 의미가 없다.

따라서, 현재 구조를 바탕으로 `MessageBox`라는 컴포넌트를 만들어 입력 효과 먼저 구현해 보자.

#### TransitionGroup 사용

`TransitionGroup` 태그는 `Transition`과 같은 목적으로 애니메이션을 적용하기 위해 사용한다.

`v-for`과 같은 반복문에서 데이터가 변경될 때, 애니메이션을 적용할 수 있다.

```vue
<script setup lang="ts">
import { ref, onMounted } from "vue";

const props = defineProps<{
  msg: string;
}>();

const emits = defineEmits<{
  (event: "complete"): void;
}>();

const typingMessage = ref("");

const typeMessage = () => {
  let i = 0;
  const interval = setInterval(() => {
    if (i === props.msg.length) {
      clearInterval(interval);
      emits("complete");
      return;
    }
    typingMessage.value += props.msg[i];
    i++;
  }, 50);
};

onMounted(() => {
  typeMessage();
});
</script>

<template>
  <div class="message-box-wrapper">
    <TransitionGroup tag="span" name="typing">
      <span v-for="(word, idx) in typingMessage" :key="word + idx">{{
        word
      }}</span>
    </TransitionGroup>
  </div>
</template>

<style scoped>
.message-box-wrapper {
  position: relative;
  padding: 8px 16px;
  background-color: #fff;
  border-radius: 8px;
}
.message-box-wrapper::before {
  content: "";
  position: absolute;
  display: inline-block;
  top: 4px;
  left: -4px;
  width: 12px;
  height: 12px;
  transform: rotate(45deg);
  background-color: #fff;
}
span {
  color: #111;
  font-weight: 600;
}
.typing-enter-from {
  opacity: 0;
}
.typing-enter-to {
  opacity: 1;
}
.typing-enter-active {
  transition: opacity 0.01s;
}
</style>

// MessageBox.vue
```

`complete` emits을 통해 타이핑 애니메이션이 종료되었을 때 이벤트를 넘겨줄 수 있도록 하고,

`TransitionGroup`은 변경되는 데이터에 대해 동작하기 때문에 빈 문자열에 `interval`를 통한 동작을 반영했다.

이제 `MessageBox` 컴포넌트를 적용해 보자.

```vue
<script setup lang="ts">
import { ref } from "vue";
import MessageBox from "@/components/MessageBox.vue";

const firstDone = ref<boolean>(false);
const onShowMessage = () => {
  firstDone.value = true;
};
</script>

<template>
  <main>
    <h1>Example</h1>
    <section class="box-container">
      <Transition name="box" appear>
        <MessageBox show msg="Hello, world!" @complete="onShowMessage" />
      </Transition>
      <Transition name="box">
        <MessageBox v-if="firstDone" msg="Welcome to the Example message." />
      </Transition>
    </section>
  </main>
</template>

<style scoped>
main {
  display: flex;
  flex-direction: column;
  width: 100%;
  gap: 16px;
}
.box-container {
  display: flex;
  flex-direction: column;
  width: 100%;
  background-color: #999;
  border-radius: 16px;
  padding: 16px;
  gap: 16px;
}
.second-box:not(.show) {
  opacity: 0;
}
.box-enter-from {
  opacity: 0;
  transform: translateY(8px);
}
.box-enter-to {
  opacity: 1;
  transform: translateY(0);
}
.box-enter-active {
  transition: all 0.5s ease;
}
</style>
```

![Desktop View](/assets/img/post/20240523/typing.gif){: .normal}

첫 번쨰 `MessageBox`의 `complete` 이벤트를 통해 `flag`를 변경하면서 두 번째 메세지가 순차적으로 표시되도록 하였다.

여러 라이브러리도 많지만 `Transition`만으로도 충분히 가능하다는 것을 확인하는 시간이었다. ^\_\_^

## 레퍼런스

[Vue Docs - Transition](https://vuejs.org/guide/built-ins/transition)
