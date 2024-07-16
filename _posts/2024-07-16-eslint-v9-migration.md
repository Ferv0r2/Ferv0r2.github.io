---
title: 우리 팀의 ESLint v9 마이그레이션 적용기 (feat. Vue)
description: ESLint와 코딩 컨벤션의 연결 고리와 효율성에 관하여
author: Ferv0r2
date: 2024-07-16 01:02:00 +0900
categories: [convention, eslint, vue]
tags: [devtool]
render_with_liquid: false
image: /assets/img/post/20240716/banner.png
---

## 들어가며

최근 우리 팀은 코드 품질 향상과 최신 기술 트렌드를 반영하기 위해 TypeScript와 ESLint를 업데이트하였습니다.

1. 사내 라이브러리를 개발하면서 TypeScript를 최신 버전 `v5.5.2`로 업데이트 하였고
2. 현재 사용하는 ESLint `v8.26.0`이 TypeScript `<=v5.4.0`까지 지원하여
3. lint가 동작하지 않는 이슈가 발생하였습니다.

따라서, ESLint를 최신화하려던 중에 **Breaking Update** 사항이 있어 **Migration이 필수적인 이슈**가 발생하였고, 이를 해결하는 과정을 서술합니다.

이 과정에서 `off`한 rule에 대해 꼭 필요한 것인지, 어떤 부분에서 타협을 보았는지 검토하고 사내 코딩 컨벤션을 함께 고려하여 적절한 ESLint를 고민하는 과정을 포함하였습니다.

![Desktop View](/assets/img/post/20240716/slack.png){: .normal}

> 채널 내 ESLint 업데이트 공유 및 컨벤션 조정 제안

## TypeScript 업데이트와 ESLint 이슈

앞서 언급했던 바와 같이, TypeScript 최신 버전 업데이트 이후 ESLint가 **정상 작동하지 않는 문제**를 발견했습니다.

그 이유는 팀에서 사용하고 있는 ESLint `v8.26.0`은 TypeScript `v5.4.0` 까지 지원했기 때문입니다.

![Desktop View](/assets/img/post/20240716/error.png){: .normal}

이 문제를 해결하기 위해 ESLint를 최신 버전인 `v9.6.0`으로 업데이트하기로 결정했습니다.

하지만 간단하게 해결되지 않았는데요, `v8.x`에서 `v9.x`로 메이저 업데이트가 진행된 만큼 큰 변동 사항이 생겨 간단히 옵션 몇 가지만 변경하는 것이 아니었습니다.

## ESLint 마이그레이션

ESLint의 업데이트로 인해 설정 파일이 **flat config** 형태로 변경되었습니다.

기존 CommonJS 형식은 **지원되지 않는 Legacy 버전**이 되어 버렸습니다.

아예 동작하지 않도록 설정되었어요...

이는 기능 개발 중, **일정 관리의 걸림돌**이 되었습니다.

![Desktop View](/assets/img/post/20240716/holy.png){: width="360" .normal}

> 기능 마감일 D-2

그래도 언젠가는 해야할 일, 미루지 않고 진행하기로 결정하였습니다.

설정 자체가 변경되었다 보니 `package.json`의 `script`을 포함한 각종 변경 사항이 발생하였습니다.

### 1. 설정 파일 형식 변경

**기존:** CommonJS 형식 (`.eslintrc`)

```js
module.exports = {
  // ...
  rules: {
    // 규칙 설정
  },
};
```

**변경:** ES 모듈 형식 (`eslint.config.js`)

```js
export default [
  // ...
  {
    rules: {
      // 규칙 설정
    },
  },
];
```

### 2. 플랫 설정(Flat Config) 도입

**기존:** 계층적 구조

```js
module.exports = {
  extends: ["eslint:recommended"],
  overrides: [
    {
      files: ["*.ts"],
      rules: {
        // TypeScript 특정 규칙
      },
    },
  ],
};
```

**변경:** 배열 형태의 플랫 구조

```js
export default [
  js.configs.recommended,
  {
    files: ["**/*.ts"],
    rules: {
      // TypeScript 특정 규칙
    },
  },
];
```

### 3. 플러그인 및 파서 import 방식

**기존:** 문자열로 플러그인 참조

```js
module.exports = {
  extends: ["plugin:vue/vue3-essential"],
};
```

**변경:** 플러그인을 직접 import

```js
import pluginVue from "eslint-plugin-vue";
export default [...pluginVue.configs["flat/recommended"]];
```

### 4. 언어 옵션 설정 방식 변경

**기존:** `parserOptions`를 최상위에 정의

```js
module.exports = {
  parserOptions: {
    ecmaVersion: "latest",
    sourceType: "module",
  },
};
```

**변경:** `languageOptions` 객체 내에 정의

```js
export default [
  {
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      parser: "@typescript-eslint/parser",
    },
  },
];
```

### 5. 규칙 설정 방식

**기존:** 최상위 `rules` 객체에 모든 규칙 정의

