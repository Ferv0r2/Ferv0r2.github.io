---
title: Velog to Github
author: Ferv0r2
date: 2024-05-05 14:08:00 +0900
categories: [talk]
tags: [etc]
render_with_liquid: false
image: /assets/img/post/20240505/banner.png
---

## 플랫폼 이주

기존 [Velog](https://velog.io/@fervor_dev/posts)에서 포스팅 이후 맥이 끊기고 다시 시작하기로 마음을 다잡았다.

_"굳이 왜 Git으로 플랫폼을 옮겼는가?"_ 하면 두 가지 이유가 있다.

**1. 커스텀하기 편하다.**

- 고퀄리티의 글을 작성하기 위해서는 어느정도 정형화된 형식이 도움이 될 수 있다.

  하지만 강조 처리나 특정한 부분을 삽입할 때, 커스텀이 되지 않는 것은 굉장히 불편하다.

- 또한, 나는 애니메이션 작업을 좋아하기 때문에 표현하기 적합할 필요가 있다.

**2. 일괄 처리가 편하다.**

- Velog에서 글을 작성했을 때, `Tag`를 뒤늦게 알게 되어 글을 하나하나 수정하면서 고통받았던 경험이 있다.

- 코드로 구성된 Git이 훨씬 수정에 용이하다.

---

## 낯선 Init 과정

Github Blog는 **GitHub Pages** 서비스를 이용하고 있고 `jekyll` 를 사용한다.

> jekyll : ruby로 만들어진 정적 사이트 생성 툴 (SSG)

ruby를 설치하고 환경변수를 설정하면서 install이 안되거나 build가 안되는 등 이슈가 많았다.

> [[Error] Could not open library 'libcurl'](https://github.com/CocoaPods/CocoaPods/issues/9955)

구글링을 통해 이슈를 수정했지만 곧바로 다른 이슈가 발생하기에 ruby를 재설치하기로 결정했다.

현재는 아주 잘 된다. ^\_\_^

평소에 `npm run dev` 혹은 `yarn dev`으로 실행했던 script가 아닌 아래처럼 입력하는 것이 아직은 익숙하지 않다.

```ruby
bundle exec jekyll s
```

## 마치며

사내에서 `README.md`나 `CHANGELOG.md`를 작성할 때 영문으로 진행하다 보니 신경쓰일 요소가 없었는데

블로그 포스팅은 국문으로 작성하다 보니 말투가 굉장히 신경쓰인다 ^\_\_^..

나를 표현하는 도구로 잘 활용하면 좋을 것 같다.
