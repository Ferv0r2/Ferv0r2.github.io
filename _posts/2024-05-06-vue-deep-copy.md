---
title: Vue - 다차원 배열 Proxy(Object)의 깊은 복사는 어떻게 할까?
author: Ferv0r2
date: 2024-05-06 22:25:00 +0900
categories: [vue]
tags: [proxy, spreadOperator, deepCopy, structuredClone]
render_with_liquid: false
image: /assets/img/post/20240506/banner.png
---

## 발단

사내에서 Preview를 보여주는 기능을 개발하던 중에 발생한 이슈이다.
저장을 하기 전까지 기존 UI와 수정 UI를 함께 제공해야 하는데 기존 UI가 함께 변경되는 것이 아닌가?

아래 코드를 살펴보자.

```ts
import { ref } from "vue";

interface ILayoutItem {
  id: string;
  data: IData[];
}

interface IData {
  key: string;
  value: string;
  message: string;
}

const props = defineProps<{
  layoutItems: ILayoutItem[];
}>();

const modifyingLayoutItems = ref([...props.layoutItems]);
const onUpdateData = (idx: number, value) => {
  modifyingLayoutItems.value[idx].value = value;
};
```

props로 받은 `layout`을 `modifyingLayoutItems`에 스프레드 연산자로 변수에 할당하여 불변성을 유지하려고 했다.

하지만 `modifyingLayout`의 내부 Object 값을 변경할 때, `props`의 `layoutItems`가 변경되었다.

왜 이런 일이 발생했을까?

## 깊은 복사

### 스프레드 연산자

```js
const foo = [1, [2], 3];
const bar = [...foo];
```

`...` 형태의 스프레드 연산자는 흔히 *깊은 복사*라는 인식이 있지만 실제 깊은 복사가 아니다.

1차원 배열에서는 효과적으로 적용할 수 있지만 다차원 배열을 복사하는 것은 적합하지 않다고 한다.

### JSON 객체

실제 깊은 복사는 다음처럼 진행한다.

```js
const foo = [1, [2], 3];
const bar = JSON.parse(JSON.stringify(foo));
```

깊은 복사를 진행하면 `props`의 값을 변경하지 않고 값을 수정할 수 있다.

하지만 직렬화 과정에서 성능이 저하될 수 있고, 직렬화가 불가능한 속성의 경우 이슈가 발생할 수 있다.

Javascript에서 메서드를 활용한 깊은 복사 기능이 지원되지 않기에 사용자들은 `lodash` 라이브러리를 활용하여 깊은 복사를 사용했다.

그런데 최신 문법에서 이를 지원하는 메서드가 등장한 것이 아닌가!

### structuredClone 메서드

```js
const foo = [1, [2], 3];
const bar = structuredClone(foo);
```

Object를 메서드로 감싸면 깊은 복사가 완료된다.

크로스 브라우징이 지원되는 내장 메서드로 Polyfill 이슈만 잘 핸들링한다면 정말 편리할 것 같다.

> 사실 원래부터 지원돼야 했지 않을까? 라는 생각이 잠깐 들었지만..

## 그렇다면 Vue에서는 어떻게?

Vue는 기본적으로 Proxy Object를 사용하기 때문에 추가적인 메서드 활용이 필요하다.

```diff
-import { ref } from 'vue'
+import { ref, toRaw } from 'vue'

-const modifyingLayoutItems = ref([...props.layoutItems]);
+const modifyingLayoutItems = ref(structuredClone(toRaw(props.layoutItems)));
const onUpdateData = (idx: number, value) => {
  modifyingLayoutItems.value[idx].value = value;
};
```

`toRaw` 메서드를 활용하여 Proxy Object를 원시값으로 변경한다면 `structuredClone` 메서드를 문제없이 사용할 수 있다 ^\_\_^

## 레퍼런스

- [MDN - Spred_syntax](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Operators/Spread_syntax)
- [MDN - structuredClone](https://developer.mozilla.org/en-US/docs/Web/API/structuredClone)
- [Vue - toRaw](https://ko.vuejs.org/api/reactivity-advanced#toraw)
