---
title: 프론트엔드 에러 처리 전략과 사용자 경험 개선
description: 네트워크부터 입력까지, 효과적인 에러 관리로 사용자 경험을 높이는 방법
author: Ferv0r2
date: 2024-11-09 12:00:00 +0900
categories: [frontend, user experience, error handling]
tags: [error handling, user experience, frontend development, best practices]
render_with_liquid: false
image: /assets/img/post/20241109/banner.png
---

## **들어가며**

일상 생활에서 데이터를 비활성화하거나 인터넷 연결이 끊겼을 때, 우리는 "네트워크 연결을 확인하세요"와 같은 에러 메시지를 종종 보게 됩니다.

에러 처리는 단순히 경고를 표시하는 것을 넘어, 사용자 경험의 중요한 부분을 차지합니다. 문제가 발생했을 때 사용자에게 상황을 명확히 전달하고 해결 방안을 안내하는 것이 에러 처리의 핵심 역할이죠.

프론트엔드 개발에서의 에러 처리는 사용자 경험에 직접적인 영향을 미칩니다.

에러는 코드의 논리적 실수, 네트워크 상태, 사용자 입력 오류 등 다양한 이유로 발생할 수 있습니다.

이번 글에서는 에러의 주요 유형과 HTTP 상태 코드에 따른 에러 메시지 처리 방법, 그리고 프론트엔드에서 에러를 효과적으로 관리하는 전략을 다뤄보겠습니다.

## **네트워크 및 API 관련 에러**

프론트엔드 애플리케이션에서 가장 빈번하게 발생하는 에러는 네트워크 및 API 요청 에러입니다. 서버 응답이 지연되거나 잘못된 상태 코드가 반환되면 네트워크 에러가 발생할 수 있습니다.

이때 **HTTP 상태 코드**는 문제의 원인을 파악하는 데 유용한 정보를 제공합니다.

### **HTTP 상태 코드에 따른 에러 처리**

- **404 Not Found**:

  서버에서 요청한 리소스를 찾을 수 없을 때 발생합니다. 사용자에게는 "페이지를 찾을 수 없습니다"라는 메시지와 함께 홈으로 돌아갈 수 있는 옵션을 제공하는 것이 좋습니다.

  ```typescript
  fetch('https://example.com/resource')
    .then((response: Response) => {
      if (response.status === 404) {
        throw new Error('페이지를 찾을 수 없습니다');
      }
      return response.json();
    })
    .catch((error: Error) => {
      console.error(error.message);
      // 사용자에게 홈으로 돌아갈 수 있는 링크 제공
    });
  ```

- **500 Internal Server Error**:

  서버 내부 문제로 응답하지 못할 때 발생합니다. "잠시 후 다시 시도하세요"와 같은 메시지를 표시하고, 백엔드 팀에 문제를 전달해 빠르게 해결할 수 있도록 합니다.

  ```typescript
  const fetchData = async () => {
    try {
      const response = await fetch('https://example.com/data');
      if (!response.ok) {
        throw new Error('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
      }
      return await response.json();
    } catch (error) {
      console.error((error as Error).message);
    }
  }
  ```

- **401 Unauthorized / 403 Forbidden**:

  사용자가 인증되지 않았거나 권한이 없는 경우 발생합니다. 로그인 페이지로 리디렉션하거나 접근 권한이 없다는 안내 메시지를 보여줍니다.

  ```typescript
  const fetchData = async () => {
    try {
      const response = await fetch('https://example.com/data');
      if (response.status === 401) {
        window.location.href = '/login';
      } else if (response.status === 403) {
        throw new Error('접근 권한이 없습니다.');
      }
      return await response.json();
    } catch (error) {
      console.error((error as Error).message);
    }
  }
  ```

이 외에도 **503 Service Unavailable**, **429 Too Many Requests** 등 다양한 상태 코드가 있으며, 각 코드에 맞는 사용자 메시지와 대체 동작을 제공하는 것이 중요합니다.

