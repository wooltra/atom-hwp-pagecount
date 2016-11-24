# HWP page counter package

Counts the pages by Korean method(HWP). shows how many pages would be in 200-character manuscript paper.

A fork of [Atom wordcount package](https://github.com/nesQuick/atom-wordcount). Thanks you!

-----

Atom 편집기에서 작성한 문서가 200자 원고지 기준 몇 장인지 표시합니다.

한컴오피스 한글(아래한글 2010, 2014)과 동일한 방식으로 측정하는 것 같습니다. (Ctrl-Q,D로 눌러서 보는 문서통계 화면)

아닌 경우가 있거든 Issues 에 올려주시거나 wooltradev@gmail.com 으로 알려주세요.

![A screenshot](/screenshot.png)

- 확장자가 없거나, 텍스트 형식의 확장자인 경우 원고지 장수를 표시합니다. 설정에서 변경할 수 있습니다.
- 저장하지 않은 파일도 분량을 알 수 있습니다.
- 0.1장 단위로 표시합니다. 200자 원고지 한장은 10줄이기 때문에 0.1장은 원고지 한 줄입니다.
- 텍스트 영역을 선택한 경우에는 해당 부분이 몇 장인지 표시합니다.

[Atom wordcount package](https://github.com/nesQuick/atom-wordcount) 를 아주 조금 변경하여 만들었습니다. 감사!