```js
module.exports = {
  rules: {
    "vue/multi-word-component-names": "off",
    "no-unused-vars": "error",
  },
};
```

**변경:** 여러 설정 객체로 분리

```js
export default [
  {
    rules: {
      "vue/multi-word-component-names": "off",
    },
  },
  {
    rules: {
      "no-unused-vars": "error",
    },
  },
];
```

### 6. 글로벌 변수 설정

**기존:** env 옵션으로 설정

```js
module.exports = {
  env: {
    node: true,
    browser: true,
  },
};
```

**변경:** globals 라이브러리 사용

```js
import globals from "globals";

export default [
  {
    languageOptions: {
      globals: {
        ...globals.node,
        ...globals.browser,
      },
    },
  },
];
```

### 7. 파일 무시 설정

**기존:** `.eslintignore` 파일 또는 `--ignore-path` 옵션 사용

```json
{
  "scripts": {
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --ignore-path .gitignore"
  }
}
```

**변경:** 설정 내 `ignores` 배열로 정의

```js
export default [
  {
    ignores: ["**/dist/*", "**/node_modules/*"],
  },
];
```

이러한 변경은 ESLint의 설정을 더 유연하고 모듈화된 방식으로 관리할 수 있게 해줍니다.

특히 **플랫 설정의 도입**으로 설정 간의 우선순위를 더 명확하게 제어할 수 있게 되었습니다. ~~(적용을 마음먹기 힘들 뿐...)~~

또한, **규칙 설정을 여러 객체로 분리**함으로써 프로젝트의 다양한 요구사항에 따라 규칙을 더 세밀하게 조정할 수 있게 되었습니다.

가장 걱정이었던 부분은 현재 사용 중인 `eslint-plugin-vue` 플러그인이 **flat config**를 지원하지 않을 수 있는 부분에 염려하였는데, 다행히도 **올해 3월**에 늦지 않게 업데이트 해주었습니다