### **네트워크 문제 처리 전략**

네트워크 연결 문제는 사용자에게 큰 불편을 줄 수 있으므로, 이런 상황을 잘 처리하는 것이 중요합니다. 예를 들어, 재시도 버튼을 제공하거나 자동 재시도 기능을 구현할 수 있습니다.

```typescript
const fetchWithRetry = async (url: string, retries: number = 3): Promise<any> => {
  for (let i = 0; i < retries; i++) {
    try {
      const response: Response = await fetch(url);
      if (response.ok) {
        return await response.json();
      }
      throw new Error('서버 오류 발생');
    } catch (error) {
      if (i < retries - 1) {
        console.log(`refetching... ${i + 1}`);
        return
      }
      alert('네트워크 오류가 발생했습니다. 나중에 다시 시도해주세요.');
    }
  }
}

fetchWithRetry('https://example.com/data');
```

## **사용자 입력 관련 에러**

사용자가 폼에 잘못된 입력을 할 경우에도 에러가 발생할 수 있습니다. 이때 실시간으로 에러 메시지를 제공하여 사용자가 쉽게 문제를 인식하고 수정할 수 있도록 돕는 것이 중요합니다.

예를 들어, 이메일 형식이 맞지 않으면 **빨간색 경고 메시지**를 표시하거나 특정 조건을 만족하지 않으면 **해당 필드를 강조하는 방식**이 **사용자 경험을 크게 향상**시킬 수 있습니다.

### **실시간 유효성 검사**

![Desktop View](/assets/img/post/20241109/input-error.png){: .normal}

```typescript
const validateEmail = (email: string): void => {
  const emailRegex: RegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    throw new Error('유효한 이메일 형식을 입력하세요');
  }
}

try {
  validateEmail('invalid-email');
} catch (error) {
  console.error((error as Error).message);
  // 입력 필드에 에러 메시지 표시
}
```

입력 에러 메시지는 **구체적이고 직관적**으로 제공해야 합니다. 단순히 "입력값이 잘못되었습니다"라는 메시지보다는 "유효한 이메일 형식을 입력하세요"처럼 명확한 피드백을 제공하면 사용자 편의성이 높아집니다.

### **사용자 입력 개선 사례**

잘못된 입력을 쉽게 수정할 수 있도록 에러 발생 시 **실시간 피드백**을 제공하는 것은 물론, 필수 입력 필드에 **시각적 힌트**를 주거나 올바른 형식을 **예시로 제시**하는 방식도 유효합니다.

```html
<label for="email">이메일 (예: user@example.com)</label>
<input type="text" id="email" name="email" placeholder="user@example.com" />
<span id="email-error" class="error-message">잘못된 이메일 형식입니다.</span>
```

## **상태 관리 및 로직 에러**

애플리케이션이 복잡해질수록 상태 관리와 관련된 에러 발생 가능성도 높아집니다. `zustand`, `pinia`와 같은 상태 관리 라이브러리를 사용할 때, 상태 불일치나 데이터 흐름 문제로 인한 에러가 발생할 수 있습니다.

### **Zustand에서의 상태 관리 에러 처리**

```tsx
import create from 'zustand';

interface UserState {
  userData: any;
  setUserData: (data: any) => void;
}

const useStore = create<UserState>((set) => ({
  userData: null,
  setUserData: (data: any) => {
    try {
      set({ userData: data });
    } catch (error) {
      console.error('상태 업데이트 중 오류 발생:', error);
    }
  },
}));

// 컴포넌트에서 사용 예시
function UserProfile({ newUserData }: { newUserData: any }) {
  const setUserData = useStore((state) => state.setUserData);

  try {
    setUserData(newUserData);
  } catch (error) {
    console.error('사용자 데이터 업데이트 중 오류 발생:', error);
  }
}
```

### **상태 불일치 문제 해결**

상태 관리 도구의 미들웨어를 활용해 상태 변화 전후를 기록하는 방식으로 디버깅을 쉽게 할 수 있습니다.