- [Github: vuejs - eslint-plugin-vue](https://github.com/vuejs/eslint-plugin-vue/pull/2407)

## 심연에 손을 뻗다

이번 업데이트 적용을 위해 많은 라이브러리의 버전을 최신화하고 새로 추가하였습니다.

이와 함께 새로운 플러그인을 도입하면서 추가된 규칙이 생기면서 검토하는 시간을 가졌습니다.

> 코딩 컨벤션을 문서화 뿐만 아니라 eslint에 적용하면 코드 품질을 보다 훌륭하게 유지보수할 수 있지 않을까?

> 비활성화한 규칙은 꼭 필요에 의한 것일까?

> 지금 우리 `lint`는 `legacy`하지 않을까?

사실 이미 깔끔하게 설정되어 있는 저장소의 eslint 설정에 대한 의문을 갖지 않았을 뿐더러

그것이 적합한 규칙으로 설정되었다는 믿음(?)이 있던 것 같습니다.

하지만 지금 최신화와 함께 새로 발생한 lint 이슈를 수정하면서 적절한 시기라 판단하였고 묻어 놓았던 **비활성화 규칙**을 하나씩 걷어내어 보기 시작했습니다.

![Desktop View](/assets/img/post/20240716/package.png){: width="540" .normal}

> 잔뜩 갈무리한 라이브러리

### 비활성화 규칙

우리 팀에서 비활성화한 규칙은 무엇이고, 왜 비활성화 했을까요?

그 중에서 먼저 눈에 띈 규칙은 `no-undef` 규칙이었습니다.

```js
// ...
{
  'no-undef': 'off',
}

// eslint.config.js
```

_"사용하지 않는 규칙은 당연히 표시되어야 하지 않나?"_ 싶었는데 이는 **JavaScript에서 필요한 규칙**으로, **TypeScript**는 `type-check`가 이를 대체하여 `build` 시에 잡아낼 수 있는 에러라고 합니다.

또한, [typescript-eslint](https://typescript-eslint.io/troubleshooting/faqs/general/#how-do-i-turn-on-a-typescript-eslint-rule)에서도 권장하는 방식임을 확인하였습니다.

몇 가지 규칙은 활성화해도 에러 없이 정상 작동하였으나 **덩치가 큰 규칙**도 있었습니다.

예를 들어 아래 이미지의 규칙입니다.

![Desktop View](/assets/img/post/20240716/lint.png){: .normal}

> // '@typescript-eslint/no-non-null-asserted-optional-chain': 'off',

사내 위젯 서비스의 경우 Webview 통신을 진행하다 보니 `!` 형태의 타입 어설션 사용이 많습니다.

이러한 문제를 판도라의 상자처럼 열지 않고 덮어놓을 수도 있겠지만, 코드가 더 많아지기 전에 풀어야할 숙제이기에 회의 중 **이슈로 제안**하였습니다.

### Vue를 활용하는 규칙

기본적으로 우리 팀은 [Vue - Style Guide](https://vuejs.org/style-guide/)를 따르고 있으며, 그에 맞는 **eslint-plugin-vue**를 적용하고 있습니다.

Style Guide를 보면 완전한 하나의 선택을 강요하지 않다 보니 eslint 역시 이를 강제하지 않는 부분이 있습니다.

- **Vue2**에서 **Vue3**로 업데이트
- **Composition API**의 등장
- `script setup` 문법의 등장

이러한 사항이 겹치다 보니 **kebab-case**와 **PascalCase** 등 Casing이 혼용되는 부분이 많았고, 가장 효율적인 방법을 적용하기로 하였습니다.

![Desktop View](/assets/img/post/20240716/casing.png){: .normal}

우리 팀은 두 가지 케이스를 모두 사용해본 결과, 첫 번째 코드 블럭인 **PascalCase**로 결정하였습니다.

리팩토링과 컴포넌트 삭제 시 검색을 **두 번씩 반복하지 않기 위해서**입니다.

예를 들어 `InputBox` 파일의 컴포넌트를 `input-box`와 같이 사용한다면, `InputBox`와 `input-box` 두 가지를 검색해서 수정해야 하는 불편함이 있습니다.

![Desktop View](/assets/img/post/20240716/casing2.png){: .normal}

기존에 우리 팀은 컴포넌트와 파일명은 **PascalCase**로, `props` 선언은 **camelCase**로, `props` 바인딩은 **kebab-case**로 사용해 왔습니다.

즉, `<WelcomeMessage greeting-text="hi"/>`와 같이 사용했습니다.

하지만 위 이미지처럼 `Good`이지만, 다른 Casing을 혼용하는 것은 권장하지 않는다는 내용이 있습니다.

> you can use either convention but we don't recommend mixing two different casing styles

또한, 권장 내용 뿐만 아니라 효율성과 연결된 이유도 있습니다.

**Vue v3.4**에서 `props`에 변수 바인딩 축약 기능이 업데이트 되었습니다.

- **Before**

```vue
<template>
  <TextBox :width="width" :height="height" :error="error" />
</template>
```

- **After**

```vue
<template>
  <TextBox :width :height :error />
</template>
```

하지만 `props`가 합성어인 경우 **kebab-case**로 진행 시 축약이 불가합니다.

- **kebab-case**

```vue
<template>
  <TextBox :width :height :error :element-icon="elementIcon" />
</template>
```

- **PascalCase**

```vue
<template>
  <TextBox :width :height :error :elementIcon />
</template>
```

따라서 `<WelcomeMessage greetingText="hi"/>`와 같이 **PascalCase**와 **camelCase**로 코드를 관리하는 것에 대한 의견을 주고 받는 계기가 되었습니다.

사실 이것이 받아들여 지는 경우에 합성어 `props`를 가진 모든 컴포넌트의 수정이 필요하고, 사이드 이펙트를 초래할까 걱정이 되지만 언제까지 `rule`을 `off`하고 덮어 놓을 수는 없습니다.

## 마치며

ESLint v9로의 마이그레이션 과정은 단순한 기술적 업데이트를 넘어, 우리 팀의 코드 품질과 개발 문화를 되돌아보는 중요한 계기가 되었습니다.

- **지속적인 개선의 중요성:**

  기술 부채를 **미루지 않고 적시에 해결**하는 것의 중요성을 다시 한 번 깨달았습니다.

- **규칙의 이유 이해하기:**

  단순히 규칙을 따르는 것이 아니라, **왜 그 규칙이 필요한지 이해**하는 것이 중요함을 알게 되었습니다.

- **자동화의 힘:**

  ESLint와 같은 도구를 통해 **코딩 컨벤션을 자동으로 적용하고 검사**함으로써, 개발자들이 더 중요한 문제에 집중할 수 있게 되었습니다.

개인적인 욕심은 **명명 규칙**까지 ESLint에 적용하는 것인데요, 클린 코드 관련 서적에서 보았던 기억이 납니다.

- 변수명은 명사 또는 명사구 사용
- 메서드명은 동사 또는 동사구로 시작
- `Boolean` 값을 나타내는 변수는 `is`, `has`, `can` 등으로 시작
- 상수는 모두 대문자와 언더스코어 사용
- 클래스명은 대문자로 시작 (`PascalCase`)
- 변수와 함수명은 `camelCase` 사용

이 모든 것이 ESLint를 통해 자동으로 관리될 수 있도록 만들고 **더 높은 코드 품질**을 유지하고 싶습니다.

이번 내용을 통해 eslint 개선 및 코딩 컨벤션 고도화는 개인의 의견이 아닌 팀의 논의 사항으로 확장되어 **Bottom-Top** 형태가 만들어지는 좋은 경험이었습니다. ~~(이를 해결하는 과정을 쉽지 않겠지만)~~

**어떤 방식으로 진행하는 것이 가장 효과적일지** 논의하고 이를 해결하는 과정에서 더 좋은 절충안을 만들어낼 것이라 기대합니다.

팀 단위의 이슈로 수면 위에 오른 만큼, 저 역시 책임감을 갖고 개선에 힘쓰면 좋을 것 같습니다 :)