```typescript
const loggerMiddleware = (config: any) => (set: any, get: any, api: any) =>
  config(
    (args: any) => {
      console.log('이전 상태:', get());
      set(args);
      console.log('다음 상태:', get());
    },
    get,
    api
  );

const useStoreWithLogger = create<UserState>(loggerMiddleware((set) => ({
  userData: null,
  setUserData: (data: any) => set({ userData: data }),
})));
```

## **글로벌 에러 핸들링 전략**

모든 에러를 개별 컴포넌트에서 처리하는 것은 비효율적이므로, **글로벌 에러 핸들링** 전략을 통해 반복되는 에러 처리 코드를 줄일 수 있습니다.

### **React의 Error Boundary 사용**

```tsx
import { Component, ErrorInfo } from 'react';

class ErrorBoundary extends Component<{}, { hasError: boolean }> {
  constructor(props: {}) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error) {
    return { hasError: true };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('ErrorBoundary에서 오류 발생:', error, errorInfo);
  }

  render() {
    return this.state.hasError ? (
      <h1>문제가 발생했습니다. 잠시 후 다시 시도해주세요.</h1>
    ) : (
      this.props.children
    );
  }
}

export default ErrorBoundary;
```

### **Axios 인터셉터를 사용한 글로벌 에러 처리**

또한, Axios와 같은 HTTP 클라이언트 라이브러리에서는 전역 **인터셉터(interceptor)**를 사용해 모든 요청과 응답을 감시하고, 에러 발생 시 자동 재시도나 사용자 알림을 통해 문제를 유연하게 대응할 수 있습니다.

```typescript
import axios, { AxiosError, AxiosResponse } from 'axios';

axios.interceptors.response.use(
  (response: AxiosResponse) => response,
  (error: AxiosError) => {
    console.error('API 요청 중 오류 발생:', error);
    if (error.response && error.response.status === 500) {
      alert('서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요.');
    }
    return Promise.reject(error);
  }
);
```

이러한 글로벌 에러 핸들링은 코드의 복잡성을 줄이면서도 에러 발생 시 신속한 대응이 가능하도록 합니다.

## **사용자 친화적인 에러 페이지 제공**

![Desktop View](/assets/img/post/20241109/info.png){: width="360" .normal}

에러 발생 시 사용자가 당황하지 않도록, **직관적인 에러 페이지**를 제공해야 합니다.
 
원하는 행위에 대한 액션에 대해 예상치 못한 응답이 나타난다면, 사용자는 서비스에서 이탈할 것입니다.

따라서 **에러 원인**을 제시하고 **다음 액션**을 진행할 수 있도록 안내해야 합니다.

사용자 친화적인 에러 페이지는 에러로 인한 부정적인 인상을 줄이고, **브랜드에 대한 신뢰도를 유지**하는 데 큰 도움이 됩니다.

## 마치며

어떠한 애플리케이션도 에러가 완전히 없는 상태를 유지하기는 어렵습니다. 네트워크 연결 문제, 서버의 응답 지연, 사용자 입력 오류 등 다양한 이유로 에러는 언제든 발생할 수 있습니다.

중요한 것은 이러한 에러를 "어떻게 잘 처리할 것인가"입니다.

> **에러는 필연적이지만, 잘 처리하는 것이 중요하다**

에러를 사전에 방지하는 것도 중요하지만, **예상치 못한 에러가 발생했을 때 사용자에게 명확하고 구체적인 안내를 제공**하고, 빠른 해결 방법을 제시하는 것이 프론트엔드 개발의 핵심입니다.

에러 처리는 사용자와 서비스 간의 **신뢰를 유지하는 중요한 요소**이므로, 이를 효과적으로 관리하고 대응하는 방법을 익히는 것이 프론트엔드 개발자로서 중요한 역량이 될 것입니다.

만드는 과정이 힘들수록 사용자에게 긍정적인 경험을 줄 수 있으니 에러를 잘 처리해 보아요 :)

